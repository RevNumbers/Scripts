function syncrepo {
repo sync -j32
}

function applypatches {
/scripts/applycmpatchs.sh
}

function setupenv {
source build/envsetup.sh
}

function clobber {
make -j5 clobber
}

function whichdevice {
if [[ "$BUILDDEVICE" = "droid2" ]]
  then
    CMNAME="CM4D2"
    CMFILENAME="d2"
elif [[ "$BUILDDEVICE" = "droid2we" ]]
  then
    CMNAME="CM4D2G"
    CMFILENAME="d2g"
elif [[ "$BUILDDEVICE" = "shadow" ]]
  then
    CMNAME="CM4DX"
    CMFILENAME="dx"
elif [[ "$BUILDDEVICE" = "venus2" ]]
  then
    CMNAME="CM4Dpro"
    CMFILENAME="dp"
fi
}

function goodbuild {
    cp -f /home/cm4d2/out/target/product/$BUILDDEVICE/cyanogen_$BUILDDEVICE-ota-eng.cm4d2.zip $OUTPATH/$FILENAME
    md5sum $OUTPATH/$FILENAME > $OUTPATH/$FILENAME.md5
    cat $OUTPATH/$FILENAME.md5 >> /var/www/localhost/htdocs/md5sums
    FILEURL="$(plowup -d "$BUILDDEVICE-nightly-`date +%F`" multiupload  $OUTPATH/$FILENAME | grep "multiupload.com")"
    echo "<p><a href=$FILEURL target=_blank>$CMNAME Nightly Build `date +%F`</a><br />MD5: `cat /mnt/server/750/nightlies/$FILENAME.md5 | awk '{print $1}'`</p>" >> /var/www/localhost/htdocs/nightlies-$CMFILENAME.html
    /scripts/twitterpost "$FILENAME is now available on http://www.revnumbers.info #$CMNAME"
}

function badbuild {
    echo "<p><strong>Uh oh!  Something with wrong tonights nightly!<br />When RevNumbers wakes up he'll have a nasty email telling him to fix it.</strong></p>" >> /var/www/localhost/htdocs/nightlies-$CMFILENAME.html
    /scripts/twitterpost "Something went wrong with tonights #$CMNAME unofficial nightly @RevNumbers will fix it when he can"
}











