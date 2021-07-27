push = require 'push'
log = require 'log'

require 'Bird'
require 'Scenario'

require 'StateMachine'
require 'states/PlayState'
require 'states/TitleState'
require 'states/ScoreState'
require 'states/CountDownState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GRAVITY = 10

local scenario = Scenario(VIRTUAL_WIDTH,VIRTUAL_HEIGHT)

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Filphy by Paulo')
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('assets/PressStart2P-Regular.ttf',8)
    mediumFont = love.graphics.newFont('assets/Gugi-Regular.ttf',14)
    largeFont = love.graphics.newFont('assets/Gugi-Regular.ttf',56)
    flappyFont = love.graphics.newFont('assets/Gugi-Regular.ttf',28)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState(VIRTUAL_WIDTH) end,
        ['play'] = function() return PlayState(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,GRAVITY) end,
        ['score'] = function () return ScoreState(VIRTUAL_WIDTH) end,
        ['countdown'] = function () return CountDownState(VIRTUAL_WIDTH) end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)

    gStateMachine:update(dt)

    scenario:update(dt,scrolling)
    scrolling = not scenario.collided

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()
    scenario:render()
    gStateMachine:render()
    push:finish()
end
