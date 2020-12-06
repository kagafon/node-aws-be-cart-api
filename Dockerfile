FROM node:12-alpine

WORKDIR /app

COPY package.json .
RUN npm install && npm cache clean --force

COPY . .
RUN npm run build

USER node 
ENV PORT=8080
EXPOSE 8080


CMD ["node", 'dist/main.js']