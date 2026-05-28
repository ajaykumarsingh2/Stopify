# Stage 1: Build Flutter web app
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY . .
RUN flutter build web --release

# Stage 2: Serve with Caddy
FROM caddy:2-alpine

COPY --from=build /app/build/web /srv
COPY <<EOF /etc/caddy/Caddyfile
:{$PORT}
root * /srv
file_server
try_files {path} /index.html
EOF

EXPOSE ${PORT}
