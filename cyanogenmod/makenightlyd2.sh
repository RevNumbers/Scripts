#!/bin/bash
source /etc/profile
FILENAME="CM4D2-nightly-`date +%F`.zip"
cd /home/cm4d2
repo sync -j32
# apply any cherry picks I think are cool... or want to test
bash /scripts/applycmpatchs.sh

source build/envsetup.sh
export CYANOGEN_NIGHTLY=true
make clobber

# setting CYANOGEN_NIGHTLY is redundant... but better safe than sorry
CYANOGEN_NIGHTLY=true brunch droid2

# not the best way to check the build was complete... but it works for now ;-)
if [ -e /home/cm4d2/out/target/product/droid2/cyanogen_droid2-ota-eng.cm4d2.zip ]
  then
    cp -f /home/cm4d2/out/target/product/droid2/cyanogen_droid2-ota-eng.cm4d2.zip /mnt/server/750/nightlies/$FILENAME
    md5sum /mnt/server/750/nightlies/$FILENAME > /mnt/server/750/nightlies/$FILENAME.md5
    cat /mnt/server/750/nightlies/$FILENAME.md5 >> /var/www/localhost/htdocs/md5sums
    
    # upload th
    FILEURL="$(plowup -d "cm4d2-nightly-`date +%F`" multiupload  /mnt/server/750/nightlies/$FILENAME | grep "multiupload.com")"
    echo "<p><a href=$FILEURL target=_blank>CM4D2 Nightly Build `date +%F`</a><br />MD5: `cat /mnt/server/750/nightlies/$FILENAME.md5 | awk '{print $1}'`</p>" >> /var/www/localhost/htdocs/nightlies-d2.html
    
    # Tweet that the build is available
    /scripts/twitterpost "$FILENAME is now available on http://www.revnumbers.info #cm4d2"
  else
    
    # If it wasn't complete say so on the website, and send a tweet saying so
    echo "<p><strong>Uh oh!  Something with wrong tonights nightly!<br />When RevNumbers wakes up he'll have a nasty email telling him to fix it.</strong></p>" >> /var/www/localhost/htdocs/nightlies-d2.html
    /scripts/twitterpost "Something went wrong with tonights #cm4d2 unofficial nightly @RevNumbers will fix it when he can"
fi
