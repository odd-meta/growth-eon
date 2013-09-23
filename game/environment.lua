module(..., package.seeall)


local ENVIRON = {}

ENVIRON.__index = ENVIRON

function new()
    tree = octree.new()

    local environ = { ["tree"] = tree }

    setmetatable( environ, ENVIRON )
    return environ
end

-- Tree metatable
function ENVIRON:clear()
    self.tree = octree.new()
    print("environment cleared")
end


function ENVIRON:addrandom(position)

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

    local x = position.x
    local y = position.y
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