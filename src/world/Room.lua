Room = Class {}

function Room:init(player, def)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate(def)
    self.tileMap = self.level.tileMap
    self.player = player
    -- to be added
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
    for i, item in pairs(self.level.entities) do
        item:update(dt)
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
