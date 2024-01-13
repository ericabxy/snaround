Joystick = require'joystick'
Level = require'level'
Snack = require'snack'
Snake = require'snake'

game_mode = 2

setup = {
  function ()
    timer = 0
    level0 = Level:new{char_width = 16, char_height = 16}
    level0.font = love.graphics.newImageFont(
      'share/charset0.png', Level.glyphs, 0)
    level0:setup(20, 15)
    snack0 = Snack:new()
    snack0:replace(level0:free_space())
    level0:insert{snack0}
    snake0 = Snake:new()
    snake0.timer = 0
    snake0:setup(25)
  end,
  function ()
    timer = 0
    level0 = Level:new{char_width = 8, char_height = 8}
    level0.font = love.graphics.newImageFont(
      'share/charset1.png', Level.glyphs, 0)
    level0:setup(40, 30)
    snack0 = Snack:new()
    snack0:replace(level0:free_space())
    level0:insert{snack0}
    snake0 = Snake:new()
    snake0.timer = 0
    snake0:setup(125)
  end
}

setup[game_mode]()

function love.load()
  setup[game_mode]()
end

function love.update(dt)
  snake0.timer = snake0.timer + dt
  if snake0.timer >= 0.15 then
    snake0.timer = 0
    snake0:change_direction(Joystick[0])
    local x = snake0:head()
    if snake0.direction == 'right' and not level0:crash_east(x) then
      x = x + 1
    elseif snake0.direction == 'left' and not level0:crash_west(x) then
      x = x - 1
    elseif snake0.direction == 'down' and not level0:crash_south(x) then
      x = x + level0.chars
    elseif snake0.direction == 'up' and not level0:crash_north(x) then
      x = x - level0.chars
    end
    if not snake0:crash(x) then
      level0:insert(snake0:grow( x ))
      if snake0:head() == snack0.x then
        snack0:replace(level0:free_space( ))
        level0:insert{snack0}
      else
        level0:insert(snake0:ungrow( ))
      end
    else
      love.load()
    end
  end
end

function love.draw()
  love.graphics.scale(2.5)
  love.graphics.setFont(level0.font)
  love.graphics.printf(level0:printf( ))
end
