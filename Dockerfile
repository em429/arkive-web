FROM node:16-slim@sha256:c51416d582339a0f9f5f8da347a2dd8b585e1f5893a627e9b3a208351493b2b4

WORKDIR /arkive-web
RUN chown -R node:node ./
RUN addgroup --gid 1024 mygroup
RUN adduser node mygroup
# RUN adduser --disabled-password --gecos "" --force-badname --ingroup mygroup myuser
USER node

COPY src src/
COPY static static/
COPY package.json .
COPY package-lock.json .
COPY postcss.config.cjs .
COPY tailwind.config.cjs .
COPY svelte.config.js .
COPY tsconfig.json .

RUN npm clean-install

ENV NODE_ENV production
RUN npm run build

CMD [ "node", "build/index.js" ]
