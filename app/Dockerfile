FROM node:18.15.0-alpine AS build

WORKDIR /node-app

COPY ./package*.json ./
RUN npm install

COPY . .

FROM node:18.15.0-alpine

RUN adduser -D nodeusr

RUN apk update && \
    apk add --no-cache nginx curl stress-ng && \
    npm config set strict-ssl false && \
    npm install -g pm2

WORKDIR /node-app

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build /node-app /usr/share/nginx/html
COPY --from=build /node-app /node-app

# USER nodeusr

EXPOSE 8000

HEALTHCHECK --interval=120s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -f http://localhost:8000/api/users  || exit 1

CMD ["npm", "run", "start"]
