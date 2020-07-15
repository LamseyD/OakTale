StoryState = Class{__includes = BaseState}

function StoryState:init()
    gSounds['title']:setLooping(true)
    gSounds['title']:play()
    
    self.opacity = 0
    self.iterator = 1
    self.canInput = true
    Timer.tween(1, {
        [self] = {opacity = 1}
    })
end

function StoryState:update(dt)
    if (love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter')) and self.canInput then
        -- move to play state
        -- gStateMachine:change('char-select')
        -- gStateStack:pop()
        -- gStateStack:push(CharacterSelectState())
        self.canInput = false
        Timer.tween(2, {
            [self] = {opacity = 0}
        }):finish(function()
            self.iterator = self.iterator + 1
            if self.iterator > 4 then
                gStateStack:push(FadeInState({
                    r = 1, g = 1, b = 1
                }, 1,
                function()
                    -- gSounds['intro-music']:stop()
                    -- self.tween:remove()
                    gStateStack:pop()
                
                    gStateStack:push(CharacterSelectState())
                    gStateStack:push(FadeOutState({
                        r = 1, g = 1, b = 1
                    }, 1,
                    function() end))
                end))
            end
            Timer.tween(2, {
                [self] = {opacity = 1}
            }):finish(function()
                self.canInput = true
            end)
        end)
        
    end


end

function StoryState:render()
    love.graphics.draw(gTextures['background-2'], 0, 0, 0,
        VIRTUAL_WIDTH / gTextures['background-2']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background-2']:getHeight()
    )
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(1,1,1,self.opacity)
    if self.iterator == 1 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('A long time ago in the Oak World, The Rainbow Mage stole away the mythical gemstones from the Empress of Time and used them to summon the 4 Geese of the Apocalypse', 22, VIRTUAL_HEIGHT/2 - 98, VIRTUAL_WIDTH - 50, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('A long time ago in the Oak World, The Rainbow Mage stole away the mythical gemstones from the Empress of Time and used them to summon the 4 Geese of the Apocalypse', 20, VIRTUAL_HEIGHT/2 - 100, VIRTUAL_WIDTH - 50, 'center')
    elseif self.iterator == 2 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('The stones were then fallen into the hands of the horrific monsters who used them to cause chaos and to hurt the villagers', 22, VIRTUAL_HEIGHT/2 - 98, VIRTUAL_WIDTH - 50, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('The stones were then fallen into the hands of the horrific monsters who used them to cause chaos and to hurt the villagers', 20, VIRTUAL_HEIGHT/2 - 100, VIRTUAL_WIDTH - 50, 'center')
    elseif self.iterator == 3 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf('This is the story of the hero who retrieved the stones and sealed away The Rainbow Mage...', 22, VIRTUAL_HEIGHT/2 - 98, VIRTUAL_WIDTH - 50, 'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('This is the story of the hero who retrieved the stones and sealed away The Rainbow Mage...', 20, VIRTUAL_HEIGHT/2 - 100, VIRTUAL_WIDTH - 50, 'center')
    else
        love.graphics.setColor(0,0,0,1)
        love.graphics.print('Enter portals', 502, 102)
        love.graphics.print('Duck', 502, 177)
        love.graphics.print('Go Left/Right', 502, 252)
        love.graphics.print('Jump', 502, 327)
        love.graphics.print('Pick up items', 502, 402)
        love.graphics.print('Attack', 502, 477)
        love.graphics.print('Use 50 Meso to heal for 50 health', 502, 552)

        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(gTextures['key-up'], 50, 100, 0, 0.10)
        love.graphics.print('Enter portals', 500, 100)
        love.graphics.draw(gTextures['key-down'], 50, 175, 0, 0.10)
        love.graphics.print('Duck', 500, 175)
        love.graphics.draw(gTextures['key-left'], 50, 250, 0, 0.10)
        love.graphics.draw(gTextures['key-right'], 150, 250, 0, 0.10)
        love.graphics.print('Go Left/Right', 500, 250)
        love.graphics.draw(gTextures['key-space'], 50, 325, 0, 0.10)
        love.graphics.print('Jump', 500, 325)
        love.graphics.draw(gTextures['key-z'], 50, 400, 0, 0.10)
        love.graphics.print('Pick up items', 500, 400)
        love.graphics.draw(gTextures['key-c'], 50, 475, 0, 0.10)
        love.graphics.print('Attack', 500, 475)
        love.graphics.draw(gTextures['key-d'], 50, 550, 0, 0.10)
        love.graphics.print('Use 50 Meso to heal for 50 health', 500, 550)
        love.graphics.draw(gTextures['maple'], 125, 545, 0, 0.5)
    end

end