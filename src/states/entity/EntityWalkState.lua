--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('walk')

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function EntityWalkState:update(dt)
    
    local tileBottomLeft = self.entity.level.tileMap:pointToTile(self.entity.hitbox.x + 1, self.entity.hitbox.y + self.entity.hitbox.height)
    local tileBottomRight = self.entity.level.tileMap:pointToTile(self.entity.hitbox.x + self.entity.hitbox.width - 1, self.entity.hitbox.y + self.entity.hitbox.height)

    -- temporarily shift entity down a pixel to test for game objects beneath
    self.entity.y = self.entity.y + 1

    -- local collidedObjects = self.entity:checkObjectCollisions()
    local collidedObjects = {}

    self.entity.y = self.entity.y - 1
    if #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
        self.entity.dy = 0
        self.entity:changeState('falling')
    end

    -- assume we didn't hit a wall
    self.bumped = false
    -- boundary checking on all sides, allowing us to avoid collision detection on tiles
    if self.entity.direction == 'left' then
        self.entity.hitbox.x = self.entity.hitbox.x - self.entity.walkSpeed * dt
        
        if self.entity.hitbox.x <= 0 then 
            self.entity.hitbox.x = 0
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.hitbox.x = self.entity.hitbox.x + self.entity.walkSpeed * dt

        if self.entity.hitbox.x + self.entity.hitbox.width >= VIRTUAL_WIDTH then
            self.entity.hitbox.x = VIRTUAL_WIDTH - self.entity.hitbox.width
            self.bumped = true
        end
    end
end

function EntityWalkState:processAI(params, dt)
    local room = params.room
    local directions = {'left', 'right'} --jump update later
    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk')
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('stand')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk')
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY + 1), 0, self.entity.rotation_x, 1)
    
    -- debug code
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end