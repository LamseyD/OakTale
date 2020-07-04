--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MobStandState = Class{__includes = EntityStandState}

function MobStandState:init(entity, dungeon)
    EntityStandState.init(self, entity, dungeon)
end

function MobStandState:enter(player, dungeon)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
end

function MobStandState:update(dt)
    EntityStandState.processAI(self, {}, dt)
end
