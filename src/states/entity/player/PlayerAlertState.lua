PlayerAlertState = Class{__includes = BaseState}

function PlayerAlertState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.player:changeAnimation('alert')
    
end

function PlayerAlertState:enter(params)
    -- gSounds['jump']:play()
    self.player:goInvulnerable(1.5)
end

function PlayerAlertState:update(dt)
    local new_X = 1
    local new_Y = self.player.hitbox.y - 10
    if self.player.direction == 'right' then 
        new_X = math.max(1, self.player.hitbox.x - 32)
    elseif self.player.direction == 'left' then
        new_X = math.min(VIRTUAL_WIDTH, self.player.hitbox.x + 32)
    end
    Timer.tween(0.1, {
        [self.player.hitbox] = {x = new_X, y = new_Y},
    }):finish(
        function()
            self.player:changeState('falling')
        end
    )
end

function PlayerAlertState:render()
    local anim = self.player.currentAnimation

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY), 0, self.player.rotation_x, 1)

end