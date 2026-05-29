# Stage 1: Build
FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Root warning fix
RUN git config --global --add safe.directory /usr/local/flutter
RUN flutter doctor
RUN flutter config --enable-web

COPY . /app
WORKDIR /app
RUN flutter pub get

# Flag hata diya taaki build fail na ho
RUN flutter build web --release

# Stage 2: Serve
FROM caddy:alpine
COPY --from=build-env /app/build/web /usr/share/caddy
CMD caddy file-server --listen :${PORT} --root /usr/share/caddy