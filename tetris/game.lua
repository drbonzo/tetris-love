Game = { 
    speed = 1,
    level = 0,
    playfield = nil,
    timeSinceStart = 0,
    tickDuration = 0,

    currentTetromino = nil,

    nextTetromino = nil,
    nextTetrominos = {},

    tetrominos = nil
}

function Game:new(speed, level)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.speed = speed
    game.level = level

    -- speed 1 => tickDuration = 1s
    -- spped 5 => tickDuration = 1/5 = 0.2s
    game.tickDuration = 1.0 / game.speed 

    self.tetrominos = Tetrominos:buildTetrominos()
    self.currentTetromino = CurrentTetromino:new()
    -- FIXME remove: self.tetrominos:printTetromino(self.tetrominos.t1)


    return game
end

function Game:initialize()
    self.timeSinceStart = 0
    self:initializeTetrominos()
end

function Game:initializeTetrominos()

    if table.getn(self.nextTetrominos) < 7 then -- FIXME extract method
        -- push Tetrominos at the end
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_I)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_J)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_L)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_O)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_S)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_T)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_Z)
    end

    if not self.currentTetromino.tetromino then -- FIXME method

        local tetrominoId = self.nextTetrominos[1]
        self.currentTetromino:changeTetromino(self.tetrominos:get(tetrominoId), 4, 0) -- FIXME setup position

        -- self.nextTetromino = self.nextTetrominos[2]
        -- self.nextTetrominoBlocks = self.tetrominos:get(self.nextTetromino)[1] -- always in first rotation

         -- remove used tetromino
        table.remove(self.nextTetrominos, 1)
    end

end


function Game:update(dt)
    self.timeSinceStart = self.timeSinceStart + dt

    if self.timeSinceStart > self.tickDuration then
        self:processGravity()
        self.timeSinceStart = self.timeSinceStart - self.tickDuration
    end
end


function Game:processGravity()
    -- print("Processing")
end

