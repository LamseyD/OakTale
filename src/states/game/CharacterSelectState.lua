CharacterSelectState = Class{__includes = BaseState}

function CharacterSelectState:init() 
    
    self.spriteX = VIRTUAL_WIDTH/2 - 32
    self.spriteY = VIRTUAL_HEIGHT/2 - 32

    self.opacity = 0.5
    self.current_char = 1
    self.sprite = 'character-' .. self.current_char
    self.select_animation = Animation({
            frames = {13, 14, 15, 16},
            interval = 0.18,
            texture = 'character-1',
            looping = true
        })

    self.select_animation_2 = Animation({
            frames = {13, 14, 15, 16},
            interval = 0.18,
            texture = 'character-2',
            looping = true
    })

end


function CharacterSelectState:update(dt) 
    self.select_animation:update(dt)
    self.select_animation_2:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        --push playstate
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1,
        function()
            -- gSounds['intro-music']:stop()
            -- self.tween:remove()
            
            gStateStack:push(PlayState(self.current_char))
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1,
            function() end))
        end))
    end

    if love.keyboard.wasPressed('left') then
        if self.current_char == 1 then
            --no select here
        else
            self.current_char = self.current_char - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.current_char == 2 then-- number of total of characters 
    
        else
            self.current_char = self.current_char + 1
        end
    end

    self.sprite = 'character-' .. self.current_char
end

function CharacterSelectState:render() 
    love.graphics.draw(gTextures['hene-bg'], 0,0,0,
        VIRTUAL_WIDTH / gTextures['hene-bg']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['hene-bg']:getHeight()
    )
    love.graphics.draw(gTextures['char-select'], 0, 0, 0,
        VIRTUAL_WIDTH / gTextures['char-select']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['char-select']:getHeight()
    )
    local anim = self.select_animation:getCurrentFrame()
    if self.current_char == 1 then
        love.graphics.setColor(40/255, 40/255, 40/255, 0.5)
    end
    love.graphics.draw(gTextures['select'], VIRTUAL_WIDTH/2 - 200, VIRTUAL_HEIGHT/2 + 148, 0, 0.10,0.10)
    love.graphics.setColor(1,1,1,1)
    if self.current_char == 2 then  --or wherever we define the max number of characters
        anim = self.select_animation_2:getCurrentFrame()
        love.graphics.setColor(40/255, 40/255, 40/255, 0.5)
    end
    love.graphics.draw(gTextures['select'], VIRTUAL_WIDTH/2 + 80, VIRTUAL_HEIGHT/2 + 195, math.rad(180), 0.10,0.10)

    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Select your character', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('Select your character',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')

    local offset_flag = true
    local offset_flag_2 = self.current_char == 2 and true or false
    --character placeholder
    if anim ~= 16 or self.current_char == 2 then
        offset_flag = false
    end
    love.graphics.draw(gTextures[self.sprite], gFrames[self.sprite][anim], offset_flag and VIRTUAL_WIDTH/2 - 88 or VIRTUAL_WIDTH/2 - 100, offset_flag_2 and VIRTUAL_HEIGHT/2 + 129 or VIRTUAL_HEIGHT/2 + 134)

end