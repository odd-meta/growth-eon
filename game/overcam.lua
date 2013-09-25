module(..., package.seeall)

local OVERCAM = {}

OVERCAM.__index = OVERCAM

function new( environ, width )
    local overcam = {}
    overcam._environ = environ
    overcam._width = width
    overcam._ratio = love.graphics.getWidth()/love.graphics.getHeight()
    overcam._height = overcam._width / overcam._ratio
    
    overcam._zoom_speed = 0.5

    setmetatable( overcam, OVERCAM )
    overcam:init()



    return overcam
end

-- Tree metatable
function OVERCAM:reset()
    self:init()
    print("overcam reset")
end

function OVERCAM:init()
    self._screen_x_center = love.graphics.getWidth() / 2
    self._screen_y_center = love.graphics.getHeight() / 2
    self._environ_x_center = math.ceil(self._environ.max_x / 2 )
    self._environ_y_center = math.ceil(self._environ.max_y / 2 )

    self._position = { x = self._environ_x_center, y = self._environ_y_center }

    self._bound = {}
    self._bound.left = math.floor(self._position.x) - math.ceil(self._width) / 2
    self._bound.right = math.ceil(self._position.x) + math.ceil(self._width) / 2
    self._bound.top = math.ceil(self._position.y) + math.ceil(self._height) / 2
    self._bound.bottom = math.floor(self._position.y) - math.ceil(self._height) / 2

    self._offset = {}
    self._offset.x = math.floor(self._position.x) - self._position.x
    self._offset.y = math.floor(self._position.y) - self._position.y

    self._cell_wh = love.graphics.getWidth() / self._width

    --calulate the ratio of pixels to one unit of environment grid (environment to screen ratio)
    self._es_ratio = self._cell_wh

    self._offset.x_p = self._offset.x * self._es_ratio
    self._offset.y_p = self._offset.y * self._es_ratio

    print( string.format("overcam created w: %s h: %s r: %s", self._width, self._height, self._ratio) )
    print( string.format("offset x: %s|%s y: %s|%s", self._offset.x, self._offset.x_p, self._offset.y, self._offset.y_p) )
    print( string.format("cell dimensions: %s", self._cell_wh) )
    print(string.format(" with %s,%s screen center and %s, %s environ center", self._screen_x_center, self._screen_y_center, self._environ_x_center, self._environ_y_center ))
    print( string.format("position %s, %s bounds of L: %s R: %s T: %s B: %s", self._position.x, self._position.y, self._bound.left, self._bound.right, self._bound.top, self._bound.bottom ) )

end

--takes a cell's coordinates in the environment grid
function OVERCAM:draw_cell( cell_coords, cell_data )
    --[[
    given:
        the center point of the screen in pixels
        the draw offset for the environment's cell
        the width of the environment cell
        the position of the environment cell

        x offset in pixels
        y offset in pixels
    calculate:
        top left x coord in pixels
        top left y coord in pixels
    ]]

    local draw_x = ( ( cell_coords.x - self._position.x ) * self._es_ratio ) + self._screen_x_center
    local draw_y = ( ( cell_coords.y - self._position.y ) * self._es_ratio ) + self._screen_y_center
    if cell_data ~= nil then
        local height_color = math.ceil(cell_data.height * 255)

        love.graphics.setColor( height_color, height_color, height_color )
    else
        love.graphics.setColor( 228, 66, 17 )
    end

    love.graphics.rectangle("fill", draw_x, draw_y, self._cell_wh, self._cell_wh )

    love.graphics.setColor( 255, 255, 255 )

end

function OVERCAM:draw_view()

    --print( string.format("position %s, %s bounds of L: %s R: %s T: %s B: %s", self._position.x, self._position.y, self._bound.left, self._bound.right, self._bound.top, self._bound.bottom ) )

    for x = self._bound.left, self._bound.right do
        for y = self._bound.bottom, self._bound.top do
            --print( string.format("drawing %s, %s", x, y) )
            self:draw_cell( { ["x"] = x, ["y"] = y }, play.environ:get(x,y) )
        end

    end


end

function OVERCAM:update_width(width)
    self._width = width
    self._height = self._width / self._ratio

    self._bound.left = math.floor(self._position.x) - math.ceil(self._width) / 2
    self._bound.right = math.ceil(self._position.x) + math.ceil(self._width) / 2
    self._bound.top = math.ceil(self._position.y) + math.ceil(self._height) / 2
    self._bound.bottom = math.floor(self._position.y) - math.ceil(self._height) / 2

    self._cell_wh = love.graphics.getWidth() / self._width

    --calulate the ratio of pixels to one unit of environment grid (environment to screen ratio)
    self._es_ratio = self._cell_wh

end


function OVERCAM:zoom_out()

    local new_width = self._width + self._zoom_speed
    self:update_width(new_width)

end

function OVERCAM:zoom_in()
    local new_width = self._width - self._zoom_speed
    self:update_width(new_width)

end



function OVERCAM:update_position(dt)


    if love.keyboard.isDown("right") then
        --print("going right")
        if ( self._position.x + ( self._width / 2 ) ) > self._environ.max_x  then
            self._position.x = ( self._environ.max_x - ( self._width / 2 ) )
        else
            self._position.x = self._position.x + 10 * dt
        end
    end

    if love.keyboard.isDown("left") then
        --print("going right")
        if ( self._position.x - ( self._width / 2 ) ) < 0  then
            self._position.x = ( 0 + ( self._width / 2 ) )
        else
            self._position.x = self._position.x - 10 * dt
        end
    end

    if love.keyboard.isDown("up") then
        --print("going right")
        if ( self._position.y - ( self._height / 2 ) ) < 0  then
            self._position.y = ( 0 + ( self._height / 2 ) )
        else
            self._position.y = self._position.y - 10 * dt
        end
    end

    if love.keyboard.isDown("down") then
        --print("going right")
        if ( self._position.y + ( self._height / 2 ) ) > self._environ.max_y  then
            self._position.y = ( self._environ.max_y - ( self._height / 2 ) )
        else
            self._position.y = self._position.y + 10 * dt
        end
    end

    self._bound.left = math.floor(self._position.x) - math.ceil(self._width) / 2
    self._bound.right = math.ceil(self._position.x) + math.ceil(self._width) / 2
    self._bound.top = math.ceil(self._position.y) + math.ceil(self._height) / 2
    self._bound.bottom = math.floor(self._position.y) - math.ceil(self._height) / 2


end
