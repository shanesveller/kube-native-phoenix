# docker build -t kube_native:builder --target=builder .
FROM elixir:1.7.3-alpine as builder
RUN apk add --no-cache \
    gcc \
    git \
    make \
    musl-dev
RUN mix local.rebar --force && \
    mix local.hex --force
WORKDIR /app
ENV MIX_ENV=prod

# docker build -t kube_native:deps --target=deps .
FROM builder as deps
COPY mix.* /app/
# Explicit list of umbrella apps
RUN mkdir -p \
    /app/apps/kube_native \
    /app/apps/kube_native_web
COPY apps/kube_native/mix.* /app/apps/kube_native/
COPY apps/kube_native_web/mix.* /app/apps/kube_native_web/
RUN mix do deps.get --only prod, deps.compile

# docker build -t kube_native:frontend --target=frontend .
FROM node:10.12-alpine as frontend
WORKDIR /app
COPY apps/kube_native_web/assets/package*.json /app/
COPY --from=deps /app/deps/phoenix /deps/phoenix
COPY --from=deps /app/deps/phoenix_html /deps/phoenix_html
RUN npm ci
COPY apps/kube_native_web/assets /app
RUN npm run deploy

# docker build -t kube_native:releaser --target=releaser .
FROM deps as releaser
COPY . /app/
COPY --from=frontend /priv/static apps/kube_native_web/priv/static
RUN mix do phx.digest, release --env=prod --no-tar

# docker run -it --rm elixir:1.7.3-alpine sh -c 'head -n1 /etc/issue'
FROM alpine:3.8 as runner
RUN addgroup -g 1000 kube_native && \
    adduser -D -h /app \
      -G kube_native \
      -u 1000 \
      kube_native
RUN apk add -U bash libssl1.0
USER kube_native
WORKDIR /app
COPY --from=releaser /app/_build/prod/rel/kube_native_umbrella /app
EXPOSE 4000
ENTRYPOINT ["/app/bin/kube_native_umbrella"]
CMD ["foreground"]
