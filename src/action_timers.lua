ActionTimers = {
    gravityTimeSinceStart = 0,
    gravityDelay = 0,
    movementTimeSinceStart = 0,
    movementDelay = 0,
    rotationTimeSinceStart = 0,
    rotationDelay = 0,
    softDropTimeSinceStart = 0,
    softDropDelay = 0
}

function ActionTimers:new(speed)
    local actionTimers = {}
    setmetatable(actionTimers, self)
    self.__index = self

    self:changeSpeed(speed)

    return actionTimers
end

function ActionTimers:changeSpeed(speed)
    -- speed 1 => gravityDelay = 1s
    -- speed 5 => gravityDelay = 1/5 = 0.2s
    self.gravityDelay = 1.0 / speed

    self.movementDelay = 1 / 20
    self.rotationDelay = 1 / 5
    self.softDropDelay = 1 / 50
end

function ActionTimers:update(dt)
    self.gravityTimeSinceStart = self.gravityTimeSinceStart + dt
    self.movementTimeSinceStart = self.movementTimeSinceStart + dt
    self.rotationTimeSinceStart = self.rotationTimeSinceStart + dt
    self.softDropTimeSinceStart = self.softDropTimeSinceStart + dt
end

function ActionTimers:canUpdateGravity()
    if self.gravityTimeSinceStart > self.gravityDelay then
        self.gravityTimeSinceStart = 0
        return true
    else
        return false
    end
end

function ActionTimers:forceGravity()
    -- sets gravity timer so that next gravity update check will return true
    if self.gravityTimeSinceStart < self.gravityDelay then
        self.gravityTimeSinceStart = self.gravityDelay
    end
end

function ActionTimers:canPerformMove()
    if self.movementTimeSinceStart > self.movementDelay then
        self.movementTimeSinceStart = 0
        return true
    else
        return false
    end
end

function ActionTimers:canPerformRotation()
    if self.rotationTimeSinceStart > self.rotationDelay then
        self.rotationTimeSinceStart = 0
        return true
    else
        return false
    end
end

function ActionTimers:canPerformSoftDrop()
    if self.softDropTimeSinceStart > self.softDropDelay then
        self.softDropTimeSinceStart = 0
        -- as we have just dropped the tetromino
        -- reset time for automatic tetromino drops (via gravity)
        self.gravityTimeSinceStart = 0
        return true
    else
        return false
    end
end
