<br />
<p align="center">
    <img src="https://avatars.githubusercontent.com/u/9037579?v=4"/>
    <h3 align="center">FFMPEG</h3>
    <p align="center">
        Used to build xStudio
    </p>
</p>

## About The Project

Builds packages of the [FFMPEG](https://ffmpeg.org/ffmpeg.html) for Debian and Ubuntu. 
This is in response to a need for it to build [xStudio](https://github.com/AcademySoftwareFoundation/xstudio) as is stated in the
[docs](https://github.com/AcademySoftwareFoundation/xstudio/blob/main/docs/build_guides/ubuntu_22_04.md#ffmpeg).

## Package

You can download the `.deb` package directly from this repository using wget:

```bash
wget https://github.com/juno-fx/labs-packages/raw/main/deb/ffmpeg/juno-ffmpeg-5.1.deb
```

You can then install it using one of the following commands:
```bash
apt install -f ./juno-ffmpeg-5.1.deb
```

```bash
dpkg -i ./juno-ffmpeg-5.1.deb
```

#### Building Yourself
The package is built using docker in an Ubuntu 22.04 container. You can build the package by running the following 
command:

```bash
git clone https://github.com/juno-fx/labs-packages.git
cd labs-packages/deb/ffmpeg
VERSION=5.1 docker-compose up --build
```