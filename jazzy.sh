#!/bin/sh
CWD="$(pwd)"
MY_SCRIPT_PATH=`dirname "${BASH_SOURCE[0]}"`
cd "${MY_SCRIPT_PATH}"

rm -drf docs/*

echo "Creating Docs for the App"

jazzy   --readme ./README.md \
        --github_url https://github.com/RiftValleySoftware/BlueVanClef \
        --title BlueVanClef\ Doumentation \
        --min_acl private \
        --output docs \
        --theme fullwidth \
        --build-tool-arguments -scheme,"Blue Van Clef (Framework)"
cp ./img/* docs/img

cd "${CWD}"
