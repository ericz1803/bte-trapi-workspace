# Build:
# docker build --rm --force-rm --compress --squash -t biothings/bte-trapi .
# Run:
# docker run -it --rm -p 3000:3000 --name bte-trapi biothings/bte-trapi
# Run with DEBUG logs enabled:
# docker run -it --rm -p 3000:3000 --name bte-trapi -e DEBUG="biomedical-id-resolver,bte*" biothings/bte-trapi
# Log into container:
# docker exec -ti bte-trapi sh
FROM node:16-alpine
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app
RUN npm i pm2 -g
# install git first and then remove it after `run clone` is done
RUN apk add --no-cache --virtual build-deps git
COPY --chown=node:node . .
USER node

RUN export GIT_REMOTE_PROTOCOL=https \
    && npm run clone \
    && npm i || true && npm i \
    && npm run compile \
    && npm run --silent get_rev > .current_rev \
    && npm run clean_on_prod \
    && npm i --production || true
USER root
RUN apk del build-deps
USER node
EXPOSE 3000
ENV NODE_ENV production
CMD ["pm2-runtime", "bte-pm2.json", "--env prod_nocache", "--only", "bte-trapi"]
