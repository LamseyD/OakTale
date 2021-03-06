BossState = Class{__includes = BaseState}

function BossState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.bossDefeated = false
    self.saveGameOpacity = 0
    self.saving = false
    self.currentRoom = self.dungeon.currentRoom
    local bossName = self.currentRoom.boss.name
    local x = self.currentRoom.boss.x
    local y = self.currentRoom.boss.y
    -- self.current_room = Room(self.player)
    self.gravityOn = true
    -- self.tileMap = self.dungeon.currentRoom.tileMap
    self.player.level = self.currentRoom.level
    self.victory_screen = false
    self.boss = Boss{
        animations = ENTITY_DEFS[bossName].animations,
        walkSpeed = ENTITY_DEFS[bossName].walkSpeed,
        texture = bossName,
        baseHP = ENTITY_DEFS[bossName].baseHP,
        baseATK = ENTITY_DEFS[bossName].baseATK,
        baseDEF = ENTITY_DEFS[bossName].baseDEF,
        exp = ENTITY_DEFS[bossName].exp_value,
        meso_value = ENTITY_DEFS[bossName].meso_value,
        lvl = ENTITY_DEFS[bossName].level,
        width = ENTITY_DEFS[bossName].width,
        height = ENTITY_DEFS[bossName].height,
        x = x * TILE_SIZE - ENTITY_DEFS[bossName].width,
        y = (y - 1) * TILE_SIZE - ENTITY_DEFS[bossName].height,
        hitbox_offsetX = 0,
        hitbox_offsetY = 0,
        scale = ENTITY_DEFS[bossName].scale
    }
    self.boss.level = self.currentRoom.level
    self.boss.stateMachine = StateMachine{
                                ['stand'] = function() return BossStandState(self.boss, self.currentRoom.level.tileMap) end,
                                ['walk'] = function() return BossWalkState(self.boss, self.currentRoom.level.tileMap) end,
                                ['die'] = function() return BossDieState(self.boss) end
                            }
    self.boss:changeState('walk')
    table.insert(self.currentRoom.level.entities, self.boss)
end

function BossState:exit()
    self.dungeon.currentRoom.level.entities = {}
end

function BossState:update(dt)
    -- Timer.update(dt)
    self.dungeon:update(dt)
    if not self.dungeon.currentRoom.boss then
        gStateStack:pop()
    end
    if self.boss.health <= 0 then
        self.bossDefeated = true
    end
    if love.keyboard.wasPressed('s') and not self.saving then
        self.saving = true
        self.saveGameOpacity = 1
        Timer.after(1.5, function()
            Timer.tween(1, {[self] = {saveGameOpacity = 0}})
            Timer.after(1.5, function()
                self.saving = false
            end)
        end)
    end
    -- self.current_room:update(dt)

    -- -- remove any nils from pickups, etc.
    -- self.level:clear()

    -- constrain player X no matter which state
    if self.player.hitbox.x <= 0 then
        self.player.hitbox.x = 0
    elseif self.player.hitbox.x + self.player.hitbox.width > VIRTUAL_WIDTH then
        self.player.hitbox.x = VIRTUAL_WIDTH - self.player.hitbox.width
    end

    local streak = true
    for j, item in pairs(self.player.inventory) do
        if not item then
            streak = false
        end
    end

    for j, boss in pairs(self.player.quest) do
        if not boss then
            streak = false
        end
    end

    if streak then
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1,
        function()
            gStateStack:pop()
            love.audio.pause()
            gStateStack:push(VictoryState())
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1,
            function() end))
        end))
    end
end

