FROM node:18-alpine as builder

WORKDIR /

COPY public /public/
COPY package.json package.json

RUN npm install

COPY src /src/
RUN npm run build


FROM nginx

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]