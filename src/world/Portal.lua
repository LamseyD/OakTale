Portal = Class {__includes = GameObject}

function Portal:init(input, connection)
    GameObject.init(self, input.def, input.x, input.y)
    self.connected_map = connection.map
    self.connected_portal = connection.portal

end

function Portal:update(dt)
    GameObject.update(self,dt)
end

function Portal:render()
    GameObject.render(self)
    -- love.graphics.print(self.connected_map, self.x, self.y)
    -- love.graphics.print(self.connected_portal, self.x, self.y + 20)
end