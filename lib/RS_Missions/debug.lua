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
--    Auto Island Heist
------------------------------------

local Auto_Island_Heist <const> = menu.list(Menu_Root, "全自动佩里科岛抢劫", {}, "")


local bTransitionSessionSkipLbAndNjvs = g_sTransitionSessionData + 702

-- `fmmc_launcher`
-- CORONA_MENU_DATA
local _coronaMenuData = 17445
local coronaMenuData = {
    iCurrentSelection = _coronaMenuData + 911,
}

local _sLaunchMissionDetails = 19709
local sLaunchMissionDetails2 = {
    iIntroStatus = _sLaunchMissionDetails,
    iHeistStatus = _sLaunchMissionDetails + 3,
    iLobbyStatus = _sLaunchMissionDetails + 4,
    iInviteScreenStatus = _sLaunchMissionDetails + 6,
    iInCoronaStatus = _sLaunchMissionDetails + 7,
    iBettingStatus = _sLaunchMissionDetails + 10,
    iLoadStatus = _sLaunchMissionDetails + 11,

    iMaxParticipants = _sLaunchMissionDetails + 32,
}



local AutoIslandHeistStatus <const> = {
    Disable = 0,
    Freemode = 1,
    InKotsatka = 2,
    RegisterAsCEO = 3,
    IntroScreen = 4,
    HeistPlanningScreen = 5,
    InCoronaScreen = 6,
    InMission = 7,
    MissionEnd = 8,
    Cleanup = 9
}


local AutoIslandHeist = {
    menuAction = 0,
    enable = false,
    status = AutoIslandHeistStatus.Disable,
    spawnLocation = nil,

    setting = {
        rewardValue = 2000000,
        addRandom = true,
        disableCut = false,
        delay = 1500,
        disableToast = false
    }
}

function AutoIslandHeist.setStatus(eStatus)
    AutoIslandHeist.status = eStatus
end

function AutoIslandHeist.getSpawnLocation()
    return STAT_GET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"))
end

function AutoIslandHeist.setSpawnLocation(iLocation)
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), iLocation)
end

function AutoIslandHeist.toggleActionName(toggle)
    if toggle then
        menu.set_menu_name(AutoIslandHeist.menuAction, "开启 全自动佩里科岛抢劫")
    else
        menu.set_menu_name(AutoIslandHeist.menuAction, "停止 全自动佩里科岛抢劫")
    end
end

function AutoIslandHeist.cleanup()
    AutoIslandHeist.enable = false
    AutoIslandHeist.status = AutoIslandHeistStatus.Disable
    AutoIslandHeist.toggleActionName(true)
end

function AutoIslandHeist.toast(text)
    if not AutoIslandHeist.setting.disableToast then
        util.toast("[全自动佩里科岛抢劫] " .. text)
    end
end

