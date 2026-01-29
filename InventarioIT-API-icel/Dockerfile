# STAGE 1: Build
# Se utiliza una imagen slim basada en Debian que es más compatible con las dependencias de Puppeteer.
FROM node:20.18-alpine as build

WORKDIR /home/node/app

COPY package*.json ./
RUN npm ci

COPY . .

# ✅ Genera los clientes de Prisma antes de compilar
RUN npm run db:generate

# ✅ Compila la aplicación NestJS
RUN npm run build


# STAGE 2: Runner
# Se utiliza la misma imagen base para la etapa final.
FROM node:20.18-alpine as runner

# Instalar tini
RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app


ENV NODE_ENV production

COPY package*.json ./
# Se instalan solo las dependencias de producción.
RUN npm ci --omit=dev

# Copiar la carpeta dist y los clientes de Prisma generados
COPY --chown=node:node --from=build /home/node/app/dist ./dist

USER node
EXPOSE 3000

CMD ["node", "dist/main.js"]