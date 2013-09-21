game = {}


function game.load()
	love.audio.stop()
	love.audio.rewind(musics["the_spanish_ninja_c64_style_0"])
	love.audio.play(musics["the_spanish_ninja_c64_style_0"])
	game.clock = 0

	game.enemy_size = images["enemy"]:getWidth()
	game.enemies = {}
	game.enemy_dt = 0
	game.enemy_rate = 2

	game.player_size = images["player"]:getWidth()
	game.playerx = ( 160 / 2 ) * scale
	game.playery = ( 144 - 12 ) * scale

	game.ammo = 10
	game.recharge_rate = 1
	game.recharge_dt = 0
	game.bullet_size = images["bullet"]:getWidth()
	game.bullets = {}

	game.score = 0


end

function game.draw()


	for x = 0, scale do
		for y = -1, scale do

			love.graphics.draw(images["background"],
								x * 32 * scale,
								( y + game.clock % 1  ) * 32 * scale,
								0, scale, scale)
		end
	end

	for i, v in ipairs(game.enemies) do
		love.graphics.draw(images["enemy"],
							v.x, v.y,
							0, scale, scale,
							game.enemy_size/2, game.enemy_size/2)
		if debug then love.graphics.circle("line", v.x, v.y, game.enemy_size/2 * scale) end
	end

	love.graphics.draw(images["player"], 
						game.playerx, game.playery,
						0, scale, scale, 
						game.player_size / 2, game.player_size / 2)
	if debug then
		love.graphics.circle("line", game.playerx, game.playery, game.player_size / 2* scale, game.player_size / 2 * scale )
	end

	for i, v in ipairs(game.bullets) do
		love.graphics.draw( images["bullet"],
								v.x, v.y,
								0, scale, scale,
								game.bullet_size / 2, game.bullet_size / 2)
		if debug then love.graphics.circle( "line", v.x, v.y, game.bullet_size / 2 * scale ) end
	end

	love.graphics.setColor( fontcolor.r, fontcolor.g, fontcolor.b )
	love.graphics.printf(
		"score:" .. game.score ..
		" ammo:" .. game.ammo,
		0, 0, love.graphics.getWidth(), "center")
	if debug then love.graphics.print(
		"enemies: " .. #game.enemies ..
		"\nbullets:" .. #game.bullets ..
		"\nenemy rate:" .. game.enemy_rate ..
		"\nFPS:" .. love.timer.getFPS(),
		0, 14 * scale ) end
	love.graphics.setColor(255, 255, 255)



end

function game.update(dt)
	game.clock = game.clock + dt

	game.enemy_dt = game.enemy_dt + dt


	if love.keyboard.isDown("right") then
		if game.playerx > 160 * scale then
			game.playerx = 160 * scale
		else
			game.playerx = game.playerx + 100 * dt * scale
		end
	end

	if love.keyboard.isDown("left") then
		if game.playerx < 0 then
			game.playerx = 0
		else
			game.playerx = game.playerx - 100 * dt * scale
		end
	end


	if game.enemy_dt > game.enemy_rate then
		game.enemy_dt = game.enemy_dt - game.enemy_rate
		game.enemy_rate = game.enemy_rate - 0.01 * game.enemy_rate
		local enemy = {}
		enemy.x = math.random( (8) * scale, ( 160 - 8 ) * scale )
		enemy.y = -game.enemy_size
		table.insert(game.enemies, enemy)
	end


	for ei, ev in ipairs(game.enemies) do
		ev.y = ev.y + 70 * dt * scale
		if ev.y > 144 * scale then
			table.remove(game.enemies, ei)
		end

		if game.dist(game.playerx, game.playery, ev.x, ev.y) < ( ( game.player_size - 2)  / 2 + game.enemy_size / 2 ) * scale then
			splash.load()
			state = "splash"
		end
	end

	for bi, bv in ipairs ( game.bullets ) do
		bv.y = bv.y - 100 * dt * scale
		if bv.y < 0 then 
			table.remove(game.bullets, bi)
		end

		for ei, ev in ipairs(game.enemies) do
			if game.dist( bv.x, bv.y, ev.x, ev.y ) < ( game.bullet_size / 2 + game.enemy_size / 2 ) * scale then
				table.remove( game.enemies, ei)
				table.remove( game.bullets, bi)
				game.score = game.score + 100
			end
		end
	end

	game.recharge_dt = game.recharge_dt + dt

	if game.recharge_dt > game.recharge_rate then
		game.recharge_dt = game.recharge_dt - game.recharge_rate
		game.ammo = game.ammo + 1
		if game.ammo > 10 then
			game.ammo = 10
		end
	end





end

function game.keypressed(key)
	if key == " " and game.ammo > 0 then
		love.audio.play(shoot)
		game.ammo = game.ammo - 1

		local bullet = {}
		bullet.x = game.playerx
		bullet.y = game.playery
		table.insert( game.bullets, bullet )
	end
end

function game.dist(x1, y1, x2, y2)
	return math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
end
