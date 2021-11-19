# BUILD
FROM node:slim AS build
WORKDIR /app
COPY . .
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN yarn && yarn build
# EXPORT
FROM nginx:alpine
WORKDIR /var/www/phivos/html
COPY --from=build /app/build .
COPY container.conf /etc/nginx/conf.d/default.conf
EXPOSE 80