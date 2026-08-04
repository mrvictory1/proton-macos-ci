#!/bin/bash
if [[ ! $(cat .brew-deps) -gt 0 ]] ; then
brew install automake bison cmake coreutils findutils fontforge glib glib-networking grep libnghttp2 lld make meson mingw-w64 molten-vk mpg123 nasm opus orc rust sdl2-compat spirv-headers tailscale theora vulkan-headers wget
echo "1" > .brew-deps
fi

if [ -d venv ] ; then
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

git clone https://github.com/ValveSoftware/Proton/
cd Proton

# Upstream DXVK is not compatible with macOS
# git am ../patches/repo-pre/*
git submodule set-url dxvk https://github.com/Gcenx/DXVK-macOS
git submodule set-branch --branch 1.10.x dxvk
git submodule update --init --recursive
git am ../patches/repo/*

to_patch=("piper" "wine")
for i in "${to_patch[@]}" ; do
    cd $i
    git am ../../patches/$i/*
    cd ..
done

# Piper build fails due to a dependency downloaded *during* build time.
# So instead of patching before building, start the build and let it fail.
make piper

SPEECHPLAYER_DIR="obj-piper-x86_64/p/src/piper_phonemize_external-build/e/src/espeak_ng_external/src/speechPlayer/src"
ESPEAK_PATCH_DIR=../patches/espeak
for i in $(ls $ESPEAK_PATCH_DIR) ; do
    ORIG_FILE=$(echo $i | sed s/\.diff//)
    patch build/build-*/$SPEECHPLAYER_DIR/$ORIG_FILE $ESPEAK_PATCH_DIR/$i
done

# Wine build fails due to lld-link failing to link vkd3d into wined3d.
# Custom commands that aren't easy to integrate into the build system
# need to be executed.
make redist
../wined3d.sh
make redist #again
