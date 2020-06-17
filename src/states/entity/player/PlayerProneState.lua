PlayerProneState = Class{__includes = BaseState}

function PlayerProneState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.player.offsetY = -29
    self.player.offsetX = self.player.direction == 'right' and -self.player.width or 0
    self.player:changeAnimation('prone')
end

function PlayerAttackState:enter(params)
    -- WIP HERE
    -- self.player.y = self.player.y - 32 
end

function PlayerProneState:update(dt)
    if not love.keyboard.isDown("down") then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walk')
        end
    
        if love.keyboard.wasPressed('space') then
            self.player:changeState('jump')
        end
        self.player:changeState("stand")
    end
end

function PlayerProneState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.direction == "right" and -1 or 1, 1)
        
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end