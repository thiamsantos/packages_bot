FROM elixir:1.8.1-alpine as builder
RUN apk add inotify-tools make g++

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mkdir /app
COPY . /app
WORKDIR /app

ENV MIX_ENV prod
RUN mix deps.get
RUN mix release --no-tar

FROM alpine:3.9
RUN apk add --update openssl bash libstdc++
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/packages_bot .
