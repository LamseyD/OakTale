Entity = Class{}

function Entity:init(def)

    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    --hitbox
    self.hitbox = Hitbox(self.x + def.hitbox_offsetX, self.y + def.hitbox_offsetY, 30, 50)
    self.hitbox_offsetX = def.hitbox_offsetX
    self.hitbox_offsetY = def.hitbox_offsetY


    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    self.rotation_x = 1

    self.walkSpeed = def.walkSpeed

    self.health = def.health

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0

    self.dead = false
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
            -- looping = animationDef.looping
        }
    end

    return animationsReturned
end

--[[
    AABB with some slight shrinkage of the box on the top side for perspective.
]]
function Entity:collides(target)
    return self.hitbox:collides(target)
end

function Entity:checkLeftCollisions(dt)
    self.hitbox:checkLeftCollisions(dt, self.level)
    -- update x and y if there is collision
end

function Entity:checkRightCollisions(dt)
    self.hitbox:checkRightCollisions(dt, self.level)
    -- update x and y if there is collision
end

function Entity:checkObjectCollisions()
    local collided = self.hitbox:checkObjectCollisions(self.level)
end


function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    if self.direction == 'right' then
        self.rotation_x = -1
    else 
        self.rotation_x = 1
    end
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    self.stateMachine:update(dt)
    self.x = self.hitbox.x + self.hitbox_offsetX
    self.y = self.hitbox.y + self.hitbox_offsetY
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(1, 1, 1, 64/255)
    end

    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setFont(gFonts['title-small'])
    love.graphics.setColor(0,1,1,1)
    love.graphics.print("x: " .. self.x, self.x, self.y - 30)
    love.graphics.print("y: " .. self.y, self.x, self.y - 10)
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)

    love.graphics.setColor(0, 1, 1, 1)
    love.graphics.rectangle('line', math.floor(self.x - self.offsetX), math.floor(self.y - self.offsetY), self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
end