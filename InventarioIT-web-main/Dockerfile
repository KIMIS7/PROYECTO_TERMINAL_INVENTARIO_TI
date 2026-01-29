# Dockerfile
# Declara los argumentos que se recibirán en el momento de la construcción.
ARG AUTH_SECRET
ARG AUTH_BASEPATH
ARG NEXT_BASE_PATH
ARG NEXT_PUBLIC_API
ARG APP_VERSION

# ---- Etapa 1: Dependencias ----
# Instala las dependencias en una capa separada para aprovechar el caché de Docker.
FROM node:20-alpine AS deps
WORKDIR /app

# Define las variables de entorno necesarias para el proceso de build.
ENV AUTH_SECRET=${AUTH_SECRET}
ENV NEXT_PUBLIC_AUTH_BASEPATH ${AUTH_BASEPATH}
ENV NEXT_BASE_PATH=${NEXT_BASE_PATH}
ENV NEXT_PUBLIC_API=${NEXT_PUBLIC_API}
ENV NEXT_PUBLIC_APP_VERSION=${APP_VERSION}
ENV NEXT_TELEMETRY_DISABLED=1

# Copia los archivos de gestión de paquetes.
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# Instala las dependencias usando el gestor de paquetes correcto.
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f pnpm-lock.yaml ]; then npm i -g pnpm && pnpm i --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  else echo "Lockfile no encontrado." && exit 1; \
  fi

# ---- Etapa 2: Builder ----
# Construye la aplicación Next.js.
FROM node:20-alpine AS builder
WORKDIR /app

# Recibe los argumentos definidos al inicio
ARG AUTH_SECRET
ARG AUTH_BASEPATH
ARG NEXT_BASE_PATH
ARG NEXT_PUBLIC_API
ARG NEXTAUTH_URL_BASE
ARG APP_VERSION

# Define las variables de entorno necesarias para el proceso de build
ENV AUTH_SECRET=${AUTH_SECRET}
ENV NEXT_PUBLIC_AUTH_BASEPATH ${AUTH_BASEPATH}
ENV NEXT_BASE_PATH=${NEXT_BASE_PATH}
ENV NEXT_PUBLIC_API=${NEXT_PUBLIC_API}
ENV NEXT_PUBLIC_APP_VERSION=${APP_VERSION}

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Ejecuta el script de construcción de Next.js.
RUN npm run build

# Información de depuración para verificar la versión y el contenido
RUN echo "Versión de la aplicación: ${NEXT_PUBLIC_APP_VERSION}"

# ---- Etapa 3: Runner ----
# Crea la imagen final de producción, ligera y optimizada.
FROM node:20-alpine AS runner
WORKDIR /app

# Recibe los argumentos definidos al inicio
ARG AUTH_SECRET
ARG AUTH_BASEPATH
ARG NEXT_BASE_PATH
ARG NEXT_PUBLIC_API
ARG NEXTAUTH_URL_BASE
ARG APP_VERSION

# Establece el entorno a producción y configura las variables necesarias
ENV NODE_ENV=production
ENV AUTH_SECRET=${AUTH_SECRET}
ENV NEXT_PUBLIC_AUTH_BASEPATH ${AUTH_BASEPATH}
ENV NEXT_BASE_PATH=${NEXT_BASE_PATH}
ENV NEXT_PUBLIC_API=${NEXT_PUBLIC_API}
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_APP_VERSION=${APP_VERSION}

# Crea un grupo y usuario no-root para mejorar la seguridad.
RUN addgroup --system --gid 1001 nextjs
RUN adduser --system --uid 1001 nextjs

# Copia los artefactos de la compilación desde la etapa 'builder'.
# Esto requiere tener `output: 'standalone'` en tu archivo next.config.js.
COPY --from=builder --chown=nextjs:nextjs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nextjs /app/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nextjs /app/public ./public

# Cambia al usuario no-root.
USER nextjs

# Expone el puerto en el que se ejecutará la aplicación.
EXPOSE 3000

ENV PORT 3000

# El comando para iniciar el servidor de Next.js en modo standalone.
CMD HOSTNAME="0.0.0.0" node server.js