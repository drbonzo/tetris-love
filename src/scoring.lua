Scoring = {
    POINTS_FOR_SOFT_DROP = 1,
    POINTS_FOR_HARD_DROP = 2,
    score = 0,
    startSpeed = 1,
    startLevel = 0,
    startTime = 0,
    endTime = 0,
    linesCleared = 0
}

function Scoring:new(startTime, speed, level)

    local scoring = {}
    setmetatable(scoring, self)
    self.__index = self

    self.startTime = startTime
    self.startSpeed = speed
    self.startLevel = level

    return scoring
end

function Scoring:getScore()
    return self.score
end

function Scoring:addScoreForSoftDrop()
    self.score = self.score + self.POINTS_FOR_SOFT_DROP
end

function Scoring:applyScoreForLinesCleared(linesCleared)

    if linesCleared == 1 then
        self.score = self.score + 100
    elseif linesCleared == 2 then
        self.score = self.score + 300
    elseif linesCleared == 3 then
        self.score = self.score + 500
    elseif linesCleared == 4 then
        self.score = self.score + 800
    else
        -- 0 points
    end

    self.linesCleared = self.linesCleared + linesCleared
end

function Scoring:endGame(endTime)
    self.endTime = endTime
end

function Scoring:getGameDuration()
    return self.endTime - self.startTime
end

function Scoring:getLinesCleared()
    return self.linesCleared
end

function Scoring:getStartSpeed()
    return self.startSpeed
end

function Scoring:getStartLevel()
    return self.startLevel
end
