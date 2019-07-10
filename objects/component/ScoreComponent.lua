local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local c = class('ScoreComponent', GameObject)

function c:initialize(cd)
    GameObject.initialize(self)
    self.score = 0

    input:bind('r', 'reset')
end

function c:update(dt)
    if input:down('reset') then
        for _, v in pairs(self.owner:get_gameobjects(
                              function(e)
                return e.class.name ~= 'Player'
            end)) do self.owner:remove_game_object(v) end
        self.score = 0
        player:reset()
    end

    for _, v in pairs(self.owner:get_gameobjects(
                          function(e) return e.class.name == 'Enemy' end)) do
        for _, vv in pairs(self.owner:get_gameobjects(
                               function(e)
                return e.class.name == 'Bullet'
            end)) do
            if self:CheckCollision(v.x, v.y, v.image:getWidth(),
                                   v.image:getHeight(), vv.x, vv.y,
                                   vv.image:getWidth(), vv.image:getHeight()) then
                self.score = self.score + 1
                self.owner:remove_game_object(v)
                self.owner:remove_game_object(vv)
            end
        end
    end
    if player.is_alive then
        for _, v in pairs(self.owner:get_gameobjects(
                              function(e)
                return e.class.name == 'Enemy'
            end)) do
            if player.is_alive then
                local x, y = player:get_component('PlayerPathComponent')
                                 :get_position()
                if self:CheckCollision(v.x, v.y, v.image:getWidth(),
                                       v.image:getHeight(), x, y,
                                       player.image:getWidth(),
                                       player.image:getHeight()) then
                    player.is_alive = false
                    self.owner:remove_game_object(v)
                end
            end
        end
    end
end

function c:CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function c:draw()
    love.graphics.print(self.score, 10, 10)
    if not player.is_alive then love.graphics.print('YOU DEAD!', 250, 250) end
end
return c
