Game = {
    speed = 1,
    level = 0,
    playfield = nil,
    tetrominoGenerator = nil,
    currentTetromino = nil,
    nextTetromino = nil,
    tetrominos = nil,
    actionTimers = nil
}

function Game:new(playfield, tetrominoGenerator, tetrominos, speed, level)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.playfield = playfield
    game.tetrominoGenerator = tetrominoGenerator
    game.speed = speed
    game.level = level -- FIXME wygeneruj level linii po 2-8 losowych klockow w losowych miejscach
    game.actionTimers = ActionTimers:new(speed)


    self.tetrominos = tetrominos
    self.currentTetromino = CurrentTetromino:new()


    return game
end

function Game:initialize()
    self:initializeTetrominos()
end

function Game:initializeTetrominos()

    local tetrominoId = self.tetrominoGenerator:getAndRemoveFirstTetrominoId()
    -- put it at the middle
    -- as we count from 1 (not from 0): add 1
    local tetrominoStartPosition = {
        x = (self.playfield.width - 4) / 2 + 1, -- TODO DRY
        y = 3
    }
    self.currentTetromino:changeTetromino(self.tetrominos:get(tetrominoId), tetrominoStartPosition.x, tetrominoStartPosition.y)

    -- FIXME         -- self.nextTetromino = self.nextTetrominos[2]
    -- self.nextTetrominoBlocks = self.tetrominos:get(self.nextTetromino)[1] -- always in first rotation

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
    if self:canMoveTo(self.currentTetromino, -1, 0, 0) and self.actionTimers:canPerformMove() then
        self.currentTetromino.x = self.currentTetromino.x - 1
    end
end

function Game:moveRight()
    if self:canMoveTo(self.currentTetromino, 1, 0, 0) and self.actionTimers:canPerformMove() then
        self.currentTetromino.x = self.currentTetromino.x + 1
    end
end

function Game:softDrop()

    if self.actionTimers:canPerformSoftDrop() then

        if self:canMoveTo(self.currentTetromino, 0, 1, 0) then
            self.currentTetromino.y = self.currentTetromino.y + 1
        else
            -- block cannot move down - so lock it
            self.actionTimers:forceGravity()
        end
    end
end

function Game:hardDrop()
    -- FIXME check borders - if any non zero block from this tetronimo is out of the edge
    -- FIXME lock the tetromino
    self.currentTetromino.y = 0 -- FIXME find this position
end

function Game:rotateClockWise()
    if self:canMoveTo(self.currentTetromino, 0, 0, 1) and self.actionTimers:canPerformRotation() then
        self.currentTetromino:rotateClockWise()
    end
end

function Game:rotateCounterClockWise()
    if self:canMoveTo(self.currentTetromino, 0, 0, -1) and self.actionTimers:canPerformRotation() then
        self.currentTetromino:rotateCounterClockWise()
    end
end

-- @param currentTetromino
-- @param dx change in X
-- @param dy change in Y
-- @param dr change in rotation (+1 - next CW, -1 next CCW)
-- @return bool
function Game:canMoveTo(currentTetromino, dx, dy, dr)
    local pos_x = currentTetromino.x + dx
    local pos_y = currentTetromino.y + dy
    local tetrominoBlocks = currentTetromino:getBlocksForRotationChange(dr)
    local x
    local y

    for r = 1, 4 do

        for c = 1, 4 do

            x = pos_x + c - 1
            y = pos_y + r - 1

            local result = self.playfield:tetrominoBlockOverlapsWithPlayfieldBlock(tetrominoBlocks[r][c], x, y)

            if result == nil then
                -- continue - this was out of range
            elseif result then
                return false
            else
                -- false
                -- check next block
            end
        end
    end

    return true
end


function Game:processGravity()

    if self:canMoveTo(self.currentTetromino, 0, 1, 0) then
        self.currentTetromino.y = self.currentTetromino.y + 1
    else
        self:lockTetromino()
    end
end

function Game:lockTetromino()
    self.playfield:absorbTetromino(self.currentTetromino)
    -- FIXME refactor
    self.currentTetromino.tetromino = nil
    self:initializeTetrominos() -- FIXME rename
    -- FIXME apply score
    -- if tetromino was meant to go down, but there is no place for it to go down - lock it and change current tetromino
end

