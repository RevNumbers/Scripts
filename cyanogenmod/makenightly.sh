#!/bin/bash
source /etc/profile
source /scripts/nightly-functions.sh
OUTPATH="/mnt/server/750/nightlies"
BUILDDEVICE="$1"
whichdevice
export CYANOGEN_NIGHTLY=true
FILENAME="$CMNAME-nightly-`date +%F`.zip"
ARGS="$@"

if [[ "$ARGS" =~ "noclobber" ]]
  then
    NOCLOBBER="1"
fi

if [[ "$ARGS" =~ "noupload" ]]
  then
    NOUPLOAD="1"
fi

if [[ "$ARGS" =~ "nopatches" ]]
  then
    NOPATCHES="1"
fi

if [[ "$ARGS" =~ "nosync" ]]
  then
    NOSYNC="1"
    #Since patching will fail if sync hasn't been done also set
    NOPATCHES="1"
fi

cd /home/cm4d2
if test -n "$NOSYNC"
  then
    echo "You have chosen not to sync before build"
  else
    syncrepo
fi
setupenv
if test -n "$NOPATCHES"
  then
    echo "You have chosen not to apply any patches"
  else
    applypatches
fi
if test -n "$NOCLOBBER"
  then
    echo "You have chosen not to clean the tree before build"
  else
    clobber
fi
echo "##########################################################"
echo "             Starting build for $BUILDDEVICE              "
echo "##########################################################"
CYANOGEN_NIGHTLY=true brunch $BUILDDEVICE

if test -n "$NOUPLOAD"
  then
    "You have chosen not to upload/post"
  else
    if [ -e /home/cm4d2/out/target/product/$BUILDDEVICE/cyanogen_$BUILDDEVICE-ota-eng.cm4d2.zip ]
      then
        goodbuild
      else
        badbuild
    fi
fi
