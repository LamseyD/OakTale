--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, dungeon)
    self.entity = player
    -- self.dungeon = dungeon
    self.entity:changeAnimation('walk')
    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 0
    
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
    else
        self.entity:changeState('stand')
    end

    if love.keyboard.isDown('space') then
        self.entity:changeState('jump')
        -- self.entity:changeState('swing-sword')
        -- self.entity:changeState('pot-lift')
    end

    if love.keyboard.isDown('down') then
        self.entity:changeState('prone')
    end
    self.entity.offsetX = self.entity.direction == 'right' and -self.entity.width - 10 or 10
    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end

function PlayerWalkState:render()
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