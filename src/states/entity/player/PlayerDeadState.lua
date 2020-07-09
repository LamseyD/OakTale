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
            gStateStack:pop()
            
            gStateStack:push(PlayState())
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1,
            function() end))
        end))
    end
end

function PlayerDeadState:render()
    love.graphics.setFont(gFonts['title-medium'])
    love.graphics.printf('Press Enter to respawn', 0, VIRTUAL_HEIGHT/2 + 200, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(gTextures['tomb'], self.player.hitbox.x, self.player.hitbox.y)
end