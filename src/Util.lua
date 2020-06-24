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

function GenerateCharacterQuads(atlas, CHAR_DEF)
    local spritesheet = {}
    local sheetCounter = 1
    local order = {"alert_","jump_","proneStab_","stand1_","swingO1_","walk1_"}
    local counter = 0
    for j,item in pairs(order) do
        for counter = 0, 3 do
            for i, frame in pairs(CHAR_DEF["frames"]) do
                if item .. counter .. ".png" == i then
                    spritesheet[sheetCounter] = love.graphics.newQuad(frame["frame"]["x"], frame["frame"]["y"], frame["frame"]["w"], frame["frame"]["h"], atlas:getDimensions())
                    sheetCounter = sheetCounter + 1
                -- counter = counter + 1
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

function GenerateCharacterQuads_2(atlas, CHAR_DEF)
    local spritesheet = {}
    local sheetCounter = 1
    local counter = 1
    for j, item in pairs(CHAR_DEF["frames"]) do
        spritesheet[sheetCounter] = love.graphics.newQuad(item["frame"]["x"], item["frame"]["y"], item["frame"]["w"], item["frame"]["h"], atlas:getDimensions())
        sheetCounter = sheetCounter + 1
        counter = counter + 1
    end
    return spritesheet
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