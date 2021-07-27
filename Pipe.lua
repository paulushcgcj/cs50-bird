Class = require 'class'
require 'BoundBox'

Pipe = Class{}


function Pipe:init(orientation,screenWidth,yPosition,pipeImage)
    self.box = BoundBox(
        screenWidth + (pipeImage:getWidth() / 2),
        yPosition,
        pipeImage:getWidth(),
        pipeImage:getHeight()
    )

    self.deltaY = 0

    self.orientation = orientation
end

function Pipe:update(dt,scrollSpeed)
    self.box:update(scrollSpeed * dt,0)
end

function Pipe:canDespawn()
    return self.box:canDespawn()
end

function Pipe:render(pipeImage)
    love.graphics.draw(
        pipeImage,
        self.orientation == 'top' and self.box.x + self.box.width or self.box.x,
        self.box.y,
        self.orientation == 'top' and math.rad(180) or 0,
        1,
        1
    )
end

function Pipe:collides(target)    
    return self.box:collidesComplex(target.box,0,self.orientation == 'top' and self.box.height or 0,3)
end

function Pipe:toString()
    local s = "Pipe["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end

function Pipe:drawCollider()
    self.box:drawCollider(
        3,
        self.orientation == 'top' and -self.box.height + 3 or 3,
        6,
        6
    )
end
