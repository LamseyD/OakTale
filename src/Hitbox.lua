Hitbox = Class{}

function Hitbox:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

-- function Hitbox:update(x, y)
--     self.x = x
--     self.y = y
-- end

function Hitbox:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Hitbox:checkLeftCollisions(dt, level)
    -- check for left two tiles collision
    local current_level = level
    local collidedObjects = {}
    local tileBottomLeft = current_level.tileMap:pointToTile(self.x + 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if tileBottomLeft and tileBottomLeft:collidable() then
        self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.y = self.y - 1
        collidedObjects = self:checkObjectCollisions(current_level)
        self.y = self.y + 1

        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x + self.walkSpeed * dt
        end
    end
    return collidedObjects
end

function Hitbox:checkRightCollisions(dt, level)
    -- check for right two tiles collision
    local current_level = level
    local collidedObjects = {}
    local tileBottomRight = current_level.tileMap:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if tileBottomRight and tileBottomRight:collidable() then
        self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.y = self.y - 1
        collidedObjects = self:checkObjectCollisions(current_level)
        self.y = self.y + 1

        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x - self.walkSpeed * dt
        end
    end
    return collidedObjects
end

function Hitbox:checkObjectCollisions(level)
    local collidedObjects = {}
    local current_level = level
    for k, object in pairs(current_level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            -- elseif object.consumable then
            --     object.onConsume(self)
            --     table.remove(current_level.objects, k)
            end
        end
    end

    return collidedObjects
end

function Hitbox:render()
    --love.graphics.setColor(1, 0, 0, 1)
    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    --love.graphics.setColor(1, 1, 1, 1)
end