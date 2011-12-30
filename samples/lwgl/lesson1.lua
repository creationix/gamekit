local GL = require('gles2')
local SDL = require('sdl')
local Events = require('events')
local FFI = require('ffi')

-- Load a window
SDL.SDL_Init(SDL.SDL_INIT_VIDEO)
SDL.SDL_WM_SetCaption("Luvit GLES2 Lesson 1", nil);
local screen = SDL.SDL_SetVideoMode(500, 500, 0, SDL.SDL_OPENGL)

-- Make demo closable
local function exit()
  Events.stop_events()
  SDL.SDL_Quit();
  print("Thanks for Playing!");
end
Events:on(SDL.SDL_KEYDOWN, function (evt)
  if evt.key.keysym.sym == SDL.SDLK_ESCAPE then
    exit()
  end
end)
Events:on(SDL.SDL_QUIT, exit)

--Do OpenGL Stuff here
