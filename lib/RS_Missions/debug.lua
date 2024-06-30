local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "DEBUG")

local Freemode_Mission = Menu_Root
local Heist_Mission = Menu_Root


local LocalsTest = {
    ["fm_content_vehrob_arena"] = {
        iChallengeCondition = 7807 + 1342 + 14,
        iChallengeBitset = 7807 + 1340,

        eEndReason = 7807 + 1285,
        iGenericBitset = 7748
    },
    ["fm_content_vehrob_cargo_ship"] = {
        iChallengeBitset = 7025 + 1286,

        eEndReason = 7025 + 1224,
        iGenericBitset = 6934
    },
    ["fm_content_vehrob_casino_prize"] = {
        iChallengeBitset = 9060 + 1310,

        eEndReason = 9060 + 1231,
        iGenericBitset = 8979
    },
    ["fm_content_vehrob_police"] = {
        iChallengeCondition = 8847 + 1333 + 8 + 1, -- +[0~2]

        eEndReason = 8847 + 1276,
        iGenericBitset = 8772
    },
    ["fm_content_vehrob_submarine"] = {
        iChallengeCondition = 6125 + 1199 + 19,
        iChallengeBitset = 6125 + 1196,

        eEndReason = 6125 + 1137,
        iGenericBitset = 6041
    },
    ["fm_content_chop_shop_delivery"] = {
        iMissionEntityBitSet = 1893 + 2 + 14,

        eEndReason = 1893 + 137,
        iGenericBitset = 1835
    }
}


------------------------------------
--    Salvage Yard Robbery
------------------------------------

local Salvage_Yard_Robbery <const> = menu.list(Freemode_Mission, get_label_text("SCOUT_BIG_START"), {}, "")

local SalvageYardRobberyVars = {
    challengeCompleted = true
}

local SalvageYardRobberyChallenge = {
    ["fm_content_vehrob_arena"] = function(script)
        LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition, 100)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 17, 18)
    end,
    ["fm_content_vehrob_cargo_ship"] = function(script)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 31)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 1, 0, 1) -- 32, 33
    end,
    ["fm_content_vehrob_casino_prize"] = function(script)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 24, 25, 26)
    end,
    ["fm_content_vehrob_police"] = function(script)
        for i = 0, 2 do
            LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition + i, 1)
        end
    end,
    ["fm_content_vehrob_submarine"] = function(script)
        LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition, 100)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 1, 9, 10) -- 41, 42
    end
}

