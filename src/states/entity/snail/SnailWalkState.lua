--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

SnailWalkState = Class{__includes = EntityWalkState}

function SnailWalkState:init(snail, tileMap)
    self.entity = snail
    self.tileMap = tileMap
    self.entity:changeAnimation('walk')
    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 0
    self.entity.direction = math.random(2) == 1 and 'left' or 'right'
    print(self.entity.direction)
end

function SnailWalkState:update(dt)
    local tileBottomRight = self.tileMap:pointToTile(self.entity.x + self.entity.width - 1, self.entity.y + self.entity.height)
    local tileBottomLeft = self.tileMap:pointToTile(self.entity.x - 1, self.entity.y + self.entity.height)
    if self.entity.direction == 'left' and (not tileBottomLeft or not tileBottomLeft:collidable()) then
        self.entity.direction = 'right'
    elseif self.entity.direction == 'right' and (not tileBottomRight or not tileBottomRight:collidable()) then
        self.entity.direction = 'left'
    end
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width or 0
    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end

function SnailWalkState:render()
    local anim = self.entity.currentAnimation
    local extra_offset_X = 0
    local direction_offset_X = 0
    local rotation_x = 1
    if anim:getCurrentFrame() == 16 then
        extra_offset_X = 12
    end

    if self.entity.direction == 'right' then
        if anim:getCurrentFrame() == 16 then
            extra_offset_X = -12
        end
        rotation_x = -1
    end 


    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX + extra_offset_X), math.floor(self.entity.y - self.entity.offsetY + 1), 0, rotation_x, 1)
    
end