
GameObject = Class{}

function GameObject:init(def, x, y, onConsume)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frames = def.frames or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid
    self.consumable = def.consumable
    self.animated = def.animated or false
    self.interval = def.interval
    -- self.defaultState = def.defaultState
    -- self.state = self.defaultState
    -- self.states = def.states

    -- self.projectile = def.projectile 

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- default empty collision callback
    self.onCollide = function(player, object) end
    self.onConsume = onConsume or nil

    -- directions
    self.direction = def.direction or nil
    self.dx = def.dx or 0
    self.dy = def.dy or 0

    --
    self.x_scale = def.x_scl or 1
    self.y_scale = def.y_scl or 1
    self.hitbox_offsetX = def.hitbox_offsetX
    self.hitbox_offsetY = def.hitbox_offsetY

    self.animations = Animation{texture = self.texture, frames = self.frames, interval = self.interval}
    self.hitbox = Hitbox(self.x + def.hitbox_offsetX, self.y + def.hitbox_offsetY, self.width, self.height)
end

function GameObject:collides(target)
    return not (target.hitbox.x > self.hitbox.x + self.width or self.hitbox.x > target.hitbox.x + target.width or
    target.hitbox.y > self.hitbox.y + self.height or self.hitbox.y > target.hitbox.y + target.height)
end

function GameObject:update(dt)
    -- if self.currentAnimation then
    --     self.currentAnimation:update(dt)
    -- end
    self.animations:update(dt)
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    local anim = self.animations
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x, self.y, 0, self.x_scale, self.y_scale)
    --love.graphics.setColor(1, 0, 0, 1)
    --love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.width, self.height)
    --love.graphics.setColor(1, 1, 1, 1)
end
