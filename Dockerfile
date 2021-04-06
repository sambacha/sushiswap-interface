FROM node:14 as builder

ARG NODE_ENV="production"
ENV NODE_ENV=${NODE_ENV}
#ARG ETH_NETWORK_ID
#ENV ETH_NETWORK_ID=${ETH_NETWORK_ID}
#ARG ETH_CHAIN_ID
#ENV ETH_CHAIN_ID=${ETH_CHAIN_ID}
#ARG ETHERSCAN_PREFIX
#ENV ETHERSCAN_PREFIX=${ETHERSCAN_PREFIX}
#ARG BLOCK_TIME
#ENV BLOCK_TIME=${BLOCK_TIME}
RUN mkdir -p /app


COPY package-lock.json /app
COPY package.json /app

ADD . /app
WORKDIR /app
RUN yarn && yarn run prod


FROM nginx:1.19

COPY --from=builder /app/build /etc/nginx/
