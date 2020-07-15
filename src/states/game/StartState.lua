StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['title']:setLooping(true)
    gSounds['title']:play()
    
    self.opacity = 1
    -- Timer.tween(1, {
    --     [self.opacity] = {opacity = 0}
    -- })
end

function StartState:update(dt)
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
            
            gStateStack:push(StoryState())
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

function StartState:render()
    love.graphics.draw(gTextures['background-2'], 0, 0, 0,
        VIRTUAL_WIDTH / gTextures['background-2']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background-2']:getHeight()
    )

    love.graphics.setFont(gFonts['title-large'])
    love.graphics.setColor(1, 1, 1, 0.90)
    love.graphics.printf('OakTale', 0, VIRTUAL_HEIGHT/2 - 256, VIRTUAL_WIDTH - 64, 'center')

    love.graphics.draw(gTextures['icon'], VIRTUAL_WIDTH/2 + 216, VIRTUAL_HEIGHT/2 - 300, 0, 0.3,0.3)

    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.printf('Press Enter to start your Adventure', 0, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH, 'center')
end