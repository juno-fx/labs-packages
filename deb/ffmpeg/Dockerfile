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
COPY ./build.sh ./

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh ${VERSION}

WORKDIR /juno/ffmpeg-${VERSION}

COPY juno-ffmpeg-${VERSION} /juno/juno-ffmpeg-${VERSION}

RUN make install DESTDIR="../juno-ffmpeg-${VERSION}"

WORKDIR /juno

RUN chmod -R 0755 juno-ffmpeg-${VERSION} \
    && dpkg-deb --build juno-ffmpeg-${VERSION}


FROM ubuntu:22.04 AS test

RUN apt update && apt upgrade -y

COPY --from=build-base /juno/juno-ffmpeg-*.deb ./

# Verify that it is able to be installed
RUN apt install -y -f ./juno-ffmpeg-*.deb  \
    && which ffmpeg  \
    && ffmpeg -version


FROM alpine AS package

COPY --from=test /juno-ffmpeg-*.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
