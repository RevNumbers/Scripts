#!/bin/bash
source /etc/profile
FILENAME="CM4DX-nightly-`date +%F`.zip"
cd /home/cm4d2
repo sync -j32
bash /scripts/applycmpatchs.sh
source build/envsetup.sh
export CYANOGEN_NIGHTLY=true
make clobber
CYANOGEN_NIGHTLY=true brunch shadow

if [ -e /home/cm4d2/out/target/product/shadow/cyanogen_shadow-ota-eng.cm4d2.zip ]
  then
    cp -f /home/cm4d2/out/target/product/shadow/cyanogen_shadow-ota-eng.cm4d2.zip /mnt/server/750/nightlies/$FILENAME
    md5sum /mnt/server/750/nightlies/$FILENAME > /mnt/server/750/nightlies/$FILENAME.md5
    cat /mnt/server/750/nightlies/$FILENAME.md5 >> /var/www/localhost/htdocs/md5sumsdx
    FILEURL="$(plowup -d "cm4dx-nightly-`date +%F`" multiupload  /mnt/server/750/nightlies/$FILENAME | grep "multiupload.com")"
    echo "<p><a href=$FILEURL target=_blank>CM4DX Nightly Build `date +%F`</a><br />MD5: `cat /mnt/server/750/nightlies/$FILENAME.md5 | awk '{print $1}'`</p>" >> /var/www/localhost/htdocs/nightlies-dx.html
    /scripts/twitterpost "$FILENAME is now available on http://www.revnumbers.info/dx.html #cm4dx"
  else
    echo "<p><strong>`date +%F`:<br />Uh oh!  Something went wrong with tonights nightly!<br />When RevNumbers wakes up he'll have a nasty email telling him to fix it.</strong></p>" >> /var/www/localhost/htdocs/nightlies-dx.html
    /scripts/twitterpost "Something went wrong with tonights #cm4dx unofficial nightly @RevNumbers will fix it when he can"
fi