menu.action(Salvage_Yard_Robbery, "直接完成 回收站抢劫 前置任务", {}, "", function()
    local data = {
        ["fm_content_vehrob_scoping"] = {
            eEndReason = 3752 + 508,
            iGenericBitset = 3695
        },
        ["fm_content_vehrob_prep"] = {
            eEndReason = 11366 + 1272,
            iGenericBitset = 11265
        },
        ["fm_content_vehrob_task"] = {
            eEndReason = 4773 + 1043,
            iGenericBitset = 4705
        },
        ["fm_content_vehrob_disrupt"] = {
            eEndReason = 4570 + 924,
            iGenericBitset = 4511
        }
    }

    for script, item in pairs(data) do
        if IS_SCRIPT_RUNNING(script) then
            LOCAL_SET_BIT(script, item.iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(script, item.eEndReason, 3)
        end
    end
end)

menu.toggle(Salvage_Yard_Robbery, get_label_text("SAL23_ENDS_CHAL"), {}, "", function(toggle)
    SalvageYardRobberyVars.challengeCompleted = toggle
end, true)

menu.action(Salvage_Yard_Robbery, "直接完成 回收站抢劫 终章", {}, "", function()
    for script, func in pairs(SalvageYardRobberyChallenge) do
        if IS_SCRIPT_RUNNING(script) then
            if SalvageYardRobberyVars.challengeCompleted then
                func(script)
            end

            LOCAL_SET_BIT(script, LocalsTest[script].iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(script, LocalsTest[script].eEndReason, 3)
        end
    end
end)


menu.divider(Salvage_Yard_Robbery, "Sell")

menu.action(Salvage_Yard_Robbery, "直接完成 出售任务", {}, "", function()
    local script = "fm_content_chop_shop_delivery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end

    local iMissionEntity = 0
    LOCAL_SET_BIT(script, LocalsTest[script].iMissionEntityBitSet + 1 + iMissionEntity * 3 + 1 + 0, 4) -- eMISSIONENTITYBITSET_DELIVERED

    LOCAL_SET_BIT(script, LocalsTest[script].iGenericBitset + 1 + 0, 11)
    LOCAL_SET_INT(script, LocalsTest[script].eEndReason, 3)
end)




----------------------------------------
--    Bail Office
----------------------------------------

local Bail_Office <const> = menu.list(Heist_Mission, get_label_text("CELL_BAIL_OF"), {}, "")

menu.list_action(Bail_Office, "启动差事: 头号通缉犯", {}, "", {
    { -1814367299, "头号通缉犯：惠特尼" },
    { -1443228923, "头号通缉犯：里伯曼" },
    { -625494467, "头号通缉犯：奥尼尔" },
    { -1381858108, "头号通缉犯：汤普森" },
    { 1585225527, "头号通缉犯：宋" },
    { -62594295, "头号通缉犯：加西亚" },
}, function(value)
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    local Data = {
        iRootContentID = value,
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 32, -- ciMISSION_ENTERY_TYPE_V2_CORONA
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)







local fm_content_xxx = {
    { script = "fm_content_acid_lab_sell",       eEndReason = 5483 + 1294,  iGenericBitset = 5418 },
    { script = "fm_content_acid_lab_setup",      eEndReason = 3348 + 541,   iGenericBitset = 3294 },
    { script = "fm_content_acid_lab_source",     eEndReason = 7654 + 1162,  iGenericBitset = 7577 },
    { script = "fm_content_ammunation",          eEndReason = 2079 + 204,   iGenericBitset = 2025 },
    { script = "fm_content_armoured_truck",      eEndReason = 1902 + 113,   iGenericBitset = 1836 },
    { script = "fm_content_auto_shop_delivery",  eEndReason = 1572 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_bank_shootout",       eEndReason = 2209 + 221,   iGenericBitset = 2138 },
    { script = "fm_content_bar_resupply",        eEndReason = 2275 + 287,   iGenericBitset = 2219 },
    { script = "fm_content_bicycle_time_trial",  eEndReason = 2942 + 83,    iGenericBitset = 2886 },
    { script = "fm_content_bike_shop_delivery",  eEndReason = 1574 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_bounty_targets",      eEndReason = 7019 + 1251,  iGenericBitset = 6941 },
    { script = "fm_content_business_battles",    eEndReason = 5257 + 1138,  iGenericBitset = 5186 },
    { script = "fm_content_cargo",               eEndReason = 5830 + 1148,  iGenericBitset = 5761 },
    { script = "fm_content_cerberus",            eEndReason = 1589 + 91,    iGenericBitset = 1539 },
    { script = "fm_content_chop_shop_delivery",  eEndReason = 1893 + 137,   iGenericBitset = 1835 },
    { script = "fm_content_clubhouse_contracts", eEndReason = 6639 + 1255,  iGenericBitset = 6573 },
    { script = "fm_content_club_management",     eEndReason = 5207 + 775,   iGenericBitset = 5148 },
    { script = "fm_content_club_odd_jobs",       eEndReason = 1794 + 83,    iGenericBitset = 1738 },
    { script = "fm_content_club_source",         eEndReason = 3540 + 674,   iGenericBitset = 3467 },
    { script = "fm_content_convoy",              eEndReason = 2736 + 437,   iGenericBitset = 2672 },
    { script = "fm_content_crime_scene",         eEndReason = 1948 + 151,   iGenericBitset = 1892 },
    { script = "fm_content_daily_bounty",        eEndReason = 2533 + 325,   iGenericBitset = 2480 },
    { script = "fm_content_dispatch_work",       eEndReason = 4856 + 755,   iGenericBitset = 4797 },
    { script = "fm_content_drug_lab_work",       eEndReason = 7884 + 1253,  iGenericBitset = 7820 },
    { script = "fm_content_drug_vehicle",        eEndReason = 1762 + 115,   iGenericBitset = 1707 },
    { script = "fm_content_export_cargo",        eEndReason = 2200 + 191,   iGenericBitset = 2146 },
    { script = "fm_content_ghosthunt",           eEndReason = 1552 + 88,    iGenericBitset = 1499 },
    { script = "fm_content_golden_gun",          eEndReason = 1762 + 93,    iGenericBitset = 1711 },
    { script = "fm_content_gunrunning",          eEndReason = 5639 + 1237,  iGenericBitset = 5566 },
    { script = "fm_content_island_dj",           eEndReason = 3451 + 495,   iGenericBitset = 3374 },
    { script = "fm_content_island_heist",        eEndReason = 13311 + 1339, iGenericBitset = 13220 },
    { script = "fm_content_metal_detector",      eEndReason = 1810 + 93,    iGenericBitset = 1757 },
    { script = "fm_content_movie_props",         eEndReason = 1888 + 137,   iGenericBitset = 1833 },
    { script = "fm_content_parachuter",          eEndReason = 1568 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_payphone_hit",        eEndReason = 5675 + 683,   iGenericBitset = 5616 },
    { script = "fm_content_phantom_car",         eEndReason = 1577 + 83,    iGenericBitset = 1527 },
    { script = "fm_content_pizza_delivery",      eEndReason = 1704 + 83,    iGenericBitset = 1648 },
    { script = "fm_content_possessed_animals",   eEndReason = 1593 + 83,    iGenericBitset = 1541 },
    { script = "fm_content_robbery",             eEndReason = 1732 + 87,    iGenericBitset = 1666 },
    { script = "fm_content_security_contract",   eEndReason = 7136 + 1278,  iGenericBitset = 7058 },
    { script = "fm_content_sightseeing",         eEndReason = 1822 + 84,    iGenericBitset = 1770 },
    { script = "fm_content_skydive",             eEndReason = 3010 + 93,    iGenericBitset = 2953 },
    { script = "fm_content_slasher",             eEndReason = 1597 + 83,    iGenericBitset = 1545 },
    { script = "fm_content_smuggler_ops",        eEndReason = 7600 + 1270,  iGenericBitset = 7523 },
    { script = "fm_content_smuggler_plane",      eEndReason = 1838 + 178,   iGenericBitset = 1771 },
    { script = "fm_content_smuggler_resupply",   eEndReason = 6045 + 1271,  iGenericBitset = 5966 },
    { script = "fm_content_smuggler_sell",       eEndReason = 4015 + 489,   iGenericBitset = 3880 },
    { script = "fm_content_smuggler_trail",      eEndReason = 2051 + 130,   iGenericBitset = 1980 },
    { script = "fm_content_source_research",     eEndReason = 4318 + 1195,  iGenericBitset = 4261 },
    { script = "fm_content_stash_house",         eEndReason = 3521 + 475,   iGenericBitset = 3467 },
    { script = "fm_content_taxi_driver",         eEndReason = 1993 + 83,    iGenericBitset = 1941 },
    { script = "fm_content_tow_truck_work",      eEndReason = 1755 + 91,    iGenericBitset = 1702 },
    { script = "fm_content_tuner_robbery",       eEndReason = 7313 + 1194,  iGenericBitset = 7226 },
    { script = "fm_content_ufo_abduction",       eEndReason = 2858 + 334,   iGenericBitset = 2792 },
    { script = "fm_content_vehicle_list",        eEndReason = 1568 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_vehrob_arena",        eEndReason = 7807 + 1285,  iGenericBitset = 7748 },
    { script = "fm_content_vehrob_cargo_ship",   eEndReason = 7025 + 1224,  iGenericBitset = 6934 },
    { script = "fm_content_vehrob_casino_prize", eEndReason = 9060 + 1231,  iGenericBitset = 8979 },
    { script = "fm_content_vehrob_disrupt",      eEndReason = 4570 + 924,   iGenericBitset = 4511 },
    { script = "fm_content_vehrob_police",       eEndReason = 8847 + 1276,  iGenericBitset = 8772 },
    { script = "fm_content_vehrob_prep",         eEndReason = 11366 + 1272, iGenericBitset = 11265 },
    { script = "fm_content_vehrob_scoping",      eEndReason = 3752 + 508,   iGenericBitset = 3695 },
    { script = "fm_content_vehrob_submarine",    eEndReason = 6125 + 1137,  iGenericBitset = 6041 },
    { script = "fm_content_vehrob_task",         eEndReason = 4773 + 1043,  iGenericBitset = 4705 },
    { script = "fm_content_vip_contract_1",      eEndReason = 8692 + 1157,  iGenericBitset = 8619 },
    { script = "fm_content_xmas_mugger",         eEndReason = 1620 + 83,    iGenericBitset = 1568 },
    { script = "fm_content_xmas_truck",          eEndReason = 1461 + 91,    iGenericBitset = 1409 },
}
menu.action(Menu_Root, "Complete fm_content_xxx Mission", {}, "", function()
    for _, item in pairs(fm_content_xxx) do
        if IS_SCRIPT_RUNNING(item.script) then
            LOCAL_SET_BIT(item.script, item.iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(item.script, item.eEndReason, 3)

            util.toast(item.script, TOAST_ALL)
        end
    end
end)







----------------------------------------
--    Instant Finish Test
----------------------------------------

local Instant_Finish_Test <const> = menu.list(Menu_Root, "Instant Finish Test", {}, "")


menu.divider(Instant_Finish_Test, "fm_content Mission")

local TestScript1 = "fm_content_bicycle_time_trial"

menu.toggle_loop(Instant_Finish_Test, "Show Local Info", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local iLocalPart = LOCAL_GET_INT(script, 3427)

    local text = string.format(
        "PARTICIPANT_ID_TO_INT: %s\nLOCAL_PARTICIPANT_INDEX_AS_INT: %s\niGoodsToTransfer: %s",
        NETWORK.PARTICIPANT_ID_TO_INT(),
        iLocalPart,
        LOCAL_GET_INT(script, 4267 + 1 + iLocalPart * 125 + 73)
    )

    draw_text(text)
end)


menu.action(Instant_Finish_Test, "SET_MISSION_ENTITY_BIT", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local eBitset = 1
    local iVar0 = math.floor(eBitset / 32) -- iBitSet
    local iVar1 = math.floor(eBitset % 32) -- iBitVal
    util.toast(string.format("iVar0: %s, iVar1: %s", iVar0, iVar1))

    local iMissionEntity = 0
    local address = memory.script_local(script, 2310 + 31 + 1 + iMissionEntity * 42 + 11 + 1 + iVar0)
    MISC.SET_BIT(address, iVar1)
end)

menu.action(Instant_Finish_Test, "Set Local Variations", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local iLocalPart = LOCAL_GET_INT(script, 3427)
    LOCAL_SET_INT(script, 4267 + 1 + iLocalPart * 125 + 73, 1)
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    -- SET_GAME_STATE(eGAMESTATE_END)
    LOCAL_SET_INT(script, 1543 + 82, 3)
end)
menu.action(Instant_Finish_Test, "Test Complete fm_content", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    LOCAL_SET_BIT(script, 2873 + 1 + 0, 0)

    LOCAL_SET_BIT(script, 2860 + 1 + 0, 11) -- SET_GENERIC_BIT(eGENERICBITSET_I_WON)
    -- LOCAL_SET_INT(script, 2913 + 83, 3)     -- SET_END_REASON(eENDREASON_MISSION_PASSED)
end)



menu.divider(Instant_Finish_Test, "gb Mission")

local TestScript2 = "gb_vehicle_export"

local TestSelectMission2 = 13
menu.slider(Instant_Finish_Test, "Select Mission", { "TestSelectMission2" }, "",
    0, 99, 0, 1, function(value)
        TestSelectMission2 = value
    end)
menu.toggle_loop(Instant_Finish_Test, "Set Select Mission", {}, "", function()
    local script = TestScript2
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 9, TestSelectMission2)
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 459, 14) -- SET_MODE_STATE(eMODESTATE_END)
end)

menu.action(Instant_Finish_Test, "Test Complete Vehicle Export", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- LOCAL_SET_INT(script, 388 + 1, 1)

    -- SET_EXPORT_ENTITY_BIT(iExportEntity,
    -- eEXPORTENTITYBITSET_DELIVERED, eEXPORTENTITYBITSET_FADED_OUT_FOR_DELIVERY, eEXPORTENTITYBITSET_DELIVERED_BY_KEY_ORGINISATION
    LOCAL_SET_BITS(script, 834 + 48 + 1 + 0 * 2 + 1 + 0, 6, 16, 18)


    LOCAL_SET_INT(script, 834 + 460, 4)  -- SET_END_REASON(eENDREASON_EXPORT_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, 834 + 459, 13) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)









----------------------------------------
--    Freemode Test
----------------------------------------


local Freemode_Test <const> = menu.list(Menu_Root, "Freemode Test", {}, "")

menu.toggle_loop(Freemode_Test, "Show Local Info", {}, "", function()
    local script = "tuner_property_carmod"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local text = string.format(
        "iCarmodSlot: %s",
        LOCAL_GET_INT(script, 733 + 679)
    )

    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show Global Info", {}, "", function()
    local iWarehouseStagger = GLOBAL_GET_INT(1882389 + 3)
    local iWarehouse = GLOBAL_GET_INT(1845263 + 1 + players.user() * 877 + 267 + 118 + 1 + iWarehouseStagger * 3)

    local text = string.format(
        "iWarehouseStagger: %s\niWarehouse: %s",
        iWarehouseStagger, iWarehouse
    )

    draw_text(text)
end)



menu.action(Freemode_Test, "切换战局 到 虎鲸", {}, "", function()
    -- MP_SETTING_SPAWN_SUBMARINE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 16)

    menu.trigger_commands("go inviteonly")
end)





menu.divider(Freemode_Test, "")
menu.action(Freemode_Test, "iMaterialsTotal = 0", {}, "", function()
    local pid = players.user()
    for i = 0, 6 do
        GLOBAL_SET_INT(1845263 + 1 + pid * 877 + 267 + 195 + 1 + i * 13 + 2, 0)
    end
end)
menu.action(Freemode_Test, "iProductTotal = 100", {}, "", function()
    local pid = players.user()
    for i = 0, 6 do
        GLOBAL_SET_INT(1845263 + 1 + pid * 877 + 267 + 195 + 1 + i * 13 + 1, 100)
    end
end)












----------------------------------------
--    Start Mission Test
----------------------------------------

local Test_Start_Mission <const> = menu.list(Menu_Root, "Start Mission Test", {}, "")

menu.toggle_loop(Test_Start_Mission, "Show Global Info", {}, "", function()
    local text = string.format(
        "%s",
        "-1"
    )

    draw_text(text)
end)

menu.divider(Test_Start_Mission, "Freemode Mission")

menu.click_slider(Test_Start_Mission, "Request FMMC_TYPE Mission", { "fmmcReq" }, "", 0, 310, 0, 1, function(value)
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(value)
end)
menu.click_slider(Test_Start_Mission, "Start FMMC_TYPE Mission", { "fmmcStart" }, "", 0, 310, 0, 1, function(value)
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(value)
end)


menu.divider(Test_Start_Mission, "Job")

local TestStartRootContentID = menu.text_input(Test_Start_Mission, "Root Content ID (Hash)",
    { "rs_StartRootContentID" }, "", function(value) end)

menu.action(Test_Start_Mission, "Launch Mission", {}, "", function()
    local value = menu.get_value(TestStartRootContentID)
    if value == "" then
        return
    end
    if tonumber(value) == nil then
        value = util.joaat(value)
    end

    util.toast(value)

    local Data = {
        iRootContentID = tonumber(value),
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 32, -- ciMISSION_ENTERY_TYPE_V2_CORONA
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)


menu.divider(Test_Start_Mission, "Terminate Script")

local TestTerminateScript = menu.text_input(Test_Start_Mission, "Script Name",
    { "rs_TerminateScript" }, "", function(value) end)
menu.action(Test_Start_Mission, "TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME", {}, "", function()
    local value = menu.get_value(TestTerminateScript)
    if value == "" then
        return
    end

    MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME(value)
end)







----------------------------------------
--    Job Mission Test
----------------------------------------

local Job_Mission_Test <const> = menu.list(Menu_Root, "Job Mission Test", {}, "")


menu.toggle_loop(Job_Mission_Test, "Show g_FMMC_STRUCT Info", {}, "", function()
    local iRootContentID = GLOBAL_GET_INT(4718592 + 126144)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)

    local text = string.format(
        "MissionName: %s, iRootContentIDHash: %s, iArrayPos: %s\niMissionType: %s, iMissionSubType: %s, tl23NextContentID[0]: %s\niMinNumberOfTeams: %s, iMaxNumberOfTeams: %s, iNumberOfTeams: %s\niMinNumParticipants: %s, iNumParticipants: %s\niNumPlayersPerTeam[]: %s, %s, %s, %s\niCriticalMinimumForTeam[]: %s, %s, %s, %s\niCriticalMinimumForRole[1]: %s, %s, %s, %s\niCriticalMinimumForRole[2]: %s, %s, %s, %s\niMissionEndType: %s, iTargetScore: %s, iMissionTargetScore[]: %s, %s, %s, %s\niMyTeam: %s, iTeamChosen: %s",
        GLOBAL_GET_STRING(4718592 + 126151),
        iRootContentID,
        iArrayPos,

        GLOBAL_GET_INT(4718592 + 0),
        GLOBAL_GET_INT(4718592 + 2),
        GLOBAL_GET_STRING(4718592 + 126459 + 1 + 0 * 6), -- tl23NextContentID

        GLOBAL_GET_INT(4718592 + 3254),
        GLOBAL_GET_INT(4718592 + 3253),
        GLOBAL_GET_INT(4718592 + 3252), -- iNumberOfTeams

        GLOBAL_GET_INT(4718592 + 3249),
        GLOBAL_GET_INT(4718592 + 3248),     -- iNumParticipants

        GLOBAL_GET_INT(4718592 + 3255 + 1), -- iNumPlayersPerTeam
        GLOBAL_GET_INT(4718592 + 3255 + 2),
        GLOBAL_GET_INT(4718592 + 3255 + 3),
        GLOBAL_GET_INT(4718592 + 3255 + 4),

        GLOBAL_GET_INT(4718592 + 176675 + 1), -- iCriticalMinimumForTeam
        GLOBAL_GET_INT(4718592 + 176675 + 2),
        GLOBAL_GET_INT(4718592 + 176675 + 3),
        GLOBAL_GET_INT(4718592 + 176675 + 4),

        -- g_FMMC_STRUCT.iCriticalMinimumForRole[iTeam][iRole]
        -- Global_4718592.f_176680[bVar27 /*5*/][iVar28]
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 0), -- iCriticalMinimumForRole[1]
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 1),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 2),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 3),

        GLOBAL_GET_INT(4718592 + 176680 + 1 + 1 * 5 + 1 + 0), -- iCriticalMinimumForRole[2]
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 2 * 5 + 1 + 1),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 3 * 5 + 1 + 2),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 4 * 5 + 1 + 3),

        GLOBAL_GET_INT(4718592 + 3274),
        GLOBAL_GET_INT(4718592 + 3276),
        -- g_FMMC_STRUCT.sFMMCEndConditions[iteamrepeat].iMissionTargetScore Global_4718592.f_3318[iVar0 /*25763*/].f_59
        GLOBAL_GET_INT(4718592 + 3318 + 1 + 0 * 25763 + 59),
        GLOBAL_GET_INT(4718592 + 3318 + 1 + 1 * 25763 + 59),
        GLOBAL_GET_INT(4718592 + 3318 + 1 + 2 * 25763 + 59),
        GLOBAL_GET_INT(4718592 + 3318 + 1 + 3 * 25763 + 59),

        GLOBAL_GET_INT(4718592 + 3286),
        GLOBAL_GET_INT(1845263 + 1 + players.user() * 877 + 96 + 28)
    )

    -- util.log(text)
    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "最小玩家数为1", {}, "强制任务单人可开", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iArrayPos = LOCAL_GET_INT(script, LaunchMissionDetails.iMissionVariation)
    if iArrayPos == 0 then
        return
    end

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMinPlayers
    if GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69) > 1 then
        GLOBAL_SET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69, 1)
        LOCAL_SET_INT(script, LaunchMissionDetails.iMinPlayers, 1)
    end

    GLOBAL_SET_INT(FMMC_STRUCT.iMinNumParticipants, 1)
    for i = 0, 3 do
        GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam + i, 1)
        GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam + i, 0)
    end
