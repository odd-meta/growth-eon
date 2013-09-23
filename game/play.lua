play = {}



function play.load()
    love.audio.stop()

    play.environ = environment.new()
    play.environ._cur_build_x = 0
    play.environ._cur_build_y = 0
    play.environ.max_x = 500
    play.environ.max_y = 500
    play.environ._building = false

    play.environ._build_counter = 0

    play.bgc = { r = 43, g = 76, b = 126 }

end

function play.draw()
    if play.environ._building == true then

        local percent_done = round( ( play.environ._build_counter / ( play.environ.max_x * play.environ.max_y  ) ) * 100 , 0)
        love.graphics.setFont(menu_font)
        love.graphics.setColor( play.bgc.r, play.bgc.g, play.bgc.b )
        love.graphics.printf(percent_done .. "% done building environment", 
            -120, 600*scale, love.graphics.getWidth(), "right")
    end
end

function play.update(dt)

    if play.environ._building == true then
        play.build_environment()
    end

end

function play.keypressed(key)
    if key == "=" then
        play.environ._cur_build_x = 0
        play.environ._cur_build_y = 0
        play.environ:clear()
        play.environ._building = true
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