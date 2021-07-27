DEBUG_COLLIDERS = true


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

    spawnTimer = math.random(2,4)

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

    if scrolling then

        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOP_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

        spawnTimer = spawnTimer - dt

        if spawnTimer <= 0 then
            local gap = math.random(70,110)
            table.insert(pipePairs,PipePair(math.random(35,VIRTUAL_HEIGHT - 50 - gap),VIRTUAL_WIDTH,gap))
            spawnTimer = math.random(2,4)
        end

        for _, pipePair in pairs(pipePairs) do
            pipePair:update(dt)

            if pipePair:collides(bird) then
                scrolling = false
            end

        end

        for index, pipe in pairs(pipePairs) do
            if pipe:canDespawn() then
                table.remove(pipePairs,index)
            end

        end

        bird:update(dt)
    end

    love.keyboard.keysPressed = {}
    
end

function love.draw()
    push:start()

    love.graphics.draw(background,-backgroundScroll,0)
    for _, pipe in pairs(pipePairs) do
        pipe:render()
        if DEBUG_COLLIDERS then
            pipe:drawCollider()
        end
    end

    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)

    bird:render()
    if DEBUG_COLLIDERS then
        bird:drawCollider()
    end

    push:finish()
end
