Class = require 'class'
require 'states/BaseState'

ScoreState = Class{__includes = BaseState}

function ScoreState:init(screenWidth)
    self.screenWidth = screenWidth
    self.mediumFont = love.graphics.newFont('assets/Gugi-Regular.ttf',14)
    self.flappyFont = love.graphics.newFont('assets/Gugi-Regular.ttf',28)
    self.score = 0
end

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function ScoreState:render()
    love.graphics.setFont(self.flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, self.screenWidth, 'center')

    love.graphics.setFont(self.mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, self.screenWidth, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, self.screenWidth, 'center')
end