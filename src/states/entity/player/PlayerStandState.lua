--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerStandState = Class{__includes = EntityStandState}

function PlayerStandState:enter(player, dungeon)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width - 36 or 10
end

function PlayerStandState:update(dt)
    -- self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 10
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('jump')
    end

    if love.keyboard.isDown('down') then
        self.entity:changeState('prone')
    end

    if love.keyboard.wasPressed('c') then
        self.entity:changeState('attack',{previous = 'stand'})
    end
end
