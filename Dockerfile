FROM node:6-alpine as builder
RUN apk update \
 && apk --no-cache add git \
 && rm -fr /var/cache/apk/* \
 && git clone http://github.com/mapbox/node-fontnik \
 && cd node-fontnik \
 && yarn install


FROM node:6-alpine
WORKDIR /fontnik
RUN apk update \
 && apk --no-cache add libc6-compat \
 && rm -fr /var/cache/apk/*
COPY --from=builder /node-fontnik/index.js     ./index.js
COPY --from=builder /node-fontnik/lib          ./lib
COPY --from=builder /node-fontnik/bin          ./bin
COPY --from=builder /node-fontnik/node_modules ./node_modules

