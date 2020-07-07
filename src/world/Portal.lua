Portal = Class {__includes = GameObject}

function Portal:init(def, connection)
    GameObject.init(self, def)
    self.connected_map = connection.map
    self.connected_portal = connection.portal

end

function Portal:update(dt)
    GameObject.update(self,dt)
end

function Portal:render()
    GameObject.render(self)
end