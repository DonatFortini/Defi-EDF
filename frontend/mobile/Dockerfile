FROM ghcr.io/cirruslabs/flutter:3.27.1 AS build

WORKDIR /app
COPY android/app/src/main/AndroidManifest.xml android/app/src/main/AndroidManifest.xml
COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN yes | flutter doctor --android-licenses && \
    flutter config --enable-android && \
    flutter doctor

RUN flutter build apk --release

FROM alpine:latest

RUN apk add --no-cache openjdk17 bash

WORKDIR /app
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk .

CMD ["echo", "APK ready! Access it in /app/app-release.apk"]
