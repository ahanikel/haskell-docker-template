FROM    fpco/stack-build:lts-14.3 as build
RUN     mkdir /opt/build
COPY    .     /opt/build
RUN     cd /opt/build && stack install --system-ghc

FROM    ubuntu:18.04
RUN     mkdir -p /opt/haskell-template
ARG     BINARY_PATH
WORKDIR /opt/haskell-template
RUN     apt-get update && apt-get install -y ca-certificates libgmp-dev
COPY    --from=build /root/.local/bin .
COPY    "$BINARY_PATH" /opt/haskell-template
COPY    static         /opt/haskell-template/static
COPY    config         /opt/haskell-template/config
CMD     ["/opt/haskell-template/haskell-template"]
