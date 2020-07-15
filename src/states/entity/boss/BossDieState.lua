--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

BossDieState = Class{__includes = BaseState}

function BossDieState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('die')
end

function BossDieState:enter()
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
    self.entity.hitbox.width = 0
    self.entity.hitbox.height = 0
end

function BossDieState:update(dt)
    if not self.entity.dead and self.entity.currentAnimation.timesPlayed == 1 then
        self.entity:goInvulnerable(2)
        self.entity.dead = true
    end
end

function BossDieState:render()
    local anim = self.entity.currentAnimation
    local scaleX = self.entity.scale
    local scaleY = self.entity.scale
    if self.entity.direction == 'right' then
        scaleX = - self.entity.scale
    end

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY + 1), 0, scaleX, scaleY)
end