
ENTITY_DEFS = {
    ['char-1'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        width = 30,
        height = 50,
        baseHP = 50,
        baseATK = 10,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        level = 1,
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
                interval = 0.25,
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
    ['char-2'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        width = 30,
        height = 50,
        baseHP = 50,
        baseATK = 10,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        level = 1,
        hitbox_offsetX = -12,
        hitbox_offsetY = -31,
        animations = {
            ['alert'] = {
                frames = {1, 2, 3},
                interval = 0.18,
                texture = 'character-2',
                looping = true
            },
            ['jump'] = {
                frames = {4},
                texture = 'character-2'
            },
            ['prone'] = {
                frames = {5},
                texture = 'character-2'
            },
            ['prone-attack'] = {
                frames = {6},
                interval = 0.10,
                texture = 'character-2',
                looping = false
            },
            ['stand'] = {
                frames = {7,8,9},
                interval = 0.5,
                texture = 'character-2',
                looping = true
            },
            ['attack'] = {
                frames = {10,11,12},
                interval = 0.25,
                texture = 'character-2',
                looping = false
            },
            ['walk'] = {
                frames = {13,14,15,16},
                interval = 0.18,
                texture = 'character-2',
                looping = true
            }
        }
    },
    ['snail'] = {	
        walkSpeed = SLOW_WALK_SPEED,
	    width = 38,
	    height = 26,
        baseHP = 15,
        baseATK = 1,
        baseDEF = 5,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 1,
        exp_value = 10,
        meso_value = 5,
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
    },
    ['stump'] = {	
        walkSpeed = SLOW_WALK_SPEED,
	    width = 64,
	    height = 51,
        baseHP = 20,
        baseATK = 5,
        baseDEF = 20,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 3,
        exp_value = 20,
        meso_value = 10,
        animations = {
            ['die'] = {
                frames = {1, 2, 3},
                interval = 0.5,
                texture = 'stump',
                looping = false
            },
            ['hit'] = {
                frames = {4},
                interval = 0.5,
                texture = 'stump',
                looping = false
            },
            ['walk'] = {
                frames = {5, 6, 7, 8},
                interval = 0.10,
                texture = 'stump',
                looping = true
            },
            ['stand'] = {
                frames = {9},
                interval = 0.18,
                texture = 'stump',
                looping = false
            }
        }
    },
    ['pig'] = {	
        walkSpeed = FAST_WALK_SPEED,
	    width = 68,
	    height = 44,
        baseHP = 20,
        baseATK = 7,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 30,
        meso_value = 30,
        animations = {
            ['die'] = {
                frames = {1, 2, 3},
                interval = 0.5,
                texture = 'pig',
                looping = false
            },
            ['hit'] = {
                frames = {4},
                interval = 0.5,
                texture = 'pig',
                looping = false
            },
            ['jump'] = {
                frames = {5},
                interval = 0.5,
                texture = 'pig',
                looping = false
            },
            ['walk'] = {
                frames = {6, 7, 8},
                interval = 0.10,
                texture = 'pig',
                looping = true
            },
            ['stand'] = {
                frames = {9, 10, 11},
                interval = 0.18,
                texture = 'pig',
                looping = true
            }
        }
    },
    ['blue-snail'] = {	
        walkSpeed = SLOW_WALK_SPEED,
	    width = 38,
	    height = 35,
        baseHP = 20,
        baseATK = 1,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 15,
        meso_value = 5,
        animations = {
            ['die'] = {
                frames = {1, 2, 3},
                interval = 0.5,
                texture = 'blue-snail',
                looping = false
            },
            ['hit'] = {
                frames = {4},
                interval = 0.5,
                texture = 'blue-snail',
                looping = false
            },
            ['walk'] = {
                frames = {5, 6, 7, 8},
                interval = 0.10,
                texture = 'blue-snail',
                looping = true
            },
            ['stand'] = {
                frames = {9},
                interval = 0.18,
                texture = 'blue-snail',
                looping = true
            }
        }
    },
    ['red-snail'] = {	
        walkSpeed = SLOW_WALK_SPEED,
	    width = 38,
	    height = 38,
        baseHP = 20,
        baseATK = 1,
        baseDEF = 10,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 15,
        meso_value = 5,
        animations = {
            ['die'] = {
                frames = {1, 2, 3},
                interval = 0.5,
                texture = 'red-snail',
                looping = false
            },
            ['hit'] = {
                frames = {4},
                interval = 0.5,
                texture = 'red-snail',
                looping = false
            },
            ['walk'] = {
                frames = {5, 6, 7, 8},
                interval = 0.10,
                texture = 'red-snail',
                looping = true
            },
            ['stand'] = {
                frames = {9},
                interval = 0.18,
                texture = 'red-snail',
                looping = true
            }
        }
    },
    ['green-mushroom'] = {	
        walkSpeed = MEDIUM_WALK_SPEED,
	    width = 56,
	    height = 54,
        baseHP = 50,
        baseATK = 5,
        baseDEF = 5,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 20,
        meso_value = 10,
        animations = {
            ['die'] = {
                frames = {1, 2, 3, 4},
                interval = 0.5,
                texture = 'green-mushroom',
                looping = false
            },
            ['hit'] = {
                frames = {5},
                interval = 0.5,
                texture = 'green-mushroom',
                looping = false
            },
            ['walk'] = {
                frames = {6, 7, 8, 9},
                interval = 0.10,
                texture = 'green-mushroom',
                looping = true
            },
            ['stand'] = {
                frames = {10, 11, 12},
                interval = 0.18,
                texture = 'green-mushroom',
                looping = true
            }
        }
    },
    ['orange-mushroom'] = {	
        walkSpeed = MEDIUM_WALK_SPEED,
	    width = 65,
	    height = 65,
        baseHP = 50,
        baseATK = 5,
        baseDEF = 5,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 20,
        meso_value = 10,
        animations = {
            ['die'] = {
                frames = {1, 2, 3},
                interval = 0.5,
                texture = 'orange-mushroom',
                looping = false
            },
            ['hit'] = {
                frames = {4},
                interval = 0.5,
                texture = 'orange-mushroom',
                looping = false
            },
            ['jump'] = {
                frames = {5},
                interval = 0.5,
                texture = 'orange-mushroom',
                looping = false
            },
            ['walk'] = {
                frames = {6, 7, 8},
                interval = 0.10,
                texture = 'orange-mushroom',
                looping = true
            },
            ['stand'] = {
                frames = {9, 10},
                interval = 0.18,
                texture = 'orange-mushroom',
                looping = true
            }
        }
    },
    ['tiguru'] = {	
        walkSpeed = BOSS_WALK_SPEED,
	    width = 60 * 3,
	    height = 80 * 3,
        baseHP = 1000,
        baseATK = 20,
        baseDEF = 20,
        offsetY = 0,
        offsetX = 0,
        hitbox_offsetX = -12,
        hitbox_offsetY = -26,
        level = 5,
        exp_value = 500,
        meso_value = 100,
        scale = 3,
        animations = {
            ['die'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12},
                interval = 0.5,
                texture = 'tiguru',
                looping = false
            },
            ['hit'] = {
                frames = {13},
                interval = 0.5,
                texture = 'pig',
                looping = false
            },
            ['walk'] = {
                frames = {14, 15, 16, 17, 18, 19},
                interval = 0.10,
                texture = 'tiguru',
                looping = true
            },
            ['stand'] = {
                frames = {20, 21, 22, 23, 24, 25},
                interval = 0.15,
                texture = 'tiguru',
                looping = true
            }
        }
    }
}
