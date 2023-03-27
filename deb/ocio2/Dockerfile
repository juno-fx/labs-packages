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
		python3-pip \
    && pip install opentimelineio

# set our work directory
WORKDIR /juno

# Cache so we don't spam the server
RUN wget "https://github.com/AcademySoftwareFoundation/OpenColorIO/archive/refs/tags/v${VERSION}.tar.gz"

# copy in the source for the build
COPY . .

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

WORKDIR /juno

RUN chmod -R 0755 juno-ocio2-${VERSION} \
    && dpkg-deb --build juno-ocio2-${VERSION}


FROM ubuntu:22.04 AS test

RUN apt update && apt upgrade -y

COPY --from=build-base /juno/juno-ocio2-*.deb ./

# Verify that it is able to be installed
RUN apt install -y -f ./juno-ocio2-*.deb \
    && ls -la /usr/local/include/OpenColorIO/


FROM alpine AS package

COPY --from=test /juno-ocio2-*.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
