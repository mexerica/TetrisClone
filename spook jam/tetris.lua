function love.load()
    --sound = love.audio.newSource("snd/startup2.mp3", "static"),
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
        {
            {
                {'i', 'i', 'i', ' '},
                {'i', ' ', 'i', ' '},
                {'i', 'i', ' ', ' '},
                {'i', ' ', 'i', ' '},
            },
            {
                {'i', 'i', 'i', 'i'},
                {' ', 'i', ' ', 'i'},
                {'i', ' ', 'i', 'i'},
                {' ', ' ', ' ', ' '},
            },
            {
                {'i', 'i', 'i', ' '},
                {'i', ' ', 'i', ' '},
                {' ', 'i', 'i', ' '},
                {'i', ' ', 'i', ' '},
            },
            {
                {'i', ' ', 'i', 'i'},
                {' ', 'i', ' ', 'i'},
                {'i', 'i', 'i', 'i'},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {'i', ' ', ' ', 'i'},
                {'i', ' ', ' ', 'i'},
                {'i', ' ', ' ', 'i'},
                {'i', 'i', 'i', 'i'},
            },
            {
                {'i', 'i', 'i', 'i'},
                {'i', ' ', ' ', ' '},
                {'i', ' ', ' ', ' '},
                {'i', 'i', 'i', 'i'},
            },
            {
                {'i', 'i', 'i', 'i'},
                {'i', ' ', ' ', 'i'},
                {'i', ' ', ' ', 'i'},
                {'i', ' ', ' ', 'i'},
            },
            {
                {'i', 'i', 'i', 'i'},
                {' ', ' ', ' ', 'i'},
                {' ', ' ', ' ', 'i'},
                {'i', 'i', 'i', 'i'},
            },
        },
        {
            {
                {'i', ' ', ' ', 'i'},
                {'i', 'i', ' ', 'i'},
                {'i', ' ', 'i', 'i'},
                {'i', ' ', ' ', 'i'},
            },
            {
                {'i', 'i', 'i', 'i'},
                {' ', ' ', 'i', ' '},
                {' ', 'i', ' ', ' '},
                {'i', 'i', 'i', 'i'},
            },
        },
    }

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
            table.insert(sequence,position,pieceTypeIndex)
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