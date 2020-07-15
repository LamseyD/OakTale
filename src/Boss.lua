--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Boss = Class{__includes = Entity}

function Boss:init(def)
    Entity.init(self, def)
    -- self.hitbox = Hitbox(self.x + 24, self.y + 12, self.width, self.height)
    self.dy = 0
    self.dx = 0
    self.exp = def.exp
    self.meso = def.meso_value
    self.phase = 1
<<<<<<< HEAD
    self.health = self.maxHealth
=======
>>>>>>> e02fbb5a3c3fe659e04213182ecd58ffe0a86e80
end

function Boss:update(dt)
    Entity.update(self, dt)
    if self.phase < 3 and self.health <= self.maxHealth / 3 then
        self.phase = 3
        self.walkSpeed = self.walkSpeed * 3
        self.maxWaitDuration = 3
        self.knockback = 0
    elseif self.phase == 1 and self.health <= self.maxHealth * 2 / 3 then
        self.phase = 2
        self.walkSpeed = self.walkSpeed * 2
        self.maxWaitDuration = 3
    end
    -- self.hitbox:update(self.x + 24, self.y + 12)
end

-- function Player:collides(target)
--     self.hitbox:collides(target)
-- end

function Boss:checkObjectCollisions()
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

function Boss:render()
    Entity.render(self)
    self.hitbox:render()
end
