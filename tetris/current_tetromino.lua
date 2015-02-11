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