end)

local SetMissionMaxTeams2 = menu.toggle_loop(Job_Mission_Test, "最大团队数为1", {}, "用于多团队任务", function()
    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, 1)
end)

menu.click_slider(Job_Mission_Test, "设置最大团队数", {}, "", 1, 4, 2, 1, function(value)
    menu.set_value(SetMissionMaxTeams2, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, value)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, value)
end)

menu.action(Job_Mission_Test, "Mission Over", { "MissionOver" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    LOCAL_SET_BIT(script, Locals[script].iServerBitSet, 16)
end)






menu.divider(Job_Mission_Test, "fmmc_launcher")

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    local text = string.format(
        "iPlayerOrder: %s\nsHeistRoles.ePlayerRoles: %s\nbLaunchTimerExpired: %s\nsClientCoronaData.iClientSyncID: %s",
        GLOBAL_GET_INT(1928233 + 12 + 1 + 0),                        -- GlobalServerBD_HeistPlanning.iPlayerOrder[index]
        GLOBAL_GET_INT(1928233 + 7 + 1 + 0),                         -- GlobalServerBD_HeistPlanning.sHeistRoles.ePlayerRoles[index]
        GLOBAL_GET_INT(1930201 + 2812),                              -- g_HeistPlanningClient.bLaunchTimerExpired
        GLOBAL_GET_INT(1845263 + 1 + players.user() * 877 + 96 + 31) -- GlobalplayerBD_FM[iMyGBD].sClientCoronaData.iClientSyncID
    )

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- sLaunchMissionDetails.iMissionVariation Local_19331.f_34
    -- sLaunchMissionDetails.iMinPlayers Local_19331.f_15

    local coronaMenuData = 17208

    local pid = players.user()

    local text = string.format(
        "iMissionVariation: %s, iMinPlayers: %s\ncoronaClientSyncData[iPlayer].iClientSyncID: %s\ncoronaClientSyncData[iPlayer].bVoted: %s",
        LOCAL_GET_INT(script, 19331 + 34),
        LOCAL_GET_INT(script, 19331 + 15),

        LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2),
        LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2 + 1)
    )

    draw_text(text)
