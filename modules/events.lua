local Emitter = require('emitter')
local SDL = require('./sdl')
local Timer = require('timer')
local UV = require('uv')
local FFI = require('ffi')

local Events = Emitter.new()

local event = FFI.new("SDL_Event")
local alive = true
local before = UV.now()
local interval = Timer.set_interval(1, function ()
  if not alive then return end
  local now = UV.now()
  local delta = now - before
  before = now

  while SDL.SDL_PollEvent(event) > 0 do
    if alive then
      Events:emit("event", event)
      Events:emit(event.type, event)
    end
  end
  if alive then
    Events:emit('tick', delta)
  end
end)

function Events.stop_events()
  Timer.clear_timer(interval)
  alive = false
end

return Events

