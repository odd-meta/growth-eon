play = {}


function play.load()
    love.audio.stop()

    play.environ = environment.new()

end

function play.draw()

end

function play.update(dt)

end

function play.keypressed(key)
    if key == "=" then
        play.environ:clear()
    end
end