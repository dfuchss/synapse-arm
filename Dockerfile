FROM docker.io/library/python:3.9
RUN apt-get update && apt-get install -y \
    curl \
    gosu \
    libjpeg62-turbo \
    libpq5 \
    libwebp6 \
    xmlsec1 \
    libjemalloc2 \
    libssl-dev \
    openssl \
    # For cryptography and native builds
    build-essential libssl-dev libffi-dev python3-dev cargo jq libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY ./docker/start.py /start.py
COPY ./docker/conf /conf

ENV PYTHONUNBUFFERED=1
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true

COPY pyproject.toml .
RUN pip install setuptools_rust cryptography$(grep "cryptography = " pyproject.toml | cut -d "=" -f 2- | sed 's/"//g' | xargs) && rm pyproject.toml

RUN pip install --prefix="/usr/local" matrix-synapse==$(curl --silent "https://api.github.com/repos/matrix-org/synapse/releases/latest" | jq -r .tag_name |  cut -c 2-)

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENTRYPOINT ["/start.py"]

HEALTHCHECK --start-period=5s --interval=15s --timeout=5s \
    CMD curl -fSs http://localhost:8008/health || exit 1
