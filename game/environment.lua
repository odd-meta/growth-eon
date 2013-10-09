module(..., package.seeall)

local octree = require('octree')

local ENVIRON = {}


ENVIRON.__index = ENVIRON

function new(max_x, max_y, build_later, env_type)
    tree = octree.new()

    local environ = { ["tree"] = tree }
    environ._cur_build_x = 0
    environ._cur_build_y = 0
    environ.max_x = max_x
    environ.max_y = max_y
    environ.env_type = env_type


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

function ENVIRON:get(x, y)
    local data_func = self.tree:get(x, y, 0)
    if data_func ~= nil then
        local data = data_func()
        return data
    else
        return nil
    end

end


function ENVIRON:add_random(position)
    
    if self.env_type == "complex" then
        self:add_complex_rand(position)
    elseif self.env_type == "sugared" then
        self:add_sugared_rand(position)
    end



end

function ENVIRON:add_complex_rand(position)
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


    local env_data = function() return { ["height"] = height, ["composition"] = composition, ["properties"] = properties } end
    --print("adding: "..x..","..y.." with height "..height)

    self.tree:set(x,y,0,env_data)
    --local test_ret = self.tree:get(x,y,0)

    --print( string.format("h: %s", test_ret.height) )

end

function ENVIRON:add_sugared_rand(position)
    local x = position.x
    local y = position.y

    local sugar = math.random()
    local spice = math.random()
    
    local env_data = function() return { ["sugar"] = sugar, ["spice"] = spice } end
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


            local env_data = function() return { ["height"] = height, ["composition"] = composition, ["properties"] = properties } end
            print("adding: "..x..","..y.." with height "..height)
            self.tree:set(x,y,0,env_data)


        end

    end

end