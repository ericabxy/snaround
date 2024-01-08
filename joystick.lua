local joystick = {
  {},
  {},
  {},
  {}
}

function love.joystickpressed(n, b)
  if b == 7 then
    joystick[n] = 'right'
  elseif b == 6 then
    joystick[n] = 'left'
  elseif b == 5 then
    joystick[n] = 'down'
  elseif b == 4 then
    joystick[n] = 'up'
  end
end

return joystick
