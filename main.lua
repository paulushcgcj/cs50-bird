DEBUG_COLLIDERS = true

push = require 'push'
log = require 'log'

require 'Bird'
require 'Scenario'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GRAVITY = 10

local bird = Bird(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,GRAVITY)
local scenario = Scenario(VIRTUAL_WIDTH,VIRTUAL_HEIGHT)

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Filphy by Paulo')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

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

    scenario:update(dt,scrolling,bird)
    scrolling = not scenario.collided

    if scrolling then
        bird:update(dt)
    end

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()
    scenario:render()
    bird:render()
    push:finish()
end
