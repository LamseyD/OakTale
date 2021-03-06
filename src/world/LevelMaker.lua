LevelMaker = Class{}

function LevelMaker.generate(def) -- pass in tileset topperset, pass in room definition
    local tiles = {}
    local entities = {}
    local objects = {}
    local portals = {}


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

    for j, item in pairs(def['blocks']) do
        for i = 0, item['width'] - 1 do
           for j = 0, item['height'] - 1 do
                local tileID = TILE_ID_GROUND
                local temp_tile = Tile(item['x'] + i, item['y'] + j, tileID, j == 0 and topper or nil, tileset, topperset)
                tiles[item['y'] + j][item['x'] + i] = temp_tile
           end
        end
    end

    -- for j, item in pairs(ROOM_DEFS['main']['portals']) do
    
    if def['portals'] then
        for j, item in pairs(def['portals']) do
            table.insert(portals, Portal({def = GAME_OBJECT_DEFS['portal'], x = item['x'], y = item['y']}, {map = item['connected_map'], portal = item['connected_portal']}))
        end
    end
    -- local test = 1
    -- for j, item in pairs(GAME_OBJECT_DEFS) do
    --     if j ~= 'portal' then
    --         test = test + 1
    --         local tmp_coin = Item{def = item, x = test * 64, y = 300}
    --         table.insert(objects, tmp_coin)
    --     end
    -- end
    
    -- end


    local map = TileMap(MAP_WIDTH, MAP_HEIGHT)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map, portals)
end
