--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

BossWalkState = Class{__includes = EntityWalkState}

function BossWalkState:init(boss, tileMap)
    EntityWalkState.init(self, boss, tileMap)
    self.tileMap = tileMap
end

function BossWalkState:update(dt)
    EntityWalkState.update(self, dt)
    if self.bumped and self.entity.phase == 3 then
        self.entity.direction = self.entity.direction == 'left' and 'right' or 'left'
        self.entity:changeState('stand')
    end
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
    -- perform base collision detection against walls
    if self.entity.phase < 3 then
        EntityWalkState.processAI(self, {room = tileMap}, dt)
    end
end

function BossWalkState:render()
    local anim = self.entity.currentAnimation
    local extra_offset_X = 0
    local direction_offset_X = 0
    local scaleX = self.entity.scale
    local scaleY = self.entity.scale
    if self.entity.direction == 'right' then
        scaleX = - self.entity.scale
    end

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX + extra_offset_X), math.floor(self.entity.y - self.entity.offsetY + 1), 0, scaleX, scaleY)
end