end)


TestPlayerSelect = menu.list_select(Job_Mission_Test, "Select Player", {}, "", {
    { -1, "Refresh Player List" }
}, -1, function(value)
    if value == -1 then
        local list_item = { { -1, "Refresh Player List" } }
        for _, pid in pairs(players.list()) do
            table.insert(list_item, { pid, players.get_name(pid) })
        end
        menu.set_list_action_options(TestPlayerSelect, list_item)
        util.toast("Refreshed")
        return
    end
end)
menu.toggle_loop(Job_Mission_Test, "Show Selectd Player Info", {}, "", function()
    local pid = menu.get_value(TestPlayerSelect)
    if pid == -1 or not players.exists(pid) then
        return
    end
    local player_name = players.get_name(pid)

    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local coronaMenuData = 17208

    local text = string.format(
        "%s\n\nbHasPlayerVoted: %s\nsClientCoronaData.iClientSyncID: %s\n\ncoronaClientSyncData[iPlayer].bVoted: %s\ncoronaClientSyncData[iPlayer].iClientSyncID: %s",
        player_name,

        GLOBAL_GET_INT(1882422 + 1 + pid * 142 + 31),
        GLOBAL_GET_INT(1845263 + 1 + pid * 877 + 96 + 31),

        LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2),
        LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2 + 1)
    )

    draw_text(text)
