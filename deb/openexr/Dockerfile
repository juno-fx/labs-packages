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
		zlib1g-dev

# set our work directory
WORKDIR /juno

# Cache so we don't spam the server
RUN git clone https://github.com/AcademySoftwareFoundation/openexr.git

# copy in the source for the build
COPY . .

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

WORKDIR /juno

RUN chmod -R 0755 juno-openexr-${VERSION} \
    && dpkg-deb --build juno-openexr-${VERSION}


FROM ubuntu:22.04 AS test

RUN apt update && apt upgrade -y

COPY --from=build-base /juno/juno-openexr-*.deb ./

# Verify that it is able to be installed
RUN apt install -y -f ./juno-openexr-*.deb \
    && ls -la /usr/local/include/OpenEXR


FROM alpine AS package

COPY --from=test /juno-openexr-*.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
