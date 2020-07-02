--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    -- self.hitbox = Hitbox(self.x + 24, self.y + 12, self.width, self.height)
    self.dy = 0
    self.dx = 0
end

function Player:update(dt)
    Entity.update(self, dt)
    -- self.hitbox:update(self.x + 24, self.y + 12)
end

-- function Player:collides(target)
--     self.hitbox:collides(target)
-- end

function Player:checkObjectCollisions()
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

function Player:render()
    Entity.render(self)
    self.hitbox:render()
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end