Class = require 'class'
require 'Pipe'

PipePair = Class{}

function PipePair:init(yPosition,screenWidth,gap)
    self.x = screenWidth + 32
    self.y = yPosition

    self.pipes = {
        ['upper'] = Pipe('top',screenWidth,yPosition,0),
        ['lower'] = Pipe('bottom',screenWidth,yPosition,gap)
    }
end

function PipePair:update(dt)
    for index, pipe in pairs(self.pipes) do
        pipe:update(dt)
    end
end

function PipePair:canDespawn()
    return self.pipes['upper']:canDespawn()
end

function PipePair:render()
    for index, pipe in pairs(self.pipes) do
        pipe:render()
    end
end

function PipePair:toString()
    local s = "PipePair["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end