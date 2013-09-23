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