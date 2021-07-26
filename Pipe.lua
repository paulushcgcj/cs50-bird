Class = require 'class'

Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('assets/images/pipe.png')
local PIPE_SCROLL = -60

function Pipe:init(orientation,screenWidth,yPosition,modifier)
    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()

    self.x = screenWidth + (self.width / 2)
    self.y = yPosition
    self.y = modifier > 0 and yPosition + self.height + modifier or yPosition

    self.deltaY = 0

    self.orientation = orientation
end

function Pipe:update(dt)
    self.x = (self.x + PIPE_SCROLL * dt)
end

function Pipe:canDespawn()
    return self.x < -(self.width + self.width / 4 )
end

function Pipe:render()
    love.graphics.draw(
        PIPE_IMAGE,
        self.x,
        self.orientation == 'top' and self.y + self.height or self.y,
        0,
        1,
        self.orientation == 'top' and -1 or 1
    )
end

function Pipe:toString()
    local s = "Pipe["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end