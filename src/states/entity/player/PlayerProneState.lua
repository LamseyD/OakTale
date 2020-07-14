PlayerProneState = Class{__includes = BaseState}

function PlayerProneState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.player.offsetY = -10
    -- self.player.offsetX = self.player.direction == 'right' and -self.player.width or 0
    self.player:changeAnimation('prone')
end

function PlayerProneState:enter(params)
    -- WIP HERE
    -- self.player.y = self.player.y - 32
    local temp = self.player.hitbox.width 
    self.player.hitbox.width = self.player.hitbox.height
    self.player.hitbox.height = temp
    self.player.hitbox.y = self.player.hitbox.y + 20
    if self.player.direction == 'right' then
        self.player.hitbox.x = self.player.hitbox.x - 20
    else
        -- self.player.hitbox.x = self.player.hitbox.x + 20
    end

    
end

function PlayerProneState:update(dt)
    self.player.offsetX = self.player.direction == 'right' and -self.player.hitbox.width - 55 or 30
    if not love.keyboard.isDown("down") then
        
        local temp = self.player.hitbox.width
        self.player.hitbox.width = self.player.hitbox.height
        self.player.hitbox.height = temp
        self.player.hitbox.y = self.player.hitbox.y - 20
        if self.player.direction == 'right' then
            self.player.hitbox.x = self.player.hitbox.x + 20
        end
        self.player.offsetX = 10
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walk')
        end
    
        if love.keyboard.wasPressed('space') then
            self.player:changeState('jump')
        end
        self.player:changeState("stand")
    else
        if love.keyboard.wasPressed('left') then
            self.player.direction = 'left'
        elseif love.keyboard.wasPressed('right') then
            self.player.direction = 'right'
        end
    end
end

function PlayerProneState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.rotation_x, 1)
        
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end