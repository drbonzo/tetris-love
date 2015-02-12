Game = {
    speed = 1,
    level = 0,
    playfield = nil,
    currentTetromino = nil,
    nextTetromino = nil,
    nextTetrominos = {},
    tetrominos = nil,
    actionTimers = nil
}

function Game:new(playfield, speed, level)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.playfield = playfield
    game.speed = speed
    game.level = level -- FIXME wygeneruj level linii po 2-8 losowych klockow w losowych miejscach
    game.actionTimers = ActionTimers:new(speed)


    self.tetrominos = Tetrominos:buildTetrominos()
    self.currentTetromino = CurrentTetromino:new()
    -- FIXME remove: self.tetrominos:printTetromino(self.tetrominos.t1)


    return game
end

function Game:initialize()
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
        local tetrominoStartPosition = {
            x = 0,
            y = 0
        }

        tetrominoStartPosition.y = self.playfield.height - 2

        -- put it at the middle
        -- as we count from 1 (not from 0): add 1
        tetrominoStartPosition.x = (self.playfield.width - 4) / 2 + 1
        self.currentTetromino:changeTetromino(self.tetrominos:get(tetrominoId), tetrominoStartPosition.x, tetrominoStartPosition.y) -- FIXME setup position

        -- self.nextTetromino = self.nextTetrominos[2]
        -- self.nextTetrominoBlocks = self.tetrominos:get(self.nextTetromino)[1] -- always in first rotation

        -- remove used tetromino
        table.remove(self.nextTetrominos, 1)
    end
end


function Game:update(dt)
    self.actionTimers:update(dt)

    if love.keyboard.isDown('left') then
        -- FIXME how often can I move left/right
        self:moveLeft()
    elseif love.keyboard.isDown('right') then
        self:moveRight()
    elseif love.keyboard.isDown('down') then
        self:softDrop()
    elseif love.keyboard.isDown('up') then
        self:rotateClockWise()
    elseif love.keyboard.isDown(' ') then
        self:hardDrop()
    end

    if self.actionTimers:canUpdateGravity() then
        self:processGravity()
    end
end

function Game:moveLeft()
    -- FIXME check borders first then check time

    if self.actionTimers:canPerformMove() then
        self.currentTetromino.x = self.currentTetromino.x - 1
    end
end

function Game:moveRight()
    -- FIXME check borders first then check time

    if self.actionTimers:canPerformMove() then
        self.currentTetromino.x = self.currentTetromino.x + 1
    end
end

function Game:softDrop()
    -- FIXME check borders - if any non zero block from this tetronimo is out of the edge

    if self.actionTimers:canPerformSoftDrop() then
        self.currentTetromino.y = self.currentTetromino.y - 1
    end
end

function Game:hardDrop()
    -- FIXME check borders - if any non zero block from this tetronimo is out of the edge
    -- FIXME lock the tetromino
    self.currentTetromino.y = 0 -- FIXME find this position
end

function Game:rotateClockWise()
    -- FIXME check if we can rotate
    if self.actionTimers:canPerformRotation() then
        self.currentTetromino:rotateClockWise()
    end
end

function Game:rotateCounterClockWise()
    -- FIXME check if we can rotate
    if self.actionTimers:canPerformRotation() then
        self.currentTetromino:rotateCounterClockWise()
    end
end


function Game:processGravity()
    self.currentTetromino.y = self.currentTetromino.y - 1
    -- print("Processing")
    -- if tetromino was meant to go down, but there is no place for it to go down - lock it and change current tetromino
    -- if movind down soft then stop one step before locking - so gravity can move it next tick
end

