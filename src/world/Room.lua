Room = Class {}

function Room:init(player, def)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.level = LevelMaker.generate(def)
    self.tileMap = self.level.tileMap
    self.player = player
    self.bgm = def.bgm
    -- gSounds[self.bgm]:setLooping(true)
    self.background = def.background
    self.boss = def.boss
end

function Room:update(dt)
    self.player:update(dt)
    for i, item in pairs(self.level.objects) do
        if item.falling then
            item.dy = item.dy + GRAVITY_AMOUNT
            item.hitbox.y = item.hitbox.y + (item.dy * dt)
            item.offsetX = item.direction == 'right' and -item.width or 0
            item.y = item.hitbox.y - item.hitbox_offsetY
        -- look at two tiles below our feet and check for collisions
            local tileBottomLeft = self.tileMap:pointToTile(item.hitbox.x + 1, item.hitbox.y + item.hitbox.height)
            local tileBottomRight = self.tileMap:pointToTile(item.hitbox.x + item.hitbox.width - 1, item.hitbox.y + item.hitbox.height)
    
            -- if we get a collision beneath us, go into either walking or idle
            if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) and (tileBottomLeft.topper and tileBottomRight.topper) then
                item.dy = 0
                item.hitbox.y = (tileBottomLeft.y - 1) * TILE_SIZE - item.hitbox.height -- + 20
                item.falling = false
                item.top_y = item.hitbox.y - 6
                item.bot_y = item.hitbox.y - 2
                
                -- -- check side collisions and reset position
                -- self.player:checkLeftCollisions(dt)
                -- self.player:checkRightCollisions(dt)
            end
        else
            item:update(dt)
        end
        
        
    end

    for i, entity in pairs(self.level.entities) do
        entity:update(dt)
            -- collision between the player and entities in the room
        if self.player:collides(entity) and not self.player.invulnerable and entity.health > 0 then
            self.player:damage(math.random(entity.baseATK))
            self.player:changeState('alert')
            if self.player.health <= 0 then
                self.player:changeState('dead') -- dead state?
            end
        end
        if entity.dead and not entity.invulnerable then 
            --drop items here
            local rng_generator = math.random(15)
            local meso_amnt = math.random(entity.meso, math.max(entity.meso - 10,1))
            if meso_amnt <= 10 then
                local tmp_coin = Item{def = GAME_OBJECT_DEFS['coin-1'], 
                                    x = math.min(math.max(entity.hitbox.x, 30), VIRTUAL_WIDTH - 30), 
                                    y = entity.hitbox.y, 
                                    onConsume = function(player)
                                        gSFX['pickup']:play()
                                        self.player.bank = self.player.bank + meso_amnt
                                end}
                table.insert(self.level.objects, tmp_coin)                
            elseif meso_amnt <= 20 then
                local tmp_coin = Item{def = GAME_OBJECT_DEFS['coin-2'], 
                                    x = math.min(math.max(entity.hitbox.x, 30), VIRTUAL_WIDTH - 30),
                                    y = entity.hitbox.y, 
                                    onConsume = function(player)
                                        gSFX['pickup']:play()
                                        self.player.bank = self.player.bank + meso_amnt
                                end}
                table.insert(self.level.objects, tmp_coin)                
            else
                local tmp_coin = Item{def = GAME_OBJECT_DEFS['coin-3'], 
                                    x = math.min(math.max(entity.hitbox.x, 30), VIRTUAL_WIDTH - 30),
                                    y = entity.hitbox.y, 
                                    onConsume = function(player)
                                        gSFX['pickup']:play()
                                        self.player.bank = self.player.bank + meso_amnt
                                end}

                table.insert(self.level.objects, tmp_coin)
            end

            if rng_generator == 1 then
                local tmp_obj = Item{def = GAME_OBJECT_DEFS['jewel-1'], 
                                    x = math.min(math.max(entity.hitbox.x + 30, 60), VIRTUAL_WIDTH - 60),
                                    y = entity.hitbox.y, 
                                    onConsume = function(player)
                                        gSFX['pickup-2']:play()
                                        self.player.inventory.str = true
                                    end}
                table.insert(self.level.objects, tmp_obj)
            elseif rng_generator == 2 then
                local tmp_obj = Item{def = GAME_OBJECT_DEFS['jewel-2'], 
                                    x = math.min(math.max(entity.hitbox.x + 30, 60), VIRTUAL_WIDTH - 60),
                                    y = entity.hitbox.y - 5, 
                                    onConsume = function(player)
                                        gSFX['pickup-2']:play()
                                        self.player.inventory.dex = true
                                    end}
                table.insert(self.level.objects, tmp_obj)
            elseif rng_generator == 3 then
                local tmp_obj = Item{def = GAME_OBJECT_DEFS['jewel-3'], 
                                    x = math.min(math.max(entity.hitbox.x + 30, 60), VIRTUAL_WIDTH - 60),
                                    y = entity.hitbox.y - 5, 
                                    onConsume = function(player)
                                        gSFX['pickup-2']:play()
                                    self.player.inventory.int = true
                end}
                table.insert(self.level.objects, tmp_obj)
            elseif rng_generator == 4 then
                local tmp_obj = Item{def = GAME_OBJECT_DEFS['jewel-4'], 
                                    x = math.min(math.max(entity.hitbox.x + 30, 60), VIRTUAL_WIDTH - 60),
                                    y = entity.hitbox.y - 5, 
                                    onConsume = function(player)
                                        gSFX['pickup-2']:play()
                                    self.player.inventory.luk = true
                end}
                table.insert(self.level.objects, tmp_obj)
            end
            self.player.currentExp = self.player.currentExp + entity.exp
            if self.player.currentExp >= self.player.expToLevel then
                self.player:levelUp()
            end
            table.remove(self.level.entities, i)
        elseif entity.health <= 0 then
            entity.visibleHP = false
            entity:changeState('die')
        end
    end
