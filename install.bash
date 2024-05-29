#!/bin/bash

set -x 

: "${MATLAB_BASE_PATH:=/usr/local/MATLAB}" # assume the default install path
: "${TARGET_DIR:=$XDG_DATA_HOME/MATLAB}"
mkdir -p $TARGET_DIR

if [ -e $MATLAB_BASE_PATH ]; then
    version_paths=($MATLAB_BASE_PATH/*/)
    echo $versions
fi

mkdir -p ./desktop
mkdir -p ./scripts

for path in "${version_paths[@]}"; do 
    version=$(basename $path)
    # echo ver=$version

    # generate desktop files
    new_desktop="./desktop/MATLAB $version.desktop"
    cp "MATLAB.desktop" "$new_desktop"
    sed -i "s/{VERSION}/$version/g" "$new_desktop"

    # generate scripts
    new_script="./scripts/matlab-wrapper-$version.sh"
    cp "template.bash" "$new_script"
    sed -i "s/{VERSION}/$version/g"   "$new_script" 
    sed -i "s|{TARGET}|$TARGET_DIR|g"   "$new_script" # you can use different delimeters in sed :D

    cp "$new_desktop" "$XDG_DATA_HOME/applications/"
    chmod +x "$new_script" 
    cp "$new_script" "$HOME/.local/bin/"
done


