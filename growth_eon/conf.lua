scale = 1


function love.conf(t)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
	t.modules.thread = true
    t.modules.physics = true    -- Enable the physics module (boolean)
    t.console = true           -- Attach a console (boolean, Windows only)
    t.title = "Growth Eon"        -- The title of the window the game is in (string) 
    t.author = "oddmeta"        -- The author of the game (string)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = false       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.screen.height = 800*scale       -- The window height (number)
    t.screen.width = 1000*scale        -- The window width (number)
end