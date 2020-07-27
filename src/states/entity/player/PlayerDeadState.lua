PlayerDeadState = Class{__includes = BaseState}

function PlayerDeadState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    
end

function PlayerDeadState:enter(params)
    -- gSounds['jump']:play()
    self.player.invulnerable = true
end

function PlayerDeadState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        --push playstate
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1,
        function()
            love.audio.pause()
            gStateStack:clear()
            gStateStack:push(StartState())
            gSFX['portal']:play()
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1,
            function() end))

        end))
    end
end

function PlayerDeadState:render()
    love.graphics.setFont(gFonts['title-medium'])
    if self.player.hitbox.x + self.player.hitbox.width >= VIRTUAL_WIDTH - 50 and self.player.direction == 'left' then
        self.player.direction = 'right'
    elseif self.player.hitbox.x < 50 and self.player.direction == 'right'then
        self.player.direction = 'left'
    end
    love.graphics.draw(gTextures['tomb'], self.player.hitbox.x, self.player.hitbox.y - 45, 0, self.player.rotation_x, 1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('You are dead', 2, 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to respawn', 2, 250, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('You are dead', 0, 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to respawn', 0, 250, VIRTUAL_WIDTH, 'center')
end