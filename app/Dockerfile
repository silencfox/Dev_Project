FROM node:18.15.0 as build 

WORKDIR /node-app
COPY ./package*.json ./
RUN npm i
COPY . .


FROM node:18.15.0

RUN apt install nginx
WORKDIR /node-app
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /node-app /usr/share/nginx/html
COPY --from=build /node-app /node-app

EXPOSE 8000

CMD ["npm", "run", "start"]
