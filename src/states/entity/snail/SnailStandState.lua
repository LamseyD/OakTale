--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

SnailStandState = Class{__includes = EntityStandState}

function SnailStandState:init(snail, tileMap)
    EntityStandState.init(self, snail, tileMap)
end

function SnailStandState:enter(player, dungeon)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
end

function SnailStandState:update(dt)
    EntityStandState.processAI(self, {}, dt)
end
