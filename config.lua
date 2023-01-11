cfg = {}

cfg.esxInit = 'hypex:getTwojStarySharedTwojaStaraObject'

-- Logs
cfg.Logs = true -- WEBHOOK USTAW W server.lua


-- kit-cooldowns (hours)
cfg.cooldown = 24

cfg.Kits = {

    gracz = {

        { item = "bread", amount=1},
        {item = "water", amount = 1},
        {coins = 1}

    },
    vip = {

        { item = "bread", amount=2},
        {item = "water", amount = 2},
        {coins = 10}

    },
    svip = {

        { item = "bread", amount=3},
        {item = "water", amount = 3},
        {coins = 100}

    },
    legend = {

        { item = "bread", amount=4},
        {item = "water", amount = 4},
        {coins = 1000}

    },

}