TetrominoGenerator = {
    tetrominoQueue = {},
}

function TetrominoGenerator:new()

    local tetrominoGenerator = {}
    setmetatable(tetrominoGenerator, self)
    self.__index = self

    -- init

    return tetrominoGenerator
end

-- @return {integer}
function TetrominoGenerator:getAndRemoveFirstTetrominoId()

    self:ensureWeHaveTetrominosInQueue()

    local firstTetrominoId = self.tetrominoQueue[1]

    -- remove first tetromino from queue
    table.remove(self.tetrominoQueue, 1)

    return firstTetrominoId
end

function TetrominoGenerator:ensureWeHaveTetrominosInQueue()

    if table.getn(self.tetrominoQueue) < 7 then
        -- push Tetrominos at the end
        -- FIXME randomixe tetrominos
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_I)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_J)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_L)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_O)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_S)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_T)
        table.insert(self.tetrominoQueue, Tetromino.TETROMINO_Z)
    end
end
