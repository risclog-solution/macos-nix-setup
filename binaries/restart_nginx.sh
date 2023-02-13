#!/bin/sh

sudo launchctl stop nginx
sudo pkill -9 -f "nginx: master process"
sudo launchctl start nginx
