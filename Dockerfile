FROM ghcr.io/cirruslabs/flutter:3.32.0 AS build

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web --release

FROM caddy:alpine

COPY --from=build /app/build/web /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 8080

CMD ["caddy", "file-server", "--listen", ":8080", "--root", "/usr/share/caddy"]