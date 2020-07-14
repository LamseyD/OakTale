VictoryState = Class{__includes = BaseState}

function VictoryState:init()
    gSounds['title']:setLooping(true)
    gSounds['title']:play()
    
    self.opacity = 1
    -- Timer.tween(1, {
    --     [self.opacity] = {opacity = 0}
    -- })
end

function VictoryState:update(dt)
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        -- move to play state
        -- gStateMachine:change('char-select')
        -- gStateStack:pop()
        -- gStateStack:push(CharacterSelectState())
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

    if self.opacity == 1 then
        --fade in
        Timer.tween(2, {
            [self] = {opacity = 0}
        })
    end
    
    if self.opacity == 0 then
        Timer.tween(2, {
            [self] = {opacity = 1}
        })
    end
end

function VictoryState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0,
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight()
    )
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('You successfully sealed the Black Mage using the gemstone!', 2, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH - 100, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('You successfully sealed the Black Mage using the gemstone!', 0, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH - 98, 'center')

    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.printf('Press enter to play again', 0, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)
end