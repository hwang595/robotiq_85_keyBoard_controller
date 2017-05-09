#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/hwang/My_Code/robotics_research/gripper_controller/src/robotiq_85_gripper/robotiq_85_driver"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/hwang/My_Code/robotics_research/gripper_controller/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/hwang/My_Code/robotics_research/gripper_controller/install/lib/python2.7/dist-packages:/home/hwang/My_Code/robotics_research/gripper_controller/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/hwang/My_Code/robotics_research/gripper_controller/build" \
    "/usr/bin/python" \
    "/home/hwang/My_Code/robotics_research/gripper_controller/src/robotiq_85_gripper/robotiq_85_driver/setup.py" \
    build --build-base "/home/hwang/My_Code/robotics_research/gripper_controller/build/robotiq_85_gripper/robotiq_85_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/hwang/My_Code/robotics_research/gripper_controller/install" --install-scripts="/home/hwang/My_Code/robotics_research/gripper_controller/install/bin"
