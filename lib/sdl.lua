local FFI = require 'ffi'
local FS = require 'fs'
local Path = require 'path'

local libs = {
  OSX     = { x86 = "/Library/Frameworks/SDL.framework/SDL", x64 = "/Library/Frameworks/SDL.framework/SDL" },
  Linux   = { x86 = "/usr/lib/libSDL-1.2.so.0", x64 = "/usr/lib/libSDL-1.2.so.0" },
}

FFI.cdef[[

  enum {
    SDL_INIT_AUDIO       = 0x00000010,
    SDL_INIT_VIDEO       = 0x00000020,
    SDL_INIT_CDROM       = 0x00000100,
    SDL_INIT_JOYSTICK    = 0x00000200,
    SDL_INIT_NOPARACHUTE = 0x00100000,
    SDL_INIT_EVENTTHREAD = 0x01000000,
    SDL_INIT_EVERYTHING  = 0x0000FFFF
  };
  
  enum {
    SDL_ANYFORMAT        = 0x10000000,
    SDL_HWPALETTE        = 0x20000000,
    SDL_DOUBLEBUF        = 0x40000000,
    SDL_FULLSCREEN       = 0x80000000,
    SDL_OPENGL           = 0x00000002,
    SDL_OPENGLBLIT       = 0x0000000A,
    SDL_RESIZABLE        = 0x00000010,
    SDL_NOFRAME          = 0x00000020
  };

  enum {
    SDL_QUERY            = -1,
    SDL_IGNORE           = 0,
    SDL_DISABLE          = 0,
    SDL_ENABLE           = 1
  };

]]

FFI.cdef(FS.read_file_sync(Path.join(__dirname, "/sdl.h")))

return FFI.load( ffi_SDL_lib or ffi_sdl_lib or libs[ FFI.os ][ FFI.arch ]  or "sdl" )

