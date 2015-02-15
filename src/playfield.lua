Playfield = {
    width = 0,
    height = 0,
    blocks = nil,
    EMPTY_BLOCK = 0,
    GARBAGE_BLOCK = 50,
    WALL = 99
}

function Playfield:new(width, height)

    local playfield = {}
    setmetatable(playfield, self)
    self.__index = self

    playfield.width = width
    playfield.height = height
    playfield.heightWithVanishZone = height + 2

    playfield.blocks = {}

    -- W..........W - 1
    -- W..........W - 2
    -- W..........W - 3
    -- W..........W ...
    -- W..........W
    -- WWWWWWWWWWWW - h+1
    -- ^^^        ^
    -- 123.......(w+2)
    --
    -- where:
    -- W - wall
    -- . - empty space, where tetrominos can be placed
    --
    -- Having walls simplifies checking whether brick can be placed there

    local w = width + 2 -- TODO DRY
    local h = playfield.heightWithVanishZone + 1 -- TODO DRY

    for r = 1, h do
        -- row
        playfield.blocks[r] = {}
        for c = 1, w do
            -- cols

            if (r == h) then

                -- bottom wall
                playfield.blocks[r][c] = Playfield.WALL

            elseif (c == 1 or c == w) then

                -- left and right wall
                playfield.blocks[r][c] = Playfield.WALL

            else

                playfield.blocks[r][c] = Playfield.EMPTY_BLOCK
            end
        end
    end

    return playfield
end


-- @param currentTetromino {CurrentTetromino}
function Playfield:absorbTetromino(currentTetromino)

    local block_x
    local block_y
    for r = 1, 4 do
        for c = 1, 4 do
            block_x = currentTetromino.x + c - 1
            block_y = currentTetromino.y + r - 1

            if (currentTetromino.blocks[r][c] ~= self.EMPTY_BLOCK) then
                self.blocks[block_y][block_x] = currentTetromino.blocks[r][c]
            end
        end
    end
end

-- @return {mixed}
-- true: overlaps
-- false: does not overlap
-- nil: check next position - [x,y] is out of range
function Playfield:tetrominoBlockOverlapsWithPlayfieldBlock(tetrominoBlock, x, y)

    -- check if position is inside the playfield
    if ((x < 1) or (x > self.width + 2)) then -- TODO DRY
        return nil
    end

    if ((y < 1) or (y > self.height + 3)) then -- TODO DRY
        return nil
    end

    local tetrominoHasBlock = (tetrominoBlock ~= Playfield.EMPTY_BLOCK)
    local playfieldHasBlock = (self.blocks[y][x] ~= Playfield.EMPTY_BLOCK)

    local overlaps = (playfieldHasBlock and tetrominoHasBlock)
    return overlaps
end


function Playfield:applyScoring()

    local linesCleared = 0
    local lineWidth = self.width

    while true do
        -- process lines from bottom to top
        -- until we find no more filled lines
        -- "-1" dont process wall

        local anyFullLineFound = false

        for r = self.heightWithVanishZone, 1, -1 do
            local blocksFound = 0

            -- "width + 1" without right wall
            for c = 2, self.width + 1 do

                -- no need to check for walls - loops took care of this
                if self.blocks[r][c] ~= Playfield.EMPTY_BLOCK then
                    blocksFound = blocksFound + 1
                end
            end

            -- line is filled when all blocks in a line are not empty

            local currentLineIsFilled = (blocksFound == lineWidth)
            if currentLineIsFilled then
                anyFullLineFound = true
                linesCleared = linesCleared + 1

                self:dropBlocksFromLineUpwards(r)
            end
        end


        -- process playfield until we find no more filled lines
        if anyFullLineFound == false then
            break
        end
    end

    return linesCleared
end

function Playfield:dropBlocksFromLineUpwards(lineNumber)

    -- from selected line to top:
    for r = lineNumber, 1, -1 do

        -- "width + 1" without right wall
        for c = 2, self.width + 1 do

            if r == 1 then
                -- top row = empty it
                self.blocks[r][c] = Playfield.EMPTY_BLOCK
            else
                -- copy blocks to line lower
                self.blocks[r][c] = self.blocks[r - 1][c]
            end
        end
    end
end
