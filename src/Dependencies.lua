Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
json = require 'lib/json/json'
-- json = require 'cjson'

require 'src/Animation'
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'
-- require 'cjson'


--world
require 'src/world/LevelMaker'
require 'src/world/Room'
require 'src/world/Room_defs'
require 'src/world/Tile'
require 'src/world/TileMap'
require 'src/world/Dungeon'
require 'src/world/GameLevel'
require 'src/world/GameObject'
require 'src/world/Object_defs'
require 'src/world/Portal'
require 'src/world/Item'

--states
require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/game/StartState'
require 'src/states/game/CharacterSelectState'
require 'src/states/game/PlayState'
require 'src/states/game/BossState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/VictoryState'
require 'src/states/game/StoryState'

--entity state
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityStandState'
require 'src/states/entity/player/PlayerAttackState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerStandState'
require 'src/states/entity/player/PlayerFallingState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerProneState'
require 'src/states/entity/player/PlayerAlertState'
require 'src/states/entity/player/PlayerDeadState'
require 'src/states/entity/mob/MobStandState'
require 'src/states/entity/mob/MobWalkState'
require 'src/states/entity/mob/MobDieState'
require 'src/states/entity/mob/MobFallingState'
require 'src/states/entity/boss/BossStandState'
require 'src/states/entity/boss/BossWalkState'
require 'src/states/entity/boss/BossDieState'

--graphics
require 'graphics/character/character-1/char-1'
require 'graphics/character/character-2/char-2'
require 'graphics/Mobs/Snail/snail'
require 'graphics/Mobs/Blue-snail/blue-snail'
require 'graphics/Mobs/Red-snail/red-snail'
require 'graphics/Mobs/Green-mushroom/green-mushroom'
require 'graphics/Mobs/Orange-mushroom/orange-mushroom'
require 'graphics/Mobs/Slime/slime'
require 'graphics/Mobs/Spore/spore'
require 'graphics/Mobs/Stump/stump'
require 'graphics/Mobs/Pig/pig'
require 'graphics/Mobs/Tiguru/tiguru'
require 'graphics/Mobs/Timu/timu'
require 'graphics/Mobs/Tiru/tiru'
require 'graphics/Mobs/Tiv/tiv'
require 'src/GUI'

--entities
require 'src/Entity'
require 'src/Player'
require 'src/Mob'
require 'src/Boss'
require 'src/entity_defs'
require 'src/Hitbox'

