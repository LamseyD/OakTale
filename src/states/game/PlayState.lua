PlayState = Class{__includes = BaseState}

function PlayState:init(current_char, load)
    local gameData = load and table.load(SAVEFILE) or nil
    self.saving = false
    self.saveGameOpacity = 0
    self.current_char = load and gameData.player.current_char or 'char-' .. current_char
    self.player = Player{
        current_char = self.current_char,
        animations = ENTITY_DEFS[self.current_char].animations,
        walkSpeed = ENTITY_DEFS[self.current_char].walkSpeed,
        x = VIRTUAL_WIDTH/2 - 15,
        y = VIRTUAL_HEIGHT/2,
        baseHP = ENTITY_DEFS[self.current_char].baseHP,
        baseATK = ENTITY_DEFS[self.current_char].baseATK,
        baseDEF = ENTITY_DEFS[self.current_char].baseDEF,
        lvl = 1,
        width = ENTITY_DEFS[self.current_char].width,
        height = ENTITY_DEFS[self.current_char].height,
        offsetY = ENTITY_DEFS[self.current_char].offsetY, -- Possibly implement offsets for different frames in the ENTITY DEFS table
        hitbox_offsetX = ENTITY_DEFS[self.current_char].hitbox_offsetX,
        hitbox_offsetY = ENTITY_DEFS[self.current_char].hitbox_offsetY
    }
    if load then
    for k, v in pairs(gameData.player) do
            self.player[k] = v
        end
        self.player.hitbox.x = self.player.x - self.player.hitbox_offsetX
        self.player.hitbox.y = self.player.y - self.player.hitbox_offsetY
    end
    local initRoom = gameData and gameData.currentRoom or 'main'
    self.dungeon = Dungeon(self.player, initRoom)
    -- self.current_room = Room(self.player)
    self.gravityOn = true
    -- self.tileMap = self.dungeon.currentRoom.tileMap
    self.player.level = self.dungeon.currentRoom.level
    self.player.stateMachine = StateMachine{
        ['stand'] = function() return PlayerStandState(self.player, self.dungeon) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['attack'] = function() return PlayerAttackState(self.player, self.dungeon) end,
        ['jump'] = function() return PlayerJumpState(self.player, GRAVITY_AMOUNT) end,
        ['falling'] = function() return PlayerFallingState(self.player, GRAVITY_AMOUNT) end,
        ['prone'] = function() return PlayerProneState(self.player, self.dungeon) end,
        ['alert'] = function() return PlayerAlertState(self.player,self.dungeon) end,
        ['dead'] = function() return PlayerDeadState(self.player, self.dungeon) end
    }
    self.player:changeState('falling')
    self.victory_screen = false
end

function PlayState:update(dt)
    -- Timer.update(dt)
    self.dungeon:update(dt)
    if love.keyboard.wasPressed('s') and not self.saving then
        saveGame(self.player, self.dungeon.currentRoom.roomName)
        self.saving = true
        self.saveGameOpacity = 1
        Timer.after(1.5, function()
            Timer.tween(1, {[self] = {saveGameOpacity = 0}})
            Timer.after(1.5, function()
                self.saving = false
            end)
        end)
    end
    if self.dungeon.currentRoom.boss then
        gStateStack:push(BossState(
            self.player, 
            self.dungeon))
    end
    -- self.current_room:update(dt)

    -- -- remove any nils from pickups, etc.
    -- self.level:clear()

    -- constrain player X no matter which state
    if self.player.hitbox.x <= 0 then
        self.player.hitbox.x = 1
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

function PlayState:render()

    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    self.dungeon:render()

    local streak = true
    for j, item in pairs(self.player.inventory) do
        if not item then
            streak = false
        end
    end

    if not streak then
        love.graphics.setColor(0,0,0,1)
        love.graphics.print('Collect all the mythical gemstones by defeating monsters! :)', 700, 30)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print('Collect all the mythical gemstones by defeating monsters! :)', 698, 28)
    else
        love.graphics.setColor(0,0,0,1)
        love.graphics.print('Now go find and defeat the 4 Geese of the Apocalypse!', 700, 30)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print('Now go find and defeat the 4 Geese of the Apocalypse!', 698, 28)
    end

    love.graphics.setColor(0,0,0,self.saveGameOpacity)
    love.graphics.print('Game Saved', 1150, 60)
    love.graphics.setColor(1,1,1,self.saveGameOpacity)
    love.graphics.print('Game Saved', 1148, 58)

    if self.player.displayLevelUp then
        love.graphics.setFont(gFonts['title-large'])

        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 190, VIRTUAL_WIDTH/2 + 610, 'center')
        love.graphics.setColor(208/255,0,1,1)
        love.graphics.printf('Level up!', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
        love.graphics.setColor(1,1,1,1)

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
    love.graphics.setColor(1,1,1,1)
    -- self.current_room:render()
    love.graphics.pop()

end
