Room = Class {}

function Room:init(player, def)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate(def)
    self.tileMap = self.level.tileMap
    self.player = player
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
    love.graphics.draw(gTextures['hene-bg'], 0,0,0,
        VIRTUAL_WIDTH / gTextures['hene-bg']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['hene-bg']:getHeight()
    )
    self.level:render()
    self.player:render()

    
end

function Room:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

    -- flag for whether there's ground on this column of the level
        local groundFound = false

        for y = 1, self.tileMap.height do
            if not groundFound then
                if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                    groundFound = true
                    -- random chance, 1 in 20
                    if math.random(10) == 1 then                   
                        -- instantiate snail, declaring in advance so we can pass it into state machine
                        local snail
			            snail = Snail{
	   		                animations = ENTITY_DEFS['snail'].animations,
			                walkSpeed = ENTITY_DEFS['snail'].walkSpeed,
                            texture = 'snail',
                            width = ENTITY_DEFS['snail'].width,
                            height = ENTITY_DEFS['snail'].height,
                            x = x * TILE_SIZE - ENTITY_DEFS['snail'].width,
                            y = (y - 1) * TILE_SIZE - ENTITY_DEFS['snail'].height,
			                hitbox_offsetX = 0,
			                hitbox_offsetY = 0
                        }
                        snail.level = self.level
                        snail.stateMachine = StateMachine{
                            ['stand'] = function() return EntityStandState(snail, self.tileMap) end,
                            ['walk'] = function() return EntityWalkState(snail, self.tileMap) end
                          --    ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                        }
                        snail:changeState('walk' --,{wait = math.random(5)}
                        )
                        table.insert(self.level.entities, snail)
                    end
                end
            end
        end
    end
end
