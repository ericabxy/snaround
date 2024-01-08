local snack = {
  x = 1
}

function snack:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function snack:random(tab)
  self.x = tab[love.math.random(#tab)]
end

return snack
