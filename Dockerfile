FROM node:14-alpine as buildImage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .
RUN npm run build

RUN npm prune --production


FROM node:14-alpine

WORKDIR /app

COPY --from=buildImage /app/node_modules ./node_modules/
COPY --from=buildImage /app/dist ./dist/

USER node 
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]