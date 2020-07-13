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
    if love.keyboard.wasPressed('d') then
        self.health = self.maxHealth
    end
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
    
    if self.health / self.maxHealth < 0.15 then
        love.graphics.setFont(gFonts['title-medium'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Press d to heal', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('Press d to heal',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    end

    love.graphics.setFont(gFonts['title-small'])
    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 150, 685, 200, 20)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 150, 685, math.max(self.health, 0) * 200/self.maxHealth, 20)
    love.graphics.rectangle('line', 150, 685, 200, 20)
    
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('HP:', 100, 683  )
    love.graphics.print(self.health .. ' / ' .. self.maxHealth, 215, 683)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('HP:', 100, 680  )
    love.graphics.print(self.health .. ' / ' .. self.maxHealth, 215, 680)
    love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end