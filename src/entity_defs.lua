
ENTITY_DEFS = {
    ['char-1'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        width = 30,
        height = 50,
        baseHP = 50,
        baseATK = 15,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        animations = {
            ['alert'] = {
                frames = {1, 2, 3},
                interval = 0.18,
                texture = 'character-1',
                looping = true
            },
            ['jump'] = {
                frames = {4},
                texture = 'character-1'
            },
            ['prone'] = {
                frames = {5},
                texture = 'character-1'
            },
            ['prone-attack'] = {
                frames = {6},
                interval = 0.10,
                texture = 'character-1',
                looping = false
            },
            ['stand'] = {
                frames = {7,8,9},
                interval = 0.5,
                texture = 'character-1',
                looping = true
            },
            ['attack'] = {
                frames = {10,11,12},
                interval = 0.10,
                texture = 'character-1',
                looping = false
            },
            ['walk'] = {
                frames = {13,14,15,16},
                interval = 0.18,
                texture = 'character-1',
                looping = true
            }
        }
    },
    -- ['char-2'] = {
        
    -- }
    ['snail'] = {	
        walkSpeed = SNAIL_WALK_SPEED,
	    width = 38,
	    height = 26,
        baseHP = 2,
        baseATK = 0,
        baseDEF = 0,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        animations = {
            ['die'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9},
                interval = 0.10,
                texture = 'snail',
                looping = false
            },
            ['hit'] = {
                frames = {10},
                interval = 0.5,
                texture = 'snail',
                looping = false
            },
            ['walk'] = {
                frames = {11, 12, 13, 14, 15},
                interval = 0.10,
                texture = 'snail',
                looping = true
            },
            ['stand'] = {
                frames = {16},
                interval = 0.18,
                texture = 'snail',
                looping = false
            }
        }
    }
}