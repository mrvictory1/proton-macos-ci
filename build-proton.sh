#!/bin/bash
if [[ ! -z "$GITHUB_ACTIONS" ]]; then
DEPTH="--depth=1"
# GitHub Actions runner has a different version of perl installed without json module.
# Perl json module is required by vkd3d.
# macOS provided perl does not need this step.
brew uninstall perl
fi

# Wine's dlls/win32u/opengl.c file fails to compile if libEGL is missing. However there isn't
# a nice way to download or compile libEGL so instead it is copied from Google Chrome.
# Source: https://stackoverflow.com/a/77461235
# The .dylib files are (currently) universal so this step should still work under Rosetta 2.
CHROME_LIB_DIR="/Applications/Google Chrome.app/Contents/Frameworks/Google Chrome Framework.framework/Libraries"
if [[ -e /usr/local/lib/libEGL.dylib ]]; then
    if [[ -d "/Applications/Google Chrome.app/" ]] ; then
        cp "$CHROME_LIB_DIR"/libGLESv2.dylib /usr/local/lib
        cp "$CHROME_LIB_DIR"/libEGL.dylib /usr/local/lib
    else
        echo "Copy libEGL.dylib and libGLESv2.dylib from an application supplying them"
        echo "to /usr/local/lib. Google Chrome and other Chromium based browsers come"
        echo "with these libraries."
        echo "You may want to read / edit the script."
        exit 1
    fi
fi

if [[ ! $(cat .brew-deps) -gt 0 ]] ; then
brew install automake bison cmake coreutils findutils fontforge glib glib-networking grep libffi libnghttp2 libvpx lld make meson mingw-w64 molten-vk mpg123 nasm opus orc rust sdl2-compat spirv-headers theora vulkan-headers wget zlib
echo "1" > .brew-deps
fi

if [ ! -d venv ] ; then
    python3 -m venv venv
fi
source venv/bin/activate
if [[ ! $(cat .python-deps) -gt 0 ]] ; then
    pip3 install afdko
    echo "1" > .python-deps
fi

# not sure if grep is needed
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/libtool/libexec/gnubin:$PATH"

git clone https://github.com/ValveSoftware/Proton/ $DEPTH
cd Proton

# Upstream DXVK is not compatible with macOS
# git am ../patches/repo-pre/*
git submodule set-url dxvk https://github.com/Gcenx/DXVK-macOS
git submodule set-branch --branch 1.10.x dxvk
git submodule update --init --recursive $DEPTH
cd dxvk
git checkout 1.10.x
cd ..
git am ../patches/repo/*

to_patch=("piper" "wine")
for i in "${to_patch[@]}" ; do
    cd $i
    git am ../../patches/$i/*
    cd ..
done

# Piper build fails due to a dependency downloaded *during* build time.
# So instead of patching before building, start the build and let it fail.
make piper || true

SPEECHPLAYER_DIR="obj-piper-x86_64/p/src/piper_phonemize_external-build/e/src/espeak_ng_external/src/speechPlayer/src"
ESPEAK_PATCH_DIR=../patches/espeak
for i in $(ls $ESPEAK_PATCH_DIR) ; do
    ORIG_FILE=$(echo $i | sed s/\.diff//)
    patch build/build-*/$SPEECHPLAYER_DIR/$ORIG_FILE $ESPEAK_PATCH_DIR/$i
done

# Wine build fails due to lld-link failing to link vkd3d into wined3d.
# Custom commands that aren't easy to integrate into the build system
# need to be executed.
make redist || true
../wined3d.sh
make redist #again
