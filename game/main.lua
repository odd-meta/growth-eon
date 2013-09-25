debug = false
require('splash')
require('play')


environment = require('environment') 






function love.load()



	window_icon = love.graphics.newImage("assets/ico_clean_32.png" )
	success = love.graphics.setIcon( window_icon )

	-- load in our game image assets
	img_names = {}
	images = {}
	for i, name in ipairs(img_names) do
		images[name] = love.graphics.newImage("assets/" .. name .. ".gif" )
	end

	for i, image in pairs(images) do
		image:setFilter("nearest", "nearest")
	end



	-- load in our game music assets
	music_names = {"yd - MyVeryOwnDeadShip"}

	musics = {}

	for i, name in ipairs(music_names) do
		musics[name] = love.audio.newSource( "assets/music/" .. name .. ".ogg", "stream")
	end

	for i, music in pairs(musics) do
		music:setLooping(true)
	end
	
	
	-- load in our game sound assets
	sound_names = {"ding.wav"}

	sounds = {}

	for i, name in ipairs(sound_names) do
		sounds[name] = love.audio.newSource( "assets/sound/" .. name , "static")
	end

	--shoot = love.audio.newSource( "assets/shoot.ogg", "static" )

	-- setup our game font objects
	title_font = love.graphics.newFont( "assets/fonts/telavision.ttf", 82*scale )
	menu_font = love.graphics.newFont( "assets/fonts/telavision.ttf", 32*scale )


	

	bgc = { r=220, g=224, b=230 }

	fontcolor = { r=31, g=31, b=32 }


	state = "splash"

	splash.load()


end


function love.draw()


	if state == "splash" then
		splash.draw()
	elseif state == "play" then
		play.draw()
	end


end

function love.update(dt)
	if state == "splash" then
		splash.update(dt)
	elseif state == "play" then
		play.update(dt)
	end

end

function love.keypressed(key)


	if key == "`" then
		debug = not debug
	end

	if state == "splash" then
		splash.keypressed(key)
	elseif state == "play" then
		play.keypressed(key)
	end

end
