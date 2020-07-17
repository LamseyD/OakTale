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
    self.extra_offset_X = 0
end

function PlayerWalkState:update(dt)
    if self.entity.direction == 'right' then
        self.entity.offsetX = -self.entity.width - 46
    else
        self.entity.offsetX = 20
    end

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
    else
        self.entity:changeState('stand')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('jump')
    end

    if love.keyboard.isDown('down') then
        self.entity:changeState('prone')
    end

    if love.keyboard.wasPressed('c') then
        self.entity:changeState('attack', {previous = 'stand'})
    end
    
    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end

function PlayerWalkState:render()
    --move to update if needed to clean up animation. ??????

    local anim = self.entity.currentAnimation
    local offset_flag = true
    if anim.texture == 'character-2' then
        if self.entity.direction == 'right' then
            self.entity.offsetX = -self.entity.width - 30
        else
            self.entity.offsetX = 5
        end
    end
    self.extra_offset_X = 0
    if anim:getCurrentFrame() == 16 and anim.texture ~= 'character-2' then
        self.extra_offset_X = 12
        if self.entity.direction == 'right' then
            self.extra_offset_X = -12
        end
    end
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX + self.extra_offset_X), math.floor(self.entity.y - self.entity.offsetY + 1), 0, self.entity.rotation_x, 1)
    
end