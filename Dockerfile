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

ENV YARN_VERSION 1.22.4
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
	sudo tar -xzf yarn.tar.gz -C /opt/ && \
	rm yarn.tar.gz && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg

RUN yarn --version

COPY package-lock.json /app
COPY package.json /app

ADD . /app
WORKDIR /app
RUN yarn && yarn run prod


FROM nginx:1.19

COPY --from=builder /app/build /etc/nginx/
