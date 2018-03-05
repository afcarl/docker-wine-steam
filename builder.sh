#!/bin/sh

# Getting the user id.
MYUID=`id -u`

TEMP=$(mktemp -d)

# Copying the Dockerfile to set parameters.
cp -f Dockerfile $TEMP/ && cp -f finalize_installation.sh $TEMP/

# Setting the right user id.
sed -i -e "s/1001/$MYUID/g" $TEMP/Dockerfile

# Building the image.
docker build -t webanck/docker-wine-steam $TEMP/

# Cleaning up.
rm -rf $TEMP/
