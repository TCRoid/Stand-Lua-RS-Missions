--------------------------------
-- Author: Rostal
--------------------------------

local IS_SUPPORT = true
if menu.get_version().game ~= "1.68-3095" then
    IS_SUPPORT = false
    util.toast("Not support current game version.")
end

-- util.require_natives("3095a", "init")

local NET_GAMESERVER_GET_PRICE = function(itemHash, categoryHash, p2) return native_invoker.unified_int(itemHash, categoryHash, p2, 0xC27009422FCCA88D, "iib") end

local function global_set_int(global, value)
    memory.write_int(memory.script_global(global), value)
end

local function global_get_int(global)
    return memory.read_int(memory.script_global(global))
end

local function draw_text(text)
    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end

local function toast(text)
    util.toast(text, TOAST_ALL)
end


local NET_SHOP_INVALID_ID <const> = 2147483647

local categoryHash <const> = util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD")

local g_cashTransactionDataCached <const> = 4537212 -- index = 0



local menuRoot <const> = menu.my_root()

menu.divider(menuRoot, "SHOP_TRANSACTION_RETRY_SYSTEM")

local eTransactionService = util.joaat("SERVICE_EARN_BEND_JOB")
local iCost = 10000

menu.list_action(menuRoot, "Transaction Service", {}, "", {
    { util.joaat("SERVICE_EARN_BEND_JOB"), "SERVICE_EARN_BEND_JOB", {}, "Max: 15M" },
}, function(value)
    eTransactionService = value
end)

local menuCost = menu.slider(menuRoot, "Cost", { "RSCash" }, "",
    -1, 15000000, -1, 10000, function(value)
        iCost = value
    end)
menu.add_value_replacement(menuCost, -1, "Max")


menu.action(menuRoot, "Trigger Transaction Retry", {}, "", function()
    if not IS_SUPPORT then
        return
    end

    if iCost == -1 then
        iCost = NET_GAMESERVER_GET_PRICE(eTransactionService, categoryHash, true)
    end


    -- g_cashTransactionDataCached[index].iTransactionId
    global_set_int(g_cashTransactionDataCached + 1 + 0, NET_SHOP_INVALID_ID - 1)

    -- g_cashTransactionDataCached[index].iTransactionTetherID
    global_set_int(g_cashTransactionDataCached + 1 + 6, NET_SHOP_INVALID_ID)

    -- g_cashTransactionDataCached[index].iTimedRetryAttempts
    global_set_int(g_cashTransactionDataCached + 1 + 5, 0)

    -- g_cashTransactionDataCached[index].retryTimeStamp
    global_set_int(g_cashTransactionDataCached + 1 + 4, 0)

    -- g_cashTransactionDataCached[index].eTransactionCategory
    global_set_int(g_cashTransactionDataCached + 1 + 3, categoryHash)

    -- g_cashTransactionDataCached[index].eTransactionService
    global_set_int(g_cashTransactionDataCached + 1 + 2, eTransactionService)

    -- g_cashTransactionDataCached[index].iCost
    global_set_int(g_cashTransactionDataCached + 1 + 1, iCost)

    -- g_cashTransactionDataCached
    global_set_int(g_cashTransactionDataCached, 1) -- iNumTransactions
end)

menu.action(menuRoot, "Reset Trigger Transaction Retry Data", {}, "", function()
    if not IS_SUPPORT then
        return
    end

    -- g_cashTransactionDataCached[index].iTransactionId
    global_set_int(g_cashTransactionDataCached + 1 + 0, NET_SHOP_INVALID_ID)

    -- g_cashTransactionDataCached[index].iTransactionTetherID
    global_set_int(g_cashTransactionDataCached + 1 + 6, NET_SHOP_INVALID_ID)

    -- g_cashTransactionDataCached[index].iTimedRetryAttempts
    global_set_int(g_cashTransactionDataCached + 1 + 5, 0)

    -- g_cashTransactionDataCached[index].retryTimeStamp
    global_set_int(g_cashTransactionDataCached + 1 + 4, 0)

    -- g_cashTransactionDataCached[index].eTransactionCategory
    global_set_int(g_cashTransactionDataCached + 1 + 3, 0)

    -- g_cashTransactionDataCached[index].eTransactionService
    global_set_int(g_cashTransactionDataCached + 1 + 2, 0)

    -- g_cashTransactionDataCached[index].iCost
    global_set_int(g_cashTransactionDataCached + 1 + 1, 0)

    -- g_cashTransactionDataCached
    global_set_int(g_cashTransactionDataCached, 16) -- iNumTransactions
end)



menu.divider(menuRoot, "")

menu.toggle_loop(menuRoot, "Show Info", {}, "", function()
    if not IS_SUPPORT then
        return
    end

    local text = string.format(
        "iNumTransactions: %s\niTransactionId: %s\niCost: %s\neTransactionService: %s\neTransactionCategory: %s\nretryTimeStamp: %s\niTimedRetryAttempts: %s\niTransactionTetherID: %s",
        global_get_int(g_cashTransactionDataCached),
        global_get_int(g_cashTransactionDataCached + 1 + 0),
        global_get_int(g_cashTransactionDataCached + 1 + 1),
        global_get_int(g_cashTransactionDataCached + 1 + 2),
        global_get_int(g_cashTransactionDataCached + 1 + 3),
        global_get_int(g_cashTransactionDataCached + 1 + 4),
        global_get_int(g_cashTransactionDataCached + 1 + 5),
        global_get_int(g_cashTransactionDataCached + 1 + 6)
    )
    draw_text(text)
end)

menu.action(menuRoot, "NET_GAMESERVER_GET_PRICE", {}, "", function()
    local list = {
        "SERVICE_EARN_JOBS",

        "SERVICE_EARN_ISLAND_HEIST_FINALE",
        "SERVICE_EARN_TUNER_ROBBERY_FINALE",
        "SERVICE_EARN_AGENCY_STORY_FINALE",
        "SERVICE_EARN_MUSIC_STUDIO_SHORT_TRIP",
        "SERVICE_EARN_JUGGALO_STORY_MISSION",
        "SERVICE_EARN_AVENGER_OPERATIONS",
        "SERVICE_EARN_CHICKEN_FACTORY_RAID_PREP",
        "SERVICE_EARN_CHICKEN_FACTORY_RAID_FINALE",

        "SERVICE_EARN_BEND_JOB",
        "SERVICE_EARN_GANGOPS_FINALE",
        "SERVICE_EARN_GANGOPS_SETUP",
        "SERVICE_EARN_CASINO_STORY_MISSION_REWARD",
        "SERVICE_EARN_CASINO_HEIST_FINALE",
        "SERVICE_EARN_ARENA_WAR",
    }

    local text = ""

    for _, item in pairs(list) do
        local itemHash = util.joaat(item)
        local price = NET_GAMESERVER_GET_PRICE(itemHash, categoryHash, true)

        text = text .. item .. ": " .. price .. "\n"
    end

    toast(text)
end)
