#!/bin/sh

sudo launchctl stop nginx
sudo pkill -9 -f "nginx: master process"
sudo pkill -9 -f "nginx: worker process"
sudo launchctl start nginx