mobs = {
    ['snail'] = {
        mob = SNAIL, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['blue-snail'] = {
        mob = BLUESNAIL, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['red-snail'] = {
        mob = REDSNAIL, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['green-mushroom'] = {
        mob = GREENMUSHROOM, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['orange-mushroom'] = {
        mob = ORANGEMUSHROOM, 
        states = {"die1_","hit1_","jump_","move_","stand_"}
    },
    ['slime'] = {
        mob = SLIME, 
        states = {"die1_","hit1_","jump_","move_","stand_"}
    },
    ['spore'] = {
        mob = SPORE, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['stump'] = {
        mob = STUMP, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['pig'] = {
        mob = PIG, 
        states = {"die1_","hit1_","jump_","move_","stand_"}
    },
    ['tiguru'] = {
        boss = true,
        mob = TIGURU, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['timu'] = {
        boss = true,
        mob = TIMU, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['tiru'] = {
        boss = true,
        mob = TIRU, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['tiv'] = {
        boss = true,
        mob = TIV, 
        states = {"die1_","hit1_","move_","stand_"}
    }
}

mobKeys = {}
bossKeys = {}
for k, v in pairs(mobs) do
    if not v.boss then
        mobKeys[#mobKeys+1] = k
    else
        bossKeys[#bossKeys+1] = k
    end
end

gTextures = {  
    -- hold texture files
    ['background'] = love.graphics.newImage('graphics/misc/background.png'),
    ['background-2'] = love.graphics.newImage('graphics/misc/background-2.png'),
    ['icon'] = love.graphics.newImage('graphics/misc/icon.png'),
    ['select'] = love.graphics.newImage('graphics/misc/arrow.png'),
    ['char-select'] = love.graphics.newImage('graphics/misc/charselect.png'),
    ['hene-bg'] = love.graphics.newImage('graphics/misc/hene-background.png'),
    ['tiles'] = love.graphics.newImage('graphics/map/tiles.png'),
    ['toppers'] = love.graphics.newImage('graphics/map/tile_tops.png'),
    ['character-1'] = love.graphics.newImage('graphics/character/character-1/char-1.png'),
    ['character-2'] = love.graphics.newImage('graphics/character/character-2/char-2.png'),
    ['portal'] = love.graphics.newImage('graphics/map/portal.png'),
    ['tomb'] = love.graphics.newImage('graphics/misc/tombstone.png'),
    ['coin-1'] = love.graphics.newImage('graphics/misc/coin.png'),
    ['coin-2'] = love.graphics.newImage('graphics/misc/coin-2.png'),
    ['coin-3'] = love.graphics.newImage('graphics/misc/coin-3.png'),
    ['jewel-1'] = love.graphics.newImage('graphics/misc/jewel-1.png'),
    ['jewel-2'] = love.graphics.newImage('graphics/misc/jewel-2.png'),
    ['jewel-3'] = love.graphics.newImage('graphics/misc/jewel-3.png'),
    ['jewel-4'] = love.graphics.newImage('graphics/misc/jewel-4.png'),
    ['maple'] = love.graphics.newImage('graphics/misc/maple.png'),
    ['key-up'] = love.graphics.newImage('graphics/misc/key-up.png'),
    ['key-down'] = love.graphics.newImage('graphics/misc/key-down.png'),
    ['key-left'] = love.graphics.newImage('graphics/misc/key-left.png'),
    ['key-right'] = love.graphics.newImage('graphics/misc/key-right.png'),
    ['key-space'] = love.graphics.newImage('graphics/misc/key-space.png'),
    ['key-z'] = love.graphics.newImage('graphics/misc/key-z.png'),
    ['key-c'] = love.graphics.newImage('graphics/misc/key-c.png'),
    ['key-d'] = love.graphics.newImage('graphics/misc/key-d.png'),
    ['key-s'] = love.graphics.newImage('graphics/misc/key-s.png'),
}

gBackgrounds = {
    ['hene-bg'] = love.graphics.newImage('graphics/misc/hene-background.png'),
    ['maple-island'] = love.graphics.newImage('graphics/map/maple-island.png'),
    ['road-to-hene'] = love.graphics.newImage('graphics/map/road-to-hene-bg.png'),
    ['praire'] = love.graphics.newImage('graphics/map/praire.png'),
    ['sleepywoods'] = love.graphics.newImage('graphics/map/Sleepywoods.png'),
    ['back-side-1'] = love.graphics.newImage('graphics/map/back-side-1.png'),
    ['back-side-2'] = love.graphics.newImage('graphics/map/back-side-2.png'),
    ['tree-trunk'] = love.graphics.newImage('graphics/map/tree-trunk.png'),
    ['tree-top'] = love.graphics.newImage('graphics/map/tree-top.png'),
    ['helios-tower'] = love.graphics.newImage('graphics/map/helios-tower.png'),
    ['ludi'] = love.graphics.newImage('graphics/map/ludi.png'),
    ['orbis'] = love.graphics.newImage('graphics/map/orbis.png'),
    ['orbis-tower'] = love.graphics.newImage('graphics/map/orbis-tower.png'),
    ['orbis-tower-bottom'] = love.graphics.newImage('graphics/map/orbis-tower-bottom.png'),
    ['orbis-tower-mid'] = love.graphics.newImage('graphics/map/orbis-tower-mid.png'),
    ['helios-tower-2'] = love.graphics.newImage('graphics/map/helio-tower-2.png')
}



gFrames = {
    -- hold entities frames
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['toppers'] = GenerateQuads(gTextures['toppers'], 16, 16),
    ['character-1'] = GenerateCharacterQuads(gTextures['character-1'], CHAR_1, {"alert_","jump_","proneStab_","stand1_","swingO1_","walk1_"}, 3),
    ['character-2'] = GenerateCharacterQuads_2(gTextures['character-2'], CHAR_2, {"alert_","jump_","proneStab_","stand1_","swingO1_","walk1_"}, 3),
    ['portal'] = GenerateQuads(gTextures['portal'], 250, 470)
}

for name, mob in pairs(mobs) do
    gTextures[name] = love.graphics.newImage('graphics/Mobs/'..(name:gsub("^%l", string.upper))..'/'..name..'.png')
    gFrames[name] = GenerateCharacterQuads(gTextures[name], mob.mob, mob.states, 20)
end

gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], 
    TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], 
    TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFonts = {
    -- hold fonts
    ['title-small'] = love.graphics.newFont('fonts/OrangeJuice/OrangeJuice.ttf', 32),
    ['title-medium'] = love.graphics.newFont('fonts/OrangeJuice/OrangeJuice.ttf', 64),
    ['title-large']  = love.graphics.newFont('fonts/OrangeJuice/OrangeJuice.ttf', 256)
}

gSounds = {
    -- hold music
    ['title'] = love.audio.newSource('sounds/title.mp3', 'stream'),
    ['henesys'] = love.audio.newSource('sounds/henesys.mp3', 'stream'),
    ['backside-1'] = love.audio.newSource('sounds/backside-1.mp3', 'stream'),
    ['backside-2'] = love.audio.newSource('sounds/backside-2.mp3', 'stream'),
    ['lith-harbor'] = love.audio.newSource('sounds/Lith-harbor.mp3', 'stream'),
    ['sleepywood'] = love.audio.newSource('sounds/sleepywood.mp3', 'stream'),
    ['tree-trunk'] = love.audio.newSource('sounds/tree-trunk.mp3', 'stream'),
    ['rest-n-peace'] = love.audio.newSource('sounds/rest-n-peace.mp3', 'stream'),
    ['ellinia'] = love.audio.newSource('sounds/ellinia.mp3', 'stream'),
    ['queens-garden'] = love.audio.newSource('sounds/queens-garden.mp3', 'stream'),
    ['helios-tower'] = love.audio.newSource('sounds/helios-tower.mp3', 'stream'),
    ['high-enough'] = love.audio.newSource('sounds/high-enough.mp3', 'stream'),
    ['ludi'] = love.audio.newSource('sounds/ludi.mp3', 'stream'),
    ['orbis'] = love.audio.newSource('sounds/orbis.mp3', 'stream'),
    ['orbis-tower'] = love.audio.newSource('sounds/orbis-tower.mp3', 'stream'),
}

gSFX = {
    ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['portal'] = love.audio.newSource('sounds/portal.wav', 'static'),
    ['attack'] = love.audio.newSource('sounds/attack.wav', 'static'),
    ['level-up'] = love.audio.newSource('sounds/levelup.wav', 'static'),
    ['pickup'] = love.audio.newSource('sounds/pickup.wav', 'static'),
    ['pickup-2'] = love.audio.newSource('sounds/pickup-2.wav', 'static'),
}