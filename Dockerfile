FROM    fpco/stack-build:lts-14.3 as build
RUN     mkdir /opt/build
COPY    .     /opt/build
RUN     cd /opt/build && stack build --system-ghc

FROM    ubuntu:16.04
RUN     mkdir -p /opt/myapp
ARG     BINARY_PATH
WORKDIR /opt/myapp
RUN     apt-get update && apt-get install -y ca-certificates libgmp-dev
COPY    --from=build /opt/build/.stack-work/install/x86_64-linux/lts-14.3/8.6.5/bin .
COPY    "$BINARY_PATH" /opt/myapp
COPY    static         /opt/myapp/static
COPY    config         /opt/myapp/config
CMD     ["/opt/myapp/myapp"]
