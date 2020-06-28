FROM cirrusci/flutter:latest-web AS doordish
WORKDIR /app
RUN sudo chown -R cirrus:cirrus /app

RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

COPY lib /app/lib
COPY assets /app/assets
COPY web /app/web
COPY pubspec.yaml /app/pubspec.yaml

RUN flutter doctor -v
RUN flutter build web

FROM nginx
EXPOSE 80
COPY --from=doordish /app/build/web /usr/share/nginx/html