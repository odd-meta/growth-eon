play = {}

local overcam = require('overcam')
local environment = require('environment') 


function play.load()
    love.audio.stop()

    play.environ = environment.new(500,300)
    play.overcam = overcam.new(play.environ, 10)
    play._c = {}
    play._c.bg = { r = 43, g = 76, b = 126 }
    play._c.font = { r = 243, g = 238, b = 236 }

end

function play.draw()

    if play.environ._building == true then

        local percent_done = round( ( play.environ._build_counter / ( play.environ.max_x * play.environ.max_y  ) ) * 100 , 0)
        love.graphics.setFont(menu_font)
        love.graphics.setColor( play._c.font.r, play._c.font.g, play._c.font.b )
        love.graphics.printf(percent_done .. " % done building environment!", 
            -120, 600*scale, love.graphics.getWidth(), "right")
        love.graphics.setColor( 255,255,255 )
    end
    if play.environ._building == false then
        play.overcam:draw_view()
    end
end

function play.update(dt)

    if play.environ._building == true then
        play.build_environment()
    end
    if play.environ._building == false then
        play.overcam:update_position(dt)
    end

end

function play.keypressed(key)
    if key == "=" then
        play.environ._cur_build_x = 0
        play.environ._cur_build_y = 0
        play.environ:clear()
        play.environ._building = true
    end
    if key == "r" then 
        play.overcam:reset()
    end
end

function love.mousepressed( x, y, mb )
    if mb == "wu" then
      play.overcam:zoom_in()
   end

   if mb == "wd" then
      play.overcam:zoom_out()
   end



end


function play.build_environment()
     play.environ._build_counter =  play.environ._build_counter + 1
    if play.environ._cur_build_x <= play.environ.max_x then


        if play.environ._cur_build_y <= play.environ.max_y then
            play.environ:addrandom( { x = play.environ._cur_build_x, y = play.environ._cur_build_y } )
            play.environ._cur_build_y = play.environ._cur_build_y + 1
        elseif play.environ._cur_build_y > play.environ.max_y then
            play.environ._cur_build_x = play.environ._cur_build_x + 1

            if play.environ._cur_build_x <= play.environ.max_x then 

                play.environ._cur_build_y = 0
                play.environ:addrandom( { x = play.environ._cur_build_x, y = play.environ._cur_build_y } )
                play.environ._cur_build_y = play.environ._cur_build_y + 1
            else
            end


        else


        end
    else
        play.environ._building = false


    end

end