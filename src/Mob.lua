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
    self.visibleHP = false
end

function Mob:update(dt)
    Entity.update(self, dt)
    -- self.hitbox:update(self.x + 24, self.y + 12)
end

-- function Player:collides(target)
--     self.hitbox:collides(target)
-- end

function Mob:checkObjectCollisions()
    -- local collidedObjects = {}

    -- for k, object in pairs(self.level.objects) do
    --     if object:collides(self) then
    --         if object.solid then
    --             table.insert(collidedObjects, object)
    --         elseif object.consumable then
    --             object.onConsume(self)
    --             table.remove(self.level.objects, k)
    --         end
    --     end
    -- end

    -- return collidedObjects
    self.hitbox:checkObjectCollisions(self.level)
end

function Mob:render()
    Entity.render(self)
    self.hitbox:render()
    if self.visibleHP then
       love.graphics.setColor(255, 255, 255, 50)
       love.graphics.rectangle('fill', math.floor(self.x - self.offsetX), math.floor(self.y - self.offsetY + 1) - 40, self.width, 10)
       love.graphics.setColor(255, 0, 0, 255)
       love.graphics.rectangle('fill', math.floor(self.x - self.offsetX), math.floor(self.y - self.offsetY + 1) - 40, math.max(self.health, 0) * self.width/self.maxHealth, 10)
       love.graphics.rectangle('line', math.floor(self.x - self.offsetX), math.floor(self.y - self.offsetY + 1) - 40, self.width, 10)
       love.graphics.setColor(255, 255, 255, 255)
    end
end