AutoIslandHeist.menuAction = menu.action(Auto_Island_Heist, "开启 全自动佩里科岛抢劫", {}, "[仅适用于单人]", function()
    if AutoIslandHeist.enable then
        AutoIslandHeist.enable = false
        return
    end

    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end
    if not DOES_PLAYER_OWN_KOSATKA() then
        util.toast("你需要拥有虎鲸")
        return
    end

    AutoIslandHeist.toggleActionName(false)
    AutoIslandHeist.enable = true
    AutoIslandHeist.spawnLocation = nil

    AutoIslandHeist.setStatus(AutoIslandHeistStatus.Freemode)

    util.create_tick_handler(function()
        if not AutoIslandHeist.enable then
            AutoIslandHeist.cleanup()
            AutoIslandHeist.toast("已停止...")
            return false
        end

        local setting = AutoIslandHeist.setting
        local eStatus = AutoIslandHeist.status

        if eStatus == AutoIslandHeistStatus.Freemode then
            if not IS_PLAYER_IN_KOSATKA() then
                AutoIslandHeist.spawnLocation = AutoIslandHeist.getSpawnLocation()
                AutoIslandHeist.setSpawnLocation(16) -- MP_SETTING_SPAWN_SUBMARINE
                menu.trigger_commands("go inviteonly")

                AutoIslandHeist.toast("切换战局到虎鲸...")
            end
            AutoIslandHeist.setStatus(AutoIslandHeistStatus.InKotsatka)
        elseif eStatus == AutoIslandHeistStatus.InKotsatka then
            if IS_IN_SESSION() then
                if IS_PLAYER_IN_KOSATKA() then
                    util.yield(setting.delay)

                    if not IS_PLAYER_BOSS_OF_A_GANG() then
                        menu.trigger_commands("ceostart")

                        AutoIslandHeist.toast("注册为CEO...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.RegisterAsCEO)
                    else
                        if AutoIslandHeist.spawnLocation then
                            AutoIslandHeist.setSpawnLocation(AutoIslandHeist.spawnLocation)
                        end

                        local Data = {
                            iRootContentID = -1172878953, -- HIM_STUB
                            iMissionType = 260,           -- FMMC_TYPE_HEIST_ISLAND_FINALE
                            iMissionEnteryType = 67,      -- ciMISSION_ENTERY_TYPE_HEIST_ISLAND_TABLE
                        }
                        LAUNCH_MISSION(Data)

                        AutoIslandHeist.toast("启动差事...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.IntroScreen)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.RegisterAsCEO then
            if IS_PLAYER_BOSS_OF_A_GANG() then
                util.yield(setting.delay)

                AutoIslandHeist.setStatus(AutoIslandHeistStatus.InKotsatka)
            end
        elseif eStatus == AutoIslandHeistStatus.IntroScreen then
            local script = "fmmc_launcher"
            if IS_SCRIPT_RUNNING(script) then
                -- FM_MISSION_INTRO_SCREEN_MAINTAIN
                if LOCAL_GET_INT(script, sLaunchMissionDetails2.iIntroStatus) == 3 then
                    util.yield(setting.delay)

                    LOCAL_SET_INT(script, sLaunchMissionDetails2.iMaxParticipants, 1)

                    AutoIslandHeist.toast("开始游戏...")
                    AutoIslandHeist.setStatus(AutoIslandHeistStatus.HeistPlanningScreen)
                end
            end
        elseif eStatus == AutoIslandHeistStatus.HeistPlanningScreen then
            if IS_SCRIPT_RUNNING("heist_island_planning") then
                local script = "fmmc_launcher"
                if IS_SCRIPT_RUNNING(script) then
                    -- FM_MISSION_LOAD_IN_CORONA_SCENE_COMPLETE
                    if LOCAL_GET_INT(script, sLaunchMissionDetails2.iLoadStatus) == 2 then
                        util.yield(setting.delay)


                        local sConfig = GlobalPlayerBD_HeistIsland.sConfig()

                        local Data = {
                            bHardModeEnabled = false,
                            eApproachVehicle = 6,
                            eInfiltrationPoint = 3,
                            eCompoundEntrance = 0,
                            eEscapePoint = 1,
                            eTimeOfDay = 1,
                            eWeaponLoadout = 1,
                            bUseSuppressors = true
                        }
                        GLOBAL_SET_INT(sConfig + 35, Data.eWeaponLoadout)
                        GLOBAL_SET_BOOL(sConfig + 38, Data.bHardModeEnabled)
                        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_NORMAL)

                        GLOBAL_SET_INT(sConfig + 39, Data.eApproachVehicle)
                        GLOBAL_SET_INT(sConfig + 40, Data.eInfiltrationPoint)
                        GLOBAL_SET_INT(sConfig + 41, Data.eCompoundEntrance)
                        GLOBAL_SET_INT(sConfig + 42, Data.eEscapePoint)
                        GLOBAL_SET_INT(sConfig + 43, Data.eTimeOfDay)
                        GLOBAL_SET_BOOL(sConfig + 44, Data.bUseSuppressors)

                        GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer() + 1, 1)
                        GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer(), 0)

                        AutoIslandHeist.toast("设置面板并继续...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.InCoronaScreen)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.InCoronaScreen then
            if IS_SCRIPT_RUNNING("heist_island_planning") then
                local script = "fmmc_launcher"
                if IS_SCRIPT_RUNNING(script) then
                    -- FM_MISSION_IN_CORONA_SCREEN_MAINTAIN
                    if LOCAL_GET_INT(script, sLaunchMissionDetails2.iInCoronaStatus) == 4 then
                        util.yield(setting.delay)

                        -- ciCORONA_LOBBY_START_GAME
                        LOCAL_SET_INT(script, coronaMenuData.iCurrentSelection, 14)

                        -- FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT
                        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)

                        AutoIslandHeist.toast("准备就绪，进入任务...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.InMission)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.InMission then
            if IS_IN_SESSION() then
                local script = "fm_mission_controller_2020"
                if IS_SCRIPT_RUNNING(script) then
                    util.yield(setting.delay + 3000)

                    if AutoIslandHeist.setting.rewardValue ~= -1 then
                        if AutoIslandHeist.setting.addRandom then
                            AutoIslandHeist.setting.rewardValue = AutoIslandHeist.setting.rewardValue +
                                math.random(0, 50000)
                        end
                        Tunables.SetIntList("IslandHeistPrimaryTargetValue", AutoIslandHeist.setting.rewardValue)
                    end
                    if AutoIslandHeist.setting.disableCut then
                        Tunables.SetFloatList("NpcCut", 0)
                    end
                    INSTANT_FINISH_FM_MISSION_CONTROLLER()

                    -- g_sTransitionSessionData.bTransitionSessionSkipLbAndNjvs
                    GLOBAL_SET_BOOL(bTransitionSessionSkipLbAndNjvs, true)

                    AutoIslandHeist.toast("直接完成任务...")
                    AutoIslandHeist.setStatus(AutoIslandHeistStatus.MissionEnd)
                end
            end
        elseif eStatus == AutoIslandHeistStatus.MissionEnd then
            if not IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
                AutoIslandHeist.toast("任务已完成...")
                AutoIslandHeist.setStatus(AutoIslandHeistStatus.Cleanup)
            end
        elseif eStatus == AutoIslandHeistStatus.Cleanup then
            AutoIslandHeist.cleanup()
            AutoIslandHeist.toast("结束...")
            return false
        end
    end)
end)

