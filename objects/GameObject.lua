local class = require("libraries.middleclass")
local GameObject = class('GameObject')

function GameObject:initialize() self.components = {} end

function GameObject:update(dt)
    for k, v in pairs(self.components) do v:update(dt) end
end

function GameObject:draw(dt) 
    for k, v in pairs(self.components) do v:draw(dt) end
end

function GameObject:destory()
    for key, v in pairs(self.components) do
        v:destory()
        table.remove(self.components, key)
    end
end

function GameObject:add_component(key, component)
    component.owner = self
    self.components[key] = component
end

function GameObject:get_component(key)
    local ret = self.components[key]
    return ret
end

return GameObject
