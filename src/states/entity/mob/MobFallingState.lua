--[[
    GD50
    Super Mario Bros. Remake

    -- PlayerFallingState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MobFallingState = Class{__includes = BaseState}

function MobFallingState:init(mob, gravity)
    self.mob = mob
    self.gravity = gravity
    self.mob:changeAnimation('stand')
end

function MobFallingState:update(dt)
    self.mob.dy = self.mob.dy + self.gravity
    self.mob.hitbox.y = self.mob.hitbox.y + (self.mob.dy * dt)
    self.mob.offsetX = self.mob.direction == 'right' and -self.mob.width or 0

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.mob.level.tileMap:pointToTile(self.mob.hitbox.x + 1, self.mob.hitbox.y + self.mob.hitbox.height)
    local tileBottomRight = self.mob.level.tileMap:pointToTile(self.mob.hitbox.x + self.mob.hitbox.width - 1, self.mob.hitbox.y + self.mob.hitbox.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) and (tileBottomLeft.topper and tileBottomRight.topper) then
        self.mob.dy = 0
        self.mob:changeState('walk')
        self.mob.hitbox.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.mob.hitbox.height -- + 20
        -- -- check side collisions and reset position
        -- self.player:checkLeftCollisions(dt)
        -- self.player:checkRightCollisions(dt)
    end

end

function MobFallingState:render()
    local anim = self.mob.currentAnimation

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.mob.x - self.mob.offsetX), math.floor(self.mob.y - self.mob.offsetY), 0, self.mob.rotation_x, 1)

end