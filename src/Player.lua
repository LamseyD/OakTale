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
    self.current_char = def.current_char
    self.dy = 0
    self.dx = 0
    self.displayLevelUp = false
    -- self.lvl = 1
    self.currentExp = 0
    self.expToLevel = math.ceil(self.lvl * self.lvl * 15)

    self.bank = 0
    self.inventory = {
        str = false,
        dex = false,
        int = false,
        luk = false
    }
    self.quest = {
        tiv = false,
        tiguru = false,
        timu = false,
        tiru = false
    }
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
    while self.currentExp >= self.expToLevel do
        self.lvl = self.lvl + 1
        self.currentExp = self.currentExp - self.expToLevel
        self.expToLevel = math.floor(self.lvl * self.lvl * 15)
    end
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
    if love.keyboard.wasPressed('d') and self.bank >= 50 then
        self.health = math.min(self.maxHealth, self.maxHealth + 50)
        self.bank = self.bank - 50
    end

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.consumable and love.keyboard.wasPressed('z') then
                object.onConsume()
                table.remove(self.level.objects, k)
            end
        end
    end
    -- self.hitbox:update(self.x + 24, self.y + 12)
end

-- function Player:collides(target)
--     self.hitbox:collides(target)
-- end

function Player:checkObjectCollisions()
    self.hitbox:checkObjectCollisions(self.lvl)
end

function Player:render()
    Entity.render(self)
    self.hitbox:render()

    if self.health / self.maxHealth < 0.15 and self.health / self.maxHealth > 0 then
        love.graphics.setFont(gFonts['title-medium'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Press d to use meso to buy potion', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('Press d to use meso to buy potion',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    end
end