FROM hexpm/elixir:1.11.1-erlang-23.1.1-alpine-3.12.0 AS build

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY lib lib
COPY rel rel
RUN mix do compile, release

FROM alpine:3.12.0 AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/packages_bot ./

ENV HOME=/app
