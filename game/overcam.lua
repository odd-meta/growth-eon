module(..., package.seeall)

local OVERCAM = {}

OVERCAM.__index = OVERCAM

function new(environ, width)
    local overcam = {}
    overcam._environ = environ
    overcam._width = width
    overcam._ratio = love.graphics.getWidth()/love.graphics.getHeight()
    overcam._height = overcam._width / overcam._ratio
    
    setmetatable( overcam, OVERCAM )
    overcam:init()



    return overcam
end

-- Tree metatable
function OVERCAM:reset( )
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
    self._bound.left = self._position.x - math.ceil(self._width) / 2
    self._bound.right = self._position.x + math.ceil(self._width) / 2
    self._bound.top = self._position.y + math.ceil(self._height) / 2
    self._bound.bottom = self._position.y - math.ceil(self._height) / 2
    print( string.format("overcam created w: %s h: %s r: %s", self._width, self._height, self._ratio) )
    print(string.format(" with %s,%s screen center and %s, %s environ center", self._screen_x_center, self._screen_y_center, self._environ_x_center, self._environ_y_center ))
    print( string.format("position %s, %s bounds of L: %s R: %s T: %s B: %s", self._position.x, self._position.y, self._bound.left, self._bound.right, self._bound.top, self._bound.bottom ) )

end


function OVERCAM:draw_cell( cell_coords)

end