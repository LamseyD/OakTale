Room = Class {}

function Room:init(player, def)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate(def)
    self.tileMap = self.level.tileMap
    self.player = player
    self.bgm = def.bgm
    -- gSounds[self.bgm]:setLooping(true)
    self.background = def.background
end

function Room:enter()

end

function Room:exit()

end

function Room:change()

end

function Room:update(dt)
    self.player:update(dt)
    for i, item in pairs(self.level.objects) do
        item:update(dt)
    end

    for i, entity in pairs(self.level.entities) do
        -- -- local entity = self.entities[i]
        -- for x, tmp in pairs(self.objects) do
        --     if tmp.fired then
        --         if entity:collides(tmp) then
        --             entity.health = 0
        --             tmp.fired = false
        --             tmp.state = 'broken'
        --             tmp.solid = true
        --         end
        --     end
        -- end
        -- remove entity from the table if health is <= 0
        if entity.health <= 0 then
            entity.dead = true
        elseif not entity.dead then
            entity:update(dt)
        end

        -- collision between the player and entities in the room
        if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
            self.player:damage(math.random(entity.baseATK))
            self.player:goInvulnerable(1.5)
            if self.player.direction == 'right' then 
               self.player.hitbox.x = math.max(1, self.player.hitbox.x - 50)
            elseif self.player.direction == 'left' then
                self.player.hitbox.x = math.min(VIRTUAL_WIDTH, self.player.hitbox.x + 50)
            end
            self.player.hitbox.y = self.player.hitbox.y - 15
            self.player:changeState('falling')
            if self.player.health == 0 then
                -- gStateMachine:change('start') -- dead state?
            end
        end
    
        if entity.dead then
            table.remove(self.level.entities, i)
        end

    end
end

function Room:render()
    love.graphics.draw(gBackgrounds[self.background], 0,0,0,
        VIRTUAL_WIDTH / gBackgrounds[self.background]:getWidth(),
        VIRTUAL_HEIGHT / gBackgrounds[self.background]:getHeight()
    )
    self.level:render()
    self.player:render()

    
end

function Room:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

    -- flag for whether there's ground on this column of the level
        local groundFound = false
        local prevGroundFound = false

        for y = 1, self.tileMap.height do
            prevGroundFound = groundFound
            if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                groundFound = true
                    -- random chance, 1 in 10
                if not prevGroundFound and math.random(10) == 1 then              
                    -- instantiate snail, declaring in advance so we can pass it into state machine
                    local mob
                    local mobName = mobKeys[math.random(#mobKeys)]
                    mob = Mob{
                        animations = ENTITY_DEFS[mobName].animations,
                        walkSpeed = ENTITY_DEFS[mobName].walkSpeed,
                        texture = mob,
                        health = ENTITY_DEFS[mobName].baseHP,
                        baseATK = ENTITY_DEFS[mobName].baseATK,
                        baseDEF = ENTITY_DEFS[mobName].baseDEF,
                        width = ENTITY_DEFS[mobName].width,
                        height = ENTITY_DEFS[mobName].height,
                        x = x * TILE_SIZE - ENTITY_DEFS[mobName].width,
                        y = (y - 1) * TILE_SIZE - ENTITY_DEFS[mobName].height,
                        hitbox_offsetX = 0,
                        hitbox_offsetY = 0
                    }
                    mob.level = self.level
                    mob.stateMachine = StateMachine{
                        ['stand'] = function() return MobStandState(mob, self.tileMap) end,
                        ['walk'] = function() return MobWalkState(mob, self.tileMap) end
                        --    ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                    }
                    mob:changeState('walk' --,{wait = math.random(5)}
                    )
                    table.insert(self.level.entities, mob)
                end
            elseif self.tileMap.tiles[y][x].id == TILE_ID_EMPTY then
                groundFound = false
            end
        end
    end
end
