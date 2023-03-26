
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
		yasm \
		nasm \
        libfdk-aac-dev \
        libfdk-aac2 \
    	libfreetype-dev \
    	libmp3lame-dev \
    	libopus-dev \
		libvpx-dev \
		libx265-dev \
		libx264-dev

# set our work directory
WORKDIR /juno

# Cache so we don't spam the server
RUN wget "https://ffmpeg.org/releases/ffmpeg-${VERSION}.tar.bz2"

# copy in the source for the build
COPY . .

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

RUN mkdir -p juno-ffmpeg-${VERSION}/usr/local/lib/ \
    && mkdir -p juno-ffmpeg-${VERSION}/usr/local/bin/ \
    && cp -r ffmpeg-${VERSION}/ff* juno-ffmpeg-${VERSION}/usr/local/bin/ \
    && chmod -R 0755 juno-ffmpeg-${VERSION} \
    && dpkg-deb --build juno-ffmpeg-${VERSION}

FROM build-base AS test

ARG VERSION

# Verify that it is able to be installed
RUN apt install -y -f ./juno-ffmpeg-${VERSION}.deb
RUN find / -name libavdevice.so \
    && which ffmpeg

FROM alpine AS package

ARG VERSION

COPY --from=test /juno/juno-ffmpeg-${VERSION}.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
