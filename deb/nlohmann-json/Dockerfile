
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

# set our work directory
WORKDIR /juno

# Cache so we don't spam the server
RUN wget "https://github.com/nlohmann/json/archive/refs/tags/v${VERSION}.tar.gz"

# copy in the source for the build
COPY . .

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

RUN chmod -Rv 0755 juno-json-${VERSION} \
    && dpkg-deb --build juno-json-${VERSION}


FROM ubuntu:22.04 AS test

RUN apt update && apt upgrade -y

COPY --from=build-base /juno/*.deb .

# Verify that it is able to be installed
RUN apt install -f ./*.deb -y \
    && ls -la /usr/local/include/nlohmann/ \
    && ls -la /usr/local/lib/cmake/nlohmann_json/


FROM alpine AS package

COPY --from=test /*.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
