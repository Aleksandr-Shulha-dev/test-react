FROM node:18-alpine as builder

WORKDIR /

COPY public /public/
COPY package.json package.json

RUN npm install

COPY src /src/
RUN npm run build


FROM nginx

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
# COPY ./nginx/fullchain.pem /etc/nginx/certs/fullchain.pem
# COPY ./nginx/privkey.pem /etc/nginx/certs/privkey.pem

COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80 443