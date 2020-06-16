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

--graphics
require 'graphics/character/character-1/char-1'

--entities
require 'src/Entity'
require 'src/Player'
require 'src/entity_defs'

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
    ['character-1'] = love.graphics.newImage('graphics/character/character-1/char-1.png')
}

gFrames = {
    -- hold entities frames
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['toppers'] = GenerateQuads(gTextures['toppers'], 16, 16),
    ['character-1'] = GenerateCharacterQuads(gTextures['character-1'], CHAR_1)
}

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
    ['title'] = love.audio.newSource('sounds/title.mp3', 'static')
}