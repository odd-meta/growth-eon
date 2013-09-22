splash = {}

function splash.load()

	love.audio.stop()
	love.audio.rewind(musics["yd - MyVeryOwnDeadShip"])
	love.audio.play(musics["yd - MyVeryOwnDeadShip"])
	splash.dt_temp = 0
	splash.menu = { "play", "quit" }
	splash.menu_selected = 1
	splash.menu_sel_color = {r=43, g=76, b=126}
	splash.menu_sel_sound = sounds["ding.wav"]



end

function splash.draw_menu(menu, selected, sel_color)
	love.graphics.setFont(menu_font)
	love.graphics.setColor( fontcolor.r, fontcolor.g, fontcolor.b )

	for i, text in pairs(menu) do
		if i == selected then
			love.graphics.setColor( sel_color.r, sel_color.g, sel_color.b )
		end
		love.graphics.printf(text, 
		75, 300 + 40 * i, love.graphics.getWidth(), "left")
		love.graphics.setColor( fontcolor.r, fontcolor.g, fontcolor.b )
	end
		
	love.graphics.setColor( 255,255,255 )


end

function splash.change_menu_selected(menu, selected, direction, sel_sound)

	if direction == "up" then
		if selected == 1 then
			selected = #menu
		else
			selected = selected - 1
		end
	
	elseif direction == "down" then
		if selected == #menu then
			selected = 1
		else
			selected = selected + 1
		end
	else

	end
	love.audio.stop(sel_sound)
	love.audio.play(sel_sound)
	return selected

end


function splash.draw()
	love.graphics.setFont(title_font)
	love.graphics.setColor( fontcolor.r, fontcolor.g, fontcolor.b )
	if splash.dt_temp == 2.5 then
		love.graphics.printf("Growth Eon", 
			150, 600*scale, love.graphics.getWidth(), "center")
	end

	love.graphics.setColor( 255,255,255 )

	splash.draw_menu(splash.menu, splash.menu_selected, splash.menu_sel_color)

end

function splash.update(dt)
	splash.dt_temp = splash.dt_temp + dt

	if splash.dt_temp > 2.5 then
		splash.dt_temp = 2.5
	end
end


function splash.keypressed(key)

	if key == "up" or key == "down" then
		splash.menu_selected = splash.change_menu_selected(splash.menu, splash.menu_selected, key, splash.menu_sel_sound)
	end

end