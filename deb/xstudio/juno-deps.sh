BRANCH="continued"

# install Juno Labs deps
wget https://github.com/juno-fx/labs-packages/raw/$BRANCH/deb/actor-framework/juno-caf-0.18.4.deb
wget https://github.com/juno-fx/labs-packages/raw/$BRANCH/deb/ffmpeg/juno-ffmpeg-5.1.deb
wget https://github.com/juno-fx/labs-packages/raw/$BRANCH/deb/nlohmann-json/juno-json-3.7.3.deb
wget https://github.com/juno-fx/labs-packages/raw/$BRANCH/deb/ocio2/juno-ocio2-2.2.0.deb
wget https://github.com/juno-fx/labs-packages/raw/$BRANCH/deb/openexr/juno-openexr-2.2.0.deb
apt install -y -f ./*.deb
rm -rfv ./*.deb
