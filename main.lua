Joystick = require'joystick'
Level = require'level'
Snack = require'snack'
Snake = require'snake'

Level.font = love.graphics.newImageFont('share/charset0.png', '0123456789:;<=>?', 0)

function setup_game()
  level0 = Level:new()
  snack0 = Snack:new()
  snack0:random(level0:free_space())
  level0:insert(snack0.x, '?')
  snake0 = Snake:new()
  snake0:start(108)
end

setup_game()

function love.load()
  setup_game()
  timer = 0
end

function love.update(dt)
  timer = timer + dt
  if timer >= 0.15 then
    timer = 0
    snake0:change_direction(Joystick[0])
    local x = snake0:head()
    if snake0.direction == 'right' and not level0:crash_east(x) then
      x = x + 1
    elseif snake0.direction == 'left' and not level0:crash_west(x) then
      x = x - 1
    elseif snake0.direction == 'down' and not level0:crash_south(x) then
      x = x + 20
    elseif snake0.direction == 'up' and not level0:crash_north(x) then
      x = x - 20
    end
    if not snake0:crash(x) then
      snake0:grow(x)--move head
      level0:insert(snake0:head())
      level0:insert(snake0:neck())
      if snake0:head() == snack0.x then
        snack0:random(level0:free_space())
        level0:insert(snack0.x, '?')
      else
        level0:insert(snake0:tail(), '0')
        snake0:grown()--move tail
        level0:insert(snake0:tail( ))
      end
    else
      love.load()
    end
  end
end

function love.draw()
  love.graphics.scale(2.5)
  love.graphics.setFont(level0.font)
  love.graphics.printf(level0.charmap, 0, 0, 320-1, 'left')  
end
