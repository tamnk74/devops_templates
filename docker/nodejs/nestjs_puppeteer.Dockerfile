FROM node:14-alpine As deps
ARG ENV_TAG=development
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY --chown=node:node . .

COPY .env.${ENV_TAG} ./.env
COPY package*.json ./
RUN npm install & npm run build

FROM node:14-slim as production
ARG ENV_TAG=development
ENV NODE_ENV production
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Install Google Chrome Stable and fonts
# Note: this installs the necessary libs to make the browser work with Puppeteer.
RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
  apt-get update && \
  apt-get install google-chrome-stable -y --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY .env.${ENV_TAG} ./.env
COPY package*.json ./
RUN npm ci --production
COPY --chown=node:node . .
COPY --from=deps --chown=node:node /app/dist ./dist

USER node
CMD ["node", "dist/main.js"]

EXPOSE 3000 5010
