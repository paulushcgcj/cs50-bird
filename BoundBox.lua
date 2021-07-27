Class = require 'class'

BoundBox = Class{}

function BoundBox:init(x,y,width,height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function BoundBox:toString()
    local s = "BoundBox["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end

function BoundBox:update(x,y)
    self.x = self.x + x
    self.y = self.y + y
end

function BoundBox:canDespawn()
    return self.x < -(self.width + self.width / 4 )
end

function BoundBox:collides(target)
    return self:collides(target,0)
end

function BoundBox:collidesComplex(target,shiftY)
    if self.x > (target.x - 6) + target.width or (target.x - 6) > self.x + self.width then
        return false
    end
    if (self.y - shiftY) > target.y + target.height or target.y > (self.y - shiftY) + self.height then
        return false
    end
    return true
end

function BoundBox:drawCollider(shiftX,shiftY,shiftWidth,shiftHeight)
    love.graphics.rectangle(
        'line',
        self.x + shiftX,
        self.y + shiftY,
        self.width - shiftWidth,
        self.height - shiftHeight
    )
end