FROM node:22-alpine
WORKDIR /app
COPY . .
RUN bun install
EXPOSE 8000
CMD ["node", "aboutproxy/index.js"]
