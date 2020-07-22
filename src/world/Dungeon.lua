
Dungeon = Class{}

function Dungeon:init(player, initRoom)
    self.player = player

    -- container use to store rooms in a static dungeon
    self.rooms = {}

    for i, item in pairs(ROOM_DEFS) do
        -- local temp_room = Room(self.player, item)
        -- table.insert(self.rooms, temp_room)
        self.rooms[i] = Room(self.player, item, i)
    end

    -- possible create a function to generate all rooms at the beginning?

    -- current room we're operating in
    self.currentRoom = self.rooms[initRoom]
    self.currentRoom:spawnEnemies()
    love.audio.pause()
    gSounds[self.currentRoom.bgm]:play()
    gSounds[self.currentRoom.bgm]:setLooping(true)

    -- room we're moving camera to during a shift; becomes active room afterwards
    self.nextRoom = nil
    -- self.shifting = false
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
    for i, item in pairs(self.currentRoom.level.portals) do
        if self.player:collides(item) and love.keyboard.wasPressed('up') then
            if self.currentRoom.boss then
                gStateStack:pop()
            end
            gStateStack:push(FadeInState({
                r = 1, g = 1, b = 1
            }, 1,
            function()
                -- gSounds['intro-music']:stop()
                -- self.tween:remove(   

                local temp_x = self.rooms[item.connected_map].level.portals[item.connected_portal].x
                local temp_y =  self.rooms[item.connected_map].level.portals[item.connected_portal].y
                
                for i, entity in pairs(self.currentRoom.level.entities) do
                    table.remove(self.currentRoom.level.entities,i)
                end
                
                self.currentRoom = self.rooms[item.connected_map]
                self.player.level = self.currentRoom.level
                self.player.x = temp_x
                self.player.hitbox.x = temp_x
                self.player.y = temp_y + 50
                self.player.hitbox.y = temp_y + 50

                if not self.currentRoom.boss then
                    self.currentRoom:spawnEnemies()
                end
                
                if not gSounds[self.currentRoom.bgm]:isPlaying() then
                    love.audio.pause()
                    gSounds[self.currentRoom.bgm]:seek(0)
                end
                gSFX['portal']:play()
                gSounds[self.currentRoom.bgm]:play()
                gSounds[self.currentRoom.bgm]:setLooping(true)
                -- self.player.x = self.currentRoom.level.portals[item.connected_portal].x 
                -- self.player.y = self.currentRoom.level.portals[item.connected_portal].y + 20
                -- self.player.hitbox.x = self.currentRoom.level.portals[item.connected_portal].x
                -- self.player.hitbox.y = self.currentRoom.level.portals[item.connected_portal].y + 20
                self.player:changeState('falling')
                gStateStack:push(FadeOutState({
                    r = 1, g = 1, b = 1
                }, 1,
                function() end))
            end))
        end
    end

    -- pause updating if we're in the middle of shifting
    --if not self.shifting then    
    self.currentRoom:update(dt)
    --else
        
        -- still update the player animation if we're shifting rooms
    self.player.currentAnimation:update(dt)
    --end

    
end

function Dungeon:render()
    self.currentRoom:render()
    
    -- if self.nextRoom then
    --     self.nextRoom:render()
    -- end
end
