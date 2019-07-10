local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local PlayerPathComponent = class('PlayerPathComponent', GameObject)

function PlayerPathComponent:initialize(x, y, speed)
    GameObject.initialize(self)
    self.x = x
    self.y = y
    self.speed = speed

    input:bind('left', 'left')
    input:bind('right', 'right')
    input:bind('a', 'left')
    input:bind('d', 'right')
    input:bind('up', 'up')
    input:bind('w', 'up')
    input:bind('down', 'down')
    input:bind('s', 'down')
end

function PlayerPathComponent:update(dt)
    if input:down('left') then
        if self.x > -self.owner.image:getWidth() / 2 then
            self.x = self.x - (self.speed * dt)
        end
    end
    if input:down('right') then
        if self.x < (love.graphics.getWidth() - self.owner.image:getWidth() / 2) then
            self.x = self.x + (self.speed * dt)
        end
    end
    if input:down('down') then
        if self.y <
            (love.graphics.getHeight() - self.owner.image:getHeight() / 2) then
            self.y = self.y + self.speed * dt
        end
    end
    if input:down('up') then
        if self.y > 0 then self.y = self.y - self.speed * dt end
    end
end

function PlayerPathComponent:get_position() return self.x, self.y end

return PlayerPathComponent
