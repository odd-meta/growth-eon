module(..., package.seeall)

local octree = require('octree')

local ENVIRON = {}


ENVIRON.__index = ENVIRON

function new(max_x, max_y, build_later)
    tree = octree.new()

    local environ = { ["tree"] = tree }
    environ._cur_build_x = 0
    environ._cur_build_y = 0
    environ.max_x = max_x
    environ.max_y = max_y
    if build_later == true then
        environ._building = false
    else
        environ._building = true
    end


    environ._build_counter = 0

    setmetatable( environ, ENVIRON )
    return environ
end

-- Tree metatable
function ENVIRON:clear()
    self.tree = octree.new()
    print("environment cleared")
end


function ENVIRON:addrandom(position)

    local x = position.x
    local y = position.y

    local height = math.random()
    local composition = {
        ["soil"] = 0.8,
        ["rock"] = 0.4
    }
    local temperature = math.random(70,100)
    local humidity = math.random()
    local properties = {
        ["temperature"] = temperature,
        ["humidity"] = humidity
    }


    local env_data = { ["height"] = height, ["composition"] = composition, ["properties"] = properties }
    --print("adding: "..x..","..y.." with height "..height)

    self.tree:set(x,y,0,env_data)


end

function ENVIRON:randomize(size)

    for x=0, size.x do
        for y=0, size.y do
            local height = math.random()
            local composition = {
                ["soil"] = 0.8,
                ["rock"] = 0.4
            }
            local temperature = math.random(70,100)
            local humidity = math.random()
            local properties = {
                ["temperature"] = temperature,
                ["humidity"] = humidity
            }


            local env_data = { ["height"] = height, ["composition"] = composition, ["properties"] = properties }
            print("adding: "..x..","..y.." with height "..height)
            self.tree:set(x,y,0,env_data)


        end

    end

end