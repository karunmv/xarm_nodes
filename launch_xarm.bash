#!/bin/bash
source /opt/ros/foxy/setup.bash
cd ./src/xarm_ros2 && git submodule update --init --remote
cd /ROS
colcon build