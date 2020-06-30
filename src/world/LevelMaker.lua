LevelMaker = Class{}

function LevelMaker.generate() -- pass in tileset topperset, pass in room definition
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_GROUND

    local topper = true

    local tileset = 8
    local topperset = 15

    for x = 1, MAP_WIDTH do
        table.insert(tiles,{})
    end

    for x = 1, MAP_WIDTH do
        local tileID = TILE_ID_EMPTY
        for y = 1, 10 do
            table.insert(tiles[y], Tile(x, y, tileID, nil, tileset, topperset))
        end
        tileID = TILE_ID_GROUND
        for y = 11, MAP_HEIGHT do
            table.insert(tiles[y], Tile(x, y, tileID, y == 11 and topper or nil, tileset, topperset))
        end
    end

    local map = TileMap(MAP_WIDTH, MAP_HEIGHT)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end
