#!/bin/bash
source /etc/profile
FILENAME="CM4D2G-nightly-`date +%F`.zip"
cd /home/cm4d2
repo sync -j32
bash /scripts/applycmpatchs.sh
source build/envsetup.sh
export CYANOGEN_NIGHTLY=true
make clobber
CYANOGEN_NIGHTLY=true brunch droid2we

if [ -e /home/cm4d2/out/target/product/droid2we/cyanogen_droid2we-ota-eng.cm4d2.zip ]
  then
    cp -f /home/cm4d2/out/target/product/droid2we/cyanogen_droid2we-ota-eng.cm4d2.zip /mnt/server/750/nightlies/$FILENAME
    md5sum /mnt/server/750/nightlies/$FILENAME > /mnt/server/750/nightlies/$FILENAME.md5
    cat /mnt/server/750/nightlies/$FILENAME.md5 >> /var/www/localhost/htdocs/md5sumsd2g
    FILEURL="$(plowup -d "cm4d2g-nightly-`date +%F`" multiupload  /mnt/server/750/nightlies/$FILENAME | grep "multiupload.com")"
    echo "<p><a href=$FILEURL target=_blank>CM4D2G Nightly Build `date +%F`</a><br />MD5: `cat /mnt/server/750/nightlies/$FILENAME.md5 | awk '{print $1}'`</p>" >> /var/www/localhost/htdocs/nightlies-d2g.html
    /scripts/twitterpost "$FILENAME is now available on http://www.revnumbers.info/d2g.html #cm4d2g"
  else
    echo "<p><strong>Uh oh!  Something with wrong tonights nightly!<br />When RevNumbers wakes up he'll have a nasty email telling him to fix it.</strong></p>" >> /var/www/localhost/htdocs/nightlies-d2g.html
    /scripts/twitterpost "Something went wrong with tonights #cm4d2g unofficial nightly @RevNumbers will fix it when he can"
fi