end)




menu.divider(Job_Mission_Test, "fm_mission_controller")

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    local text = string.format(
        "iCurrentGangopsMission: %s, eChosenApproachType: %s, bIsThisAStrandMission: %s\nbPassedFirstMission: %s, bPassedFirstStrandNoReset: %s, bLastMission: %s\nIS_A_STRAND_MISSION_BEING_INITIALISED: %s",
        GLOBAL_GET_INT(2684312 + 26),
        GLOBAL_GET_INT(1963911),
        GLOBAL_GET_INT(2684312 + 43 + 57),

        GLOBAL_GET_INT(2684312 + 43 + 55),
        GLOBAL_GET_INT(2684312 + 43 + 56),
        GLOBAL_GET_INT(2684312 + 43 + 58),
        GLOBAL_BIT_TEST(2684312 + 43 + 4, 0)
    )

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local team = PLAYER.GET_PLAYER_TEAM(players.user())

    local MC_serverBD_3 = 26154

    local text = string.format(
        "Team: %s\ntdObjectiveLimitTimer: %s\ntdMultiObjectiveLimitTimer: %s\ntdLimitTimer: %s\niTimerPenalty: %s\niMultiObjectiveTimeLimit: %s",
        team,
        LOCAL_GET_INT(script, MC_serverBD_3 + 740 + 1 + team * 2),
        LOCAL_GET_INT(script, MC_serverBD_3 + 749 + 1 + team * 2),
        LOCAL_GET_INT(script, MC_serverBD_3 + 758),
        LOCAL_GET_INT(script, MC_serverBD_3 + 760 + 1 + team),
        LOCAL_GET_INT(script, MC_serverBD_3 + 765 + 1 + team)
    )

    draw_text(text)
