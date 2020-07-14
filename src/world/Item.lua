Item = Class {__includes = GameObject}

function Item:init(input)
    GameObject.init(self, input.def, input.x, input.y, input.onConsume)
    self.top_y = self.hitbox.y - 2
    self.bot_y = self.hitbox.y + 2
    self.direction = 'up'
    self.opacity = 0
    self.dy = 0 
    self.falling = true
end

function Item:update(dt)
    --trigger gravity??? Later in future implementation
    --item floats up and down
    GameObject.update(self,dt)
    if self.direction == 'up' then
        Timer.tween(0.8, {
            [self] = {y = self.top_y}
        }):finish(function()
            self.direction = 'down'
        end)
    elseif self.direction == 'down' then
        Timer.tween(0.8, {
            [self] = {y = self.bot_y}
        }):finish(function()
            self.direction = 'up'
        end)
    end
end

function Item:render()
    love.graphics.draw(gTextures[self.texture], self.x, self.y, 0, self.x_scale, self.y_scale)
    -- love.graphics.print(self.connected_map, self.x, self.y)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.print(self.connected_Item, self.x, self.y + 20)
end