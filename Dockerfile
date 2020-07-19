FROM node:12.18.2-alpine3.9 as build
COPY . /app
WORKDIR /app/zxing-js-library
RUN apk add --no-cache --virtual .gyp python3 make g++ 
RUN yarn
WORKDIR /app
RUN npm install
RUN npm run build:submodule
RUN npm run build

FROM nginx:1.19.1
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