end)




menu.divider(Job_Mission_Test, "fm_mission_controller_2020")

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local team = PLAYER.GET_PLAYER_TEAM(players.user())

    local MC_serverBD_3 = 55004

    local text = string.format(
        "Team: %s\ntdObjectiveLimitTimer: %s\ntdMultiObjectiveLimitTimer: %s\ntdLimitTimer: %s\niTimerPenalty: %s\niMultiObjectiveTimeLimit: %s",
        team,
        LOCAL_GET_INT(script, MC_serverBD_3 + 297 + 1 + team * 2),
        LOCAL_GET_INT(script, MC_serverBD_3 + 306 + 1 + team * 2),
        LOCAL_GET_INT(script, MC_serverBD_3 + 315),
        LOCAL_GET_INT(script, MC_serverBD_3 + 317 + 1 + team),
        LOCAL_GET_INT(script, MC_serverBD_3 + 322 + 1 + team)
    )

    draw_text(text)
end)













menu.divider(Job_Mission_Test, "")

menu.action(Job_Mission_Test, "Get Content Info (By Natives)", { "getContentInfo" }, "", function()
    local content_id = NETWORK.UGC_GET_CONTENT_ID(0)
    if content_id ~= nil then
        local text = string.format(
            "\nContent Name: %s\nContent ID: %s\nContent Path: %s\nRoot Content ID: %s (%s)\nRoot Content ID Index: %s",
            NETWORK.UGC_GET_CONTENT_NAME(0),
            content_id,
            NETWORK.UGC_GET_CONTENT_PATH(0, 0),
            NETWORK.UGC_GET_ROOT_CONTENT_ID(0),
            util.joaat(NETWORK.UGC_GET_ROOT_CONTENT_ID(0)),
            MISC.GET_CONTENT_ID_INDEX(util.joaat(NETWORK.UGC_GET_ROOT_CONTENT_ID(0)))
        )
        toast(text)
    end
end)

