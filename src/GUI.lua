GUI = Class{}
--Scraps?

function GUI:displayDmg(x, y, amt)
    self.init_x = x
    self.init_y = y - 30
    self.disp_y = self.init_y
    self.disp_opacity = 1
    local amount = amt
    Timer.tween(0.5,{
        [self] = {disp_y = self.disp_y - 50, disp_opacity = 0}
    })
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(252/255,177/255,3/255, self.disp_opacity)
    love.graphics.print(amount, self.init_x, self.disp_y)
    love.graphics.setColor(0,0,0,self.disp_opacity)
    love.graphics.print(amount, self.init_x + 5, self.disp_y + 5)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['title-small'])
end


function GUI:render()
    -- GUI:displayDmg
end