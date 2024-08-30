# ROS2 xArm Image

NOTE: Please use the --recursive flag to clone this repo in order to clone the submodule repos along with the main branch

Pull the xarm_nodes image and perform the following:

```sh
$ cd <path>/<to>/xarm_nodes
$ docker build -t xarm-node .
```
After building, a basic terminal inside the container can be opened with:

```sh
$ docker run -it xarm-node:latest
```
## Adding the option to use GUI programs

In the host system, do the following: 

```sh
$ xhost +local:root
```
Now, rerun the container with the following flags:

```sh
$ docker run --name xarm -it --network=host --ipc=host -v /tmp/.X11-unix/:/tmp/.X11-unix/:rw --env=DISPLAY xarm-node:latest
```

This enables the use of GUI programs like rqt, rviz2, gazebo etc.

Now you are ready to test basic topics and services provided in https://github.com/xArm-Developer/xarm_ros2/tree/foxy