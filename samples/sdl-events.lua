local SDL = require 'sdl'
local Events = require 'events'
local FFI = require 'ffi'

SDL.SDL_Init(SDL.SDL_INIT_VIDEO)
SDL.SDL_WM_SetCaption("Luvit SDL Events!", nil);
local screen = SDL.SDL_SetVideoMode(320, 200, 0, SDL.SDL_RESIZABLE)

SDL.SDL_InitSubSystem(SDL.SDL_INIT_JOYSTICK)
local joysticks = {}
SDL.SDL_JoystickEventState(SDL.SDL_ENABLE);
p("numjoysticks", SDL.SDL_NumJoysticks())
for i = 1,SDL.SDL_NumJoysticks() do
  p("Found ", FFI.string(SDL.SDL_JoystickName(i-1)));
  local joy = SDL.SDL_JoystickOpen(i-1)
  joysticks[i] = joy
end
p("Joysticks", joysticks)


local function exit()
  Events.stop_events()
  SDL.SDL_Quit();
  print("Thanks for Playing!");
end

Events:on(SDL.SDL_ACTIVEEVENT, function (evt)
  local a = evt.active
  p("ACTIVEEVENT", {gain=a.gain,state=a.state})
end)

function dump_keysym(keysym)
  return {
    scancode = keysym.scancode,
    sym = keysym.sym,
    mod = keysym.mod,
    unicode = keysym.unicode
  }
end

Events:on(SDL.SDL_KEYDOWN, function (evt)
  local k = evt.key
  p("KEYDOWN", {which=k.which,keysym=dump_keysym(k.keysym)})
  local sym = k.keysym.sym
  if sym == SDL.SDLK_ESCAPE then
    exit()
  end
end)

Events:on(SDL.SDL_KEYUP, function (evt)
  local k = evt.key
  p("KEYUP", {which=k.which,keysym=dump_keysym(k.keysym)})
end)

Events:on(SDL.SDL_MOUSEMOTION, function (evt)
  local m = evt.motion
  p("MOUSEMOTION", {which=m.which,state=m.state,x=m.x,y=m.y,xrel=m.xrel,yrel=m.yrel})
end)

Events:on(SDL.SDL_MOUSEBUTTONDOWN, function (evt)
  local b = evt.button
  p("MOUSEBUTTONDOWN", {which=b.which,button=b.button,state=b.state,x=b.x,y=b.y})
end)

Events:on(SDL.SDL_MOUSEBUTTONUP, function (evt)
  local b = evt.button
  p("MOUSEBUTTONUP", {which=b.which,button=b.button,state=b.state,x=b.x,y=b.y})
end)

Events:on(SDL.SDL_JOYAXISMOTION, function (evt)
  local j = evt.jaxis
  p("JOYAXISMOTION", {which=j.which,axis=j.axis,value=j.value})
end)

Events:on(SDL.SDL_JOYHATMOTION, function (evt)
  local j = evt.jhat
  p("JOYHATMOTION", {which=j.which,hat=j.hat,value=j.value})
end)

Events:on(SDL.SDL_JOYBUTTONDOWN, function (evt)
  local j = evt.jbutton
  p("JOYBUTTONDOWN", {which=j.which,button=j.button,state=j.state})
end)

Events:on(SDL.SDL_JOYBUTTONUP, function (evt)
  local j = evt.jbutton
  p("JOYBUTTONUP", {which=j.which,button=j.button,state=j.state})
end)

Events:on(SDL.SDL_VIDEORESIZE, function (evt)
  local r = evt.resize
  p("VIDEORESIZE", {w=r.w,h=r.h})
end)

Events:on(SDL.SDL_VIDEOEXPOSE, function (evt)
  local e = evt.expose
  p("VIDEOEXPOSE", {})
end)

Events:on(SDL.SDL_QUIT, function (evt)
  local q = evt.quit
  p("QUIT", {})
  exit()
end)

