#!/usr/bin/env bash

apt-get update
apt-get install -y wget git

wget -O - https://raw.githubusercontent.com/brendan-rius/jupyter-c-kernel/master/install.sh | sh

echo ":: Install C kernel for Jupyter Notebook successfully."
echo ":: Now restart the docker container."