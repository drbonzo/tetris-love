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

        local newTetrominos = {}
        table.insert(newTetrominos, Tetromino.TETROMINO_I)
        table.insert(newTetrominos, Tetromino.TETROMINO_J)
        table.insert(newTetrominos, Tetromino.TETROMINO_L)
        table.insert(newTetrominos, Tetromino.TETROMINO_O)
        table.insert(newTetrominos, Tetromino.TETROMINO_S)
        table.insert(newTetrominos, Tetromino.TETROMINO_T)
        table.insert(newTetrominos, Tetromino.TETROMINO_Z)

        newTetrominos = self:shuffleTable(newTetrominos)

        for k, t in pairs(newTetrominos) do
            -- push new Tetrominos at the end
            table.insert(self.tetrominoQueue, t)
        end
    end
end

function TetrominoGenerator:shuffleTable(aTable)
    local itemCount = #aTable

    for j = 1, 10 do
        for i = 1, itemCount do
            local index_1 = math.random(1, itemCount)
            local index_2 = math.random(1, itemCount)

            if index_1 ~= index_2 then
                -- swap items
                aTable[index_1], aTable[index_2] = aTable[index_2], aTable[index_1]
            end
        end
    end

    return aTable
end
