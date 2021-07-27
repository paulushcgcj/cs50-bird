Class = require 'class'
require 'BoundBox'

Bird = Class{}

function Bird:init(screenWidth,screenHeight,gravity)
    self.screenHeight = screenHeight
    self.screenWidth = screenWidth
    self.image = love.graphics.newImage('assets/images/bird.png')
    self.box = BoundBox(
        screenWidth / 2 - (self.image:getWidth() / 2),
        screenHeight / 2 - (self.image:getHeight() / 2),
        self.image:getWidth(),
        self.image:getHeight()
    )

    self.bottomY = screenHeight + self.box.height + (self.box.height / 4)
    self.topY = self.box.height * -2

    self.deltaY = 0

    self.originalGravity = gravity
    self.gravity = gravity

    --TODO: Move this to outside
    self.originalJumpForce = 5
    self.jumpForce = 2
end

function Bird:update(dt)

    self.deltaY = self.deltaY + self.gravity * dt
    if love.keyboard.wasPressed('space') then
        self.deltaY = -(self.jumpForce + dt)
        sounds['jump']:play()
    end

    self.box:update(0,self.deltaY)
    self.box:clampY(self.topY,self.bottomY)

end

function Bird:render()
    love.graphics.draw(self.image,self.box.x,self.box.y)
end

function Bird:toString()
    local s = "Bird["
    for key, value in pairs(self) do
        s = s ..key ..":" ..tostring(value) ..", "
    end
    s = s .."box:" ..self.box:toString() ..", "
    s = string.sub(s,0,string.len(s)-2).."]"
    return s
end

function Bird:drawCollider()
    self.box:drawCollider(0,0,0,0)
end