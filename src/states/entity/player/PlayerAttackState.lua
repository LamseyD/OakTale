--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    end

    -- separate hitbox for the player's sword; will only be active during this state
    -- self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

    -- sword-left, sword-up, etc
    self.player:changeAnimation('attack')
end

function PlayerAttackState:enter(params)


    -- restart sword swing animation
    self.player.currentAnimation:refresh()
end

function PlayerAttackState:update(dt)
    
    -- -- check if hitbox collides with any entities in the scene
    -- for k, entity in pairs(self.dungeon.currentRoom.entities) do
    --     if entity:collides(self.swordHitbox) then
    --         entity:damage(1)
    --         gSounds['hit-enemy']:play()
    --     end
    -- end

    -- -- if we've fully elapsed through one cycle of animation, change back to idle state
    -- if self.player.currentAnimation.timesPlayed > 0 then
    --     self.player.currentAnimation.timesPlayed = 0
    --     self.player:changeState('idle')
    -- end

    -- -- allow us to change into this state afresh if we swing within it, rapid swinging
    -- if love.keyboard.wasPressed('space') then
    --     self.player:changeState('swing-sword')
    -- end
end

function PlayerAttackState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.direction == 'right' and -1 or 1, 1)

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end