end

function Room:render()
    love.graphics.draw(gBackgrounds[self.background], 0,0,0,
        VIRTUAL_WIDTH / gBackgrounds[self.background]:getWidth(),
        VIRTUAL_HEIGHT / gBackgrounds[self.background]:getHeight()
    )
    self.level:render()
    self.player:render()

    
end

function Room:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

    -- flag for whether there's ground on this column of the level
        local groundFound = false
        local prevGroundFound = false

        for y = 1, self.tileMap.height do
            prevGroundFound = groundFound
            if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                groundFound = true
                    -- random chance, 1 in 10
                if not prevGroundFound and math.random(10) == 1 then              
                    -- instantiate snail, declaring in advance so we can pass it into state machine
                    local mob
                    local mobName = mobKeys[math.random(#mobKeys)]
                    mob = Mob{
                        animations = ENTITY_DEFS[mobName].animations,
                        walkSpeed = ENTITY_DEFS[mobName].walkSpeed,
                        texture = mob,
                        baseHP = ENTITY_DEFS[mobName].baseHP,
                        baseATK = ENTITY_DEFS[mobName].baseATK,
                        baseDEF = ENTITY_DEFS[mobName].baseDEF,
                        exp = ENTITY_DEFS[mobName].exp_value,
                        meso_value = ENTITY_DEFS[mobName].meso_value,
                        lvl = ENTITY_DEFS[mobName].level,
                        width = ENTITY_DEFS[mobName].width,
                        height = ENTITY_DEFS[mobName].height,
                        x = x * TILE_SIZE - ENTITY_DEFS[mobName].width,
                        y = (y - 1) * TILE_SIZE - ENTITY_DEFS[mobName].height,
                        hitbox_offsetX = 0,
                        hitbox_offsetY = 0
                    }
                    mob.level = self.level
                    mob.stateMachine = StateMachine{
                        ['stand'] = function() return MobStandState(mob, self.tileMap) end,
                        ['walk'] = function() return MobWalkState(mob, self.tileMap) end,
                        ['die'] = function() return MobDieState(mob) end,
                        ['falling'] = function() return MobFallingState(mob, GRAVITY_AMOUNT) end
                    }
                    mob:changeState('walk')
                    table.insert(self.level.entities, mob)
                end
            elseif self.tileMap.tiles[y][x].id == TILE_ID_EMPTY then
                groundFound = false
            end
        end
    end
end
