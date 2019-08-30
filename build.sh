#!/bin/bash
id="winetree94"
repository="jenkins-docker"

docker build -t "${id}/${repository}" . --rm -q