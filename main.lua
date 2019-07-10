debug = true

local Input = require('libraries.Input')
local Player = require('objects.Player')
local Scene = require('objects.Scene')
local Assets = require("assets")
local EnemyGenerateComponent = require(
                                   'objects.component.EnemyGenerateComponent')
local ScoreComponent = require('objects.component.ScoreComponent')

function table_leng(t)
    local leng = 0
    for k, v in pairs(t) do leng = leng + 1 end
    return leng
end

function love.load(arg)
    input = Input()
    key_binding()
    scene = Scene()
    scene:add_component('EnemyGenerateComponent', EnemyGenerateComponent:new())
    scene:add_component('ScoreComponent', ScoreComponent:new())
    player = Player:new(scene, Assets.plane_image, 200, 710, 150)
    scene:add_game_object(player)
end

function love.update(dt) scene:update(dt) end

function love.draw(dt) scene:draw(dt) end

function key_binding()
    input:bind('escape', function() love.event.push('quit') end)
end