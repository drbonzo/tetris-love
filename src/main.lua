require 'debug_module'
require 'tetromino'
require 'tetrominos'
require 'current_tetromino'
require 'playfield'
require 'action_timers'
require 'tetromino_generator'
require 'scoring'
require 'game'
require 'game_builder'
require 'application'
require 'game_displayer'

local application
local gameDisplayer
local startLevel = 0
local startSpeed = 1

function love.load()

    math.randomseed(os.time())

    application = buildApplication()
    application:showMenu()

    love.graphics.setBackgroundColor(39, 40, 34) --set the background color to a nice blue
    -- width: 4 letters by 5 blocks + 3 letter spacing + 2 for margin = 25
    -- height: 23 block lines + 2 for margin = 25
    love.window.setMode((4 * 5 + 3 + 2) * 20, 25 * 20) --set the window dimensions to 500 x 500

    gameDisplayer = GameDisplayer:new()
end

function love.update(dt)

    application:update(dt)
end

function love.keypressed(key)

    if application.state == ApplicationState.MENU then

        processMainMenu(key)

    elseif application.state == ApplicationState.PLAYING then

        processGame(key)

    elseif application.state == ApplicationState.GAME_OVER then

        processGameOver(key)

    elseif application.state == ApplicationState.PAUSED then

        processPauseMenu(key)

    elseif application.state == ApplicationState.TERMINATED then
        -- nothing
    end
end

function love.quit()
    print("Thanks for playing :)")

    -- false = do quit
    -- true = do not quit
    return false
end

function processMainMenu(key)

    if key == 'q' then

        application:terminate()
        love.event.quit()

    elseif key == 'return' then

        local game = buildGame(startSpeed, startLevel)

        application:playGame(game)

    elseif key == 'l' then

        if love.keyboard.isDown('rshift') or love.keyboard.isDown('lshift') then
            startLevel = startLevel - 1
        else
            startLevel = startLevel + 1
        end

        local gameBuilder = GameBuilder:new()
        startLevel = gameBuilder:checkLevel(startLevel)

    elseif key == 's' then
        if love.keyboard.isDown('rshift') or love.keyboard.isDown('lshift') then
            startSpeed = startSpeed - 1
        else
            startSpeed = startSpeed + 1
        end

        local gameBuilder = GameBuilder:new()
        startSpeed = gameBuilder:checkSpeed(startSpeed)
    end
end

function processPauseMenu(key)

    if key == 'q' then
        application:endGame()
    elseif key == 'p' then
        application:resumeGame()
    end
end

function processGame(key)
    -- local game = application.game
    -- FIXME

    if key == 'p' then
        application:pauseGame()
    end
end

function processGameOver(key)
    if key == 'escape' or key == 'return' then
        application:endGame()
    end
end


function love.draw()

    local game = application.game

    if application.state == ApplicationState.MENU then

        drawMainMenu()

    elseif application.state == ApplicationState.PLAYING then

        drawGame(game)

    elseif application.state == ApplicationState.PAUSED then

        drawPauseMenu()

    elseif application.state == ApplicationState.GAME_OVER then

        drawGameOverScreen(game)

    elseif application.state == ApplicationState.TERMINATED then
        -- nothing
    end
end

function drawMainMenu()

    gameDisplayer:displayMainMenu(startLevel, startSpeed)
end

function drawPauseMenu()

    love.graphics.setColor(255, 255, 255)
    love.graphics.print("(PAUSED)", 10, 40)
    love.graphics.print("un[P]ause", 10, 60)
    love.graphics.print("[Q]uit to Menu", 10, 80)
end

function drawGame(game)
    gameDisplayer:displayGame(game)
end

function drawGameOverScreen(game)
    gameDisplayer:displayGameOverScreen(game)
end

function buildApplication()

    local app = Application:new()
    return app
end

function buildGame(speed, level)

    local gameBuilder = GameBuilder:new()
    local width = 10
    local height = 22
    local game = gameBuilder:buildGame(width, height, speed, level)

    return game
end
