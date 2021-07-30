Class = require 'libs/class'
require 'src/Pipe'

PipePair = Class{}

local PIPE_IMAGE = love.graphics.newImage('assets/images/pipe.png')
local PIPE_SCROLL = -60

function PipePair:init(yPosition,screenWidth,gap)
    self.pipes = {
        ['upper'] = Pipe('top',screenWidth,yPosition,PIPE_IMAGE),
        ['lower'] = Pipe('bottom',screenWidth,yPosition + gap,PIPE_IMAGE)
    }
    self.scored = false
end

function PipePair:update(dt)
    for _, pipe in pairs(self.pipes) do
        pipe:update(dt,PIPE_SCROLL)
    end
end

function PipePair:canDespawn()
    return self.pipes['upper']:canDespawn()
end

function PipePair:collides(target)

    for _, pipe in pairs(self.pipes) do
        if pipe:collides(target) then
            return true
        end
    end

    return false

end

function PipePair:getXEdge()
    return self.pipes['lower'].box.x + self.pipes['lower'].box.width
end

function PipePair:render()
    for _, pipe in pairs(self.pipes) do
        pipe:render(PIPE_IMAGE)
    end
end


function PipePair:drawCollider()
    for _, pipe in pairs(self.pipes) do
        pipe:drawCollider()
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