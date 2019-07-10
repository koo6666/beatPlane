local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local Timer = require('libraries.hump.timer')
local Bullet = class('Bullet', GameObject)

function Bullet:initialize(scene, image, x, y, speed, r)
    GameObject.initialize(self)
    self.scene = scene
    self.image = image
    self.x = x
    self.y = y
    self.speed = speed or 300
    self.r = r or -math.pi / 2
end

function Bullet:update(dt) 
    self.y = self.y - self.speed * dt 
    if self.y < 0 then
        self.scene:remove_game_object(self)
    end
end

function Bullet:draw(dt) love.graphics.draw(self.image, self.x, self.y) end

return Bullet
