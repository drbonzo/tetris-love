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
    game.level = level -- FIXME wygeneruj level linii po 2-8 losowych klockow w losowych miejscach

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

    if love.keyboard.isDown('left') then
        -- FIXME how often can I move left/right
        self:moveLeft()
    elseif love.keyboard.isDown('right') then
        self:moveRight()
    end

    if self.timeSinceStart > self.tickDuration then
        self:processGravity()
        self.timeSinceStart = self.timeSinceStart - self.tickDuration
    end
end

function Game:moveLeft()
    -- FIXME check borders
    self.currentTetromino.x = self.currentTetromino.x - 1
end

function Game:moveRight()
    -- FIXME check borders - if any non zero block from this tetronimo is out of the edge
    self.currentTetromino.x = self.currentTetromino.x + 1
end


function Game:processGravity()
    self.currentTetromino.y = self.currentTetromino.y + 1
    -- print("Processing")
    -- if tetromino was meant to go down, but there is no place for it to go down - lock it and change current tetromino
    -- if movind down soft then stop one step before locking - so gravity can move it next tick
end

