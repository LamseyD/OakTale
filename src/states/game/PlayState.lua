PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- self.camX = 0
    -- self.camY = 0
    -- self.level = LevelMaker.generate()
    -- self.tileMap = self.level.tileMap
    -- self.background = math.random(3)
    -- self.backgroundX = 0
    -- self.backgroundY = 0
    self.player = Player{
        animations = ENTITY_DEFS['char-1'].animations,
        walkSpeed = ENTITY_DEFS['char-1'].walkSpeed,
        x = VIRTUAL_WIDTH/2,
        y = VIRTUAL_HEIGHT/2,
        width = 65, -- Implement a new function to get current width and height from current quad frame
        height = 95,
        health = ENTITY_DEFS['char-1'].health,
        offsetY = ENTITY_DEFS['char-1'].offsetY -- Possibly implement offsets for different frames in the ENTITY DEFS table
    }
    self.dungeon = Dungeon(self.player)
    -- self.current_room = Room(self.player)
    self.gravityOn = true
    self.tileMap = self.dungeon.currentRoom.tileMap
    self.player.map = self.tileMap
    self.player.stateMachine = StateMachine{
        ['stand'] = function() return PlayerStandState(self.player, self.dungeon) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['attack'] = function() return PlayerAttackState(self.player, self.dungeon) end,
        ['jump'] = function() return PlayerJumpState(self.player, GRAVITY_AMOUNT) end,
        ['falling'] = function() return PlayerFallingState(self.player, GRAVITY_AMOUNT) end,
        ['prone'] = function() return PlayerProneState(self.player, self.dungeon) end
    }

    self.player:changeState('falling')
end

function PlayState:update(dt)
    -- Timer.update(dt)
    self.dungeon:update(dt)
    -- self.current_room:update(dt)

    -- -- remove any nils from pickups, etc.
    -- self.level:clear()

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x + self.player.width > VIRTUAL_WIDTH then
        self.player.x = VIRTUAL_WIDTH - self.player.width
    end
end

function PlayState:render()

    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    self.dungeon:render()
    -- self.current_room:render()
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

-- function PlayState:updateCamera()
--     -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
--     -- setting it half the screen to the left of the player so they are in the center
--     -- self.camX = math.max(0,
--     --     math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
--     --     self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

--     -- adjust background X to move a third the rate of the camera for parallax
--     self.backgroundX = (self.camX / 3) % 256
--     self.backgroundY = (self.camY / 3) % 256
-- end

--[[
    Adds a series of enemies to the level randomly.
]]
