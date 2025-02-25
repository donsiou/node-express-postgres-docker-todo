FROM node:18 as build
WORKDIR /usr/src/app
COPY package.json /usr/src/app/package.json 
COPY package-lock.json /usr/src/app/package-lock.json
RUN npm ci --production

FROM node:18-slim as production
RUN apt update && apt upgrade -y
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
COPY server.js /usr/src/app/server.js
COPY config /usr/src/app/config
COPY db /usr/src/app/db
COPY server /usr/src/app/server
EXPOSE 3000
CMD ["node", "server.js"]