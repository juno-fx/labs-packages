<br />
<p align="center">
    <img src="https://avatars.githubusercontent.com/u/9037579?v=4"/>
    <h3 align="center">OpenColorIO</h3>
    <p align="center">
        Used to build xStudio
    </p>
</p>

## About The Project

Builds packages of the [OpenColorIO](https://github.com/AcademySoftwareFoundation/OpenColorIO/) for Debian and Ubuntu. 
This is in response to a need for it to build [xStudio](https://github.com/AcademySoftwareFoundation/xstudio) as is stated in the
[docs](https://github.com/AcademySoftwareFoundation/xstudio/blob/main/docs/build_guides/ubuntu_22_04.md#ffmpeg).

## Package

You can download the `.deb` package directly from this repository using wget:

```bash
wget https://github.com/juno-fx/labs-packages/raw/main/deb/ffmpeg/juno-ocio2-2.2.0.deb
```

You can then install it using one of the following commands:
```bash
apt install -f ./juno-ocio2-2.2.0.deb
```

```bash
dpkg -i ./juno-ocio2-2.2.0.deb
```

#### Building Yourself
The package is built using docker in an Ubuntu 22.04 container. You can build the package by running the following 
command:

```bash
git clone https://github.com/juno-fx/labs-packages.git
cd labs-packages/deb/ocio2
VERSION=2.2.0 docker-compose up --build
```

The resulting `.deb` package will be in the current working directory.