function BossState:render()

    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    self.dungeon:render()
    local task = self.bossDefeated and 'Congratulations! You have defeated '..self.currentRoom.boss.name..'!' or 'Defeat the mighty '..self.currentRoom.boss.name..' or face great shame!'
    if not self.bossDefeated then
        love.graphics.setColor(1, 1, 1, 50/255)
        love.graphics.rectangle('fill', 5 * TILE_SIZE, TILE_SIZE, (MAP_WIDTH - 10) * TILE_SIZE, TILE_SIZE / 2, 8, 8)
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle('fill', 5 * TILE_SIZE, TILE_SIZE, math.max(self.boss.health, 0) * (MAP_WIDTH - 10) * TILE_SIZE/self.boss.maxHealth, TILE_SIZE / 2, 8, 8)
        love.graphics.rectangle('line', 5 * TILE_SIZE, TILE_SIZE, (MAP_WIDTH - 10) * TILE_SIZE, TILE_SIZE / 2, 8, 8)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(string.upper(self.currentRoom.boss.name), 600, 100)
    end
    
    love.graphics.setColor(0,0,0,1)
    love.graphics.print(task, 850, 30)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(task, 848, 30)

    love.graphics.setColor(0,0,0,self.saveGameOpacity)
    love.graphics.print('Cannot save game during boss fight', 940, 60)
    love.graphics.setColor(1,1,1,self.saveGameOpacity)
    love.graphics.print('Cannot save game during boss fight', 938, 58)

    if self.player.displayLevelUp then
        love.graphics.setFont(gFonts['title-large'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 190, VIRTUAL_WIDTH/2 + 610, 'center')
        love.graphics.setColor(208/255,0,1,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)

    end

    if self.player.health / self.player.maxHealth < 0.2 and self.player.health / self.player.maxHealth > 0 then
        love.graphics.setFont(gFonts['title-medium'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Press d to use meso to buy potion', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('Press d to use meso to buy potion',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    end

    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('Level ' .. self.player.lvl, 50, 665)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print('Level ' .. self.player.lvl, 45, 660)

    love.graphics.setFont(gFonts['title-small'])
    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 300, 685, 200, 20)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 300, 685, math.max(math.floor(self.player.health), 0) * 200/self.player.maxHealth, 20)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', 300, 685, 200, 20)
    
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('HP:', 250, 683  )
    love.graphics.print(self.player.health .. ' / ' .. self.player.maxHealth, 365, 683)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('HP:', 247, 680  )
    love.graphics.print(self.player.health .. ' / ' .. self.player.maxHealth, 362, 680)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 565, 685, 200, 20)
    love.graphics.setColor(240/255, 252/255, 3/255, 1)
    love.graphics.rectangle('fill', 565, 685, math.max(math.floor(self.player.currentExp), 0) * 200/self.player.expToLevel, 20)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', 565, 685, 200, 20)

    love.graphics.setColor(0,0,0,1)
    love.graphics.print('EXP:', 515, 683  )
    love.graphics.print(self.player.currentExp .. ' / ' .. self.player.expToLevel, 630, 683)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('EXP:', 512, 680  )
    love.graphics.print(self.player.currentExp .. ' / ' .. self.player.expToLevel, 627, 680)
    -- love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(gTextures['maple'], 780, 680, 0, 0.25, 0.25)
    love.graphics.setColor(0,0,0,1)
    love.graphics.print(': '.. self.player.bank, 825, 683  )
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(': '.. self.player.bank, 822, 680  )
    
    if not self.player.inventory.str then
        love.graphics.setColor(1,1,1,0.5)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.draw(gTextures['jewel-1'], 1000, 680, 0, 0.25, 0.25)
    if not self.player.inventory.dex then
        love.graphics.setColor(1,1,1,0.5)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.draw(gTextures['jewel-2'], 1050, 680, 0, 0.25, 0.25)
    if not self.player.inventory.int then
        love.graphics.setColor(1,1,1,0.5)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.draw(gTextures['jewel-3'], 1100, 680, 0, 0.25, 0.25)
    if not self.player.inventory.luk then
        love.graphics.setColor(1,1,1,0.5)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.draw(gTextures['jewel-4'], 1150, 680, 0, 0.25, 0.25)

    love.graphics.pop()
end
