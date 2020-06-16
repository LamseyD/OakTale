Room = Class {}

function Room:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate()
    self.tileMap = self.level.tileMap
    self.player = player
end

function Room:update(dt)

    --place holder for testing.
    --should implement in player states
    -- for k, tile in pairs(self.level.tileMap.tiles) do
    --     if tile.id == TILE_ID_GROUND then
    --         if self.player:platform_collision(tile) then
    --             self.player.y = (tile.y - 1) - self.player.height
    --         end
    --     end
    -- end
    self.player:update(dt)
end

function Room:render()
    love.graphics.draw(gTextures['hene-bg'], 0,0,0,
        VIRTUAL_WIDTH / gTextures['hene-bg']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['hene-bg']:getHeight()
    )
    self.tileMap:render()
    self.player:render()
end