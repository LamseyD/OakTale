--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

BossStandState = Class{__includes = EntityStandState}

function BossStandState:init(entity, dungeon)
    EntityStandState.init(self, entity, dungeon)
end

function BossStandState:enter(player, dungeon)--, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
end

function BossStandState:update(dt)
    EntityStandState.processAI(self, {}, dt)
end

function BossStandState:render()
    local anim = self.entity.currentAnimation
    local scaleX = self.entity.scale
    local scaleY = self.entity.scale
    if self.entity.direction == 'right' then
        scaleX = - self.entity.scale
    end

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY + 1), 0, scaleX, scaleY)
end
