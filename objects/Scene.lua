local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')

local Scene = class('Scene', GameObject)

function Scene:initialize()
    GameObject.initialize(self)
    self.gameobjects = {}
end

function Scene:update(dt)
    GameObject.update(self, dt)
    for i, v in ipairs(self.gameobjects) do v:update(dt) end
end

function Scene:draw(dt)
    GameObject.draw(self,dt)
    for i, v in ipairs(self.gameobjects) do v:draw(dt) end
end

function Scene:destory()
    for i, v in ipairs(self.gameobjects) do
        v:destory()
        table.remove(self.gameobjects, i)
    end
end

function Scene:add_game_object(gameObject)
    table.insert(self.gameobjects, gameObject)
end

function Scene:remove_game_object(gameObject)
    for i, v in ipairs(self.gameobjects) do
        if v == gameObject then
            v:destory()
            table.remove(self.gameobjects, i)
        end
    end
end

function Scene:get_gameobjects(func)
    local ret = {}
    for _, v in pairs(self.gameobjects) do
        if func(v) then table.insert(ret, v) end
    end
    return ret
end

return Scene
