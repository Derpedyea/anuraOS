FROM oven/bun:1-alpine
WORKDIR /app
COPY package. json bun.lock* ./
RUN bun install --frozen-lockfile
COPY . .
RUN bun run build || true
EXPOSE 8000
CMD ["bun", "run", "server/index.js"]
