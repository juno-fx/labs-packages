# Throttle so we don't murder the build server
TOTAL_CPUS=$(nproc)
HALF_CPUS=$((TOTAL_CPUS / 2))
JOBS=$((HALF_CPUS > 0 ? HALF_CPUS : 1))

# notify
echo "VERSION: $1"
echo "JOBS: $JOBS"

# setup build env
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:/usr/local/lib64/pkgconfig
# shellcheck disable=SC2164
cd xstudio
mkdir build
# shellcheck disable=SC2164
cd build

# build
cmake .. -DBUILD_DOCS=Off
make -j $JOBS
