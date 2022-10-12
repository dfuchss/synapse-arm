FROM ubuntu
RUN apt-get update && apt-get install -y \
    curl \
    gosu \
    libpq5 libpq-dev \
    xmlsec1 \
    libjemalloc2 libjemalloc-dev \
    libssl-dev openssl \
    libffi-dev python3.9 cargo jq libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && /usr/bin/python3 get-pip.py && rm get-pip.py

COPY ./docker/start.py /start.py
COPY ./docker/conf /conf

RUN --mount=type=tmpfs,target=/root/.cargo pip3 install --find-links https://wheel-index.linuxserver.io/ubuntu/ --prefix="/usr/local" matrix-synapse[postgres]==$(curl --silent "https://api.github.com/repos/matrix-org/synapse/releases/latest" | jq -r .tag_name |  cut -c 2-)

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENTRYPOINT ["/start.py"]

HEALTHCHECK --start-period=5s --interval=15s --timeout=5s \
    CMD curl -fSs http://localhost:8008/health || exit 1
