Class = require 'class'

Bird = Class{}

function Bird:init(screenWidth,screenHeight,gravity)
    self.image = love.graphics.newImage('assets/images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = screenWidth / 2 - (self.width / 2)
    self.y = screenHeight / 2 - (self.height / 2)

    self.maxY = screenHeight + self.height + (self.height / 4)

    self.deltaY = 0

    self.originalGravity = gravity
    self.gravity = gravity

    --TODO: Move this to outside
    self.originalJumpForce = 5
    self.jumpForce = 5
end

function Bird:jump()
    self.deltaY = self.deltaY - self.gravity
end

function Bird:update(dt)

    if self.y < self.maxY then

        self.deltaY = self.deltaY + self.gravity * dt

        if love.keyboard.wasPressed('space') then
            self.deltaY = -self.jumpForce
        end

        self.y = self.y + self.deltaY
    end
 
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