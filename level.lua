local level = {
  border_width = 20,
  border_height = 280,
  charmap =
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'..
    '00000000000000000000'
}

function level:crash_east(x)
  if x % self.border_width == 0 then
    return true
  end
end

function level:crash_west(x)
  if x % self.border_width == 1 then
    return true
  end
end

function level:crash_south(x)
  if x > self.border_height then
    return true
  end
end

function level:crash_north(x)
  if x < self.border_width then
    return true
  end
end

function level:free_space(b)
  b = b or '0'
  local tab = {}
  for x=1, string.len(self.charmap) do
    if string.sub(self.charmap, x, x) == b then
      table.insert(tab, x)
    end
  end
  return tab
end

function level:insert(x, char)
  if x >= string.len(self.charmap) then
    self.charmap =
      string.sub(self.charmap, 1, x - 1)..
      char
  elseif x <= 1 then
    self.charmap =
      char..
      string.sub(self.charmap, 2)
  else
    self.charmap =
      string.sub(self.charmap, 1, x - 1)..
      char..
      string.sub(self.charmap, x + 1)
  end
end

function level:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

return level
