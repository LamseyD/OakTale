require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('OakTale')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
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
    Timer.update(dt)
    gStateStack:update(dt)
    -- gStateMachine:update(dt)
    -- muteMusic()
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    -- gStateMachine:render()
    push:finish()
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