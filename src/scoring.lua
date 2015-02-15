Scoring = {
    score = 0,
    POINTS_FOR_SOFT_DROP = 1,
    POINTS_FOR_HARD_DROP = 2
}

function Scoring:new()

    local scoring = {}
    setmetatable(scoring, self)
    self.__index = self

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
end