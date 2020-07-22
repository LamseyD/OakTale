--[[
    GD50
    Legend of Zelda

    Util Class

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function GenerateTileSets(quads, setsX, setsY, sizeX, sizeY)
    local tilesets = {}
    local tableCounter = 0
    local sheetWidth = setsX * sizeX
    local sheetHeight = setsY * sizeY

    -- for each tile set on the X and Y
    for tilesetY = 1, setsY do
        for tilesetX = 1, setsX do
            
            -- tileset table
            table.insert(tilesets, {})
            tableCounter = tableCounter + 1

            for y = sizeY * (tilesetY - 1) + 1, sizeY * (tilesetY - 1) + 1 + sizeY do
                for x = sizeX * (tilesetX - 1) + 1, sizeX * (tilesetX - 1) + 1 + sizeX do
                    table.insert(tilesets[tableCounter], quads[sheetWidth * (y - 1) + x])
                end
            end
        end
    end

    return tilesets
end

function GenerateCharacterQuads(atlas, CHAR_DEF, order, max)
    local spritesheet = {}
    local sheetCounter = 1
    local order = order
    local counter = 0
    for j,item in pairs(order) do
        for counter = 0, max do
            for i, frame in pairs(CHAR_DEF["frames"]) do
                if item .. counter .. ".png" == i then
                    spritesheet[sheetCounter] = love.graphics.newQuad(frame["frame"]["x"], frame["frame"]["y"], frame["frame"]["w"], frame["frame"]["h"], atlas:getDimensions())
                    sheetCounter = sheetCounter + 1
                end
            end
        end
    end
    -- for i, frame in ipairs(CHAR_DEF["frames"])
    --     spritesheet[sheetCounter] = love.graphics.newQuad(frame["frame"]["x"], frame["frame"]["y"], frame["frame"]["w"], frame["frame"]["h"], atlas:getDimensions())
    -- -- for i = 0, #CHAR_DEF do
    -- --     spritesheet
    -- -- end
    --     sheetCounter = sheetCounter + 1
    return spritesheet
end

function GenerateCharacterQuads_2(atlas, CHAR_DEF, order, max)
    local spritesheet = {}
    local sheetCounter = 1
    local order = order
    local counter = 0
    for j,item in pairs(order) do
        for counter = 0, max do
            for i, frame in pairs(CHAR_DEF["frames"]) do
                if item .. counter .. ".png" == frame["filename"] then
                    spritesheet[sheetCounter] = love.graphics.newQuad(frame["frame"]["x"], frame["frame"]["y"], frame["frame"]["w"], frame["frame"]["h"], atlas:getDimensions())
                    sheetCounter = sheetCounter + 1
                end
            end
        end
    end
    return spritesheet
end

local function exportstring( s )
    return string.format("%q", s)
 end

--// The original Save and Load Functions are from http://lua-users.org/wiki/SaveTableToFile 
function table.save(tbl, filename)
    local charS,charE = "   ","\n"
    local file,err = io.open( filename, "wb" )
    if err then return err end

    -- initiate variables for save procedure
    local tables,lookup = { tbl },{ [tbl] = 1 }
    file:write( "return {"..charE )

    for idx,t in ipairs( tables ) do
        file:write( "-- Table: {"..idx.."}"..charE )
        file:write( "{"..charE )
        local thandled = {}

        for i,v in ipairs( t ) do
            if v == false then
                v = 'false'
            elseif v == true then
                v = 'true'
            end
            thandled[i] = true
            local stype = type( v )
          -- only handle value
            if stype == "table" then
                if not lookup[v] then
                    table.insert( tables, v )
                    lookup[v] = #tables
                end
                file:write( charS.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
                file:write(  charS..exportstring( v )..","..charE )
            elseif stype == "number" then
                file:write(  charS..tostring( v )..","..charE )
            end
        end

        for i,v in pairs( t ) do
            if v == false then
                v = 'false'
            elseif v == true then
                v = 'true'
            end
          -- escape handled values
            if (not thandled[i]) then
          
                local str = ""
                local stype = type( i )
                -- handle index
                if stype == "table" then
                    if not lookup[i] then
                        table.insert( tables,i )
                        lookup[i] = #tables
                    end
                    str = charS.."[{"..lookup[i].."}]="
                elseif stype == "string" then
                    str = charS.."["..exportstring( i ).."]="
                elseif stype == "number" then
                    str = charS.."["..tostring( i ).."]="
                end
          
                if str ~= "" then
                    stype = type( v )
                -- handle value
                    if stype == "table" then
                        if not lookup[v] then
                            table.insert( tables,v )
                            lookup[v] = #tables
                        end
                        file:write( str.."{"..lookup[v].."},"..charE )
                    elseif stype == "string" then
                        file:write( str..exportstring( v )..","..charE )
                    elseif stype == "number" then
                        file:write( str..tostring( v )..","..charE )
                    end
                end
            end
        end
        file:write( "},"..charE )
    end
    file:write( "}" )
    file:close()
end
 
 --// The Load Function
function table.load(sfile)
    local ftables,err = loadfile( sfile )
    if err then return _,err end
    local tables = ftables()
    for idx = 1,#tables do
        local tolinki = {}
        for i,v in pairs(tables[idx]) do
            if v == "false" then
                tables[idx][i] = false
            elseif v == "true" then
                tables[idx][i] = true
            end
            if type( v ) == "table" then
                tables[idx][i] = tables[v[1]]
            end
            if type( i ) == "table" and tables[i[1]] then
                table.insert( tolinki,{ i,tables[i[1]] } )
            end
        end
        -- link indices
        for _,v in ipairs( tolinki ) do
            tables[idx][v[2]],tables[idx][v[1]] = tables[idx][v[1]],nil
        end
    end
    return tables[1]
end

function copyTable(table)
    local newTable = {}
    for k, v in pairs(table) do
        newTable[k] = v
    end
    return newTable
end

function saveGame(player, roomName)
    local gameSave = {player = copyTable(player),
                          currentRoom = roomName}
        gameSave.player.level = nil
        gameSave.player.stateMachine = nil
        gameSave.player.animations = nil
        gameSave.player.hitbox = nil
        table.save(gameSave, SAVEFILE)
end
--[[
    Recursive table printing function.
    https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
]]
-- function print_r ( t )
--     local print_r_cache= {}
--     local function sub_print_r(t,indent)
--         if (print_r_cache[tostring(t)]) then
--             print(indent.."*"..tostring(t))
--         else
--             print_r_cache[tostring(t)]=true
--             if (type(t)=="table") then
--                 for pos,val in pairs(t) do
--                     if (type(val)=="table") then
--                         print(indent.."["..pos.."] => "..tostring(t).." {")
--                         sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
--                         print(indent..string.rep(" ",string.len(pos)+6).."}")
--                     elseif (type(val)=="string") then
--                         print(indent.."["..pos..'] => "'..val..'"')
--                     else
--                         print(indent.."["..pos.."] => "..tostring(val))
--                     end
--                 end
--             else
--                 print(indent..tostring(t))
--             end
--         end
--     end
--     if (type(t)=="table") then
--         print(tostring(t).." {")
--         sub_print_r(t,"  ")
--         print("}")
--     else
--         sub_print_r(t,"  ")
--     end
--     print()
-- end