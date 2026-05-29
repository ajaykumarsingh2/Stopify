# Build Stage
FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter config --enable-web

COPY . /app
WORKDIR /app
RUN flutter pub get
RUN flutter build web --release

# Serve Stage
FROM caddy:alpine
COPY --from=build-env /app/build/web /usr/share/caddy
# This is the magic line for Railway
CMD caddy file-server --listen :${PORT} --root /usr/share/caddy