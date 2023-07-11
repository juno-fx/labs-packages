# Build base
FROM ubuntu:22.04 AS build-base

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

# copy in the source for the build
COPY juno-deps.sh ./juno-deps.sh

# Install Juno Labs pre-built dependencies
RUN chmod -v +x ./juno-deps.sh \
    && ./juno-deps.sh

# Cache so we don't spam the server
RUN git clone https://github.com/AcademySoftwareFoundation/xstudio.git \
    && cd xstudio \
    && git reset --hard 56bf691bb025ec405227c9185e8bb3bcd28c3a3c # rolling back to March 10th because of docs issue

# build deps
RUN apt install -y \
		python3-pip \
		python-is-python3 \
		pybind11-dev \
		libpython3-dev \
		libspdlog-dev \
		libfmt-dev \
		libssl-dev \
		zlib1g-dev \
		libasound2-dev \
		nlohmann-json3-dev \
		uuid-dev \
		libglu1-mesa-dev \
		freeglut3-dev \
		mesa-common-dev \
		libglew-dev \
		libfreetype-dev \
		libjpeg-dev \
		libpulse-dev \
		yasm \
		nasm \
		libfdk-aac-dev \
		libfdk-aac2 \
		libmp3lame-dev \
		libopus-dev \
		libvpx-dev \
		libx265-dev \
		libx264-dev \
		qttools5-dev \
		qtbase5-dev \
		qt5-qmake  \
		qtdeclarative5-dev \
		qtquickcontrols2-5-dev \
		qml-module-qtquick* \
		qml-module-qt-labs-*

# copy in the source for the build
COPY build.sh ./build.sh

# Start the build process
RUN chmod -v +x ./build.sh \
    && ./build.sh

WORKDIR /juno

COPY ./juno-xstudio-1.0.0 ./juno-xstudio

RUN mkdir -p ./juno-xstudio/opt/xstudio/ \
    && cp -r ./xstudio/build/bin/* ./juno-xstudio/opt/xstudio/ \
    && mkdir -p /opt/xstudio/ \
    && touch /opt/xstudio/xstudio.bin \
    && mkdir -p ./juno-xstudio/usr/local/bin/ \
    && ln -sf /opt/xstudio/xstudio.bin ./juno-xstudio/usr/local/bin/xstudio

RUN chmod -R 0755 juno-xstudio \
    && dpkg-deb --build juno-xstudio


FROM ubuntu:22.04 AS test

RUN apt update && apt upgrade -y

COPY juno-deps.sh ./

RUN apt install -y wget \
    && chmod -v +x ./juno-deps.sh \
	&& ./juno-deps.sh

COPY --from=build-base /juno/juno-xstudio.deb ./

# Verify that it is able to be installed
RUN apt install -y -f ./juno-xstudio.deb \
    && which xstudio

RUN apt install -y python3-pip \
    && pip3 install --upgrade opentimelineio

RUN export QV4_FORCE_INTERPRETER=1 \
    && export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/opt/xstudio/lib \
    && export PYTHONPATH=/opt/xstudio/python/lib/python3.10/site-packages \
    && export XSTUDIO_ROOT=/opt/xstudio
#	&& xstudio --pref /opt/xstudio/preference/


FROM alpine AS package

COPY --from=test /juno-xstudio.deb .

CMD cp -r *.deb /output/ && chmod -R 777 /output/