menu.divider(Auto_Island_Heist, "收入")
local Auto_Island_Heist_Reward = menu.slider(Auto_Island_Heist, "主要目标价值", { "AutoIslandHeistRewardValue" }, "",
    -1, 2550000, AutoIslandHeist.setting.rewardValue, 50000, function(value)
        AutoIslandHeist.setting.rewardValue = value
    end)
menu.add_value_replacement(Auto_Island_Heist_Reward, -1, Labels.Default)
menu.toggle(Auto_Island_Heist, "添加随机数", {}, "主要目标价值加0 ~ 50000的随机数", function(toggle)
    AutoIslandHeist.setting.addRandom = toggle
end, true)
menu.toggle(Auto_Island_Heist, "禁用NPC分红", {}, "", function(toggle)
    AutoIslandHeist.setting.disableCut = toggle
end)

menu.divider(Auto_Island_Heist, "设置")
menu.slider(Auto_Island_Heist, "延迟", { "AutoIslandHeistDelay" }, "到达新的状态后的等待时间",
    0, 5000, AutoIslandHeist.setting.delay, 100, function(value)
        AutoIslandHeist.setting.delay = value
    end)
menu.toggle(Auto_Island_Heist, "禁用通知提示", {}, "", function(toggle)
    AutoIslandHeist.setting.disableToast = toggle
end)









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

menu.toggle_loop(Freemode_Test, "CUTSCENE", {}, "", function()
    local text = string.format(
        "IS_CUTSCENE_PLAYING: %s\nIS_CUTSCENE_ACTIVE: %s\nIS_PLAYER_IN_CUTSCENE: %s\nNETWORK_IS_IN_MP_CUTSCENE: %s",
        CUTSCENE.IS_CUTSCENE_PLAYING(),
        CUTSCENE.IS_CUTSCENE_ACTIVE(),
        NETWORK.IS_PLAYER_IN_CUTSCENE(players.user()),
        NETWORK.NETWORK_IS_IN_MP_CUTSCENE()
    )
    draw_text(text)
end)




