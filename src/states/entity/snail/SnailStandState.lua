--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

SnailStandState = Class{__includes = EntityStandState}

function SnailStandState:enter(player, dungeon)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width - 10 or 10
end

function SnailStandState:update(dt)

end
