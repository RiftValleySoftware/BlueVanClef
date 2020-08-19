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

cd "${CWD}"
