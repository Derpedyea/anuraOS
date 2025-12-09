FROM oven/bun:1-alpine
WORKDIR /app
COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile || bun install
COPY . .
RUN bun run build || true
WORKDIR /app/server
RUN bun install --frozen-lockfile || bun install
WORKDIR /app
EXPOSE 8000
CMD ["bun", "run", "server/server.js"]