menu.action(Freemode_Test, "切换战局 到 虎鲸", {}, "", function()
    -- MP_SETTING_SPAWN_SUBMARINE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 16)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 游戏厅", {}, "", function()
    -- MP_SETTING_SPAWN_ARCADE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 15)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 设施", {}, "", function()
    -- MP_SETTING_SPAWN_DEFUNCT_BASE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 11)

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
    local iRootContentID = GLOBAL_GET_INT(FMMC_STRUCT.iRootContentIDHash)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)

    local text = string.format(
        "MissionName: %s, iRootContentIDHash: %s, iArrayPos: %s\ntl23NextContentID: %s, %s, %s\niEndCutscene: %s",
        GLOBAL_GET_STRING(FMMC_STRUCT.tl63MissionName),
        iRootContentID,
        iArrayPos,

        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 0 * 6),
        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 1 * 6),
        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 2 * 6),

        GLOBAL_GET_INT(g_FMMC_STRUCT + 127643)
    )

    -- util.log(text)
    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "最小玩家数为1", {}, "强制任务单人可开", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iArrayPos = LOCAL_GET_INT(script, sLaunchMissionDetails.iMissionVariation)
    if iArrayPos == 0 then
        return
    end

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMinPlayers
    if GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69) > 1 then
        GLOBAL_SET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69, 1)
        LOCAL_SET_INT(script, sLaunchMissionDetails.iMinPlayers, 1)
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

menu.action(Job_Mission_Test, "Mission Finish", { "MissionFinish" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    -- CHECK_TO_SEE_IF_THIS_IS_THE_LAST_STRAND_MISSION()
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
        if tl23NextContentID ~= "" then
            GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
        end
    end

    -- g_FMMC_STRUCT.iCelebrationType
    GLOBAL_SET_INT(4718592 + 178859, 5)

    -- ciMISSION_CUTSCENE_ISLAND_HEIST_HS4F_DRP_OFF
    LOCAL_SET_INT(script, 50150 + 3016, 69)    -- MISSION_HAS_VALID_MOCAP
    LOCAL_SET_INT(script, 50150 + 2525 + 1, 0) -- SHOULD_PLAY_END_MOCAP



    if GLOBAL_GET_BOOL(StrandMissionData.bIsThisAStrandMission) then
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstMission, true)
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstStrandNoReset, true)
        GLOBAL_SET_BOOL(StrandMissionData.bLastMission, true)
    end

    -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
    LOCAL_SET_BIT(script, Locals[script].iLocalBoolCheck11, 7)

    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT(script, Locals[script].iTeamScore + i, 999999)
    end

    -- SSBOOL_TEAMx_FINISHED
    LOCAL_SET_BITS(script, Locals[script].iServerBitSet, 9, 10, 11, 12)
end)

