-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- Initiate physics and set gravity to zero
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Seed the random number generator
math.randomseed( os.time() )

-- Initializing game objects sheet
local sheetOptions = {
    frames = {
        { -- 1) Asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        { -- 2) Asteroid 2
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        { -- 3) Asteroid 3
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        { -- 4) Ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        { -- 5) Laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        }
    }
}

local objectSheet = graphics.newImageSheet( "assets/gameObjects.png", sheetOptions )

-- Initializing game variables
local lives = 3
local score = 0
local died = false

local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

