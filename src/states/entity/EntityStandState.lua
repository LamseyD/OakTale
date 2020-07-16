--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityStandState = Class{__includes = BaseState}
-- dungeon
function EntityStandState:init(entity, dungeon)
    self.entity = entity
    self.entity:changeAnimation('stand')
-- self.dungeon = dungeon
    self.dungeon = dungeon
    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0
end

-- function EntityStandState:enter(params)

-- end

--[[
    We can call this function if we want to use this state on an agent in our game; otherwise,
    we can use this same state in our Player class and have it not take action.
]]
function EntityStandState:processAI(params, dt)
    self.waitDuration = params.waitDuration and params.waitDuration or self.waitDuration
    if self.waitDuration == 0 then
        self.waitDuration = math.random(self.entity.maxWaitDuration)
    else
        self.waitTimer = self.waitTimer + dt
        if self.waitTimer > self.waitDuration then
            self.entity:changeState('walk')
        end
    end
end

function EntityStandState:render()
    local anim = self.entity.currentAnimation
    if anim.texture == 'character-2' then
        if self.entity.direction == 'right' then
            self.entity.offsetX = -self.entity.width - 30
        else
            self.entity.offsetX = 5
        end
    end
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY + 1), 0, self.entity.rotation_x, 1)
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end