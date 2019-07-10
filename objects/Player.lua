local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local PlayerPathComponent = require(
                                'objects.component.player.PlayerPathComponent')
local PlayerAttackComponent = require(
                                  "objects.component.player.PlayerAttackComponent")
local Assets = require('assets')
local Player = class('Player', GameObject)

function Player:initialize(scene, image, x, y, speed)
    GameObject.initialize(self)
    self.scene = scene
    self.image = image
    self.is_alive = true
    self.source_x = x
    self.source_y = y

    self:add_component('PlayerPathComponent',
                       PlayerPathComponent:new(x, y, speed))
    self:add_component('PlayerAttackComponent', PlayerAttackComponent:new())
end

function Player:reset()
    local component = self:get_component('PlayerPathComponent')
    component.x = self.source_x
    component.y = self.source_y
end

function Player:update(dt)
    GameObject.update(self, dt)
    -- if not self.is_alive then self.scene:remove_game_object(self) end
end

function Player:draw(dt)
    if not self.is_alive then return end
    local posX, posY = self:get_component('PlayerPathComponent'):get_position()
    love.graphics.draw(self.image, posX, posY)
end

return Player
