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
    self.displayLevelUp = false
    -- self.lvl = 1
    self.currentExp = 0
    self.expToLevel = math.ceil(self.lvl * self.lvl * 15)

end

function Player:statsLevelUp()
    local HPIncrease = 0

    self.maxHealth = math.floor(self.maxHealth + self.lvl * 10)

    local attackIncrease = 0

    self.baseATK = math.floor(self.baseATK + self.lvl * 1.25)
    local defenseIncrease = 0

    self.baseDEF = math.floor(self.baseDEF + self.lvl * 1.5)

    self.health = self.maxHealth
    return HPIncrease, attackIncrease, defenseIncrease
end

function Player:levelUp()
    self.currentExp = 0
    self.lvl = self.lvl + 1
    self.expToLevel = math.floor(self.lvl * self.lvl * 15)
    gSFX['level-up']:play()
    Timer.every(0.25, function()
        self.displayLevelUp = not self.displayLevelUp
    end):limit(8)
    :finish(function()
        self.displayLevelUp = false
    end)

    return self:statsLevelUp()
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

    -- for k, object in pairs(self.lvl.objects) do
    --     if object:collides(self) then
    --         if object.solid then
    --             table.insert(collidedObjects, object)
    --         elseif object.consumable then
    --             object.onConsume(self)
    --             table.remove(self.lvl.objects, k)
    --         end
    --     end
    -- end

    -- return collidedObjects
    self.hitbox:checkObjectCollisions(self.lvl)
end

function Player:render()
    

    Entity.render(self)
    self.hitbox:render()

    if self.displayLevelUp then
        love.graphics.setFont(gFonts['title-large'])

        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 190, VIRTUAL_WIDTH/2 + 610, 'center')
        love.graphics.setColor(208/255,0,1,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)

    end

    if self.health / self.maxHealth < 0.15 then
        love.graphics.setFont(gFonts['title-medium'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Press d to heal', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('Press d to heal',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    end

    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('Level ' .. self.lvl, 50, 665)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print('Level ' .. self.lvl, 50, 660)

    love.graphics.setFont(gFonts['title-small'])
    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 300, 685, 200, 20)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 300, 685, math.max(math.floor(self.health), 0) * 200/self.maxHealth, 20)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', 300, 685, 200, 20)
    
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('HP:', 250, 683  )
    love.graphics.print(self.health .. ' / ' .. self.maxHealth, 365, 683)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('HP:', 250, 680  )
    love.graphics.print(self.health .. ' / ' .. self.maxHealth, 365, 680)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 565, 685, 200, 20)
    love.graphics.setColor(240/255, 252/255, 3/255, 1)
    love.graphics.rectangle('fill', 565, 685, math.max(math.floor(self.currentExp), 0) * 200/self.expToLevel, 20)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', 565, 685, 200, 20)

    love.graphics.setColor(0,0,0,1)
    love.graphics.print('EXP:', 515, 683  )
    love.graphics.print(self.currentExp .. ' / ' .. self.expToLevel, 630, 683)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('EXP:', 515, 680  )
    love.graphics.print(self.currentExp .. ' / ' .. self.expToLevel, 630, 680)
    love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end