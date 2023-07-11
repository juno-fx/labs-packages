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
cd "json-$1"

mkdir build
# shellcheck disable=SC2164
cd build

# start building
cmake .. -DJSON_BuildTests=Off
make -j $JOBS

# install into the juno-caf package
make install DESTDIR="../../juno-json-$1"
