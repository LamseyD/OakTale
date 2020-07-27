StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['title']:rewind()
    gSounds['title']:setLooping(true)
    gSounds['title']:play()

    self.options = {new = {b = 0},
                    load = {b = 1}}
    self.opacity = 1
    self.currentSelection = 'new'
    self.save = false
    local f = io.open(SAVEFILE,"r")
    if f ~= nil then 
        io.close(f) 
        self.save = true
    end
end

function StartState:update(dt)
    if love.keyboard.wasPressed('up') then
        self.currentSelection = 'new'
        self.options = {new = {b = 0},
                        load = {b = 1}}
    elseif self.save and love.keyboard.wasPressed('down') then
        self.currentSelection = 'load'
        self.options = {new = {b = 1},
                        load = {b = 0}}
    end
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1,
        function()
            -- gSounds['intro-music']:stop()
            -- self.tween:remove()
            gStateStack:pop()
            if self.currentSelection == 'new' then
                gStateStack:push(StoryState())
            elseif self.currentSelection == 'load' then
                gStateStack:push(PlayState(nil, true))
            end
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

    love.graphics.setColor(1, 1, self.options.new.b, 0.9)
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.printf('New Game', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
    if not self.save then
        love.graphics.setColor(1, 1, 1, 0.2)
    else
        love.graphics.setColor(1, 1, self.options.load.b, 0.9)
    end
    love.graphics.printf('Load Game', 0, VIRTUAL_HEIGHT/2 + 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.printf('Press Enter to start your Adventure', 0, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH, 'center')
end