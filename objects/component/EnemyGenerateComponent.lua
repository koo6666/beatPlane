local class = require("libraries.middleclass")
local GameObject = require('objects.GameObject')
local Enemy = require('objects.Enemy')
local Assets = require('assets')
local c = class('EnemyGenerateComponent', GameObject)

function c:initialize(cd)
    GameObject.initialize(self)
    self.CD_MAX = cd or 1
    self.create_CD = self.CD_MAX
end

function c:update(dt)
    self.create_CD = self.create_CD - (1 * dt)
    if self.create_CD < 0 then
        self.create_CD = self.CD_MAX

        local enemy = Enemy:new(self.owner, Assets.enemy_image,
                                math.random(10, love.graphics.getWidth() - 10),
                                -10)
        self.owner:add_game_object(enemy)
    end
end

return c
