Hitbox = Class{}

function Hitbox:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Hitbox:update(x, y)
    self.x = x
    self.y = y
end

function Hitbox:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Hitbox:checkObjectCollisions(level)
    local collidedObjects = {}
    local current_level = level
    for k, object in pairs(current_level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
                object.onConsume(self)
                table.remove(current_level.objects, k)
            end
        end
    end

    return collidedObjects
end

function Hitbox:render()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
end