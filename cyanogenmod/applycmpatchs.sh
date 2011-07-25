#!/bin/bash

#Usb service change to use intents http://review.cyanogenmod.com/#change,6441
cd /home/cm4d2/frameworks/base/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_frameworks_base refs/changes/41/6441/1 && git cherry-pick FETCH_HEAD

#add signal dBm option http://review.cyanogenmod.com/6904
cd /home/cm4d2/frameworks/base/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_frameworks_base refs/changes/04/6904/2 && git cherry-pick FETCH_HEAD

#Separate Timeout for Screen and Security Lock http://review.cyanogenmod.com/6526
cd /home/cm4d2/frameworks/base/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_frameworks_base refs/changes/26/6526/1 && git cherry-pick FETCH_HEAD

#add signal dBm option http://review.cyanogenmod.com/6903
cd /home/cm4d2/packages/apps/CMParts/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_packages_apps_CMParts refs/changes/03/6903/2 && git cherry-pick FETCH_HEAD

#Separate Timeout for Screen and Security Lock http://review.cyanogenmod.com/6527
cd /home/cm4d2/packages/apps/CMParts/
git fetch http://review.cyanogenmod.com/p/CyanogenMod/android_packages_apps_CMParts refs/changes/27/6527/1 && git cherry-pick FETCH_HEAD
