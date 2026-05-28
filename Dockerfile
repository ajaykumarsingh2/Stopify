# Stage 1: Build Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.32.0 AS build

WORKDIR /app
COPY . .
RUN flutter pub get && flutter build web --release

# Stage 2: Serve with Caddy
FROM caddy:2-alpine

COPY --from=build /app/build/web /srv
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 8080
