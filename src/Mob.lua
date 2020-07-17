--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Mob = Class{__includes = Entity}

function Mob:init(def)
    Entity.init(self, def)
    -- self.hitbox = Hitbox(self.x + 24, self.y + 12, self.width, self.height)
    self.dy = 0
    self.dx = 0
    self.exp = def.exp
    self.meso = def.meso_value
    -- self.level = def.level
    self.visibleHP = false
    self.name = def.name
end

function Mob:update(dt)
    Entity.update(self, dt)
    -- self.hitbox:update(self.x + 24, self.y + 12)
end

function Mob:checkObjectCollisions()
    self.hitbox:checkObjectCollisions(self.level)
end

function Mob:render()
    Entity.render(self)
    self.hitbox:render()

    if self.visibleHP then
       love.graphics.setColor(1, 1, 1, 50/255)
       love.graphics.rectangle('fill', math.floor(self.x), math.floor(self.hitbox.y - self.offsetY + 1) - 40, self.width, 10)
       love.graphics.setColor(1, 0, 0, 1)
       love.graphics.rectangle('fill', math.floor(self.x), math.floor(self.hitbox.y - self.offsetY + 1) - 40, math.max(self.health, 0) * self.width/self.maxHealth, 10)
       love.graphics.rectangle('line', math.floor(self.x), math.floor(self.hitbox.y - self.offsetY + 1) - 40, self.width, 10)
       love.graphics.setColor(1, 1, 1, 1)
    end
end
