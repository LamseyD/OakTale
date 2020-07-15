BossState = Class{__includes = BaseState}

function BossState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
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

    if streak then
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1,
        function()
            -- gSounds['intro-music']:stop()
            -- self.tween:remove()
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
    local task = 'Defeat the mighty '..self.currentRoom.boss.name..' or face great shame!'
    love.graphics.setColor(0,0,0,1)
    love.graphics.print(task, 802, 30)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(task, 800, 30)

    if self.player.displayLevelUp then
        love.graphics.setFont(gFonts['title-large'])
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 190, VIRTUAL_WIDTH/2 + 610, 'center')
        love.graphics.setColor(208/255,0,1,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)

    end

    if self.player.health / self.player.maxHealth < 0.15 then
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

    love.graphics.setColor(1, 1, 1, 50/255)
    love.graphics.rectangle('fill', 5 * TILE_SIZE, TILE_SIZE, (MAP_WIDTH - 10) * TILE_SIZE, TILE_SIZE / 2, 8, 8)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 5 * TILE_SIZE, TILE_SIZE, math.max(self.boss.health, 0) * (MAP_WIDTH - 10) * TILE_SIZE/self.boss.maxHealth, TILE_SIZE / 2, 8, 8)
    love.graphics.rectangle('line', 5 * TILE_SIZE, TILE_SIZE, (MAP_WIDTH - 10) * TILE_SIZE, TILE_SIZE / 2, 8, 8)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('TIGURU', 600, 100)
    love.graphics.pop()

--     love.graphics.push()
--     love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
--     love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
--         gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
--     love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
--     love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
--         gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
--     -- translate the entire view of the scene to emulate a camera
--     love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
--     self.level:render()

--     self.player:render()
--     love.graphics.pop()
    
--     -- render score
--     love.graphics.setFont(gFonts['medium'])
--     love.graphics.setColor(0, 0, 0, 255)
--     love.graphics.print(tostring(self.player.score), 5, 5)
--     love.graphics.setColor(255, 255, 255, 255)
--     love.graphics.print(tostring(self.player.score), 4, 4)
end
