# Throttle so we don't murder the build server
TOTAL_CPUS=$(nproc)
HALF_CPUS=$((TOTAL_CPUS / 2))
JOBS=$((HALF_CPUS > 0 ? HALF_CPUS : 1))

# notify
echo "VERSION: $1"
echo "JOBS: $JOBS"

# shellcheck disable=SC2164
cd "openexr"
git checkout RB-3.1

# jump to build
mkdir build
cd build
cmake .. -DOPENEXR_INSTALL_TOOLS=Off -DBUILD_TESTING=Off
make -j $JOBS
make install DESTDIR="../../juno-openexr-$1"
