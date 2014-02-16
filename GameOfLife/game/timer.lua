Timer = {
  currentTime = 0,
  resetInterval = 0,
  active = true
}

function Timer:new()
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Timer:tick(dt)
  if self.active then
    self.currentTime = self.currentTime + dt

    if self.currentTime >= self.resetInterval then
      self.currentTime = 0
      self.callback()
    end
  end
end

-- Override this function to allow for your own customizable behaviour on a Timer tick.
function Timer:callback()
  print "Hello world"
end
