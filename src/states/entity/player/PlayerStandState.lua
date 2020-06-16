--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerStandState = Class{__includes = EntityStandState}

function PlayerStandState:enter(player)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
end

function PlayerStandState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        -- self.entity:changeState('swing-sword')
    end

end
