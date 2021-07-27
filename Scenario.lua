Class = require 'class'

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

end

function Scenario:update(dt)
    self.backgroundScroll = (self.backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOP_POINT

    self.groundScroll = (self.groundScroll + GROUND_SCROLL_SPEED * dt)
        % self.screenWidth
end

function Scenario:render()
    love.graphics.draw(self.background,-self.backgroundScroll,0)
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