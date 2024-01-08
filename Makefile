LUTROFILE = snakearound.lutro
ZIP = zip

lutro:
	$(ZIP) $(LUTROFILE) share/charset0.png joystick.lua level.lua main.lua snack.lua snake.lua

clean:
	$(RM) $(LUTROFILE)
