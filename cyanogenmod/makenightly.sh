#!/bin/bash
source /etc/profile
source /scripts/nightly-functions.sh
OUTPATH="/mnt/server/750/nightlies"
BUILDDEVICE="$1"
whichdevice
FILENAME="$CMNAME-nightly-`date +%F`.zip"

cd /home/cm4d2
syncrepo
setupenv
applypatches
clobber
export CYANOGEN_NIGHTLY=true
CYANOGEN_NIGHTLY=true brunch $BUILDDEVICE

if [ -e /home/cm4d2/out/target/product/$BUILDDEVICE/cyanogen_$BUILDDEVICE-ota-eng.cm4d2.zip ]
  then
  goodbuild
  else
  badbuild
fi
