--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.player:changeAnimation('jump')
    
end

function PlayerJumpState:enter(params)
    -- gSounds['jump']:play()
    self.player.dy = PLAYER_JUMP_VELOCITY
end

function PlayerJumpState:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    -- go into the falling state when y velocity is positive
    if self.player.dy >= 0 then
        self.player:changeState('falling')
    end

    self.player.y = self.player.y + (self.player.dy * dt)

    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        -- self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        -- self.player:checkRightCollisions(dt)
    end

    

    -- check if we've collided with any collidable game objects
    -- for k, object in pairs(self.player.level.objects) do
    --     if object:collides(self.player) then
    --         if object.solid then
    --             object.onCollide(object)

    --             self.player.y = object.y + object.height
    --             self.player.dy = 0
    --             self.player:changeState('falling')
    --         elseif object.consumable then
    --             object.onConsume(self.player)
    --             table.remove(self.player.level.objects, k)
    --         end
    --     end
    -- end

    -- check if we've collided with any entities and die if so
    -- for k, entity in pairs(self.player.level.entities) do
    --     if entity:collides(self.player) then
    --         gSounds['death']:play()
    --         gStateMachine:change('start')
    --     end
    -- end
end

function PlayerJumpState:render()
    local anim = self.player.currentAnimation
    local direction_offset_X = 0
    local rotation_x = 1

    if self.player.direction == 'right' then
        self.player.offsetX = -self.player.width + 12
        rotation_x = -1
    else
        self.player.offsetX = -12
    end 


    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX + direction_offset_X), math.floor(self.player.y - self.player.offsetY), 0, rotation_x, 1)

end