menu.action(Job_Mission_Test, "Get Content Info (By Globals)", { "getGContentInfo" }, "", function()
    local iRootContentIDHash = GLOBAL_GET_INT(FMMC_STRUCT.iRootContentIDHash)
    if iRootContentIDHash ~= 0 then
        local text = string.format(
            "\nContent Name: %s\nContent ID: %s\nRoot Content ID: %s (%s)",
            GLOBAL_GET_STRING(FMMC_STRUCT.tl63MissionName),
            GLOBAL_GET_STRING(FMMC_STRUCT.tl31LoadedContentID),
            "",
            iRootContentIDHash
        )
        toast(text)
    end
end)


menu.divider(Job_Mission_Test, "")
menu.toggle_loop(Job_Mission_Test, "Show Mission Controller Script", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    local text = ""

    util.spoof_script(script, function()
        local isHost = NETWORK.NETWORK_IS_HOST_OF_THIS_SCRIPT()
        local getHost = players.get_name(NETWORK.NETWORK_GET_HOST_OF_THIS_SCRIPT())
        local instanceId = NETWORK.NETWORK_GET_INSTANCE_ID_OF_THIS_SCRIPT()

        text = string.format(
            "Script: %s\nNETWORK_IS_HOST_OF_THIS_SCRIPT: %s\nNETWORK_GET_HOST_OF_THIS_SCRIPT: %s\nNETWORK_GET_INSTANCE_ID_OF_THIS_SCRIPT: %s",
            script,
            isHost,
            getHost,
            instanceId
        )
    end)

    local getHost2 = players.get_name(NETWORK.NETWORK_GET_HOST_OF_SCRIPT(script, 0, 0))
    local scriptHost = players.get_name(players.get_script_host())

    text = string.format(
        "%s\nNETWORK_GET_HOST_OF_SCRIPT: %s\nScript Host: %s",
        text,
        getHost2,
        scriptHost
    )

    draw_text(text)
end)
menu.action(Job_Mission_Test, "Request Mission Controller Script Host", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    if util.request_script_host(script) then
        util.toast("Success")
    else
        util.toast("Fail")
    end
end)








----------------------------------------
--    Script Event Test
----------------------------------------

local Script_Event_Test <const> = menu.list(Menu_Root, "Script Event Test", {}, "")

local ScriptEventDetails = memory.alloc(8 * 2)
menu.toggle_loop(Script_Event_Test, "Get Network Script Event", {}, "", function()
    -- SCRIPT_EVENT_QUEUE_NETWORK = 1
    local eventType = 174 -- EVENT_NETWORK_SCRIPT_EVENT

    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        if SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex) == eventType then
            if SCRIPT.GET_EVENT_DATA(1, eventIndex, ScriptEventDetails, 2) then
                local eventHash = memory.read_int(ScriptEventDetails)
                local FromPlayerIndex = memory.read_int(ScriptEventDetails + 8)

                local text = string.format(
                    "Script Event Hash: %s\nFrom Player: %s\nTime: %s",
                    eventHash,
                    players.get_name(FromPlayerIndex),
                    os.date("%Y-%m-%d %H:%M:%S", util.current_unix_time_seconds())
                )

                toast(text)
            end
        end
    end
end)
