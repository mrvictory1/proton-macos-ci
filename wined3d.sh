#!/bin/bash
cd build/build*/obj-wine-x86_64
tools/winegcc/winegcc -o dlls/wined3d/i386-windows/wined3d.dll --wine-objdir . -b i686-windows -Wl,--wine-builtin -shared \
  ../src-wine/dlls/wined3d/wined3d.spec \
  dlls/wined3d/i386-windows/adapter_gl.o dlls/wined3d/i386-windows/adapter_vk.o \
  dlls/wined3d/i386-windows/buffer.o dlls/wined3d/i386-windows/context.o \
  dlls/wined3d/i386-windows/context_gl.o dlls/wined3d/i386-windows/context_vk.o \
  dlls/wined3d/i386-windows/cs.o dlls/wined3d/i386-windows/decoder.o \
  dlls/wined3d/i386-windows/device.o dlls/wined3d/i386-windows/directx.o \
  dlls/wined3d/i386-windows/ffp_gl.o dlls/wined3d/i386-windows/ffp_hlsl.o \
  dlls/wined3d/i386-windows/gl_compat.o dlls/wined3d/i386-windows/glsl_shader.o \
  dlls/wined3d/i386-windows/palette.o dlls/wined3d/i386-windows/query.o \
  dlls/wined3d/i386-windows/resource.o dlls/wined3d/i386-windows/sampler.o \
  dlls/wined3d/i386-windows/shader.o dlls/wined3d/i386-windows/shader_sm1.o \
  dlls/wined3d/i386-windows/shader_sm4.o dlls/wined3d/i386-windows/shader_spirv.o \
  dlls/wined3d/i386-windows/stateblock.o dlls/wined3d/i386-windows/surface.o \
  dlls/wined3d/i386-windows/swapchain.o dlls/wined3d/i386-windows/texture.o \
  dlls/wined3d/i386-windows/texture_gl.o dlls/wined3d/i386-windows/texture_vk.o \
  dlls/wined3d/i386-windows/utils.o dlls/wined3d/i386-windows/vertexdeclaration.o \
  dlls/wined3d/i386-windows/view.o dlls/wined3d/i386-windows/wined3d_main.o \
  dlls/wined3d/resource.res dlls/wined3d/version.res \
  -L../dst-vkd3d-i386/lib -lvkd3d \
  -lvkd3d-shader -lvkd3d-utils libs/dxguid/i386-windows/libdxguid.a \
  dlls/opengl32/i386-windows/libopengl32.a dlls/user32/i386-windows/libuser32.a \
  dlls/gdi32/i386-windows/libgdi32.a dlls/advapi32/i386-windows/libadvapi32.a \
  dlls/winecrt0/i386-windows/libwinecrt0.a libs/compiler-rt/i386-windows/libcompiler-rt.a \
  dlls/ucrtbase/i386-windows/libucrtbase.a dlls/kernel32/i386-windows/libkernel32.a \
  dlls/ntdll/i386-windows/libntdll.a --no-default-config -fms-hotpatch -Wl,--build-id -Wl,/safeseh:no
tools/winegcc/winegcc -o dlls/wined3d/x86_64-windows/wined3d.dll --wine-objdir . -b x86_64-windows -Wl,--wine-builtin -shared \
  ../src-wine/dlls/wined3d/wined3d.spec \
  dlls/wined3d/x86_64-windows/adapter_gl.o dlls/wined3d/x86_64-windows/adapter_vk.o \
  dlls/wined3d/x86_64-windows/buffer.o dlls/wined3d/x86_64-windows/context.o \
  dlls/wined3d/x86_64-windows/context_gl.o dlls/wined3d/x86_64-windows/context_vk.o \
  dlls/wined3d/x86_64-windows/cs.o dlls/wined3d/x86_64-windows/decoder.o \
  dlls/wined3d/x86_64-windows/device.o dlls/wined3d/x86_64-windows/directx.o \
  dlls/wined3d/x86_64-windows/ffp_gl.o dlls/wined3d/x86_64-windows/ffp_hlsl.o \
  dlls/wined3d/x86_64-windows/gl_compat.o dlls/wined3d/x86_64-windows/glsl_shader.o \
  dlls/wined3d/x86_64-windows/palette.o dlls/wined3d/x86_64-windows/query.o \
  dlls/wined3d/x86_64-windows/resource.o dlls/wined3d/x86_64-windows/sampler.o \
  dlls/wined3d/x86_64-windows/shader.o dlls/wined3d/x86_64-windows/shader_sm1.o \
  dlls/wined3d/x86_64-windows/shader_sm4.o dlls/wined3d/x86_64-windows/shader_spirv.o \
  dlls/wined3d/x86_64-windows/stateblock.o dlls/wined3d/x86_64-windows/surface.o \
  dlls/wined3d/x86_64-windows/swapchain.o dlls/wined3d/x86_64-windows/texture.o \
  dlls/wined3d/x86_64-windows/texture_gl.o dlls/wined3d/x86_64-windows/texture_vk.o \
  dlls/wined3d/x86_64-windows/utils.o dlls/wined3d/x86_64-windows/vertexdeclaration.o \
  dlls/wined3d/x86_64-windows/view.o dlls/wined3d/x86_64-windows/wined3d_main.o \
  dlls/wined3d/resource.res dlls/wined3d/version.res \
  -L../dst-vkd3d-x86_64/lib -lvkd3d \
  -lvkd3d-shader -lvkd3d-utils libs/dxguid/x86_64-windows/libdxguid.a \
  dlls/opengl32/x86_64-windows/libopengl32.a dlls/user32/x86_64-windows/libuser32.a dlls/gdi32/x86_64-windows/libgdi32.a dlls/advapi32/x86_64-windows/libadvapi32.a \
  dlls/winecrt0/x86_64-windows/libwinecrt0.a libs/compiler-rt/x86_64-windows/libcompiler-rt.a \
  dlls/ucrtbase/x86_64-windows/libucrtbase.a dlls/kernel32/x86_64-windows/libkernel32.a \
  dlls/ntdll/x86_64-windows/libntdll.a -L../dst-gst_orc-x86_64/lib/x86_64-apple-darwin -L../dst-gstreamer-x86_64/lib/x86_64-apple-darwin -L../dst-gst_base-x86_64/lib/x86_64-apple-darwin \
  -L../dst-ffmpeg-x86_64/lib/x86_64-apple-darwin -L../dst-openfst-x86_64/lib/x86_64-apple-darwin -L../dst-kaldi-x86_64/lib/x86_64-apple-darwin -L../dst-vosk-x86_64/lib/x86_64-apple-darwin \
  -L../dst-piper-x86_64/lib/x86_64-apple-darwin -L../dst-vkd3d-x86_64/lib/x86_64-apple-darwin \
  --no-default-config -fms-hotpatch -Wl,--build-id
cd -
