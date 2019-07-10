local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local Bullet = require('objects.Bullet')
local Assets = require('assets')
local PlayerAttackComponent = class('PlayerAttackComponent', GameObject)

function PlayerAttackComponent:initialize()
    GameObject.initialize(self)
    self.attack_cd = 0.2
    self.CD = 0.2

    input:bind('space', 'attack')
    input:bind('rctrl', 'attack')
    input:bind('lctrl', 'attack')
    input:bind('ctrl', 'attack')
end

function PlayerAttackComponent:update(dt)
    self.attack_cd = self.attack_cd - (1 * dt)
    if input:down('attack') then
        if self.attack_cd < 0 then
            local posX, posY = self.owner:get_component('PlayerPathComponent')
                                   :get_position()
            local bullet = Bullet:new(self.owner.scene, Assets.bullet_image,
                                      posX + self.owner.image:getWidth() / 2,
                                      posY - 20)
            self.owner.scene:add_game_object(bullet)
            self.attack_cd = self.CD
        end
    end
end

return PlayerAttackComponent
