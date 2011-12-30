local FFI = require 'ffi'
local FS = require 'fs'

local libs = {
  OSX     = { x86 = __dirname .. "/gles2.dylib", x64 = __dirname .. "/gles2.dylib" },
  Linux   = { x86 = "/usr/lib/i386-linux-gnu/libGLESv2.so.2", x64 = "/usr/lib/x86_64-linux-gnu/libGLESv2.so" },
}

FFI.cdef[[


]]
FFI.cdef(FS.read_file_sync(__dirname .. "/gles2.h"))

return FFI.load( ffi_GLESv2_lib or libs[ FFI.os ][ FFI.arch ]  or "GLESv2" )

