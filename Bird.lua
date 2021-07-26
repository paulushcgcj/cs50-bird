Class = require 'class'

Bird = Class{}

function Bird:init(screenWidth,screenHeight)
    self.image = love.graphics.newImage('assets/images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = screenWidth / 2 - (self.width / 2)
    self.y = screenHeight / 2 - (self.height / 2)
end

function Bird:update(dt)

end

function Bird:render()
    love.graphics.draw(self.image,self.x,self.y)
end

function Bird:toString()
    local s = "Bird["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end