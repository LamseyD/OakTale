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

    -- for x = 1, MAP_WIDTH do
    --     local tileID = TILE_ID_EMPTY
    --     for y = 1, 10 do
    --         table.insert(tiles[y], Tile(x, y, tileID, nil, tileset, topperset))
    --     end
    --     tileID = TILE_ID_GROUND
    --     for y = 11, MAP_HEIGHT do
    --         table.insert(tiles[y], Tile(x, y, tileID, y == 11 and topper or nil, tileset, topperset))
    --     end
    -- end


    for x = 1, MAP_WIDTH do
        local tileID = TILE_ID_EMPTY
        for y = 1, MAP_HEIGHT do 
            table.insert(tiles[y], Tile(x, y, tileID, nil, tileset, topperset))
        end
    end

    for j, item in pairs(ROOM_DEFS['main']['blocks']) do
        for i = 0, item['width'] - 1 do
           for j = 0, item['height'] - 1 do
                local tileID = TILE_ID_GROUND
                local temp_tile = Tile(item['x'] + i, item['y'] + j, tileID, j == 0 and topper or nil, tileset, topperset)
                tiles[item['y'] + j][item['x'] + i] = temp_tile
           end
        end
    end

    -- for j, item in pairs(ROOM_DEFS['main']['portals']) do
    for j, item in pairs(ROOM_DEFS['main']['portals']) do
        table.insert(objects, GameObject(GAME_OBJECT_DEFS['portal'], item['x'], item['y']))
    end
    
    -- end


    local map = TileMap(MAP_WIDTH, MAP_HEIGHT)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end
