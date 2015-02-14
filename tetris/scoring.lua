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
