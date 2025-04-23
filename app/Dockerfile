FROM node:18.15.0 as build 

WORKDIR /node-app
COPY ./package*.json ./
RUN npm i
COPY . .


FROM nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /node-app /usr/share/nginx/html

CMD nginx && node index.js
