#!/usr/bin/env bash

apt-get update
apt-get install -y python-dev python-pip

pip install --upgrade pip

python2 -m pip install ipykernel
python2 -m ipykernel install --user

echo ":: Install Python2 kernel for Jupyter Notebook successfully."
echo ":: Now restart the docker container."