menu.action(Job_Mission_Test, "Mission Over", { "MissionOver" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    LOCAL_SET_BIT(script, Locals[script].iServerBitSet, 16)
end)






menu.divider(Job_Mission_Test, "fmmc_launcher")

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    local text = string.format(
        "iSwitchState: %s, iArrayPos: %s, IsThisAStrandMission: %s\nIS_A_STRAND_MISSION_BEING_INITIALISED: %s\nHAS_NEXT_STRAND_MISSION_HAS_BEEN_DOWNLOADED: %s\nIS_NEXT_STRAND_MISSION_READY_TO_SET_UP: %s\nIS_STRAND_MISSION_READY_TO_START_DOWNLOAD: %s\neBranchingTransitionType: %s, %s, %s\niVoteStatus: %s, iCelebrationType: %s",
        GLOBAL_GET_INT(2684504 + 43 + 3),   -- g_sTransitionSessionData.sStrandMissionData.iSwitchState
        GLOBAL_GET_INT(2684504 + 43),       -- g_sTransitionSessionData.sStrandMissionData.iArrayPos
        GLOBAL_GET_BOOL(2684504 + 43 + 57), -- g_sTransitionSessionData.sStrandMissionData.bIsThisAStrandMission

        -- g_sTransitionSessionData.sStrandMissionData.iBitSet
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 0),     -- ciSTRAND_BITSET_A_STRAND_MISSION_BEING_INITIALISED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 6),     -- ciSTRAND_BITSET_MISSION_HAS_BEEN_DOWNLOADED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 7),     -- ciSTRAND_BITSET_MISSION_READY_TO_SET_UP
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 8),     -- ciSTRAND_BITSET_MISSION_READY_TO_START_DOWNLOAD

        GLOBAL_GET_INT(4718592 + 127530 + 1 + 0), -- g_FMMC_STRUCT.eBranchingTransitionType[i]
        GLOBAL_GET_INT(4718592 + 127530 + 1 + 1), -- g_FMMC_STRUCT.eBranchingTransitionType[i]
        GLOBAL_GET_INT(4718592 + 127530 + 1 + 2), -- g_FMMC_STRUCT.eBranchingTransitionType[i]

        GLOBAL_GET_INT(1919969 + 9),              -- g_sFMMCEOM.iVoteStatus
        GLOBAL_GET_INT(4718592 + 178859)          -- g_FMMC_STRUCT.iCelebrationType
    )

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local __coronaMenuData = 17445
    local __sLaunchMissionDetails = 19709

    local text = string.format(
        "iCurrentSelection: %s\niIntroStatus: %s, iLobbyStatus: %s, iInviteScreenStatus: %s, iInCoronaStatus: %s, iBettingStatus: %s, iLoadStatus: %s",
        LOCAL_GET_INT(script, __coronaMenuData + 911), -- coronaMenuData.iCurrentSelection
        LOCAL_GET_INT(script, __sLaunchMissionDetails),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 4),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 6),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 7),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 10),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 11)
    )

    draw_text(text)
end)



local function SET_CORONA_BIT(iCoronaBit)
    local iBitSet = math.ceil(iCoronaBit / 32)
    local iBitVal = iCoronaBit % 32

    util.toast(string.format("iBitSet: %s, iBitVal: %s", iBitSet, iBitVal))

    if iBitSet >= 9 then -- NUM_CORONA_BITSETS
        return
    end

    -- SET_BIT(g_TransitionSessionNonResetVars.sTransVars.iCoronaBitSet[iBitSet], iBitVal)
    -- MISC::SET_BIT(&(Global_2685444.f_1.f_2813[iVar0]), bVar1);
    GLOBAL_SET_BIT(2685444 + 1 + 2813 + 1 + iBitSet, iBitVal)
end
menu.click_slider(Job_Mission_Test, "SET_CORONA_BIT", { "Test_iCoronaBit" }, "",
    0, 200, 170, 1, function(value)
        SET_CORONA_BIT(value)
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

    local MC_serverBD = 50150
    local MC_serverBD_4 = 59029

    local iTeam = 0

    -- if (uLocal_59029[Local_62290[bLocal_19370 /*275*/].f_1] == Local_50150.f_2114[Local_62290[bLocal_19370 /*275*/].f_1])
    -- MC_serverBD_4.iCurrentHighestPriority[mc_playerBD[iPartToUse].iteam] = MC_serverBD.iMaxObjectives[mc_playerBD[iPartToUse].iteam]
    local iMaxObjectives = 50150 + 2114

    local text = string.format(
        "iCurrentHighestPriority: %s, iMaxObjectives: %s\ntimerCelebPreLoadPostFxBeenPlaying: %s",
        LOCAL_GET_INT(script, MC_serverBD_4 + 1 + iTeam),
        LOCAL_GET_INT(script, MC_serverBD + 2114 + 1 + iTeam),
        LOCAL_GET_INT(script, 36804 + 1200)
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
