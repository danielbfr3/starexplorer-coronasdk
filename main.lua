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

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local background = display.newImageRect( backGroup, "assets/background.png", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

-- group, imagesheet, position in array os img, size x and y
ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )

ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, { radius = 30 } )
ship.myName = "ship"

-- Show UI
livesText = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 36 )

-- Hide system bar
display.setStatusBar( display.hiddenStatusBar )

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end

local function createAsteroid()
    local newAsteroid = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )
    table.insert( asteroidsTable, newAsteroid )
    physics.addBody( newAsteroid, "dynamic", { radius = 40, bounce = 0.8 } )
    newAsteroid.myName = "asteroid"

    -- 3 possible positions: 1) left, 2) top, 3) right
    local whereFrom = math.random(3)

    if ( whereFrom == 1 ) then
        -- from left
        newAsteroid.x = -60
        newAsteroid.y = math.random( 500 )
        newAsteroid:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
    elseif ( whereFrom == 2 ) then
        -- from top
        newAsteroid.x = math.random( display.contentWidth )
        newAsteroid.y = -60
        newAsteroid:setLinearVelocity( math.random( -40, 40 ), math.random( 40, 120 ) ) 
    elseif ( whereFrom == 3 ) then
        -- from right
        newAsteroid.x = display.contentWidth + 60
        newAsteroid.y = math.random( 500 )
        newAsteroid:setLinearVelocity( math.random( -120, -40 ), math.random( 20, 60 ) ) 
    end

    newAsteroid:applyTorque( math.random( -6, 6 ) )
end