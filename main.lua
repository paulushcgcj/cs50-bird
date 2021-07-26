push = require 'push'
log = require 'log'

require 'Bird'
require 'Pipe'
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GRAVITY = 10

local background = love.graphics.newImage('assets/images/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/images/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 33
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOP_POINT = 413

local bird = Bird(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,GRAVITY)

local pipePairs = {}
local spawnTimer = 0

local lastPipeY = -288 + math.random(80) + 20

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Flappy by Paulo')
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
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOP_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then

        lastPipeY = math.max(-288 + 10, math.min(lastPipeY + math.random(-20,20), VIRTUAL_HEIGHT-90-288))

        table.insert(pipePairs,PipePair(lastPipeY,VIRTUAL_WIDTH,math.random(90,150)))
        spawnTimer = 0
        --log.singleInfo("Pipes: " ..sizeOf(pipePairs))
    end

    for index, pipe in pairs(pipePairs) do
        pipe:update(dt)
    end

    for index, pipe in pairs(pipePairs) do
        if pipe:canDespawn() then
            table.remove(pipePairs,index)
        end

    end

    bird:update(dt)

    log.info(bird:toString())

    love.keyboard.keysPressed = {}
    
end

function love.draw()
    push:start()

    love.graphics.draw(background,-backgroundScroll,0)
    for index, pipe in pairs(pipePairs) do
        pipe:render()
    end
    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)

    bird:render()

    push:finish()
end

function sizeOf(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end