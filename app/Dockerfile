FROM node:18.15.0 AS build 

WORKDIR /node-app
COPY ./package*.json ./
RUN npm i
COPY . .


FROM node:18.15.0

RUN useradd -m nodeusr

RUN apt-get update && apt-get install -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm config set strict-ssl false \
    && npm install -g pm2    

WORKDIR /node-app
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /node-app /usr/share/nginx/html
COPY --from=build /node-app /node-app

#USER nodeusr

EXPOSE 8000
  
CMD ["npm", "run", "start"]
