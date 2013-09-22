splash = {}

function splash.load()

	love.audio.stop()
	love.audio.rewind(musics["yd - MyVeryOwnDeadShip"])
	love.audio.play(musics["yd - MyVeryOwnDeadShip"])
	splash.dt_temp = 0


end

function splash.draw()
	love.graphics.setFont(title_font)
	love.graphics.setColor( fontcolor.r, fontcolor.g, fontcolor.b )
	if splash.dt_temp == 2.5 then
		love.graphics.printf("Growth Eon", 
			150, 600*scale, love.graphics.getWidth(), "center")
	end

	love.graphics.setColor( 255,255,255 )

end

function splash.update(dt)
	splash.dt_temp = splash.dt_temp + dt

	if splash.dt_temp > 2.5 then
		splash.dt_temp = 2.5
	end
end


function splash.keypressed(key)
	
	if key == "up" then
		
	end
end