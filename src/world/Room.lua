Room = Class {}

function Room:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate()
    self.tileMap = self.level.tileMap
    self.player = player
end

function Room:update(dt)
    self.player:update(dt)
    for i, item in pairs(self.level.objects) do
        item:update(dt)
    end
end

function Room:render()
    love.graphics.draw(gTextures['hene-bg'], 0,0,0,
        VIRTUAL_WIDTH / gTextures['hene-bg']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['hene-bg']:getHeight()
    )
    
    self.tileMap:render()
    for i, item in pairs(self.level.objects) do
        item:render()
    end
    self.player:render()

    
end

-- function Room:spawnEnemies()
    -- -- spawn snails in the level
    -- for x = 1, self.tileMap.width do

    --     -- flag for whether there's ground on this column of the level
    --     local groundFound = false

    --     for y = 1, self.tileMap.height do
    --         if not groundFound then
    --             if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
    --                 groundFound = true

    --                 -- random chance, 1 in 20
    --                 if math.random(20) == 1 then
                        
    --                     -- instantiate snail, declaring in advance so we can pass it into state machine
    --                     local snail
    --                     snail = Snail {
    --                         texture = 'creatures',
    --                         x = (x - 1) * TILE_SIZE,
    --                         y = (y - 2) * TILE_SIZE + 2,
    --                         width = 16,
    --                         height = 16,
    --                         stateMachine = StateMachine {
    --                             ['idle'] = function() return SnailIdleState(self.tileMap, self.player, snail) end,
    --                             ['moving'] = function() return SnailMovingState(self.tileMap, self.player, snail) end,
    --                             ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
    --                         }
    --                     }
    --                     snail:changeState('idle', {
    --                         wait = math.random(5)
    --                     })

    --                     table.insert(self.level.entities, snail)
    --                 end
    --             end
    --         end
    --     end
    -- end
-- end