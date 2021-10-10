FROM elixir:1.12.3-alpine AS build
COPY mix.exs .
RUN mix do local.hex --force, local.rebar --force
RUN mix deps.get
RUN mix deps.compile
COPY config ./config
COPY lib ./lib
COPY test ./test

ENV MIX_ENV=prod
RUN mix release

FROM elixir:1.12.3-alpine
COPY --from=build $HOME/_build/prod/rel/bouba_api /app
WORKDIR /app
CMD ["./bin/bouba_api", "start"]
