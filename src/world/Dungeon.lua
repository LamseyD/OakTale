
Dungeon = Class{}

function Dungeon:init(player)
    self.player = player

    -- container use to store rooms in a static dungeon
    self.rooms = {}

    -- for i, item in pairs(ROOM_DEFS) do
    --     table.insert()
    -- end

    -- possible create a function to generate all rooms at the beginning?

    -- current room we're operating in
    self.currentRoom = Room(self.player, ROOM_DEFS['main'])
    gSounds['title']:stop()
    gSounds[ROOM_DEFS['main']['bgm']]:play()
    self.currentRoom:spawnEnemies()

    -- room we're moving camera to during a shift; becomes active room afterwards
    self.nextRoom = nil
    self.shifting = false
end

-- --[[
--     Prepares for the camera shifting process, kicking off a tween of the camera position.
-- ]]
-- function Dungeon:beginShifting(shiftX, shiftY)
--     -- 

--     -- tween the camera in whichever direction the new room is in, as well as the player to be
--     -- at the opposite door in the next room, walking through the wall (which is stenciled)

-- end

-- --[[
--     Resets a few variables needed to perform a camera shift and swaps the next and
--     current room.
-- ]]
-- function Dungeon:finishShifting()

-- end

function Dungeon:update(dt)
    
    -- pause updating if we're in the middle of shifting
    if not self.shifting then    
        self.currentRoom:update(dt)
    else
        
        -- still update the player animation if we're shifting rooms
        self.player.currentAnimation:update(dt)
    end

    for i, item in pairs(self.currentRoom.level.objects) do
        if self.player:collides(item) and item.type == 'portal' and love.keyboard.wasPressed('up') then
            gStateStack:push(FadeInState({
                r = 1, g = 1, b = 1
            }, 1,
            function()
                -- gSounds['intro-music']:stop()
                -- self.tween:remove(                
                self.currentRoom = Room(self.player, ROOM_DEFS['test'])
                self.player.level = self.currentRoom.level
                self.player:changeState('falling')
                gStateStack:push(FadeOutState({
                    r = 1, g = 1, b = 1
                }, 1,
                function() end))
            end))
        end
    end
end

function Dungeon:render()

    self.currentRoom:render()
    
    -- if self.nextRoom then
    --     self.nextRoom:render()
    -- end
end
