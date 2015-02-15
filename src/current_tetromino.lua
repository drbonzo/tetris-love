CurrentTetromino = {
    blocks = nil,
    tetromino = nil,
    rotationId = 1,
    x = 0,
    y = 0
}

function CurrentTetromino:new()

    local currentTetromino = {}
    setmetatable(currentTetromino, self)
    self.__index = self

    -- init

    return currentTetromino
end


function CurrentTetromino:changeTetromino(tetromino, x, y)
    self.tetromino = tetromino
    self.rotationId = 1
    self.blocks = tetromino.blocks[self.rotationId]
    self.x = x
    self.y = y
end

function CurrentTetromino:rotateClockWise()
    local rotationId = self:computeNewRotationId(1)
    self:updateRotation(rotationId)
end

function CurrentTetromino:rotateCounterClockWise()
    local rotationId = self:computeNewRotationId(-1)
    self:updateRotation(rotationId)
end

function CurrentTetromino:computeNewRotationId(dr)

    local rotationId = self.rotationId - 1 -- normalize (range: 0..3)
    if dr > 0 then
        rotationId = (rotationId + 1) % 4
    elseif dr < 0 then
        rotationId = (rotationId + 4 - 1) % 4 -- +4 makes rotationId always positive
    else
        -- dont change rotationId
    end

    return rotationId + 1 -- denormalize (range: 1..4)
end

function CurrentTetromino:updateRotation(rotationId)
    self.rotationId = rotationId
    self.blocks = self.tetromino.blocks[rotationId]
end

function CurrentTetromino:getBlocksForRotationChange(dr)
    local rotationId = self:computeNewRotationId(dr)
    return self.tetromino.blocks[rotationId]
end
