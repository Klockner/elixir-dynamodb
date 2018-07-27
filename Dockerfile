FROM ronualdo/phoenix-api:v1.3.2

RUN apk upgrade --no-cache --update musl-dev
RUN apk add curl curl-dev make g++

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix deps.get
