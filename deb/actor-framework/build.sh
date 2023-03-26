# Throttle so we don't murder the build server
TOTAL_CPUS=$(nproc)
HALF_CPUS=$((TOTAL_CPUS / 2))
JOBS=$((HALF_CPUS > 0 ? HALF_CPUS : 1))

# notify
echo "VERSION: $1"
echo "JOBS: $JOBS"

# unpack
tar -xf "$1.tar.gz"
# shellcheck disable=SC2164
cd "actor-framework-$1"

./configure

# shellcheck disable=SC2164
cd build

# start building
make -j $JOBS

# install into the juno-caf package
make install DESTDIR="../../juno-caf-$1"
