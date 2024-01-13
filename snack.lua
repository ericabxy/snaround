local snack = {
  x = 1
}

function snack:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function snack:replace(tab)
  self.x = tab[love.math.random(#tab)]
  return {
    {x = self.x, n = 15}
  }
end

return snack
