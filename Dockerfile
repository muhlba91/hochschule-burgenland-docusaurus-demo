# builder image
FROM node:26@sha256:a723b54c35a76e947095a20a67d39585bb09c862e6b1adeb8a9f518f95e34fb0 as builder

WORKDIR /app
COPY . .
RUN corepack enable; \
  yarn install --immutable; \
  yarn build

# final image
FROM nginx:1.31-alpine-slim@sha256:f761b94f2cb9e8e05e2943d5f773609596113ef69b54e2433a996d109a8f78b7

COPY --from=builder /app/build/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
