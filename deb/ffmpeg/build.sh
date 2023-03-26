# Throttle so we don't murder the build server
TOTAL_CPUS=$(nproc)
HALF_CPUS=$((TOTAL_CPUS / 2))
JOBS=$((HALF_CPUS > 0 ? HALF_CPUS : 1))

# notify
echo "VERSION: $1"
echo "JOBS: $JOBS"

# unpack
tar -xf "ffmpeg-$1.tar.bz2"
# shellcheck disable=SC2164
cd "ffmpeg-$1"

# configuration for build
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
./configure \
  --extra-libs=-lpthread \
  --extra-libs=-lm \
  --enable-gpl \
  --enable-libfdk_aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-shared \
  --enable-nonfree

make -j $JOBS
