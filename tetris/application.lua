ApplicationState = {}
ApplicationState.INIT = 'INIT'
ApplicationState.MENU = 'MENU'
ApplicationState.PLAYING = 'PLAYING'
ApplicationState.PAUSED = 'PAUSED'
ApplicationState.TERMINATED = 'TERMINATED'

Application = {
    state = ApplicationState.INIT,
    game = nil
}

function Application:new()
    local app = {}
    setmetatable(app, self)
    self.__index = self

    return app
end

function Application:showMenu()
    self.state = ApplicationState.MENU
end

function Application:terminate()
    self.state = ApplicationState.TERMINATED
end

function Application:playGame(game)

    self.game = game
    self.state = ApplicationState.PLAYING
    game:initialize()

    print("Playing")
end

function Application:pauseGame()

    self.state = ApplicationState.PAUSED

    print("Paused")
end

function Application:resumeGame()

    self.state = ApplicationState.PLAYING

    print("Resuming")
end

function Application:endGame()

    self.game = nil
    self.state = ApplicationState.MENU

    print("Ended game")
end

function buildApplication()

    local app = Application:new()
    return app

end

-- INIT -> MENU
---- MENU -> PLAYING
------ PLAYING -> PAUSED
-------- PAUSED -> PLAYING
-------- PAUSED -> MENU
---- MENU -> TERMINATED
