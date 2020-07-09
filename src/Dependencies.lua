Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
json = require 'lib/json/json'
-- json = require 'cjson'

require 'src/Animation'
require 'src/constants'
require 'src/StateMachine'
require 'src/util'
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

--states
require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/game/StartState'
require 'src/states/game/CharacterSelectState'
require 'src/states/game/PlayState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'

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

--graphics
require 'graphics/character/character-1/char-1'
require 'graphics/character/character-2/char-2'
require 'graphics/Mobs/Snail/snail'
require 'graphics/Mobs/Stump/stump'
require 'graphics/Mobs/Pig/pig'

--entities
require 'src/Entity'
require 'src/Player'
require 'src/Mob'
require 'src/entity_defs'
require 'src/Hitbox'

mobs = {
    ['snail'] = {
        mob = SNAIL, 
        states = {"die1_","hit1_","move_","stand_"}
    }, 
    ['stump'] = {
        mob = STUMP, 
        states = {"die1_","hit1_","move_","stand_"}
    },
    ['pig'] = {
        mob = PIG, 
        states = {"die1_","hit1_","jump_","move_","stand_"}
    }
}

mobKeys = {}
for k, v in pairs(mobs) do
    mobKeys[#mobKeys+1] = k
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
    ['tomb'] = love.graphics.newImage('graphics/misc/tombstone.png')
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
    ['tree-top'] = love.graphics.newImage('graphics/map/tree-top.png')
}



gFrames = {
    -- hold entities frames
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['toppers'] = GenerateQuads(gTextures['toppers'], 16, 16),
    ['character-1'] = GenerateCharacterQuads(gTextures['character-1'], CHAR_1, {"alert_","jump_","proneStab_","stand1_","swingO1_","walk1_"}, 3),
    ['character-2'] = GenerateCharacterQuads_2(gTextures['character-2'], CHAR_2),
    ['portal'] = GenerateQuads(gTextures['portal'], 250, 470)
}

for name, mob in pairs(mobs) do
    gTextures[name] = love.graphics.newImage('graphics/Mobs/'..(name:gsub("^%l", string.upper))..'/'..name..'.png')
    gFrames[name] = GenerateCharacterQuads(gTextures[name], mob.mob, mob.states, 8)
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
    ['title'] = love.audio.newSource('sounds/title.mp3', 'static'),
    ['henesys'] = love.audio.newSource('sounds/henesys.mp3', 'static'),
    ['backside-1'] = love.audio.newSource('sounds/backside-1.mp3', 'static'),
    ['backside-2'] = love.audio.newSource('sounds/backside-2.mp3', 'static'),
    ['lith-harbor'] = love.audio.newSource('sounds/Lith-harbor.mp3', 'static'),
    ['sleepywood'] = love.audio.newSource('sounds/sleepywood.mp3', 'static'),
    ['tree-trunk'] = love.audio.newSource('sounds/tree-trunk.mp3', 'static'),
    ['rest-n-peace'] = love.audio.newSource('sounds/rest-n-peace.mp3', 'static'),
    ['ellinia'] = love.audio.newSource('sounds/ellinia.mp3', 'static')

}
