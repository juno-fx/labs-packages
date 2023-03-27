# Throttle so we don't murder the build server
TOTAL_CPUS=$(nproc)
HALF_CPUS=$((TOTAL_CPUS / 2))
JOBS=$((HALF_CPUS > 0 ? HALF_CPUS : 1))

# notify
echo "VERSION: $1"
echo "JOBS: $JOBS"

# unpack
tar -xf "v$1.tar.gz"

# shellcheck disable=SC2164
cd "OpenColorIO-$1/"

# jump to build
mkdir build
cd build
cmake -DOCIO_BUILD_APPS=OFF -DOCIO_BUILD_TESTS=OFF -DOCIO_BUILD_GPU_TESTS=OFF ../
make -j $JOBS
make install DESTDIR="../../juno-ocio2-$1"
