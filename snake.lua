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
  segments = {}
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
  for y=1,#self.segments-1 do--exclude tail because it will move
    if self.segments[y].x == x then
      return true
    end
  end
end

function snake:grow(x)
  table.insert(self.segments, 1, {
    x = x,
    edge0 = reverse[self.seg0],
    edge1 = 0,
  })
  self.segments[1].n = forward[self.segments[1].edge0]
  self.segments[2].edge1 = self.seg0
  self.segments[2].n = self.segments[2].edge0 + self.segments[2].edge1
  return {
    self.segments[1],
    self.segments[2]
  }
end

function snake:head()
  return self.segments[1].x
end

function snake:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function snake:setup(n)
  n = n or 136
  self.segs = {n, n - 1, n - 2}
  self.seg1 = {2, 2, 2}
  self.seg2 = {2, 2, 2}
  self.segments = {
    {x = n, edge0 = 2, edge1 = 0, n = 1},
    {x = n - 1, edge0 = 2, edge1 = 0, n = 1},
    {x = n - 2, edge0 = 2, edge1 = 0, n = 1}
  }
end

function snake:ungrow()
  local tail = self.segments[#self.segments]
  table.remove(self.segments)
  local n = #self.segments
  self.segments[n].n = self.segments[n].edge1
  return {
    self.segments[ n ],
    {x = tail.x, n = 0}
  }
end

return snake
