FROM oven/bun:1-debian AS builder

RUN apt-get update && apt-get install -y \
    make \
    git \
    jq \
    uuid-runtime \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . . 

RUN git submodule update --init --recursive || true
RUN bun install
RUN cd server && bun install
RUN make bundle external-libs build/uv/uv. bundle.js public/config.json build/assets/matter.css build/cache-load.json || true

FROM oven/bun: 1-alpine
WORKDIR /app
COPY --from=builder /app . 
WORKDIR /app/server
RUN bun install --production
EXPOSE 8000
CMD ["bun", "run", "server.js"]
