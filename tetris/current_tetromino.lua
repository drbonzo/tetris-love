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
    local rotationId = self.rotationId - 1 -- normalize
    rotationId = (rotationId + 1) % 4
    self:updateRotation(rotationId)
end

function CurrentTetromino:rotateCounterClockWise()
    local rotationId = self.rotationId - 1 -- normalize
    rotationId = (rotationId + 4 - 1) % 4 -- +4 makes rotationId always positive
    self:updateRotation(rotationId)
end


function CurrentTetromino:updateRotation(rotationId)
    self.rotationId = rotationId + 1 -- denormalize
    self.blocks = self.tetromino.blocks[self.rotationId]
end
