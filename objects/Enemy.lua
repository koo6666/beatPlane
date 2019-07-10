local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local Assets = require('assets')
local Enemy = class('Enemy', GameObject)

function Enemy:initialize(scene, image, x, y, speed)
    GameObject.initialize(self)
    self.scene = scene
    self.image = image
    self.x = x
    self.y = y
    self.speed = speed or 100
    self.timer = 2
    self.r = math.random(-math.pi, math.pi)
end

function Enemy:update(dt)
    GameObject.update(self, dt)
    self.timer = self.timer - dt
    if self.timer < 0 then
        self.r = math.random(-2 * math.pi, 2 * math.pi)
        self.timer = 1
    end
    self.x = math.min(self.x + dt * self.speed * math.cos(self.r),
                      love.graphics.getWidth() - self.image:getWidth())
    if self.x < 0 then self.x = 0 end
    self.y = math.min(self.y + dt * self.speed * math.sin(self.r),
                      love.graphics.getHeight() - self.image.getHeight())
    if self.y < 0 then self.y = 0 end
end

function Enemy:draw(dt) love.graphics.draw(self.image, self.x, self.y) end

return Enemy
