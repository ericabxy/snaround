local reverse = {
  [1] = 4,
  [2] = 8,
  [4] = 1,
  [8] = 2
}

local forward = {
  [1] = 11,
  [2] = 7,
  [4] = 14,
  [8] = 13
}

local snake = {
  direction = 'right',
  seg0 = 2,
  seg1 = {},
  seg2 = {},
  segs = {},
  start = 175
}

function snake:change_direction(direction)
  if direction == 'up' and self.direction ~= 'down' then
    self.direction = 'up'
    self.seg0 = 1
  elseif direction == 'right' and self.direction ~= 'left' then
    self.direction = 'right'
    self.seg0 = 2
  elseif direction == 'down' and self.direction ~= 'up' then
    self.direction = 'down'
    self.seg0 = 4
  elseif direction == 'left' and self.direction ~= 'right' then
    self.direction = 'left'
    self.seg0 = 8
  end
end

function snake:crash(x)
  for y=1,#self.segs-1 do--exclude tail because it will move
    if self.segs[y] == x then
      return true
    end
  end
end

function snake:grow(x)
  table.insert(self.segs, 1, x)
  table.insert(self.seg1, 1, reverse[self.seg0])
  table.insert(self.seg2, 1, 0)--only record the leading edge
  self.seg2[2] = self.seg2[2] + self.seg0--record the trailing edge
end

function snake:grown()
  table.remove(self.segs)
  local butt = #self.seg1 - 1
  local tail = #self.seg1
--  self.seg2[butt] = 0--remove the trailing edge
  table.remove(self.seg1)
  table.remove(self.seg2)
end

function snake:head()
  return self.segs[1], string.char(48 + forward[self.seg1[1]])
end

function snake:neck()
  return self.segs[2], string.char(48 + self.seg1[2] + self.seg2[2])
end

function snake:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function snake:start(n)
  n = n or 136
  self.segs = {n, n - 1, n - 2}
  self.seg1 = {2, 2, 2}
  self.seg2 = {2, 2, 2}
end

function snake:tail()
  return
    self.segs[#self.segs],
    string.char(48 + self.seg2[#self.seg2])
end

return snake
