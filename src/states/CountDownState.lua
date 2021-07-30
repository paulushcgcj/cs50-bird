Class = require 'libs/class'
require 'src/states/BaseState'

CountDownState = Class{__includes = BaseState}

COUNTDOWN_TIME = 0.75

function CountDownState:init(screenWidth)
    self.screenWidth = screenWidth
    self.count = 3
    self.timer = 0
    sounds['jump']:play()
end

function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        sounds['jump']:play()

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountDownState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf(tostring(self.count), 0, 120, self.screenWidth, 'center')
end