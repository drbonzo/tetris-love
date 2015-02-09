Tetrominos = {
    t1 = nil,
    t2 = nil,
    t3 = nil,
    t4 = nil,
    t5 = nil,
    t6 = nil,
    t7 = nil
}

function Tetrominos:buildTetrominos()
    local tetrominos = {}
    setmetatable(tetrominos, self)
    self.__index = self

    local tetromino = nil
    local tetrominoId = 0

    local fileLines = io.lines("resources/tetrominos.txt")

    -- line of tetromino
    local lineNumber = 0

    -- whether block ad given point is filled or not
    local pixel = false


	for line in fileLines do 

        if line == "tetromino" then

            -- create Tetromino...
            tetromino = Tetromino:new()
            -- ... and read it's ID
            tetrominoId = tonumber(fileLines())
            lineNumber = 1

        elseif line == "end" then

            -- store completed tetronimo
            tetrominos:set(tetrominoId, tetromino)

            tetromino = nil
            tetrominoId = 0

        elseif string.len(line) == 19 then

            c = 1
            local rot = 0
            local col = 0
            while c <= 19 do

                -- rotation index: 1..4
                -- as each rotation takes 5 columns (4 with blocks, one separator)
                -- example:
                -- ____ __X_ ____ _X__
                -- XXXX __X_ ____ _X__
                -- ____ __X_ XXXX _X__
                -- ____ __X_ ____ _X__

                rot = math.floor(c/5) + 1
                --  1  2  3  4  5 - number of character -> rotation index
                --  6  7  8  9 10
                -- 11 12 13 14 15
                -- 16 17 18 19 XX

                -- col is 0 indexed
                col = (c - 1) % 5

                if col < 4 then -- skip separators which come in 5th column, at index 4
                    pixel = (string.sub(line,c,c) == 'X')
                    -- print("rot: " .. rot .. " line: " .. lineNumber .. " c: " .. c )
                    if pixel then
                        -- col + 1 - change from 0-indexed to 1-indexed
                        tetromino.blocks[rot][lineNumber][col+1] = tetrominoId -- mark pixels in color of the tetromino
                    end

                end

                -- next character in line
                c = c + 1 
            end

            lineNumber = lineNumber + 1

        end
	end

    return tetrominos
end

function Tetrominos:set(index, tetrominoBlocks)
    self['t' .. index] = tetrominoBlocks
end

function Tetrominos:get(index)
    return self['t' .. index]
end


function Tetrominos:printTetromino(tetromino)
    for rot = 1, 4 do
        print("Rotation: " .. rot)
        for r = 1,4 do
            print(tetromino.blocks[rot][r][1] .. tetromino.blocks[rot][r][2] .. tetromino.blocks[rot][r][3] .. tetromino.blocks[rot][r][4])
        end
    end
end
