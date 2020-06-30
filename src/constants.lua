
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 64
TILE_SCALE = 4


MAP_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE + TILE_SIZE
MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE + TILE_SIZE
TILE_ID_EMPTY = 5
TILE_ID_GROUND = 3

-- table of tiles that should trigger a collision
COLLIDABLE_TILES = {
    TILE_ID_GROUND
}

JUMP_BLOCKS = {}

for i = 1, 30 do
    table.insert(JUMP_BLOCKS, i)
end

CAMERA_SPEED = 100

-- speed of scrolling background
BACKGROUND_SCROLL_SPEED = 10

-- number of tiles in each tile set
TILE_SET_WIDTH = 5
TILE_SET_HEIGHT = 4

-- number of tile sets in sheet
TILE_SETS_WIDE = 6
TILE_SETS_TALL = 10

-- number of topper sets in sheet
TOPPER_SETS_WIDE = 6
TOPPER_SETS_TALL = 18

-- total number of topper and tile sets
TOPPER_SETS = TOPPER_SETS_WIDE * TOPPER_SETS_TALL
TILE_SETS = TILE_SETS_WIDE * TILE_SETS_TALL

--
-- entity constants
--
PLAYER_WALK_SPEED = 200
PLAYER_JUMP_VELOCITY = -350

GRAVITY_AMOUNT = 16

PIXEL_OFFSET = 12

SNAIL_WALK_SPEED = 50

--
-- map constants
--
-- MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 2
-- MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

-- MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
-- MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2

--
-- tile IDs
-- --
-- TILE_TOP_LEFT_CORNER = 4
-- TILE_TOP_RIGHT_CORNER = 5
-- TILE_BOTTOM_LEFT_CORNER = 23
-- TILE_BOTTOM_RIGHT_CORNER = 24

-- TILE_EMPTY = 19

-- TILE_FLOORS = {
--     7, 8, 9, 10, 11, 12, 13,
--     26, 27, 28, 29, 30, 31, 32,
--     45, 46, 47, 48, 49, 50, 51,
--     64, 65, 66, 67, 68, 69, 70,
--     88, 89, 107, 108
-- }

-- TILE_TOP_WALLS = {58, 59, 60}
-- TILE_BOTTOM_WALLS = {79, 80, 81}
-- TILE_LEFT_WALLS = {77, 96, 115}
-- TILE_RIGHT_WALLS = {78, 97, 116}
