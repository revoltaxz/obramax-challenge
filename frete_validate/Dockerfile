FROM elixir:1.11.3-alpine


RUN apk add --no-cache \
  make \
  gcc \
  libc-dev \
  argon2

WORKDIR /app

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

CMD mix phx.server

EXPOSE 4000