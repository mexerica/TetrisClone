game = {
    score = 0,
    lines = 0,
    level = 0,
    my_background = nil
}

function love.load()
    game.my_background = love.graphics.newImage('bg.jpg')
    pieceStructures = {
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', 'i', 'i'},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {' ', 'i', 'i', ' '},
                {' ', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', 'i', ' '},
                {' ', ' ', 'i', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {'i', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'i', ' ', ' ', ' '},
                {'i', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', 'i', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', 'i', ' '},
                {'i', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', ' ', 'i', ' '},
                {'i', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'i', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', 'i', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {' ', 'i', 'i', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {'i', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {'i', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {' ', 'i', 'i', ' '},
                {'i', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'i', ' ', ' ', ' '},
                {'i', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', ' ', ' '},
                {' ', 'i', 'i', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {'i', 'i', ' ', ' '},
                {'i', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
    }

    gridXCount = 10
    gridYCount = 18
    pieceXCount = 4
    pieceYCount = 4
    timerLimit = 0.5

    function canPieceMove(testX, testY, testRotation)
        for y = 1, pieceYCount do
            for x = 1, pieceXCount do
                local testBlockX = testX + x
                local testBlockY = testY + y

                if pieceStructures[pieceType][testRotation][y][x] ~= ' ' and (
                    testBlockX < 1
                    or testBlockX > gridXCount
                    or testBlockY > gridYCount
                    or inert[testBlockY][testBlockX] ~= ' '
                ) then
                    return false
                end
            end
        end

        return true
    end

    function newSequence()
        sequence = {}
        for pieceTypeIndex = 1, #pieceStructures do
            local position = love.math.random(#sequence + 1)
            table.insert(
                sequence,
                position,
                pieceTypeIndex
            )
        end
    end

    function newPiece()
        game.score = game.score + 1
        pieceX = 3
        pieceY = 0
        pieceRotation = 1
        pieceType = table.remove(sequence)
        if #sequence == 0 then newSequence() end
    end

    function reset()
        inert = {}
        for y = 1, gridYCount do
            inert[y] = {}
            for x = 1, gridXCount do inert[y][x] = ' ' end
        end
        newSequence()
        newPiece()
        game.score = 0
        game.lines = 0
        timer = 0
    end
    reset()
end

function findCompleteRows()
    for y = 1, gridYCount do
        local complete = true
        for x = 1, gridXCount do
            if inert[y][x] == ' ' then
                complete = false
                break
            end
        end

        if complete then
            game.score = game.score + 10
            game.lines = game.lines + 1
            for removeY = y, 2, -1 do
                for removeX = 1, gridXCount do inert[removeY][removeX] = inert[removeY - 1][removeX] end
            end
            for removeX = 1, gridXCount do inert[1][removeX] = ' ' end
        end
    end
end

function love.update(dt)
    timer = timer + dt
    -- Removed local timerLimit = 0.5
    if timer >= timerLimit then
        timer = 0

        local testY = pieceY + 1
        if canPieceMove(pieceX, testY, pieceRotation) then
            pieceY = testY
        else
            -- Add piece to inert
            for y = 1, pieceYCount do
                for x = 1, pieceXCount do
                    local block = pieceStructures[pieceType][pieceRotation][y][x]
                    if block ~= ' ' then inert[pieceY + y][pieceX + x] = block end
                end
            end
            findCompleteRows()
            newPiece()
            if not canPieceMove(pieceX, pieceY, pieceRotation) then reset() end
        end
    end
end

function love.keypressed(key)
    if key == 'x' then
        local testRotation = pieceRotation + 1
        if testRotation > #pieceStructures[pieceType] then
            testRotation = 1
        end

        if canPieceMove(pieceX, pieceY, testRotation) then
            pieceRotation = testRotation
        end

    elseif key == 'z' then
        local testRotation = pieceRotation - 1
        if testRotation < 1 then
            testRotation = #pieceStructures[pieceType]
        end

        if canPieceMove(pieceX, pieceY, testRotation) then
            pieceRotation = testRotation
        end

    elseif key == 'left' then
        local testX = pieceX - 1
        if canPieceMove(testX, pieceY, pieceRotation) then
            pieceX = testX
        end

    elseif key == 'right' then
        local testX = pieceX + 1
        if canPieceMove(testX, pieceY, pieceRotation) then
            pieceX = testX
        end

    elseif key == 'c' then
        while canPieceMove(pieceX, pieceY + 1, pieceRotation) do
            pieceY = pieceY + 1
            timer = timerLimit
        end
    end
end

function love.draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(game.my_background)
    love.graphics.setColor(15/255,56/255,15/255)
    love.graphics.print(game.score, 310, 55, 0, 2)
    love.graphics.print(game.lines, 360, 200, 0, 2)
    love.graphics.print(game.level, 360, 138, 0, 2)
    --love.graphics.rectangle('line', 55, 5, 200,360)
    local function drawBlock(block, x, y)
        if (block ~= ' ') then  love.graphics.rectangle('fill', (x - 1) * 20 + 17, (y - 1) * 20 - 94, 19, 19) end
    end

    for y = 1, gridYCount do
        for x = 1, gridXCount do drawBlock(inert[y][x], x + 2, y + 5) end
    end

    for y = 1, pieceYCount do
        for x = 1, pieceXCount do
            local block = pieceStructures[pieceType][pieceRotation][y][x]
            if block ~= ' ' then drawBlock(block, x + pieceX + 2, y + pieceY + 5) end
        end
    end

    for y = 1, pieceYCount do
        for x = 1, pieceXCount do
            local block = pieceStructures[sequence[#sequence]][1][y][x]
            if block ~= ' ' then drawBlock('preview', x + 16, y + 18) end
        end
    end
end