local default =
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'..
  '0000000000000000000000000000000000000000000000000000000000000000'

local level = {
  bottom = 208,
  char_height = 8,
  char_offset = 48,
  char_width = 8,
  charmap = default,
  chars = 32,
  glyphs = '',
  lines = 28,
  print_width = 240,
  starts = {
    [0] = 459,
    [1] = 437
  }
}

for x=level.char_offset,level.char_offset+16 do
  level.glyphs = level.glyphs..string.char(x)
end

function level:crash(x, dir)
  if dir == 1 and x < self.chars then
    return true
  elseif dir == 2 and x % self.chars == 0 then
    return true
  elseif dir == 4 and x > self.bottom then
    return true
  elseif dir == 8 and x % self.chars == 1 then
    return true
  end
end

function level:crash_east(x)
  if x % self.chars == 0 then
    return true
  end
end

function level:crash_west(x)
  if x % self.chars == 1 then
    return true
  end
end

function level:crash_south(x)
  if x > self.bottom then
    return true
  end
end

function level:crash_north(x)
  if x < self.chars then
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

function level:insert(arg)
  for _, tab in ipairs(arg) do
    local x, char = tab.x, string.char(self.char_offset + tab.n)
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
end

function level:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function level:printf()
  return self.charmap, 0, 0, self.print_width - 1, 'left'
end

function level:setup(chars, lines)
  self.chars = chars
  self.bottom = chars * lines - chars
  self.print_width = chars * self.char_width
  self.charmap = ''
  for x=1,chars*lines do
    self.charmap = self.charmap..'0'
  end
  self.starts[0] = math.floor(lines / 2) + math.floor(chars / 3)
  self.starts[1] = math.floor(lines / 2) - math.floor(chars / 3)
end

function level:pstart(n)
  n = n % #self.starts
  return self.starts[n]
end

function level:whereto(x, dir)
  if dir == 1 then
    return x - self.chars
  elseif dir == 2 then
    return x + 1
  elseif dir == 4 then
    return x + self.chars
  elseif dir == 8 then
    return x - 1
  else
    return x
  end
end

return level
