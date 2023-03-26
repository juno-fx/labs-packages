<br />
<p align="center">
    <img src="https://avatars.githubusercontent.com/u/77702266?s=200&v=4"/>
    <h3 align="center">C++ Actor Framework</h3>
    <p align="center">
        Contains packages used by Juno Labs
    </p>
</p>

## About The Project

Builds packages of the [C++ Actor Framework](https://actor-framework.readthedocs.io/en/stable/) for Debian and Ubuntu. 
This is in response to a need for it to build [xStudio](https://github.com/AcademySoftwareFoundation/xstudio) as is stated in the
[docs](https://github.com/AcademySoftwareFoundation/xstudio/blob/main/docs/build_guides/ubuntu_22_04.md#actorframework).

## Package

You can download the `.deb` package directly from this repository using wget:

```bash
wget 
```

#### Building Yourself
The package is built using docker in an Ubuntu 22.04 container. You can build the package by running the following 
command:

```bash
git clone https://github.com/juno-fx/labs-packages.git
cd labs-packages/deb/actor-framework
VERSION=0.18.4 docker-compose up --build
```
