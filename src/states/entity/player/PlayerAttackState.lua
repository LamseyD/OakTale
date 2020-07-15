PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    -- self.player.offsetY = 5
    -- self.player.offsetX = 8

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight = 0

    if direction == 'left' then
        hitboxWidth = 64
        hitboxHeight = 32
        hitboxX = self.player.hitbox.x - hitboxWidth
        hitboxY = self.player.hitbox.y + 16
    elseif direction == 'right' then
        hitboxWidth = 64
        hitboxHeight = 32
        hitboxX = self.player.hitbox.x + self.player.hitbox.width
        hitboxY = self.player.hitbox.y + 16
    end

    -- separate hitbox for the player's sword; will only be active during this state
    self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.previous = ''
    -- sword-left, sword-up, etc
    self.player:changeAnimation('attack')
end

function PlayerAttackState:enter(params)
    self.player.currentAnimation:refresh()
    -- gSFX['attack']:play()
    self.previous = params.previous
    
    -- restart sword swing animation
    
    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 64
        hitboxHeight = 32
        hitboxX = self.player.hitbox.x - hitboxWidth
        hitboxY = self.player.hitbox.y + 16
    elseif direction == 'right' then
        hitboxWidth = 64
        hitboxHeight = 32
        hitboxX = self.player.hitbox.x + self.player.hitbox.width
        hitboxY = self.player.hitbox.y + 16
    end

    -- separate hitbox for the player's sword; will only be active during this state
    self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
end

function PlayerAttackState:update(dt)

    if self.previous == 'jump' then
        self.player.dy = self.player.dy + GRAVITY_AMOUNT
        self.player.hitbox.y = self.player.hitbox.y + (self.player.dy * dt)    
        -- go into the falling state when y velocity is positive
        if self.player.dy >= 0 then
            self.previous = 'falling'
        end
    
        self.player.hitbox.y = self.player.hitbox.y + (self.player.dy * dt)
    
        if self.player.direction == 'left' and love.keyboard.isDown('left') then
            self.player.hitbox.x = self.player.hitbox.x - PLAYER_WALK_SPEED * dt
            -- self.player:checkLeftCollisions(dt)
        elseif self.player.direction == 'right' and love.keyboard.isDown('right') then
            self.player.hitbox.x = self.player.hitbox.x + PLAYER_WALK_SPEED * dt
            -- self.player:checkRightCollisions(dt)
        end
    elseif self.previous == 'falling' then
        self.player.dy = self.player.dy + GRAVITY_AMOUNT
        self.player.hitbox.y = self.player.hitbox.y + (self.player.dy * dt)
    
        -- look at two tiles below our feet and check for collisions
        local tileBottomLeft = self.player.level.tileMap:pointToTile(self.player.hitbox.x + 1, self.player.hitbox.y + self.player.hitbox.height)
        local tileBottomRight = self.player.level.tileMap:pointToTile(self.player.hitbox.x + self.player.hitbox.width - 1, self.player.hitbox.y + self.player.hitbox.height)
    
        -- if we get a collision beneath us, go into either walking or idle
        if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) and (tileBottomLeft.topper and tileBottomRight.topper) then
            self.player.dy = 0
    
            self.player.hitbox.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.player.hitbox.height -- + 20
            -- -- check side collisions and reset position
        elseif self.player.direction == 'left' and love.keyboard.isDown('left') then
            self.player.hitbox.x = self.player.hitbox.x - PLAYER_WALK_SPEED * dt
            -- self.player:checkLeftCollisions(dt)
        elseif self.player.direction == 'right' and love.keyboard.isDown('right') then
            self.player.hitbox.x = self.player.hitbox.x + PLAYER_WALK_SPEED * dt
            -- self.player:checkRightCollisions(dt)
        end
    end

    -- -- check if hitbox collides with any entities in the scene
    for k, entity in pairs(self.dungeon.currentRoom.level.entities) do
        if entity:collides(self.swordHitbox) and not entity.invulnerable then
            entity:goInvulnerable(1.5)
            local def_amount = 0
            if entity.lvl > self.player.lvl then
                def_amount = entity.baseDEF * math.abs(self.player.lvl - entity.lvl) * 0.5
            else
                def_amount = entity.baseDEF
            end
            local dmg_amount = math.random(math.max( self.player.baseATK - def_amount, 1), self.player.baseATK)
            entity:damage(dmg_amount)
            entity.visibleHP = true
            GUI:displayDmg(math.abs(self.player.hitbox.x - entity.hitbox.x)/2, entity.hitbox.y - 30, dmg_amount)
             -- should be knocked back
            gSFX['hit']:play()
            local knockback = entity.knockback and entity.knockback or 50
            if self.player.direction == 'right' then
                --go into knocked back state here
                entity.hitbox.x = math.min(VIRTUAL_WIDTH - entity.width, entity.hitbox.x + knockback)
            else
                entity.hitbox.x = math.max(0, entity.hitbox.x - knockback)
            end
            -- gSounds['hit-enemy']:play()
        end
    end

    -- -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 and self.player.dy == 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('stand')
    end

    -- -- allow us to change into this state afresh if we swing within it, rapid swinging
    -- if love.keyboard.wasPressed('c') then
    --     self.player:changeState('attack')
    -- end
end

function PlayerAttackState:render()
    local anim = self.player.currentAnimation
    local current_frame = anim:getCurrentFrame()
    
    if current_frame == 10 then
        self.player.offsetY = -7
        if self.player.direction == 'right' then
            self.player.offsetX = -self.player.width - 20
        else
            self.player.offsetX = 0
        end
    elseif current_frame == 11 then
        self.player.offsetY = 10
        if self.player.direction == 'right' then
            self.player.offsetX = -self.player.width - 20
        else
            self.player.offsetX = 0
        end
    elseif current_frame == 12 then
        self.player.offsetY = 56
        if self.player.direction == 'right' then
            self.player.offsetX = -self.player.width - 80
        else
            self.player.offsetX = 60
        end
    end

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.rotation_x, 1)

    --
    -- debug for player and hurtbox collision rects VV
    --

    love.graphics.setColor(1,0,0,1)
    love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y, self.swordHitbox.width, self.swordHitbox.height)
    love.graphics.setColor(1,1,1,1)

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end