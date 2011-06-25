#!/bin/bash
source /etc/profile
FILENAME="CM4D2-nightly-`date +%F`.zip"
cd /home/cm4d2
repo sync -j32
source build/envsetup.sh
make clobber
brunch droid2
cp -f /home/cm4d2/out/target/product/droid2/cyanogen_droid2-ota-eng.cm4d2.zip /mnt/server/750/nightlies/$FILENAME
FILEURL="$(plowup -d "cm4d2-nightly-`date +%F`" multiupload  /mnt/server/750/nightlies/$FILENAME | grep "multiupload.com")"
echo "<p><a href=$FILEURL>CM4D2 Nightly Build `date +%F`</a></p>" >> /var/www/localhost/htdocs/index.html
