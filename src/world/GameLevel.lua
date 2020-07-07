--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap, portals)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap
    self.portals = portals
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end

    for k, portal in pairs(self.portals) do
        portal:render()
        love.graphics.setColor(1,0,0,1)
        love.graphics.print(portal.connected_map .. '-'.. portal.connected_portal, portal.x, portal.y-20)
        love.graphics.print(k, portal.x, portal.y + 20)
        love.graphics.setColor(1,1,1,1)
    end
end