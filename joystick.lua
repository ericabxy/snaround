local joystick = {
  [0] = {},
  [1] = {},
  [2] = {},
  [3] = {}
}

function love.joystickpressed(n, b)
  if b == 7 then
    joystick[n].right = true
  elseif b == 6 then
    joystick[n].left = true
  elseif b == 5 then
    joystick[n].down = true
  elseif b == 4 then
    joystick[n].up = true
  end
end

function love.joystickreleased(n, b)
  if b == 7 then
    joystick[n].right = false
  elseif b == 6 then
    joystick[n].left = false
  elseif b == 5 then
    joystick[n].down = false
  elseif b == 4 then
    joystick[n].up = false
  end
end

return joystick
