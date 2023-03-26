
# Build base
FROM ubuntu:22.04 AS build-base

ARG VERSION

ENV DEBIAN_FRONTEND noninteractive

# system deps
RUN apt update  \
    && apt upgrade -y \
    && apt install -y \
		build-essential \
		cmake \
		git \
    	wget

# build deps
RUN apt install -y \
    	libssl-dev

# set our work directory
WORKDIR /juno

# Cache so we don't spam the server
RUN wget "https://github.com/actor-framework/actor-framework/archive/refs/tags/${VERSION}.tar.gz"

# copy in the source for the build
COPY . .

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

RUN chmod -Rv 0755 juno-caf-${VERSION} \
    && dpkg-deb --build juno-caf-${VERSION}

FROM build-base AS test

ARG VERSION

# Verify that it is able to be installed
RUN dpkg -i juno-caf-${VERSION}.deb \
    && ls -la /usr/local/lib/libcaf*

FROM alpine AS package

ARG VERSION

COPY --from=test /juno/juno-caf-${VERSION}.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
