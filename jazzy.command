#!/bin/sh
CWD="$(pwd)"
MY_SCRIPT_PATH=`dirname "${BASH_SOURCE[0]}"`
cd "${MY_SCRIPT_PATH}"

echo "Creating Docs for the iOS App\n"
rm -drf docs/iOS

jazzy   --readme ./README.md \
       -b -scheme,BlueVanClef-iOS \
       --github_url https://github.com/RiftValleySoftware/BlueVanClef \
       --title "BlueVanClef (iOS) Doumentation" \
       --min_acl private \
       --output docs/iOS \
       --theme fullwidth
cp ./img/* docs/iOS/img

echo "Creating Docs for the MacOS App\n"
rm -drf docs/MacOS

jazzy   --readme ./README.md \
       -b -scheme,BlueVanClef-MacOS \
       --github_url https://github.com/RiftValleySoftware/BlueVanClef \
       --title "BlueVanClef (MacOS) Doumentation" \
       --min_acl private \
       --output docs/MacOS \
       --theme fullwidth
cp ./img/* docs/MacOS/img

# echo "Creating Docs for the WatchOS App\n"
# rm -drf docs/WatchOS
# 
# jazzy   --readme ./README.md \
#         -b -scheme,BlueVanClef-WatchOS-Extension \
#         --github_url https://github.com/RiftValleySoftware/BlueVanClef \
#         --title "BlueVanClef (WatchOS) Doumentation" \
#         --min_acl private \
#         --output docs/WatchOS \
#         --theme fullwidth
# cp ./img/* docs/WatchOS/img
# 
# cd "${CWD}"
