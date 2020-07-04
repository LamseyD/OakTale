--[[
    GD50
    Super Mario Bros. Remake

    -- PlayerFallingState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.player:changeAnimation('jump')
end

function PlayerFallingState:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.hitbox.y = self.player.hitbox.y + (self.player.dy * dt)

    if self.player.direction == 'right' then
        self.player.offsetX = -self.player.width - 24
    else
        self.player.offsetX = 0
    end 

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.player.level.tileMap:pointToTile(self.player.hitbox.x + 1, self.player.hitbox.y + self.player.hitbox.height)
    local tileBottomRight = self.player.level.tileMap:pointToTile(self.player.hitbox.x + self.player.hitbox.width - 1, self.player.hitbox.y + self.player.hitbox.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) and (tileBottomLeft.topper and tileBottomRight.topper) then
        self.player.dy = 0
        
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walk')
        else
            self.player:changeState('stand')
        end

        self.player.hitbox.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.player.hitbox.height -- + 20
        -- -- check side collisions and reset position
    elseif love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.hitbox.x = self.player.hitbox.x - PLAYER_WALK_SPEED * dt
        -- self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.hitbox.x = self.player.hitbox.x + PLAYER_WALK_SPEED * dt
        -- self.player:checkRightCollisions(dt)
    end

    -- -- check if we've collided with any collidable game objects
    -- for k, object in pairs(self.player.map.objects) do
    --     if object:collides(self.player) then
    --         if object.solid then
    --             self.player.dy = 0
    --             self.player.y = object.y - self.player.height

    --             if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
    --                 self.player:changeState('walking')
    --             else
    --                 self.player:changeState('idle')
    --             end
    --         elseif object.consumable then
    --             object.onConsume(self.player)
    --             table.remove(self.player.level.objects, k)
    --         end
    --     end
    -- end

    -- -- check if we've collided with any entities and kill them if so
    -- for k, entity in pairs(self.player.level.entities) do
    --     if entity:collides(self.player) then
    --         gSounds['kill']:play()
    --         gSounds['kill2']:play()
    --         self.player.score = self.player.score + 100
    --         table.remove(self.player.level.entities, k)
    --     end
    -- end
end

function PlayerFallingState:render()
    local anim = self.player.currentAnimation

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.rotation_x, 1)

end