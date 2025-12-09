FROM node:22-bookworm AS builder

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
RUN npm install
RUN cd server && npm install
RUN make bundle external-libs build/uv/uv. bundle.js public/config.json build/assets/matter.css build/cache-load.json || true

FROM node: 22-alpine
WORKDIR /app
COPY --from=builder /app . 
WORKDIR /app/server
RUN npm install --production
EXPOSE 8000
CMD ["node", "server.js"]
