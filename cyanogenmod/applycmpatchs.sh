#!/bin/bash

#Overscroll Color (1/3) http://review.cyanogenmod.com/7148
cd /home/cm4d2/packages/apps/CMParts
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_packages_apps_CMParts refs/changes/48/7148/9 && git cherry-pick FETCH_HEAD
#Overscroll Color (2/3) http://review.cyanogenmod.com/7149
cd /home/cm4d2/frameworks/base/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_frameworks_base refs/changes/49/7149/8 && git cherry-pick FETCH_HEAD
#Overscroll Color (2/3) http://review.cyanogenmod.com/7166
cd /home/cm4d2/vendor/tmobile/apps/ThemeChooser/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/themes-platform-vendor-tmobile-apps-ThemeChooser refs/changes/66/7166/3 && git cherry-pick FETCH_HEAD

#Fix hijack execution and logging (hijack logging flag must be uncommented in the BoardConfig.mk line 100) http://review.cyanogenmod.com/#change,7279
cd /home/cm4d2/device/motorola/droid2/hijack
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_device_motorola_droid2 refs/changes/79/7279/1 && git cherry-pick FETCH_HEAD
cd /home/cm4d2/device/motorola/droid2we/hijack
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_device_motorola_droid2 refs/changes/79/7279/1 && git cherry-pick FETCH_HEAD
cd /home/cm4d2/device/motorola/shadow/hijack
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_device_motorola_droid2 refs/changes/79/7279/1 && git cherry-pick FETCH_HEAD
