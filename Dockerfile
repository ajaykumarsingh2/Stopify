# Stage 1: Build
FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter config --enable-web

COPY . /app
WORKDIR /app
RUN flutter pub get
# Yahan humne renderer hata diya hai taaki error na aaye, Railway ise auto-handle karega
RUN flutter build web --release

# Stage 2: Serve
FROM caddy:alpine
COPY --from=build-env /app/build/web /usr/share/caddy
# Railway port mapping fix
CMD caddy file-server --listen :${PORT} --root /usr/share/caddy