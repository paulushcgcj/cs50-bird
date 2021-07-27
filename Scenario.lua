Class = require 'class'

require 'Pipe'
require 'PipePair'

Scenario = Class{}

local BACKGROUND_SCROLL_SPEED = 33
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOP_POINT = 413

function Scenario:init(screenWidth,screenHeight)

    self.screenHeight = screenHeight
    self.screenWidth = screenWidth
    self.background = love.graphics.newImage('assets/images/background.png')
    self.backgroundScroll = 0

    self.ground = love.graphics.newImage('assets/images/ground.png')
    self.groundScroll = 0

    self.pipePairs = {}
    self.spawnTimer = math.random(2,4)

    self.collided = false
end

function Scenario:update(dt,scrolling, bird)

    if scrolling then

        self.backgroundScroll = (self.backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOP_POINT
            self.groundScroll = (self.groundScroll + GROUND_SCROLL_SPEED * dt)
            % self.screenWidth

            self.spawnTimer = self.spawnTimer - dt

        if self.spawnTimer <= 0 then
            local gap = math.random(70,110)
            local yPosition = math.random(35,self.screenHeight - 50 - gap)
            table.insert(self.pipePairs,PipePair(yPosition,self.screenWidth,gap))
            self.spawnTimer = math.random(2,4)

            print("Spawned a pipe at " ..tostring(self.screenWidth) .."/" ..tostring(yPosition) .." with a gap of " ..tostring(gap))
            print("Next spawn in " ..tostring(self.spawnTimer))
        end

        for _, pipePair in pairs(self.pipePairs) do
            pipePair:update(dt)

            if pipePair:collides(bird) then
                self.collided = true
            end

        end

        for index, pipe in pairs(self.pipePairs) do
            if pipe:canDespawn() then
                table.remove(self.pipePairs,index)
            end

        end

    end

end

function Scenario:render()

    love.graphics.draw(self.background,-self.backgroundScroll,0)

    for _, pipe in pairs(self.pipePairs) do
        pipe:render()
    end

    love.graphics.draw(self.ground,-self.groundScroll,self.screenHeight-16)

end

function Scenario:toString()
    local s = "Scenario["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end