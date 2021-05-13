# XCP-ng guest tools for RancherOS 

XCP-ng is a virtualization platform. You can read more about it here: [https://xcp-ng.org](https://xcp-ng.org)

RancherOS is a minimalist linux distribution, designed to run docker. More info here: [https://rancher.com/docs/os/v1.x/en/](https://rancher.com/docs/os/v1.x/en/)

This repository has an alpine linux docker image that contains the XCP-ng [guest tools](https://xcp-ng.org/docs/guests.html#alpine), configured for use within RancherOS. It was created to speed up the configuration process of a virtualized RancherOS VM within XCP-ng.

# Installation (From [Docker Hub](https://hub.docker.com/r/geomsk/ros-xe-guest-utilities))
Add the following to your `cloud-config.yml` when [installing](https://rancher.com/docs/os/v1.x/en/installation/server/install-to-disk/) RancherOS for the first time. Example command: `sudo ros install -c cloud-config.yml -d /dev/sdX`

If you have an existing installation you can edit the `/var/lib/rancher/conf/cloud-config.d/user_config.yml` file and reboot.

``` yaml
rancher:
  services:
    ros-xe-guest-utilities:
      container_name: ros-xe-guest-utilities
      image: geomsk/ros-xe-guest-utilities
      net: host
      privileged: true
      labels:
        io.rancher.os.scope: system
        io.rancher.os.after: network
```

Now everytime your RancherOS VM boots, the guest tools will run as well.


# Run Manually (Testing)

This is not required if you performed the instalation steps above. This is only for testing. If you want to test it first without touching your cloud-config, simply run it as a docker container.

``` bash
docker run -d --net=host --privileged=true geomsk/ros-xe-guest-utilities
```

When you finish testing you can remove it
``` bash
docker stop `docker ps | grep geomsk/ros-xe-guest-utilities | awk '{printf $1}'`
docker container rm `docker container ls -a | grep geomsk/ros-xe-guest-utilities | awk '{printf $1}'`
docker image rm `docker image ls | grep geomsk/ros-xe-guest-utilities | awk '{printf $3}'`
```
