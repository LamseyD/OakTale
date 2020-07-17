require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('OakTale')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = false,
        resizable = true
    })
    
    love.graphics.setFont(gFonts['title-small'])
    -- gSounds['title']:setLooping(true)
    -- gSounds['title']:play()

    gStateStack = StateStack()
    gStateStack:push(StartState())
    -- gStateStack:push(CharacterSelectState())
    -- gStateMachine = StateMachine {
    --     ['start'] = function() return StartState() end,
    --     ['char-select'] = function() return CharacterSelectState() end
    -- }
    -- gStateMachine:change('start')
    love.keyboard.keysPressed = {}
    g_clock = 0
    timestep = (1.0 / 144)
    -- g_muted = false
end

function love.resize(w, h)
    push:resize(w,h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    
    -- g_clock = g_clock + dt
    -- while g_clock >= timestep do
        g_clock = g_clock - timestep
        Timer.update(dt)
        gStateStack:update(dt)
    -- gStateMachine:update(dt)
    -- muteMusic()
        love.keyboard.keysPressed = {}
    -- end
    
end

function love.draw()
    push:start()
    gStateStack:render()
    -- gStateMachine:render()
    displayFPS()
    push:finish()
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['title-small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

-- function muteMusic()
--     if not g_muted and love.keyboard.wasPressed('m') then
--         gSounds['music']:pause()
--         g_muted = true
--     elseif g_muted and love.keyboard.wasPressed('m') then
--         gSounds['music']:play()
--         g_muted = false
--     end
-- end