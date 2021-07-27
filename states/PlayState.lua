Class = require 'class'
require 'states/BaseState'

PlayState = Class{__includes = BaseState}

function PlayState:init(screenWidth,screenHeight,gravity)
    self.screenHeight = screenHeight
    self.screenWidth = screenWidth
    self.pipePairs = {}
    self.spawnTimer = math.random(2,4)
    self.collided = false

    self.bird = Bird(screenWidth,screenHeight,gravity)
end

function PlayState:update(dt)
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

        if pipePair:collides(self.bird) then
            self.collided = true
        end

    end

    for index, pipe in pairs(self.pipePairs) do
        if pipe:canDespawn() or self.collided then
            print("Removing pipe at "..tostring(pipe.pipes['lower'].box.x).."/"..tostring(pipe.pipes['lower'].box.y))
            table.remove(self.pipePairs,index)
        end
    end

    self.bird:update(dt)

    if self.collided then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    for _, pipe in pairs(self.pipePairs) do
        pipe:render()
    end

    self.bird:render()
end