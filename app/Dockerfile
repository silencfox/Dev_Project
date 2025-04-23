FROM node:18.15.0 as build 

WORKDIR /node-app
COPY ./package*.json ./
RUN npm i
COPY . .

RUN yarn run build

FROM nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /node-app/build /usr/share/nginx/html

