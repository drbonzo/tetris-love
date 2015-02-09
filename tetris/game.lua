Game = { 
    speed = 1,
    level = 0,
    playfield = nil,
    timeSinceStart = 0,
    tickDuration = 0,

    currentTetromino = nil,
    currentTetrominoBlocks = nil,
    currentTetrominoRotation = 1,
    currentTetrominoPosition = { x = 1, y = 12 }, -- FIXME


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
    -- FIXME remove: self.tetrominos:printTetromino(self.tetrominos.t1)


    return game
end

function Game:initialize()
    self.timeSinceStart = 0
end

function Game:update(dt)
    self.timeSinceStart = self.timeSinceStart + dt

    self:handleTetrominos()

    if self.timeSinceStart > self.tickDuration then
        self:processGravity()
        self.timeSinceStart = self.timeSinceStart - self.tickDuration
    end
end


function Game:processGravity()
    print("Processing")
end

function Game:handleTetrominos()

    if table.getn(self.nextTetrominos) < 7 then
        -- push Tetrominos at the end
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_I)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_J)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_L)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_O)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_S)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_T)
        table.insert(self.nextTetrominos, Tetromino.TETROMINO_Z)
    end

    if not self.currentTetromino then
        -- FIXME refactor currentTetromino and other fields
        self.currentTetromino = self.nextTetrominos[1]
        self.currentTetrominoRotation = 1

        -- print('self.currentTetrominoRotation')
        -- print(self.currentTetrominoRotation)

        local tetromino = self.tetrominos:get(self.currentTetromino)
        
        self.currentTetrominoBlocks = tetromino.blocks[self.currentTetrominoRotation] -- FIXME add method for getBlocksForRotation(i)
        -- print('self.currentTetrominoBlocks');
        -- print(self.currentTetrominoBlocks)

        self.nextTetromino = self.nextTetrominos[2]
        self.nextTetrominoBlocks = self.tetrominos:get(self.nextTetromino)[1] -- always in first rotation

        -- FIXME: table.remove(self.nextTetrominos, 1) -- remove current
    end

    -- FIXME update rotation if needed?

end
