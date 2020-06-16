CharacterSelectState = Class{__includes = BaseState}

function CharacterSelectState:init() 
    self.sprite = 1-- store character
    self.spriteX = VIRTUAL_WIDTH/2 - 32
    self.spriteY = VIRTUAL_HEIGHT/2 - 32

    self.current_char = 1
    self.select_animation = Animation({
            frames = {13, 14, 15, 16},
            interval = 0.18,
            texture = 'character-1'
        })
end


function CharacterSelectState:update(dt) 
    self.select_animation:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        --push playstate
        gStateStack:pop()
        gStateStack:push(PlayState())
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

    if self.current_char == 1 then
        love.graphics.setColor(40/255, 40/255, 40/255, 0.5)
    end
    love.graphics.draw(gTextures['select'], VIRTUAL_WIDTH/2 - 200, VIRTUAL_HEIGHT/2 + 148, 0, 0.10,0.10)
    love.graphics.setColor(1,1,1,1)
    if self.current_char == 2 then  --or wherever we define the max number of characters
        love.graphics.setColor(40/255, 40/255, 40/255, 0.5)
    end
    love.graphics.draw(gTextures['select'], VIRTUAL_WIDTH/2 + 80, VIRTUAL_HEIGHT/2 + 195, math.rad(180), 0.10,0.10)

    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Select your character', 2, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('Select your character',  0, VIRTUAL_HEIGHT/2 - 200, VIRTUAL_WIDTH/2 + 600, 'center')

    --character placeholder
    love.graphics.draw(gTextures['character-1'], gFrames['character-1'][self.select_animation:getCurrentFrame()], self.select_animation:getCurrentFrame() == 16 and VIRTUAL_WIDTH/2 - 88 or VIRTUAL_WIDTH/2 - 100, VIRTUAL_HEIGHT/2 + 134)

end