--[[
    GD50
    -- Super Mario Bros. Remake --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Tile = Class{}

function Tile:init(x, y, id, topper, tileset, topperset)
    self.x = x
    self.y = y

    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = id
    self.tileset = tileset
    self.topper = topper
    self.topperset = topperset
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    
    if self.id ~= TILE_ID_EMPTY then
        love.graphics.draw(gTextures['tiles'], gFrames['tilesets'][self.tileset][self.id],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE, 0, 4, 4)
    end
    -- tile top layer for graphical variety
    if self.topper then
        love.graphics.draw(gTextures['toppers'], gFrames['toppersets'][self.topperset][self.id],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE, 0, 4, 4)
    end
    --love.graphics.setColor(1,0,1,1)
    --love.graphics.rectangle('line', (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE, self.width, self.height)
    love.graphics.setColor(1,1,1,1)
end