ROOM_DEFS = {
    ['main'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 8,
                ['y'] = 10,
                ['width'] = 6,
                ['height'] = 1 
            },
            [3] = {
                ['x'] = 10,
                ['y'] = 9,
                ['width'] = 2,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 1,
                ['y'] = 9, 
                ['width'] = 3,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 3,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 1,
            },
            [6] = {
                ['x'] = 1,
                ['y'] = 5,
                ['width'] = 6,
                ['height'] = 1
            },
            [7] = {
                ['x'] = 18,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [8] = {
                ['x'] = 16,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 1
            },
            [9] = {
                ['x'] = 15,
                ['y'] = 5,
                ['width'] = 6,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 25,
                ['y'] = 515,
                ['connected_map'] = 'road-to-main-1',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 1195,
                ['y'] = 515,
                ['connected_map'] = 'back-side-1',
                ['connected_portal'] = 2
            },
            [3] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 387,
                ['connected_map'] = 'tree-trunk-1',
                ['connected_portal'] = 2
            },
            [4] = {
                ['x'] = 60,
                ['y'] = 125,
                ['connected_map'] = 'eos-1',
                ['connected_portal'] = 2
            },
            [5] = {
                ['x'] = 1150,
                ['y'] = 125,
                ['connected_map'] = 'orbis-1',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'henesys',
        ['background'] = 'hene-bg',
        ['mobs'] = {
            ['snail'] = 10 
        }
    },
    ['road-to-main-1'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 15,
                ['y'] = 10,
                ['width'] = MAP_WIDTH - 14,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 17,
                ['y'] = 9,
                ['width'] = MAP_WIDTH - 16,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 5,
                ['y'] = 7,
                ['width'] = 8,
                ['height'] = 1 
            },
            [5] = {
                ['x'] = 5,
                ['y'] = 5,
                ['width'] = 8,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = 3,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 25,
                ['y'] = 450,
                ['connected_map'] = 'road-to-main-2',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 1195,
                ['y'] = 385,
                ['connected_map'] = 'main',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'rest-n-peace',
        ['background'] = 'road-to-hene',
        ['mobs'] = {
            ['blue-snail'] = 10
        }
    },
    ['road-to-main-2'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1,
                ['y'] = 9,
                ['width'] = 8,
                ['height'] = 2
            },
            [3] = {
                ['x'] = 1,
                ['y'] = 7,
                ['width'] = 6,
                ['height'] = 2
            },
            [4] = {
                ['x'] = 1,
                ['y'] = 5,
                ['width'] = 4,
                ['height'] = 2
            },
            [5] = {
                ['x'] = 15,
                ['y'] = 8,
                ['width'] = 4,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 20,
                ['y'] = 130,
                ['connected_map'] = 'praire',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 1195,
                ['y'] = 515,
                ['connected_map'] = 'road-to-main-1',
                ['connected_portal'] = 2
            }

        },
        ['bgm'] = 'rest-n-peace',
        ['background'] = 'road-to-hene',
        ['mobs'] = {
            ['red-snail'] = 7,
            ['blue-snail'] = 8
        }
    },
    ['praire'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = 4,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 17,
                ['y'] = 10,
                ['width'] = 4,
                ['height'] = 1,
            },
            [4] = {
                ['x'] = 7,
                ['y'] = 9,
                ['width'] = 8,
                ['height'] = 2
            },
            [5] = {
                ['x'] = 7,
                ['y'] = 7,
                ['width'] = 8,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 7,
                ['y'] = 5,
                ['width'] = 8,
                ['height'] = 1
            },
            [7] = {
                ['x'] = 7,
                ['y'] = 3,
                ['width'] = 8,
                ['height'] = 1
            },
            [8] = {
                ['x'] = 4,
                ['y'] = 3,
                ['width'] = 2,
                ['height'] = 1
            },
            [9] = {
                ['x'] = 16,
                ['y'] = 3,
                ['width'] = 2,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 1195,
                ['y'] = 450,
                ['connected_map'] = 'road-to-main-2',
                ['connected_portal'] = 2
            }
        },
        ['background'] = 'maple-island',
        ['bgm'] = 'lith-harbor',
        ['mobs'] = {
            ['red-snail'] = 5,
            ['blue-snail'] = 5,
            ['snail'] = 5
        }
    },
    ['back-side-1'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1,
                ['y'] = 8,
                ['width'] = 3,
                ['height'] = 2
            },
            [3] = {
                ['x'] = 17,
                ['y'] = 7,
                ['width'] = 4,
                ['height'] = 3
            },
            [4] = {
                ['x'] = 16,
                ['y'] = 8,
                ['width'] = 1,
                ['height'] = 2
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 20,
                ['y'] = 325,
                ['connected_map'] = 'main',
                ['connected_portal'] = 2
            },
            [2] = {
                ['x'] = 1195,
                ['y'] = 260,
                ['connected_map'] = 'back-side-2',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'backside-1',
        ['background'] = 'back-side-1',
        ['mobs'] = {
            ['pig'] = 10,
            ['stump'] = 5
        }
    },
    ['back-side-2'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1,
                ['y'] = 8,
                ['width'] = 3,
                ['height'] = 2
            },
            [3] = {
                ['x'] = 7,
                ['y'] = 8,
                ['width'] = 3,
                ['height'] = 2
            },
            [4] = {
                ['x'] = 13,
                ['y'] = 8,
                ['width'] = 3,
                ['height'] = 2
            },
            [5] = {
                ['x'] = 19,
                ['y'] = 8,
                ['width'] = 2,
                ['height'] = 2
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 20,
                ['y'] = 325,
                ['connected_map'] = 'back-side-1',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 1195,
                ['y'] = 325,
                ['connected_map'] = 'hidden-woods',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'backside-2',
        ['background'] = 'back-side-2',
        ['mobs'] = {
            ['spore'] = 10,
            ['green-mushroom'] = 5
        }
    },
    ['hidden-woods'] = {
        ['boss'] = {
            ['name'] = 'tiguru',
            ['x'] = 5,
            ['y'] = 9   
        },
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            },
            [2] = {
                ['x'] = 4,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 8,
                ['y'] = 9, 
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 12,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 16,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 6,
                ['y'] = 7,
                ['width'] = 11,
                ['height'] = 1
            },
            [7] = {
                ['x'] = 4,
                ['y'] = 5,
                ['width'] = 3,
                ['height'] = 1
            },
            [8] = {
                ['x'] = 8,
                ['y'] = 5, 
                ['width'] = 3,
                ['height'] = 1
            },
            [9] = {
                ['x'] = 12,
                ['y'] = 5,
                ['width'] = 3,
                ['height'] = 1
            },
            [10] = {
                ['x'] = 16,
                ['y'] = 5,
                ['width'] = 3,
                ['height'] = 1
            },
            [11] = {
                ['x'] = 6,
                ['y'] = 3,
                ['width'] = 11,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 20,
                ['y'] = 515,
                ['connected_map'] = 'back-side-2',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'sleepywood',
        ['background'] = 'sleepywoods',
        ['mobs'] = {
            ['green-mushroom'] = 10,
            ['orange-mushroom'] = 5
        }
    },
    ['tree-trunk-1'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 9,
                ['width'] = MAP_WIDTH, 
                ['height'] = 11
            },
            [2] = {
                ['x'] = 3,
                ['y'] = 7,
                ['width'] = 4,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 8,
                ['y'] = 5,
                ['width'] = 4,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 3,
                ['y'] = 3,
                ['width'] = 4,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 18,
                ['y'] = 5,
                ['width'] = 3,
                ['height'] = 4
            },
            [6] = {
                ['x'] = 15,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 2
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 385,
                ['connected_map'] = 'main',
                ['connected_portal'] = 3
            },
            [2] = {
                ['x'] = 215,
                ['y'] = 5,
                ['connected_map'] = 'tree-trunk-2',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'tree-trunk',
        ['background'] = 'tree-trunk',
        ['mobs'] = {
            ['slime'] = 10
        }
    },
    ['tree-trunk-2'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 14,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 11,
                ['y'] = 7,
                ['width'] = 2,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 8,
                ['y'] = 6,
                ['width'] = 2,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 1,
                ['y'] = 5,
                ['width'] = 6,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 8,
                ['y'] = 4,
                ['width'] = 2,
                ['height'] = 1
            },
            [7] = {
                ['x'] = 11,
                ['y'] = 3,
                ['width'] = 10,
                ['height'] = 1
            },
            [8] = {
                ['x'] = 3,
                ['y'] = 3,
                ['width'] = 3,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 200,
                ['y'] = 5,
                ['connected_map'] = 'tree-trunk-3',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 450,
                ['connected_map'] = 'tree-trunk-1',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'tree-trunk',
        ['background'] = 'tree-trunk',
        ['mobs'] = {
            ['stump'] = 5,
            ['slime'] = 5
        }
    },
    ['tree-trunk-3'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 2,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 10,
                ['y'] = 7,
                ['width'] = 1,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 12,
                ['y'] = 6,
                ['width'] = 1,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 14,
                ['y'] = 5,
                ['width'] = 5,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 8,
                ['y'] = 3,
                ['width'] = 2,
                ['height'] = 1
            },
            [7] = {
                ['x'] = 11,
                ['y'] = 3,
                ['width'] = 10,
                ['height'] = 1
            },
            [8] = {
                ['x'] = 3,
                ['y'] = 3,
                ['width'] = 3,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 200,
                ['y'] = 5,
                ['connected_map'] = 'tree-top',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 450,
                ['connected_map'] = 'tree-trunk-2',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'tree-trunk',
        ['background'] = 'tree-trunk',
        ['mobs'] = {
            ['stump'] = 5,
            ['slime'] = 5
        }
    },
    ['tree-top'] = {
        ['boss'] = {
            ['name'] = 'tiguru',
            ['x'] = 1,
            ['y'] = 11   
        },
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 4, 
                ['y'] = 9, 
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 15,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 8,
                ['y'] = 8,
                ['width'] = 6,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 7,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 12,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 1,
                ['y'] = 4,
                ['width'] = 7,
                ['height'] = 1 
            },
            [8] = {
                ['x'] = 14,
                ['y'] = 4,
                ['width'] = 7,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 515,
                ['connected_map'] = 'tree-trunk-2',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'ellinia',
        ['background'] = 'tree-top',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-1'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 3, 
                ['y'] = 9, 
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 15,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 7,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 7,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 12,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 6,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            },
            [8] = {
                ['x'] = 12,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 515,
                ['connected_map'] = 'main',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 330,
                ['y'] = 70,
                ['connected_map'] = 'eos-2',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'helios-tower',
        ['background'] = 'helios-tower-2',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-2'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 3, 
                ['y'] = 10, 
                ['width'] = 5,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 7,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 9,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 6,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 12,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 515,
                ['connected_map'] = 'eos-1',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 330,
                ['y'] = 70,
                ['connected_map'] = 'eos-3',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'helios-tower',
        ['background'] = 'helios-tower-2',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-3'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 10, 
                ['y'] = 10, 
                ['width'] = 2,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 12,
                ['y'] = 9,
                ['width'] = 2,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 8,
                ['y'] = 9,
                ['width'] = 2,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 6,
                ['y'] = 8,
                ['width'] = 2,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 14,
                ['y'] = 8,
                ['width'] = 2,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 5,
                ['y'] = 7,
                ['width'] = 2,
                ['height'] = 1 
            },
            [8] = {
                ['x'] = 15,
                ['y'] = 7,
                ['width'] = 2,
                ['height'] = 1 
            },
            [9] = {
                ['x'] = 4,
                ['y'] = 6,
                ['width'] = 2,
                ['height'] = 1
            },
            [10] = {
                ['x'] = 16,
                ['y'] = 6,
                ['width'] = 2,
                ['height'] = 1 
            },
            [11] = {
                ['x'] = 5,
                ['y'] = 5,
                ['width'] = 2,
                ['height'] = 1,
            },
            [12] = {
                ['x'] = 15,
                ['y'] = 5,
                ['width'] = 2,
                ['height'] = 1
            },
            [13] = {
                ['x'] = 6,
                ['y'] = 4,
                ['width'] = 4,
                ['height'] = 1
            },
            [14] = {
                ['x'] = 12,
                ['y'] = 4,
                ['width'] = 4,
                ['height'] = 1
            },
            [15] = {
                ['x'] = 10,
                ['y'] = 5,
                ['width'] = 2,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 450,
                ['connected_map'] = 'eos-2',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 125,
                ['connected_map'] = 'eos-4',
                ['connected_portal'] = 2
            },
        },
        ['bgm'] = 'high-enough',
        ['background'] = 'helios-tower',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-4'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 4, 
                ['y'] = 8, 
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 15,
                ['y'] = 8,
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 7,
                ['y'] = 10,
                ['width'] = 8,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 7,
                ['y'] = 6,
                ['width'] = 8,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 2,
                ['y'] = 4,
                ['width'] = 6,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 13,
                ['y'] = 4,
                ['width'] = 6,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 55,
                ['y'] = 450,
                ['connected_map'] = 'eos-3',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 250,
                ['y'] = 60,
                ['connected_map'] = 'eos-5',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'high-enough',
        ['background'] = 'helios-tower',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-5'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 10, 
                ['y'] = 10, 
                ['width'] = 5,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 7,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 9,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 6,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 12,
                ['y'] = 4,
                ['width'] = 3,
                ['height'] = 1 
            },
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 300,
                ['y'] = 515,
                ['connected_map'] = 'eos-4',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 + 125,
                ['y'] = 60,
                ['connected_map'] = 'eos-6',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'helios-tower',
        ['background'] = 'helios-tower-2',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-6'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 3, 
                ['y'] = 9, 
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 15,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 7,
                ['y'] = 8,
                ['width'] = 7,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 6,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 12,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 6,
                ['y'] = 4,
                ['width'] = 9,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 + 125,
                ['y'] = 515,
                ['connected_map'] = 'eos-5',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 175 ,
                ['y'] = 60,
                ['connected_map'] = 'eos-top',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'helios-tower',
        ['background'] = 'helios-tower-2',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['eos-top'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 10,
                ['width'] = MAP_WIDTH,
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1, 
                ['y'] = 8, 
                ['width'] = 4,
                ['height'] = 2
            },
            [3] = {
                ['x'] = 17,
                ['y'] = 8,
                ['width'] = 4,
                ['height'] = 2
            },
            [4] = {
                ['x'] = 8,
                ['y'] = 8,
                ['width'] = 6,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 6,
                ['y'] = 6,
                ['width'] = 13,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 12,
                ['y'] = 6,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 1,
                ['y'] = 4,
                ['width'] = 5,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 460,
                ['connected_map'] = 'eos-6',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'ludi',
        ['background'] = 'ludi',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-1'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 9
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 + 250,
                ['y'] = 515,
                ['connected_map'] = 'orbis-2',
                ['connected_portal'] = 2
            },
            [2] = {
                ['x'] = 150,
                ['y'] = 515,
                ['connected_map'] = 'main',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'orbis-tower',
        ['background'] = 'orbis-tower-bottom',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-2'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 9
            },
            [2] = {
                ['x'] = 1, 
                ['y'] = 8, 
                ['width'] = 4,
                ['height'] = 3
            },
            [3] = {
                ['x'] = 17,
                ['y'] = 8,
                ['width'] = 4,
                ['height'] = 3
            },
            [4] = {
                ['x'] = 6,
                ['y'] = 9,
                ['width'] = 10,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 6,
                ['y'] = 6,
                ['width'] = 5,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 12,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 12,
                ['y'] = 4,
                ['width'] = 4,
                ['height'] = 1 
            },
            
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 515,
                ['connected_map'] = 'orbis-1',
                ['connected_portal'] = 2
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2 + 100,
                ['y'] = 65,
                ['connected_map'] = 'orbis-3',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'orbis-tower',
        ['background'] = 'orbis-tower-mid',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-3'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 6, 
                ['y'] = 9, 
                ['width'] = 10,
                ['height'] = 2
            },
            [3] = {
                ['x'] = 6,
                ['y'] = 6,
                ['width'] = 5,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 12,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 1 
            },
            
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 + 151,
                ['y'] = 515,
                ['connected_map'] = 'orbis-2',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 370,
                ['y'] = 180,
                ['connected_map'] = 'orbis-4',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'orbis-tower',
        ['background'] = 'orbis-tower-mid',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-4'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 1
            },
            [2] = {
                ['x'] = 6, 
                ['y'] = 9, 
                ['width'] = 10,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 6,
                ['y'] = 6,
                ['width'] = 5,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 12,
                ['y'] = 7,
                ['width'] = 3,
                ['height'] = 1 
            },
            [5] = {
                ['x'] = 8,
                ['y'] = 4,
                ['width'] = 4,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 200,
                ['y'] = 515,
                ['connected_map'] = 'orbis-3',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = VIRTUAL_WIDTH / 2,
                ['y'] = 65,
                ['connected_map'] = 'orbis-5',
                ['connected_portal'] = 2
            }
        },
        ['bgm'] = 'orbis-tower',
        ['background'] = 'orbis-tower-mid',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-5'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 9
            },
            [2] = {
                ['x'] = 4, 
                ['y'] = 10, 
                ['width'] = 3,
                ['height'] = 1
            },
            [3] = {
                ['x'] = 16,
                ['y'] = 10,
                ['width'] = 3,
                ['height'] = 1
            },
            [4] = {
                ['x'] = 9,
                ['y'] = 10,
                ['width'] = 5,
                ['height'] = 1
            },
            [5] = {
                ['x'] = 10,
                ['y'] = 9,
                ['width'] = 3,
                ['height'] = 1
            },
            [6] = {
                ['x'] = 5,
                ['y'] = 6,
                ['width'] = 2,
                ['height'] = 1 
            },
            [7] = {
                ['x'] = 5,
                ['y'] = 4,
                ['width'] = 4,
                ['height'] = 1 
            },
            [8] = {
                ['x'] = 8,
                ['y'] = 7,
                ['width'] = 2,
                ['height'] = 1 
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = VIRTUAL_WIDTH / 2 - 31,
                ['y'] = 515,
                ['connected_map'] = 'orbis-4',
                ['connected_portal'] = 1
            },
            [2] = {
                ['x'] = 350,
                ['y'] = 64,
                ['connected_map'] = 'orbis-top',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'orbis-tower',
        ['background'] = 'orbis-tower',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['orbis-top'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH,
                ['height'] = 9 
            },
            [2] = {
                ['x'] = 14,
                ['y'] = 10,
                ['width'] = 6,
                ['height'] = 1
            }
        },
        ['portals'] = {
            [1] = {
                ['x'] = 100,
                ['y'] = 515,
                ['connected_map'] = 'orbis-5',
                ['connected_portal'] = 1
            }
        },
        ['bgm'] = 'orbis',
        ['background'] = 'orbis',
        ['mobs'] = {
            ['stump'] = 10
        }
    },
    ['test'] = {
        ['blocks'] = {
            [1] = {
                ['x'] = 1,
                ['y'] = 11,
                ['width'] = MAP_WIDTH, 
                ['height'] = 9
            } 
        },
        ['portal'] = {
            [2] = {
                ['x'] = 25,
                ['y'] = 515,
                ['connected_map'] = 'main',
                ['connected_portal'] = 1
            },
            [1] = {
                ['x'] = 1195,
                ['y'] = 515
            },
        }
    }
}