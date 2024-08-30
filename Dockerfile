FROM ros:foxy
LABEL maintainer=""
LABEL version="0.01"
LABEL description="xarm-node"

ARG DEBIAN_FRONTEND=noninteractive
ARG host

#Expose ports
EXPOSE 5000

#Install ROS
WORKDIR /ROS/

RUN mkdir src/

COPY ./xarm_ros2 ./src/xarm_ros2/

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    build-essential \
    ros-foxy-ament-cmake \
    python3-colcon-common-extensions \
    python3-rosdep

# #Copy new setup.bash file, to include cyclonedds
#RUN rm /opt/ros/foxy/setup.bash
#COPY setup.bash /opt/ros/foxy/

RUN rosdep update --include-eol-distros && rosdep install --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

#Install and setup chrony
RUN apt update && apt install udev uvcdynctrl v4l-utils -y && rm -rf /var/lib/apt/lists/*

COPY launch_xarm.bash .
RUN chmod +x launch_xarm.bash

COPY docker-compose.yml .

RUN ./launch_xarm.bash

# Source the setup file automatically when the container starts
RUN echo "source /ROS/install/setup.bash" >> ~/.bashrc 

#ENTRYPOINT ["/bin/bash", "/ROS/launch_xarm.bash"]