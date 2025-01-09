local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "DEBUG")

local Freemode_Mission = Menu_Root
local Heist_Mission = Menu_Root





----------------------------------------
--    Start Freemode Mission
----------------------------------------

local Start_Freemode_Mission <const> = menu.list(Menu_Root, "开始自由模式任务", {}, "")

local StartFreemodeMission = {
    iMission = 0,
    iVariation = -1,

    sendPlayer = 0,
    playerBit = 0,
    playerToggles = {}
}


local MissionCategory = {
    VIP_Work = "VIP 工作",
    VIP_Challenges = "VIP 挑战",
    Club_Work = "摩托帮工作",
    Club_Challenges = "摩托帮挑战",
    Club_Contracts = "摩托帮会所合约",
    Client_Jobs = "恐霸客户差事",
    Heist_Preps = "抢劫前置任务",
    Salvage_Yard_Robbery = "回收站抢劫",
}

local FreemodeMissions = {
    { 0, "NONE", {}, "" },

    { 214, "毁货不倦", {}, "", MissionCategory.VIP_Work },
    { 215, "火力满载", {}, "", MissionCategory.VIP_Work },
    { 216, "两栖突击", {}, "", MissionCategory.VIP_Work },
    { 217, "押送员", {}, "", MissionCategory.VIP_Work },
    { 218, "铜墙铁壁", {}, "", MissionCategory.VIP_Work },
    { 219, "生死极速", {}, "", MissionCategory.VIP_Work },
    { 220, "加足马力", {}, "", MissionCategory.VIP_Work },
    { 221, "囤积居奇", {}, "", MissionCategory.VIP_Work },
    { 166, "猎杀专员", {}, "", MissionCategory.VIP_Work },
    { 170, "空运货物", {}, "", MissionCategory.VIP_Work },
    { 173, "货物运输", {}, "", MissionCategory.VIP_Work },
    { 159, "野蛮接管", {}, "", MissionCategory.VIP_Work },
    { 157, "资产回收", {}, "", MissionCategory.VIP_Work },
    { 148, "老大对决", {}, "", MissionCategory.VIP_Work },
    { 164, "猎杀老大", {}, "", MissionCategory.VIP_Work },
    { 142, "观光客", {}, "", MissionCategory.VIP_Work },
    { 152, "游艇保卫战", {}, "", MissionCategory.VIP_Work },

    { 171, "提领一空", {}, "", MissionCategory.VIP_Challenges },
    { 172, "打捞行动", {}, "", MissionCategory.VIP_Challenges },
    { 163, "垄断车市", {}, "", MissionCategory.VIP_Challenges },
    { 160, "先到先得", {}, "", MissionCategory.VIP_Challenges },
    { 153, "亡命天涯/头号通缉犯", {}, "", MissionCategory.VIP_Challenges },
    { 162, "点对点", {}, "", MissionCategory.VIP_Challenges },
    { 155, "快递服务", {}, "", MissionCategory.VIP_Challenges },
    { 154, "市场炒作", {}, "", MissionCategory.VIP_Challenges },


    { 148, "死斗游戏", {}, "", MissionCategory.Club_Work },
    { 179, "骑士死斗", {}, "", MissionCategory.Club_Work },
    { 201, "划地为阵", {}, "", MissionCategory.Club_Work },
    { 200, "摩托车卡位战", {}, "", MissionCategory.Club_Work },

    { 189, "抢先抵达", {}, "", MissionCategory.Club_Challenges },
    { 194, "破坏狂人", {}, "", MissionCategory.Club_Challenges },
    { 193, "驾驶射击", {}, "", MissionCategory.Club_Challenges },
    { 199, "索命追击", {}, "", MissionCategory.Club_Challenges },
    { 205, "飞车整蛊", {}, "", MissionCategory.Club_Challenges },
    { 210, "独轮骑士", {}, "", MissionCategory.Club_Challenges },

    { 182, "克克皆辛苦", {}, "", MissionCategory.Club_Contracts },
    { 183, "营救俘虏", {}, "", MissionCategory.Club_Contracts },
    { 185, "佣兵送忠", {}, "", MissionCategory.Club_Contracts },
    { 186, "奉命行凶", {}, "", MissionCategory.Club_Contracts },
    { 180, "军火贸易", {}, "", MissionCategory.Club_Contracts },
    { 195, "占车为王", {}, "", MissionCategory.Club_Contracts },
    { 197, "逃狱威龙", {}, "", MissionCategory.Club_Contracts },
    { 198, "直捣黄龙", {}, "", MissionCategory.Club_Contracts },
    { 207, "易碎货物", {}, "", MissionCategory.Club_Contracts },
    { 208, "火光冲天", {}, "", MissionCategory.Club_Contracts },
    { 209, "摩的飙客", {}, "", MissionCategory.Club_Contracts },
    { 293, "摩托帮会所合约 (两个新的)", {}, "", MissionCategory.Club_Contracts },


    { 151, "追杀令/下达暗杀令", {}, "" },


    { 158, "赌场抢劫 前置任务", {}, "", MissionCategory.Heist_Preps },
    { 233, "末日豪劫 前置任务", {}, "", MissionCategory.Heist_Preps },
    { 256, "佩里科岛抢劫 前置任务", {}, "", MissionCategory.Heist_Preps },
    { 264, "别惹德瑞 前置任务", {}, "", MissionCategory.Heist_Preps },
    { 271, "改装铺合约 前置任务", {}, "", MissionCategory.Heist_Preps },

    { 242, "银行劫案", {}, "", MissionCategory.Client_Jobs },
    { 244, "数据检索", {}, "", MissionCategory.Client_Jobs },
    { 248, "致命数据", {}, "", MissionCategory.Client_Jobs },
    { 241, "钻石买卖", {}, "", MissionCategory.Client_Jobs },
    { 239, "典藏珍品", {}, "", MissionCategory.Client_Jobs },
    { 240, "插手交易", {}, "", MissionCategory.Client_Jobs },


    { 243, "赌场工作", {}, "" },
    { 258, "DJ 任务", {}, "" },
    { 262, "电话暗杀", {}, "" },
    { 263, "安保合约", {}, "" },
    { 267, "拉机能量时间挑战赛", {}, "" },
    { 291, "摩托帮 酒吧重新补给", {}, "" },
    { 294, "办公室 购买特种货物 (卢佩)", {}, "" },
    { 295, "办公室 出口混合货物", {}, "" },
    { 296, "地堡 武装国度合约", {}, "" },
    { 297, "地堡 补充原材料任务 (两个新的)", {}, "" },
    { 298, "请求地堡研究", {}, "" },
    { 299, "夜总会管理 (两个)", {}, "" },
    { 300, "夜总会管理 (两个人气事件)", {}, "" },
    { 301, "请求夜总会货物 (两个)", {}, "" },
    { 304, "致幻剂实验室 准备任务", {}, "" },
    { 305, "致幻剂实验室 补充原材料任务", {}, "" },
    { 307, "蠢人帮差事", {}, "" },
    { 308, "藏匿屋", {}, "" },
    { 309, "出租车工作", {}, "" },


    { 314, "UFO Basement", {}, "" },
    { 316, "机库 偷取货物任务 (陆地)", {}, "" },
    { 317, "LSA 行动", {}, "" },

    { 325, "Salvage_Scope", {}, "", MissionCategory.Salvage_Yard_Robbery },
    { 326, "Salvage_Task", {}, "", MissionCategory.Salvage_Yard_Robbery },
    { 327, "Salvage_Prep", {}, "", MissionCategory.Salvage_Yard_Robbery },
    { 328, "Salvage_Prep", {}, "", MissionCategory.Salvage_Yard_Robbery },

    { 337, "保金办公室悬赏目标", {}, "" },
    { 338, "玛德拉索雇凶", {}, "" },
    { 339, "派遣工作", {}, "" },
    { 351, "Arms_Trafficking", {}, "" },
}


menu.list_select(Start_Freemode_Mission, "选择任务", {}, "", FreemodeMissions, 0, function(value)
    StartFreemodeMission.iMission = value
end)
menu.slider(Start_Freemode_Mission, "设置任务", { "SFM_Mission" }, "", 0, 999, 0, 1, function(value)
    StartFreemodeMission.iMission = value
end)

menu.slider(Start_Freemode_Mission, "Variation", {}, "",
    -1, 999, -1, 1, function(value)
        StartFreemodeMission.iVariation = value
    end)


menu.list_select(Start_Freemode_Mission, "发送到玩家", {}, "", {
    { 0, "仅自己" },
    { 1, "仅组织成员" },
    { 2, "全部玩家" }
}, 0, function(value)
    StartFreemodeMission.sendPlayer = value
end)

local Start_Freemode_Mission_Player
Start_Freemode_Mission_Player = menu.list(Start_Freemode_Mission, "选择玩家", {}, "", function()
    rs.delete_menu_list(StartFreemodeMission.playerToggles)
    StartFreemodeMission.playerToggles = {}
    StartFreemodeMission.playerBit = 0

    for _, pid in pairs(players.list(true, true, true)) do
        local name = players.get_name(pid)
        local menu_toggle = menu.toggle(Start_Freemode_Mission_Player, name, {}, "", function(toggle)
            if toggle then
                StartFreemodeMission.playerBit = SET_BIT(StartFreemodeMission.playerBit, pid)
            else
                StartFreemodeMission.playerBit = CLEAR_BIT(StartFreemodeMission.playerBit, pid)
            end
        end)

        StartFreemodeMission.playerToggles[pid] = menu_toggle
    end
end)

menu.action(Start_Freemode_Mission, "开始任务", {}, "", function()
    if StartFreemodeMission.iMission == 0 then return end

    local function getPlayerBitSet(sendPlayer)
        if sendPlayer == 0 then
            return 1 << players.user()
        end

        if sendPlayer == 1 and players.get_org_type(players.user()) ~= -1 then
            local playerBit = 1 << players.user()
            for _, pid in pairs(players.list(false, true, true)) do
                if players.get_boss(pid) == players.user() then
                    playerBit = SET_BIT(playerBit, pid)
                end
            end
            return playerBit
        end

        if sendPlayer == 2 then
            return util.get_session_players_bitflag()
        end
    end

    local playerBit = StartFreemodeMission.playerBit
    if playerBit == 0 then
        playerBit = getPlayerBitSet(StartFreemodeMission.sendPlayer)
    end

    -- GB_NON_BOSS_CHALLENGE_REQUEST
    util.trigger_script_event(playerBit, {
        1450115979, players.user(), StartFreemodeMission.iMission, StartFreemodeMission.iVariation
    })
end)







----------------------------------------
--    Instant Finish Test
----------------------------------------

local Instant_Finish_Test <const> = menu.list(Menu_Root, "Instant Finish Test", {}, "")


menu.divider(Instant_Finish_Test, "fm_content Mission")

local TestScript1 = "fm_content_smuggler_sell"

menu.toggle_loop(Instant_Finish_Test, "Show Local Info", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local t = {
        ""
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)


menu.action(Instant_Finish_Test, "SET_MISSION_ENTITY_BIT", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local eBitset = 4

    local iVar0 = math.floor(eBitset / 32) -- iBitSet
    local iVar1 = math.floor(eBitset % 32) -- iBitVal
    util.toast(string.format("iVar0: %s, iVar1: %s", iVar0, iVar1))

    local iMissionEntity = 0
    local address = memory.script_local(script, 6166 + 2 + 14 + 1 + iMissionEntity * 3 + 1 + iVar0)
    MISC.SET_BIT(address, iVar1)
end)

menu.action(Instant_Finish_Test, "Set Local Variations", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    LOCAL_SET_INT(script, 250 + 19, 3)
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    -- SET_GAME_STATE(eGAMESTATE_END)
    LOCAL_SET_INT(script, 6166 + 1278, 3)
end)
menu.action(Instant_Finish_Test, "Test Complete fm_content", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end


    LOCAL_SET_BIT(script, 6056 + 1 + 0, 11) -- SET_GENERIC_BIT(eGENERICBITSET_I_WON)
    LOCAL_SET_INT(script, 6166 + 1277, 3)   -- SET_END_REASON(eENDREASON_MISSION_PASSED)
end)



menu.divider(Instant_Finish_Test, "gb Mission")

local TestScript2 = "gb_infiltration"

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
    local script = TestScript2
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 460, 4) -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)

    -- LOCAL_SET_INT(script, 834 + 459, 13) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)








----------------------------------------
--    Freemode Test
----------------------------------------


local Freemode_Test <const> = menu.list(Menu_Root, "Freemode Test", {}, "")

menu.toggle_loop(Freemode_Test, "Show Local Info", {}, "", function()
    local script = "am_contact_requests"
    if not IS_SCRIPT_RUNNING(script) then return end


    local t = {
        ""
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show Global Info", {}, "", function()
    local t = {
        ""
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)



menu.action(Freemode_Test, "切换战局 到 虎鲸", {}, "", function()
    -- MP_SETTING_SPAWN_SUBMARINE
    STAT_SET_INT(MPX("SPAWN_LOCATION_SETTING"), 16)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 游戏厅", {}, "", function()
    -- MP_SETTING_SPAWN_ARCADE
    STAT_SET_INT(MPX("SPAWN_LOCATION_SETTING"), 15)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 设施", {}, "", function()
    -- MP_SETTING_SPAWN_DEFUNCT_BASE
    STAT_SET_INT(MPX("SPAWN_LOCATION_SETTING"), 11)

    menu.trigger_commands("go inviteonly")
end)





menu.divider(Freemode_Test, "Casino Horse Race")

menu.action(Freemode_Test, "Set Win (Single)", {}, "", function()
    local script = "am_mp_casino"
    if not IS_SCRIPT_RUNNING(script) then return end

    local sRaceData = 214 + 628 + 128
    local iSelection = 214 + 628 + 39 + 16

    local iWinningSegment = LOCAL_GET_INT(script, sRaceData + 17)
    LOCAL_SET_INT(script, iSelection, iWinningSegment)
end)
menu.action(Freemode_Test, "SET_RACE_BIT", {}, "BS_RACE_INSIDE_TRACK_MINIGAME_READY_TO_START", function()
    local script = "am_mp_casino"
    if not IS_SCRIPT_RUNNING(script) then return end

    local sRaceData = 2521 + 13 + 1
    LOCAL_SET_BIT(script, sRaceData + 1, 8)
end)
menu.action(Freemode_Test, "Set Win (Multi)", {}, "", function()
    local script = "am_mp_casino"
    if not IS_SCRIPT_RUNNING(script) then return end

    local sRaceData = 2521 + 13 + 1

    local iWinningSegment = LOCAL_GET_INT(script, sRaceData + 17)

    STAT_SET_INT(MPX("INSIDETRACK_BET_HORSEID"), iWinningSegment)
end)










----------------------------------------
--    Start Mission Test
----------------------------------------

local Test_Start_Mission <const> = menu.list(Menu_Root, "Start Mission Test", {}, "")

menu.toggle_loop(Test_Start_Mission, "Show Global Info", {}, "", function()
    local t = {
        "iActiveMission: " .. GLOBAL_GET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.iActiveMission()),
        "iMissionToLaunch: " .. GLOBAL_GET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.iMissionToLaunch()),
        "iCurrentMissionType: " .. GLOBAL_GET_INT(GlobalplayerBD_FM.iCurrentMissionType())
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)


menu.divider(Test_Start_Mission, "Freemode Mission")

menu.click_slider(Test_Start_Mission, "Request FMMC_TYPE Mission", { "fmmcReq" }, "", 0, 400, 0, 1, function(value)
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(value)
end)
menu.click_slider(Test_Start_Mission, "Start FMMC_TYPE Mission", { "fmmcStart" }, "", 0, 400, 0, 1, function(value)
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(value)
end)


menu.divider(Test_Start_Mission, "Job Mission")

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
    local iRootContentID = GLOBAL_GET_INT(g_FMMC_STRUCT.iRootContentIDHash)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)


    local t = {
        "MissionName: " .. GLOBAL_GET_STRING(g_FMMC_STRUCT.tl63MissionName),
        "iRootContentIDHash: " .. iRootContentID,
        "iArrayPos: " .. iArrayPos,
        "tl31LoadedContentID: " .. GLOBAL_GET_STRING(g_FMMC_STRUCT.tl31LoadedContentID),
    }

    local text = table.concat(t, "\n")
    draw_text(text)
    -- util.log(text)
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

    if GLOBAL_GET_INT(g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars(iArrayPos).iMinPlayers) > 1 then
        GLOBAL_SET_INT(g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars(iArrayPos).iMinPlayers, 1)
        LOCAL_SET_INT(script, sLaunchMissionDetails.iMinPlayers, 1)

        GLOBAL_SET_INT(g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars(iArrayPos).iMaxNumberOfTeams, 1)
    end

    GLOBAL_SET_INT(g_FMMC_STRUCT.iMinNumParticipants, 1)
    GLOBAL_SET_INT(g_FMMC_STRUCT.iNumPlayersPerTeam, 1)
    GLOBAL_SET_INT(g_FMMC_STRUCT.iCriticalMinimumForTeam, 0)
    -- for i = 0, 3 do
    --     GLOBAL_SET_INT(g_FMMC_STRUCT.iNumPlayersPerTeam + i, 1)
    --     GLOBAL_SET_INT(g_FMMC_STRUCT.iCriticalMinimumForTeam + i, 0)
    -- end
end)

local SetMissionMaxTeams2 = menu.toggle_loop(Job_Mission_Test, "最大团队数为1", {}, "用于多团队任务", function()
    GLOBAL_SET_INT(g_FMMC_STRUCT.iNumberOfTeams, 1)
    GLOBAL_SET_INT(g_FMMC_STRUCT.iMaxNumberOfTeams, 1)
end)

menu.click_slider(Job_Mission_Test, "设置最大团队数", {}, "", 1, 4, 2, 1, function(value)
    menu.set_value(SetMissionMaxTeams2, false)

    GLOBAL_SET_INT(g_FMMC_STRUCT.iNumberOfTeams, value)
    GLOBAL_SET_INT(g_FMMC_STRUCT.iMaxNumberOfTeams, value)
end)

menu.action(Job_Mission_Test, "Mission Finish", { "rsmFinish" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    -- CHECK_TO_SEE_IF_THIS_IS_THE_LAST_STRAND_MISSION
    -- for i = 0, 5 do
    --     local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
    --     if tl23NextContentID ~= "" then
    --         -- String Null, get out
    --         GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
    --     end
    -- end

    -- (not) More than max (FMMC_MAX_STRAND_MISSIONS), get out
    LOCAL_SET_INT(script, Locals[script].iNextMission, 5)

    -- if GLOBAL_GET_BOOL(sStrandMissionData.bIsThisAStrandMission) then
    --     GLOBAL_SET_BOOL(sStrandMissionData.bPassedFirstMission, true)
    --     GLOBAL_SET_BOOL(sStrandMissionData.bPassedFirstStrandNoReset, true)
    --     GLOBAL_SET_BOOL(sStrandMissionData.bLastMission, true)
    -- end

    -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
    LOCAL_SET_BIT(script, Locals[script].iLocalBoolCheck11, 7)

    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT(script, Locals[script].iTeamScore + i, 999999)
    end

    -- SSBOOL_TEAMx_FINISHED, SBBOOL_MISSION_OVER
    LOCAL_SET_BITS(script, Locals[script].iServerBitSet, 9, 10, 11, 12, 16)
end)

menu.action(Job_Mission_Test, "Mission Failed", { "rsmFailed" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    LOCAL_SET_BIT(script, Locals[script].iServerBitSet, 16, 20) -- SSBOOL_TEAM0_FAILED
end)






menu.divider(Job_Mission_Test, "fmmc_launcher")


local CORONA_STATUS = {
    [0] = "CORONA_STATUS_IDLE",
    [1] = "CORONA_STATUS_CAN_START",
    [2] = "CORONA_STATUS_WALK_IN",
    [3] = "CORONA_STATUS_JOIN_HOST",
    [4] = "CORONA_STATUS_MatC_HAND_SHAKE",
    [5] = "CORONA_STATUS_INIT_CORONA",
    [6] = "CORONA_STATUS_INIT_TRAN_SCRIPT",
    [7] = "CORONA_STATUS_GET_DATA_SETUP_TRAN",
    [8] = "CORONA_STATUS_SETUP_VARS",
    [9] = "CORONA_STATUS_INTRO",
    [10] = "CORONA_STATUS_LOBBY",
    [11] = "CORONA_STATUS_H2H_LOBBY",
    [12] = "CORONA_STATUS_LEADERBOARD",
    [13] = "CORONA_STATUS_JOINED_PLAYERS",
    [14] = "CORONA_STATUS_LOCAL_PLAYERS",
    [15] = "CORONA_STATUS_LAST_JOB_PLAYERS",
    [16] = "CORONA_STATUS_LAST_HEIST_PLAYERS",
    [17] = "CORONA_STATUS_FRIENDS",
    [18] = "CORONA_STATUS_CREW_MEMBERS",
    [19] = "CORONA_STATUS_MATCHED_PLAYERS",
    [20] = "CORONA_LAUNCH_TRANSITION",
    [21] = "CORONA_STATUS_BALANCE_AND_LOAD",
    [22] = "CORONA_STATUS_SCTV_HOLDING",
    [23] = "CORONA_STATUS_SCTV_PROPERTY_CAM",
    [24] = "CORONA_STATUS_IN_CORONA",
    [25] = "CORONA_STATUS_IN_GENERIC_JOB_CORONA",
    [26] = "CORONA_STATUS_TEAM_DM",
    [27] = "CORONA_STATUS_HEIST_PLANNING",
    [28] = "CORONA_STATUS_HEIST_PLANNING_CUTSCENE",
    [29] = "CORONA_STATUS_HEIST_CUTSCENE",
    [30] = "CORONA_STATUS_HEIST_TUTORIAL_CUTSCENE",
    [31] = "CORONA_STATUS_FLOW_CUTSCENE",
    [32] = "CORONA_STATUS_GANG_OPS_HEIST_PLANNING",
    [33] = "CORONA_STATUS_CASINO_HEIST_PLANNING",
    [34] = "CORONA_STATUS_GENERIC_HEIST_PLANNING",
    [35] = "CORONA_STATUS_BETTING",
    [36] = "CORONA_STATUS_WAIT_FOR_CASH_TRANSACTION",
    [37] = "CORONA_STATUS_KICKED",
    [38] = "CORONA_STATUS_RESET_POSITION",
    [39] = "CORONA_STATUS_WARP_TO_SAFE_LOC",
    [40] = "CORONA_STATUS_WALK_OUT",
    [41] = "CORONA_STATUS_LAUNCH",
    [42] = "CORONA_STATUS_WAIT_FOR_ACTIVE",
    [43] = "CORONA_STATUS_QUIT"
}

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_193
    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].eCoronaStatus

    local eCoronaStatus = GLOBAL_GET_INT(GlobalplayerBD_FM.eCoronaStatus())
    if CORONA_STATUS[eCoronaStatus] then
        eCoronaStatus = CORONA_STATUS[eCoronaStatus]
    end


    local t = {
        "eCoronaStatus: " .. eCoronaStatus
    }

    local text = table.concat(t, "\n")
    draw_text(text)
    -- util.log(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then return end

    local __coronaMenuData = 17602
    local __sLaunchMissionDetails = 19875

    local __GlobalplayerBD_FM = 1845221 + 1 + players.user() * 889
    -- local __g_sTransitionSessionData = 2684718

    local t = {
        "iLobbyStatus: " .. LOCAL_GET_INT(script, __sLaunchMissionDetails + 4),
        "iCasinoHeistFinaleCoronaState: " .. LOCAL_GET_INT(script, __coronaMenuData + 2045),
        "iFmLauncherGameState: " .. GLOBAL_GET_INT(__GlobalplayerBD_FM + 96),
        "iTotalPlayersJoinedTeamDMScreen: " .. LOCAL_GET_INT(script, __coronaMenuData + 420),
        "piJobLeader: " .. LOCAL_GET_INT(script, __coronaMenuData + 2229),
        "g_sCasinoHeistData.piLeader: " .. GLOBAL_GET_INT(1965614 + 4356),
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)


menu.toggle_loop(Job_Mission_Test, "IS_CORONA_BIT_SET", {}, "", function()
    -- Global_2685658.f_1.f_2813[iVar0]
    -- g_TransitionSessionNonResetVars.sTransVars.iCoronaBitSet[iBitSet]


    local iCoronaBit = 234
    local iBitSet = math.floor(iCoronaBit / 32)
    local iBitVal = math.floor(iCoronaBit % 32)

    local value = GLOBAL_BIT_TEST(2685658 + 1 + 2813 + 1 + iBitSet, iBitVal)
    draw_text("IS_CORONA_BIT_SET: " .. value)
end)
menu.action(Job_Mission_Test, "SET_CORONA_BIT", {}, "", function()
    local iCoronaBit = 234 -- CORONA_CASINO_HEIST_MAINTAIN_BOARDS
    local iBitSet = math.floor(iCoronaBit / 32)
    local iBitVal = math.floor(iCoronaBit % 32)

    GLOBAL_SET_BIT(2685658 + 1 + 2813 + 1 + iBitSet, iBitVal)
end)









menu.divider(Job_Mission_Test, "fm_mission_controller")

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    local t = {
        "g_sCasinoHeistData.sFinaleData.sStateData.eState: " .. GLOBAL_GET_INT(1965614 + 1497 + 724)
    }


    local text = table.concat(t, "\n")
    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then return end

    local MC_serverBD = 19746

    local iTeam = 0

    local t = {
        ""
    }

    local text = table.concat(t, "\n")
    draw_text(text)
end)








menu.divider(Job_Mission_Test, "fm_mission_controller_2020")

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then return end

    local MC_serverBD = 50150

    local iTeam = 0

    local t = {
        ""
    }

    local text = table.concat(t, "\n")
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

menu.action(Job_Mission_Test, "Get Native Info", {}, "", function()
    local t = {
        "GET_NUM_RESERVED_MISSION_OBJECTS: " .. NETWORK.GET_NUM_RESERVED_MISSION_OBJECTS(false, 0),
        "GET_NUM_RESERVED_MISSION_PEDS: " .. NETWORK.GET_NUM_RESERVED_MISSION_PEDS(false, 0),
        "GET_NUM_RESERVED_MISSION_VEHICLES: " .. NETWORK.GET_NUM_RESERVED_MISSION_VEHICLES(false, 0),
        "GET_NUM_CREATED_MISSION_OBJECTS: " .. NETWORK.GET_NUM_CREATED_MISSION_OBJECTS(false),
        "GET_NUM_CREATED_MISSION_PEDS: " .. NETWORK.GET_NUM_CREATED_MISSION_PEDS(false),
        "GET_NUM_CREATED_MISSION_VEHICLES: " .. NETWORK.GET_NUM_CREATED_MISSION_VEHICLES(false),
    }

    local text = table.concat(t, "\n")
    toast(text)
end)


menu.divider(Job_Mission_Test, "")
menu.toggle_loop(Job_Mission_Test, "Show Script Host", {}, "", function()
    local text = ""

    if IS_SCRIPT_RUNNING("fmmc_launcher") then
        local fmmc_launcher_host = players.get_name(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("fmmc_launcher", -1, 0))
        text = text .. "fmmc_launcher host: " .. fmmc_launcher_host .. "\n"
    end

    if IS_SCRIPT_RUNNING("freemode") then
        local freemode_host = players.get_name(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0))
        text = text .. "freemode host: " .. freemode_host
    end

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "信息显示 任务脚本主机", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    util.spoof_script(script, function()
        local host = players.get_name(NETWORK.NETWORK_GET_HOST_OF_THIS_SCRIPT())

        util.draw_debug_text(script .. " Host: " .. host)
    end)
end)
menu.action(Job_Mission_Test, "成为任务脚本主机", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    if not util.request_script_host(script) then
        util.toast("成为任务脚本主机 失败")
        return
    end

    util.yield()

    local isHost = false
    util.spoof_script(script, function()
        isHost = NETWORK.NETWORK_IS_HOST_OF_THIS_SCRIPT()
    end)

    if not isHost then
        util.toast("成为任务脚本主机 失败")
        return
    end

    util.toast("成为任务脚本主机 成功")
end)







----------------------------------------
--    Script Event Test
----------------------------------------

local Script_Event_Test <const> = menu.list(Menu_Root, "Script Event Test", {}, "")

local AllScriptEvents = {
    [-825801109] = "CLEANUP_ACID_LAB",
    [70144883] = "CLEANUP_SUPPORT_BIKE",
    [724230594] = "UPDATE_ACID_LAB_LOCKSTATE",
    [1496652116] = "CREATE_ACID_LAB_UNDER_MAP",
    [92231268] = "PAPERBOY_HIT_DELIVERED",
    [-642704387] = "TICKER_MESSAGE",
    [-1801288766] = "TICKER_MESSAGE_CUSTOM",
    [800157557] = "GENERAL",
    [-1525416261] = "LAUNCH_TIMED_COP_MISSION",
    [-1968768940] = "JOINABLE_SCRIPT",
    [1808840101] = "EXCLUDE_PLAYER",
    [-1013606569] = "REQUEST_TO_WARP",
    [485477315] = "RESPONSE_TO_WARP",
    [-1640419269] = "REQUEST_TO_WARP_INTO_VEHICLE",
    [-489610609] = "RESPONSE_TO_WARP_INTO_VEHICLE",
    [1292842567] = "INVITE_TO_JOIN_MP_MISSION",
    [-1156597129] = "INVITE_TO_JOIN_AMBIENT_SCRIPT",
    [1360244486] = "JOIN_SCRIPT_IF_NOT_ON_SCRIPT",
    [489928194] = "STOLEN_VEHICLE_SCANNED",
    [-70348966] = "OFF_MISSION_INTERACTION",
    [1448191991] = "BACKUP_NEEDED",
    [2068171338] = "SWAP_MAP_OBJECT",
    [-440651555] = "START_BUYING_DRUGS",
    [-2134203395] = "SOLD_DRUGS",
    [-2143033398] = "MAKE_HOLD_UP_ACTIVE",
    [921195243] = "HOLD_UP_FAKE_DONE",
    [1925046697] = "SET_HOLD_UP_DONE",
    [-227823823] = "IN_HOLD_UP_STORE",
    [-351075546] = "IN_HOLD_UP_STORE_STRICT",
    [-2095300399] = "HOLD_UP_TRIGGER_EMPTY_REG",
    [-750559436] = "NOTIFY_COPS_OF_HOLD_UP",
    [830204282] = "CANCEL_COP_PATROL",
    [-1595661064] = "RACE_TO_POINT_INVITE",
    [-221407512] = "RACE_TO_POINT_CANCEL_INVITE",
    [-852946413] = "RACE_TO_POINT_REACHED_DESTINATION",
    [1489206770] = "BULL_SHARK_ON",
    [-1297129143] = "BULL_SHARK_OFF",
    [996099702] = "INVITE_TO_APARTMENT",
    [-1974408814] = "CANCEL_INVITE_TO_APARTMENT",
    [331423856] = "TEXT_MESSAGE_USING_LITERAL",
    [790324273] = "SPAWN_OCCLUSION_AREA_FOR_MISSION",
    [-985640574] = "ASSIGN_PLAYER_A_NEW_CODE_NAME",
    [-1478462195] = "HIT_CHECKPOINT",
    [-1144717585] = "LAMAR_HIT_CHECKPOINT",
    [46758331] = "AGGREGATE_RACE_OVER",
    [-1257929937] = "RACE_POS",
    [674358812] = "IMPROMPTU_DM_REPLY",
    [-2046488977] = "IMPROMPTU_DM_REQUEST",
    [-255601196] = "DM_VEH_KILL",
    [1321815212] = "FIRST_KILL",
    [-1873258089] = "DM_REWARD_CASH",
    [-243421234] = "DM_FINISHED",
    [-584633745] = "DM_BULLSHARK",
    [-694832268] = "RACE_FINISHED",
    [345763700] = "HIT_TARGET",
    [-1842662384] = "RESET_TARGETS",
    [-645482653] = "SET_ARENA_ANNOUNCER_SOUND_BS",
    [-862713486] = "FMMC_CLEAR_FIRE_EVENT",
    [-2101783800] = "NOTIFY_DAMAGER_OF_FIRE_TRAP_DAMAGE",
    [-1338841683] = "NOTIFY_WANTED_SET_FOR_VEHICLE",
    [-216334921] = "FMMC_SET_VEHICLE_IMMOVABLE",
    [1185422646] = "FMMC_REMOTE_VEHICLE_EXPLOSION",
    [1936952754] = "RACE_NJVS_VOTED",
    [1552761002] = "RACE_RALLY_ARROWS",
    [-2051624621] = "DEV_SPECTATE_CONTINUE",
    [2008601170] = "DEV_SPECTATE_LBD_GO",
    [1219385733] = "JOB_INTRO",
    [-1918866827] = "EXEC_DROP",
    [-1275019346] = "BAG_DROP",
    [-503325966] = "LEAVE_VEHICLE",
    [-306678306] = "CLEANUP_PV",
    [511118845] = "CLEANUP_TRUCK_CAB",
    [-1857907332] = "CLEANUP_TRUCK_TRAILER",
    [1794509667] = "CLEANUP_AVENGER",
    [21877292] = "CLEANUP_HACKER_TRUCK",
    [97609215] = "CLEANUP_SUBMARINE",
    [312122415] = "CLEANUP_SUBMARINE_DINGHY",
    [659755529] = "DJ_CLUB_MUSIC_DATA",
    [-95607521] = "SET_PLAYER_ARRESTABLE",
    [1517551547] = "SET_BOUNTY_ON_PLAYER",
    [2098360921] = "BOUNTY_OVER",
    [-1886123256] = "LEAVE_BOUNTY",
    [1269949700] = "CHARACTER_STAT_DATA_QUERY_INT",
    [-1547064369] = "CHARACTER_STAT_DATA_QUERY_FLOAT",
    [-2122488865] = "CHARACTER_STAT_DATA_QUERY_BOOL",
    [1786704858] = "CHARACTER_STAT_DATA_SEND_INT",
    [-1654501984] = "CHARACTER_STAT_DATA_SEND_FLOAT",
    [1677702660] = "CHARACTER_STAT_DATA_SEND_BOOL",
    [109434679] = "PERSONAL_VEHICLE_STOLEN",
    [1169945323] = "WAR",
    [473977978] = "SET_SHIPMENT_DOOR_LOCKSTATE",
    [1621405488] = "BEHIND_POLICE_DOOR",
    [1213173357] = "OPEN_POLICE_DOOR",
    [-472432012] = "BEHIND_PRISON_GATE",
    [542081926] = "OPEN_PRISON_GATE",
    [236974293] = "PROPERTY_TAKEOVER",
    [1693450033] = "SET_TEAM_TARGET_TERRITORY",
    [-1849280215] = "FMMC_OBJECTIVE_COMPLETE",
    [681303157] = "NETWORK_INDEX_FOR_LATER_RULE",
    [-242068405] = "BMB_BOMB_PLACED",
    [1973676008] = "BMB_PICKUP_CREATED",
    [-1191891172] = "BMB_PROP_DESTROY",
    [-1907551039] = "FMMC_PLAYER_CROSSED_THE_LINE",
    [-1048869137] = "FMMC_PLAYER_IS_SWAN_DIVE_SCORING",
    [-928610258] = "RANDOM_SPAWN_SLOT_USED",
    [32012762] = "PRON_PLAYERS_DRAWING_TRAILS",
    [1100337345] = "FMMC_TRIGGERED_BODY_SCANNER",
    [-116775390] = "FMMC_OBJECTIVE_END_MESSAGE",
    [-1973211860] = "FMMC_PLAYER_KNOCKED_OUT",
    [-1261519271] = "FMMC_PLAYER_KNOCKED_OUT_NOISE",
    [1554913608] = "FMMC_PLAYER_SWITCHED_TEAMS",
    [-517172617] = "FMMC_PED_GIVEN_GUNONRULE",
    [-688408229] = "FMMC_PED_COMBAT_STYLE_CHANGED",
    [-556896699] = "FMMC_PED_WAITING_AFTER_GOTO",
    [-251385090] = "FMMC_PED_DONE_WAITING_AFTER_GOTO",
    [-860190766] = "FMMC_PED_CLEAR_GOTO_WAITING_STATE",
    [-1077769870] = "FMMC_PED_DEFENSIVE_AREA_GOTO_CLEANED_UP",
    [632558101] = "FMMC_PED_DIRTY_FLAG_SET",
    [-743218354] = "FMMC_ANIM_STARTED",
    [-487774749] = "FMMC_ANIM_STOPPED",
    [354129590] = "FMMC_SECONDARY_ANIM_CLEANUP",
    [-207816074] = "FMMC_TREVOR_BODHI_BREAKOUT_SYNCH_SCENE_ID",
    [-92159980] = "FMMC_GO_FOUNDRY_HOSTAGE_SYNCH_SCENE_ID",
    [1168334649] = "FMMC_PED_INVENTORY_CLEANUP",
    [-1203749370] = "FMMC_REMOVE_PED_FROM_GROUP",
    [-493614734] = "FMMC_PED_SUCCESSFULLY_REMOVED_FROM_GROUP",
    [2144138006] = "FMMC_PED_ADDED_TO_CC",
    [1943072873] = "FMMC_PED_ADDED_TO_CHARM",
    [901809442] = "FMMC_PED_REMOVED_FROM_CHARM",
    [-1788110225] = "FMMC_CC_NEW_PARTCONTROLLER",
    [976269167] = "FMMC_CC_PED_BEATDOWN",
    [2065948146] = "FMMC_CC_PED_BEATDOWN_CLEAR",
    [-891053525] = "FMMC_CC_PED_BEATDOWN_HIT",
    [-1928082281] = "FMMC_CC_FAIL",
    [1791132025] = "FMMC_CC_DIALOGUE_CLIENT_TO_HOST",
    [1480069940] = "FMMC_CC_DIALOGUE_HOST_TO_CLIENTS",
    [-988680051] = "FMMC_CC_AWARD",
    [2032112353] = "FMMC_CC_DEAD",
    [2007883737] = "FMMC_SAFETY_DEPOSIT_BOX_LOOTED",
    [-994303175] = "FMMC_OCCUPY_SAFETY_DEPOSIT_BOX_CABINET",
    [1472054923] = "FMMC_PAINTING_STOLEN",
    [770949062] = "FMMC_GRAB_CASH",
    [-2074218566] = "FMMC_GRAB_CASH_DROP_CASH",
    [1340718905] = "FMMC_GRAB_CASH_DISPLAY_TAKE",
    [1833326986] = "FMMC_REQUEST_RESTRICTION_ROCKETS",
    [-726855469] = "FMMC_OPEN_DOOR",
    [760100327] = "FMMC_SWAP_DOOR_FOR_DAMAGED_VERSION",
    [-1345093153] = "FMMC_TREVOR_COVER_CONVERSATION_TRIGGERED",
    [-1162760531] = "FMMC_PICKED_UP_POWERPLAY_POWERUP",
    [-1248635465] = "FMMC_PICKED_UP_LIVES_PICKUP",
    [-1484757921] = "FMMC_PICKED_UP_POWERPLAY_PICKUP",
    [678487596] = "FMMC_POWERPLAY_PICKUP_ENDED",
    [-1646027645] = "FMMC_PP_PICKUP_PLAY_ANNOUNCER",
    [1618150171] = "FMMC_CANT_DECREMENT_SCORE",
    [1855541331] = "FMMC_MISSION_EQUIPMENT",
    [-206073737] = "DATA_FMMC_SPAWN_PICKUP",
    [-2055852684] = "FMMC_LOCH_SANTOS_MONSTER",
    [2112842196] = "FMMC_MODEL_SWAP",
    [1278623228] = "FMMC_SPAWN_PED_AMMO_PICKUP",
    [-809738197] = "FMMC_REMOVE_PED_AMMO_PICKUP",
    [-1404232591] = "FMMC_SHOW_REZ_TICKER",
    [1498840888] = "FMMC_SHOW_REZ_SHARD",
    [-185637351] = "FMMC_TEAM_CHECKPOINT_PASSED",
    [-1054853926] = "FMMC_PICKED_UP_VEHICLE_WEAPON",
    [1799240698] = "FMMC_ACTIVATE_VEHICLE_WEAPON",
    [-233606230] = "FMMC_REQUEST_EXTRA_LIFE_FROM_PICKUP",
    [552755951] = "FMMC_VEHICLE_WEAPON_SOUND",
    [-875270279] = "FMMC_DETONATE_PROP",
    [1325364634] = "FMMC_TOGGLE_PROP_CLAIMING",
    [-422978529] = "FMMC_CLAIM_PROP",
    [665603983] = "FMMC_TARGET_PROP_SHOT",
    [845662336] = "FMMC_RESET_ALL_PROPS",
    [-1509415975] = "FMMC_SMASHED_BY_TOUCH",
    [1743838956] = "FMMC_STEAL_OBJECT",
    [1636964625] = "FMMC_APPLY_EXTRA_VEH_DAMAGE_FROM_COLLISION",
    [901008778] = "FMMC_DECREMENT_REMAINING_TIME",
    [-1069260930] = "FMMC_INCREMENT_REMAINING_TIME",
    [1884708548] = "FMMC_START_PRE_COUNTDOWN_STOP",
    [-1483527804] = "FMMC_LOCATE_ALERT_SOUND",
    [754498703] = "FMMC_PROP_DESTROYED",
    [-1569939096] = "FMMC_CLEAR_HAS_BEEN_ON_SMALLEST_TEAM",
    [551528057] = "FMMC_CONDEMNED_DIED",
    [212395624] = "FMMC_SHARD_BOMBUSHKA_MINI_ROUND_END_EARLY",
    [450342880] = "FMMC_PLAY_PULSE_SFX",
    [-1943385788] = "FMMC_BOMBUSHKA_NEW_ROUND_SHARD",
    [-107806796] = "FMMC_SHOWDOWN_DAMAGE",
    [268477538] = "FMMC_SHOWDOWN_ELIMINATION",
    [1535425282] = "FMMC_BMBFB_EXPLODE_BALL",
    [718233939] = "FMMC_BMBFB_GOAL",
    [1868797439] = "FMMC_ARENA_TRAP_ACTIVATED",
    [-39801880] = "FMMC_ARENA_TRAP_DEACTIVATED",
    [-1351892839] = "FMMC_ARENA_LANDMINE_TOUCHED",
    [-65043796] = "FMMC_ARENA_ARTICULATED_JOINT",
    [-805075223] = "FMMC_MOVE_FMMC_YACHT",
    [1017623532] = "FMMC_METAL_DETECTOR_ALERTED",
    [-2015790266] = "FMMC_CCTV_REACHED_DESTINATION",
    [1689130548] = "FMMC_SET_ARTIFICIAL_LIGHTS",
    [911236861] = "FMMC_INTERIOR_DESTRUCTION",
    [-883636085] = "FMMC_INTERACT_WITH_EVENT",
    [277508486] = "FMMC_UPDATE_DOOR_LINKED_ENTITIES",
    [-2057730552] = "FMMC_ACTIVATE_ELEVATOR",
    [840866290] = "FMMC_CALL_ELEVATOR",
    [434253941] = "FMMC_ZONE_TIMER",
    [1295826463] = "FMMC_PHONE_EMP_EVENT",
    [-1619352151] = "FMMC_POISON_GAS",
    [-1859579689] = "FMMC_DIRECTIONAL_DOOR_EVENT",
    [-1682444584] = "FMMC_TRIGGER_AGGRO_FOR_TEAM",
    [-1381782315] = "FMMC_PLAY_SYNC_SCENE_FACIAL_ANIM",
    [-696110572] = "FMMC_TRIGGER_AGGRO_FOR_TEAM_LEGACY",
    [-882774828] = "FMMC_BLOCK_WANTED_CONE_RESPONSE_EVENT",
    [1262194935] = "FMMC_UPDATE_MINIGAME_OFF_RULE_EVENT",
    [1521244608] = "FMMC_UPDATE_DOOR_OFF_RULE_EVENT",
    [121898416] = "FMMC_COP_DECOY_EVENT",
    [-713706416] = "FMMC_COP_BEHAVIOUR_OVERRIDE_EVENT",
    [-1314282935] = "FMMC_THERMITE_EFFECT_EVENT",
    [1145497846] = "FMMC_HARD_TARGET_NEW_TARGET_SHARD",
    [1049081606] = "FMMC_RESET_INDIVIDUAL_PROP",
    [1534998773] = "FMMC_PROP_CLAIMED_SUCCESSFULLY_BY_PART",
    [-1388433285] = "FMMC_TURF_WARS_TEAM_LEADING_CHANGED",
    [1515212653] = "FMMC_PROP_CONTESTED",
    [-1413458482] = "FMMC_PROP_CLAIMED",
    [1256592628] = "FMMC_COLLECTED_WEAPON",
    [1735064874] = "FMMC_RESPAWNED_WEAPON",
    [385289427] = "FMMC_REQUEST_RIGHTFUL_PROP_COLOUR_FROM_HOST",
    [441692490] = "FMMC_RECEIVE_RIGHTFUL_PROP_COLOUR_FROM_HOST",
    [-348588420] = "FMMC_POWER_UP_STOLEN",
    [-574169884] = "FMMC_REMOTE_VEHICLE_SWAP",
    [1078862215] = "FMMC_OVERTIME_SCORED",
    [-718533546] = "FMMC_AIRSHOOTOUT_SCORED",
    [94579007] = "FMMC_KILLSTREAK_POWERUP_ACTIVATED_FREEZE_POS",
    [268646358] = "FMMC_KILLSTREAK_POWERUP_ACTIVATED_TURF_TRADE",
    [1673994003] = "FMMC_MANUAL_RESPAWN_TO_PASSENGERS",
    [-1399576575] = "FMMC_KILL_PLAYER_NOT_AT_LOCATE",
    [-774813079] = "FMMC_BROADCAST_PREREQS",
    [1085855935] = "FMMC_GHOST_STARTED",
    [-1385469702] = "FMMC_SPAWN_PROTECTION_ALPHA",
    [2012970876] = "FMMC_ALPHA_CHANGE",
    [-1417270427] = "FMMC_PLAYER_ALPHA_WITH_WEAPON",
    [-1620733523] = "FMMC_DELIVER_VEHICLE_STOP",
    [1482058198] = "FMMC_SHARED_RENDERTARGET_EVENT",
    [-1946226138] = "FMMC_FOR_INSTANCED_CONTENT",
    [1802943345] = "FMMC_START_SCRIPTED_ANIM_CONVERSATION",
    [-1111418514] = "FMMC_ENTITY_DAMAGED_EVENT_FAKE",
    [-884339433] = "FMMC_AUDIO_TRIGGER_ACTIVATED",
    [-1371518135] = "FMMC_SET_BILLIONAIRE_PARTY_STATE",
    [-1244902478] = "FMMC_REMOVE_DUMMY_BLIP",
    [-1974444575] = "FMMC_TURF_WAR_SCORED",
    [-1381815544] = "FMMC_LEFT_LOCATE_DELAY_RECAPTURE",
    [-1514442960] = "FMMC_INITIATE_SEAT_SWAP_TEAM_VEHICLE",
    [419297535] = "FMMC_OVERTIME_ROUND_CHANGE",
    [862953666] = "FMMC_OVERTIME_ROUND_CHANGE_TURNS",
    [-1428889829] = "FMMC_OVERTIME_RESET_TURNS_AND_SCORE",
    [1187417153] = "FMMC_OVERTIME_LANDING",
    [140212610] = "FMMC_OVERTIME_VEHICLE_DESTROYED",
    [544805172] = "FMMC_SUMO_ZONE_TIME_EXTEND_SHARD",
    [-258214892] = "FMMC_PP_TEAM_INTRO_ROOT",
    [-591040888] = "FMMC_PP_PRE_INTRO_ROOT",
    [2068799778] = "FMMC_PP_SUDDDEATH_ROOT",
    [-955932219] = "FMMC_PP_WINNER_ROOT",
    [1553314011] = "FMMC_PP_EXIT_ROOT",
    [-1826400021] = "FMMC_PP_MANUAL_MUSIC_CHANGE",
    [1882023452] = "FMMC_IAO_SFX_PLAY",
    [1503743722] = "FMMC_TP_TRANSFORM_SFX",
    [-1429672749] = "FMMC_RUGBY_PLAY_SOUND",
    [-1600038423] = "FMMC_DISTANCE_GAINED",
    [-1582094961] = "FMMC_SUDDEN_DEATH_REASON",
    [-1950395758] = "FMMC_OVERRIDE_LIVES_FAIL",
    [1525910828] = "DEBUG_OBJECTIVE_SKIP_FOR_TEAM",
    [312843496] = "FMMC_PLAYER_SCORE",
    [973905825] = "FMMC_DISPLAY_CUSTOM_OBJECT_PICKUP_SHARD",
    [-5824515] = "FMMC_INCREMENT_TEAM_SCORE_RESURRECTION",
    [1720046017] = "FMMC_INCREMENTED_LOCAL_PLAYER_SCORE",
    [409660429] = "FMMC_OVERTIME_SCORED_SHARD",
    [-1646943037] = "FMMC_OVERTIME_REMOVE_VEHICLE",
    [762321585] = "FMMC_RUMBLE_TEAM_SCORES_SHARD",
    [386021326] = "FMMC_OVERTIME_PAUSE_RENDERPHASE",
    [1269531025] = "FMMC_EXIT_MISSION_MOC",
    [1198440081] = "FMMC_STOLEN_FLAG_SHARD",
    [-1446825422] = "FMMC_CAPTURED_FLAG_SHARD",
    [-1216916890] = "FMMC_RETURNED_FLAG_SHARD",
    [744758564] = "FMMC_TAGGED_ENTITY",
    [-827089923] = "FMMC_CCTV_SPOTTED",
    [162557496] = "FMMC_CCTV_EVENT",
    [17006661] = "FMMC_LOCATE_STOCKPILE_SOUND",
    [-1917868794] = "FMMC_LOCATE_CAPTURE_PLAYER_SCORE",
    [-1444790657] = "FMMC_DIALOGUE_LOOK",
    [1161158278] = "FMMC_PED_RETASK_HANDSHAKE",
    [1573680147] = "FMMC_START_SYNC_LOCK_HACK_TIMER",
    [875407480] = "FMMC_DELIVER_CUTSCENE_VEH",
    [-173074921] = "FMMC_OBJECTIVE_MID_POINT",
    [1772600142] = "FMMC_CUTSCENE_SPAWN_PROGRESS",
    [1485096848] = "FMMC_PRI_FIN_MCS2_PLANE_NON_CRITICAL",
    [1442900799] = "FMMC_PRI_FIN_MCS2_PLANE_CLEANUP",
    [406896637] = "FMMC_MOCAP_PLAYER_ANIMATION",
    [-834368638] = "FMMC_CUTSCENE_PLAYER_REQUEST",
    [628626497] = "FMMC_LOWER_LIFT_WARP",
    [-2063735769] = "FMMC_UPPER_LIFT_WARP",
    [1144811583] = "FMMC_APARTMENTWARP_CS_REQUEST",
    [284778178] = "FMMC_APARTMENTWARP_CS_RELEASE",
    [-793987806] = "FMMC_REMOTELY_ADD_RESPAWN_POINTS",
    [-859331176] = "FMMC_INTERACTABLE",
    [-2084365157] = "FMMC_ADD_GRABBED_CASH",
    [-348912014] = "FMMC_REMOVE_GRABBED_CASH",
    [1352797507] = "FMMC_LOCATION_INPUT_TRIGGERED",
    [1307613846] = "FMMC_OBJECT_CARRIER_ALERT",
    [95371092] = "FMMC_PLAYER_ABILITY_ACTIVATED",
    [1078731808] = "FMMC_SOUND_ZONE",
    [18275] = "FMMC_ZONE_AIR_DEFENCE_SHOT",
    [2045500918] = "FMMC_PED_HEARING",
    [-1166320472] = "FMMC_PED_SPOOKED",
    [-1065404810] = "FMMC_PED_UNSPOOKED",
    [-14203583] = "FMMC_PED_SPOOK_HURTORKILLED",
    [806577542] = "FMMC_PED_GIVEN_SPOOKED_GOTO_TASK",
    [1637781065] = "FMMC_PED_GIVEN_UNSPOOKED_GOTO_TASK",
    [861362309] = "FMMC_PED_UPDATE_TASKED_GOTO_PROGRESS",
    [921924864] = "FMMC_PED_AGGROED",
    [-1850753446] = "FMMC_AGGROED_SCRIPT_FORCED_PED",
    [-1062937189] = "FMMC_PED_SPEECH_AGGROED",
    [-1897331664] = "FMMC_PED_CANCEL_TASKS",
    [-2050133835] = "FMMC_PED_SPEECH_AGRO_BITSET",
    [-238307165] = "FMMC_START_STREAMING_END_MOCAP",
    [1995019175] = "FMMC_TEAM_HAS_FINISHED_CUTSCENE",
    [-483186747] = "FMMC_MY_WEAPON_DATA",
    [-515608795] = "FMMC_TEAM_HAS_EARLY_CELEBRATION",
    [-304125940] = "FMMC_DRILL_ASSET",
    [-364552928] = "FMMC_REQUEST_BINBAG",
    [-56926755] = "FMMC_INVESTIGATE_CONTAINER",
    [1819888169] = "FMMC_BINBAG_OWNER_CHANGED",
    [-491825853] = "FMMC_TRASH_DRIVE_ENABLE",
    [1820928415] = "FMMC_HEIST_LEADER_PLAY_COUNT",
    [20381331] = "FMMC_SVM_LEADER_PLAY_COUNT",
    [-420783202] = "FMMC_OBJECTIVE_REVALIDATE",
    [-352822052] = "FMMC_FORCING_EVERYONE_FROM_VEH",
    [464796389] = "FMMC_PLAYER_TEAM_SWITCH_REQUEST",
    [135327204] = "FMMC_VIP_MARKER_POSITION",
    [-1767880119] = "VAULT_DRILL_EFFECT_EVENT",
    [-1164304147] = "VAULT_DRILL_ASSET_REQUEST_EVENT",
    [-1531407042] = "VAULT_DRILL_PROGRESS_EVENT",
    [-1205686672] = "FMMC_SHUNT_POWERUP",
    [-60546449] = "FMMC_POWERUP_SOUND",
    [1490708557] = "FMMC_SET_PED_UNIT_STATE",
    [516029934] = "SERVER_AUTHORISED_TEAM_SWAP",
    [872970752] = "CLIENT_TEAM_SWAP_COMPLETE",
    [700407288] = "TERRITORY_CASH",
    [-44188161] = "TERRITORY_KILL",
    [-1426942980] = "MEETING_ACTIVE",
    [-433009319] = "ADD_TO_AVALIABLE_MISSIONS",
    [-699641045] = "REMOVE_PLAYER_FROM_ALL_AVALIABLE_MISSIONS",
    [-2135659127] = "REMOVE_PLAYER_FROM_THIS_AVALIABLE_MISSION",
    [209706016] = "TEAM_ARREST_DIE_WARP",
    [1402149483] = "NEXT_EXPECTED_COP_MISSION",
    [1790527807] = "REQUEST_NEW_MISSION_OF_TYPE",
    [1214811719] = "REQUEST_NEW_SPECIFIC_MISSION",
    [668479480] = "REQUEST_JOIN_EXISTING_MISSION",
    [305758732] = "RESERVE_MISSION_BY_PLAYER",
    [-69240130] = "RESERVE_MISSION_BY_LEADER",
    [-1343306814] = "CONFIRM_RESERVED_FOR_MISSION",
    [47655170] = "START_RESERVED_MISSION",
    [-297627286] = "CANCEL_MISSION_RESERVATION_BY_PLAYER",
    [354670805] = "CANCEL_MISSION_RESERVED_BY_LEADER",
    [-1725440811] = "CHANGE_RESERVED_MISSION_DETAILS",
    [1541018842] = "INVITE_PLAYER_ONTO_MISSION",
    [1186559054] = "PLAYER_WARPED_BECAUSE_OF_INVITE",
    [-366707054] = "FORCE_PLAYER_ONTO_MISSION",
    [-770180912] = "REPLY_PLAYER_JOINED_MISSION",
    [-458778574] = "REPLY_PLAYER_FAILED_TO_JOIN_MISSION",
    [-180869819] = "REPLY_PLAYER_ENDED_MISSION",
    [-901768496] = "MISSION_REQUEST_FINISHED",
    [-1515435012] = "MISSION_REQUEST_FAILED",
    [-1577766279] = "MISSION_REQUEST_MISSION_FULL",
    [1537523179] = "MISSION_REQUEST_CHANGE_UNIQUEID",
    [1276163489] = "MISSION_REQUEST_PLAYER_ON_MISSION",
    [-1634378433] = "CHECK_IF_STILL_OK_TO_JOIN_MISSION",
    [1757622014] = "CONFIRMATION_LAUNCH_MISSION",
    [1631863242] = "REASON_FOR_MISSION_REQUEST_FAILURE",
    [1538777886] = "MISSION_NOT_JOINABLE",
    [412738426] = "MISSION_JOINABLE_AGAIN_FOR_PLAYERS",
    [-608922521] = "MISSION_READY_FOR_SECONDARY_TEAMS",
    [-1899281683] = "FORCE_PLAYER_FROM_MISSION_REQUEST",
    [1625721778] = "FORCE_PLAYER_QUIT_PREMISSION",
    [-819388467] = "MRINFO_MISSION_JUST_STARTED",
    [-1454704731] = "FREEMODE_INVITE_GENERAL",
    [-1145616223] = "ADD_ACTIVITY_TO_PENDING_ACTIVITIES",
    [-856493615] = "REGISTER_MS_CLOUD_BASIC_DATA",
    [1821361454] = "REGISTER_MS_CLOUD_DESCRIPTION_DATA",
    [1059964730] = "REGISTER_MS_CLOUD_NAMES_DATA",
    [-688766203] = "REGISTER_MS_CLOUD_DETAILS_DATA",
    [1657302810] = "REQUEST_FULL_MS_CLOUD_DATA",
    [604825270] = "UNREGISTER_MS_CLOUD_MISSION",
    [-1681825192] = "SETUP_PLAYER_CHOICE_GROUP_MISSION",
    [-1089682296] = "DELIVERED_CUSTODY_CROOK_TO_DROP_OFF",
    [-708494477] = "LEAVE_CUSTODY_GET_TO_DROP_TIMER_ENDED",
    [-2047126310] = "VAN_DOORS_BEEN_BLOWN_OPEN",
    [892676538] = "SECURITY_VAN_CREATE_MONEY",
    [-1877358087] = "KILLED_HORDE_PED",
    [-904539506] = "CORONA_SYNC_TEAMS",
    [-1677864235] = "COP_CAN_SEE_WANTED_NPC",
    [-1943760162] = "NPC_CRIME_COMMITTED",
    [2133577347] = "NPC_CRIME_REPORT",
    [630191280] = "PLAYER_AVAILABLE_FOR_BETTING",
    [-1225769426] = "PLAYER_LEFT_BETTING",
    [-421485104] = "BETTING_POOL_LOCKED",
    [-1475173745] = "VIRTUAL_CASH_BET",
    [384871537] = "VIRTUAL_CASH_REJECTED",
    [-1396120036] = "PLAYER_CLEAR_CORONA_SLOT",
    [-1063040691] = "PLAYER_JOINED_VOTE",
    [704885250] = "CORONA_PLAYER_ANIMATION",
    [-628570887] = "CORONA_PLAYER_PURCHASED_ARMOR",
    [-346976655] = "LAUNCH_FM_TRIGGER_TUT",
    [-1242582143] = "LAUNCH_FM_TRIGGER_TUT_DM",
    [1825959511] = "PLAYER_STARTED_FM_TRIGGER_TUT",
    [-155515863] = "PLAYER_READY_FOR_DM_TUT",
    [27445046] = "PLAYER_READY_FOR_HOLD_UP_TUT",
    [54884912] = "PLAYER_START_HOLD_UP_TUT",
    [1475033331] = "REQUEST_NPC_INVITE",
    [360707510] = "PASSENGERS_RUN_SCANNER_ON_VEHICLE",
    [-21564015] = "MAKE_PLAYERS_PARTNERS",
    [-830063381] = "GIVE_PLAYER_CASH_FROM_LAST_JOB",
    [1340682521] = "ARM_WRESTLE_UPDATE",
    [554549413] = "ARM_WRESTLE_TABLE_ACTIVATE",
    [-1249235193] = "ARM_WRESTLE_TABLE_POSITIONS",
    [285774088] = "ARM_WRESTLE_BUCKET_COLLECTION",
    [1303822404] = "DARTS_UPDATE",
    [1706418749] = "DARTS_BOARD_ACTIVATE",
    [1841098008] = "DARTS_DANGER_ZONE_UPDATE",
    [1812909382] = "DARTS_ENEMY_PRESENT",
    [666659573] = "MP_PROSTITUTION_KILL_THREAD",
    [-1858619043] = "BALL_UPDATE",
    [2100975970] = "FAULT",
    [-1300990023] = "OOB",
    [-800317609] = "POINT_WON",
    [495916342] = "HIT_BEFORE_BOUNCE",
    [1158536892] = "GET_OFF_MY_SIDE",
    [-1748128791] = "QUIT",
    [1624615515] = "TargetStatusChange",
    [-1456452635] = "CreateRandomTarget",
    [744818000] = "Skill",
    [-1065897857] = "Shots",
    [-1478912997] = "ShotsRound",
    [-1663366994] = "PlayerQuitRange",
    [-1319201654] = "EVENT_ALTER_NON_LOCAL_PLAYER_AWARDS",
    [276367769] = "OHD_IN_MP_CUTSCENE",
    [973071710] = "OHD_IS_WANTED",
    [-1019014207] = "OHD_IS_CUFFED",
    [742672229] = "OHD_IS_BEING_PROCESSED",
    [-525674633] = "OHD_IN_CUSTODY",
    [320349598] = "OHD_IS_BEING_CUFFED",
    [-1742050195] = "OHD_IS_BEING_UNCUFFED",
    [1100320285] = "OHD_HAS_KEYS",
    [752544403] = "OHD_PLAYER_ROLE",
    [-53300463] = "OHD_HEIST_ROLE",
    [173886263] = "OHD_TALKING",
    [-1238213211] = "OHD_INVISIBLE",
    [-1507442482] = "OHD_TELEPORT",
    [-1368408833] = "OHD_PARTNER",
    [-1608366263] = "OHD_IS_VOTING",
    [131402765] = "OHD_IS_PLAYER_SPECTATING",
    [786145470] = "OHD_IS_PLAYER_PAUSING",
    [947746716] = "OHD_IS_PLAYER_PASSIVE",
    [1625753371] = "OHD_IS_RALLY_DRIVER",
    [1331533566] = "OHD_IS_RALLY_PASSENGER",
    [-854676202] = "OHD_TAGGED_REMOTE_PLAYER",
    [-980126594] = "OHD_IS_RESPAWNING",
    [-307075051] = "OHD_IN_MP_CUTSCENE_RESET",
    [1976797232] = "OHD_IS_WANTED_RESET",
    [969963183] = "OHD_IS_CUFFED_RESET",
    [1275765085] = "OHD_IS_BEING_PROCESSED_RESET",
    [-1235934848] = "OHD_IN_CUSTODY_RESET",
    [1490610283] = "OHD_IS_BEING_CUFFED_RESET",
    [1837431216] = "OHD_IS_BEING_UNCUFFED_RESET",
    [1944393806] = "OHD_HAS_KEYS_RESET",
    [-1324810510] = "OHD_TALKING_RESET",
    [-1508425407] = "OHD_INVISIBLE_RESET",
    [2037599821] = "OHD_TELEPORT_RESET",
    [427978404] = "OHD_PARTNER_RESET",
    [-2010253278] = "OHD_IS_VOTING_RESET",
    [-35133785] = "OHD_IS_PLAYER_SPECTATING_RESET",
    [-1133455371] = "OHD_IS_PLAYER_PAUSING_RESET",
    [-1552848514] = "OHD_IS_PLAYER_PASSIVE_RESET",
    [-1038339567] = "OHD_IS_RALLY_DRIVER_RESET",
    [843189135] = "OHD_IS_RALLY_PASSENGER_RESET",
    [2079562891] = "OHD_TAGGED_REMOTE_PLAYER_RESET",
    [1414398544] = "OHD_IN_IMPROMPTU_RACE_COUNTDOWN",
    [-783944077] = "OHD_IN_IMPROMPTU_RACE_COUNTDOWN_RESET",
    [-1760661233] = "OHD_USING_CHAT_WINDOW",
    [476054205] = "OHD_USING_CHAT_WINDOW_RESET",
    [-1722237414] = "OHD_IS_RESPAWNING_RESET",
    [1619668539] = "QUERY_SPECIFIC_SPAWN_POINT",
    [738588402] = "ASK_SERVER_FOR_CONTACT_REQUEST",
    [-2066493927] = "ASK_SERVER_FOR_CLEAR_PENDING_CONTACT_REQUEST",
    [-836944817] = "TELL_SERVER_CONTACT_REQUEST_COMPLETE",
    [677734991] = "SERVER_SEND_RESPONSE_FOR_CONTACT_REQUEST",
    [1638329709] = "SERVER_SEND_RESPONSE_FOR_CLEAR_CONTACT_REQUEST",
    [645554251] = "PLAYER_BEGIN_CR_TARGET_COOLDOWN",
    [-1465780376] = "SERVER_VEHICLE_SPAWN_FAIL",
    [-1659629763] = "SERVER_VEHICLE_SPAWN_REQUEST",
    [1814376422] = "SERVER_VEHICLE_SPAWN_COMPLETE",
    [1432378003] = "TRANSITION_PARAMETER_CHANGED",
    [-1804721998] = "YOURE_GOING_TO_FOLLOW_ME",
    [-1773335296] = "SEND_BASIC_TEXT",
    [1655503526] = "CAR_INSURANCE",
    [323285304] = "REQUEST_TO_SPAWN_VEHICLE",
    [-1516223898] = "CLEAR_SPAWN_VEHICLE_REQUEST",
    [-452973862] = "RESPONSE_TO_SPAWN_VEHICLE",
    [87964287] = "REMOVE_WINDOW_REQUEST",
    [-340339913] = "PROPERTY_MESS",
    [-1832152488] = "CORONA_MATCHMAKING_CLOSED",
    [-247998055] = "CORONA_MATCHMAKING_OPEN",
    [718406913] = "EXCLUDE_PLAYER_FROM_CURRENT_MISSION",
    [637164059] = "JOBLIST_INVITE_REPLY",
    [77165180] = "REQUEST_CORONA_VEHICLE_WORLD_CHECK",
    [1691063220] = "REPLY_CORONA_VEHICLE_WORLD_CHECK",
    [72011763] = "CORONA_VEHICLE_WORLD_CHECK_IS_NO_LONGER_REQUIRED",
    [1980857009] = "HEIST_UPDATE_ROLES",
    [1242653348] = "HEIST_SETUP_INIT_DATA",
    [-712467334] = "HEIST_UPDATE_CUTS",
    [1392195419] = "HEIST_UPDATE_STATUS",
    [1046798818] = "HEIST_UPDATE_ROLE_SINGLETON",
    [1169323649] = "HEIST_UPDATE_CUT_SINGLETON",
    [485727405] = "HEIST_UPDATE_OUTFIT_SINGLETON",
    [1156767422] = "HEIST_SYNC_GLOBAL_DATA",
    [40620324] = "HEIST_REMOVE_MEMBER",
    [1637760414] = "HEIST_PRE_PLAN_REQUEST_MISSION_MEMBERS",
    [728200248] = "HEIST_PRE_PLAN_DOWNLOAD_MISSION_MEMBERS",
    [-912750342] = "HEIST_PRE_PLAN_ABANDON_PLANNING",
    [-2051197492] = "HEIST_MEDAL_DATA",
    [894833172] = "HEIST_BEGIN_HACK_MINIGAME",
    [1918151566] = "HEIST_END_HACK_MINIGAME",
    [-872106351] = "HEIST_UPDATE_CUT_SINGLETON_TUTORIAL",
    [-1089170834] = "HEIST_QUIET_KNOCKING",
    [1678175620] = "HEIST_PLAYER_IN_TURRET",
    [-2026172248] = "CORONA_PLAYER_OUTFIT",
    [1318264045] = "CORONA_PLAYER_OUTFIT_FROM_LEADER",
    [-866285931] = "CORONA_OUTFIT_STYLE_FROM_MEMBER",
    [658221619] = "CORONA_MASK_STYLE_FROM_MEMBER",
    [-478626914] = "CORONA_OUTFIT_CHANGE",
    [-1229530943] = "CORONA_VERSUS_OUTFIT_STYLE_CHANGE",
    [-308394398] = "CORONA_SCTV_LAUNCHED_JOB",
    [1123248983] = "SYNC_WHEEL_ROTATION",
    [-778470954] = "REQUEST_WHEEL_ROTATION",
    [604158588] = "ATTACH_REMOTE_PLAYER_TO_CAR",
    [518061381] = "DETACH_REMOTE_PLAYER_FROM_CAR",
    [76329662] = "REQUEST_ATTACH_REMOTE_PLAYER_TO_CAR",
    [1722921560] = "REQUEST_INTERACT_CAR",
    [735026609] = "INTERACT_CAR",
    [1223595735] = "CLEAR_INTERACT_CAR",
    [-2120841502] = "CLEAR_WHEEL_DATA",
    [-544979849] = "SET_ROLLERCOASTER_HIDDEN",
    [260853325] = "SYNC_ROLLERCOASTER_DIST",
    [-584642945] = "REQUEST_ROLLERCOASTER_DIST",
    [386680788] = "ATTACH_REMOTE_PLAYER_TO_COASTER",
    [2106712608] = "DETACH_REMOTE_PLAYER_FROM_COASTER",
    [178067438] = "REQUEST_ATTACH_REMOTE_PLAYER_TO_COASTER",
    [-973934490] = "MODIFY_COASTER_OCCUPANTS",
    [597065108] = "AUTHORISE_COASTER_ENTRY",
    [-688049763] = "PERSONAL_VEHICLE_SET",
    [-122334439] = "HEIST_UPDATE_OUTFITS",
    [-2102799478] = "HEIST_RESYNC_HOST",
    [-1704545346] = "REMOVE_WANTED_LEVEL",
    [-159225502] = "SET_COPS_DISABLED",
    [57493695] = "OFF_THE_RADAR",
    [-390379542] = "AML_SET_HPV_RUNNING",
    [1657054023] = "AML_RUN_SPC_CRATE",
    [-1601747497] = "AML_DONE_SPC_CRATE",
    [-2038957354] = "NETWORK_ROULETTE_MSG",
    [-1955663765] = "NETWORK_ROULETTE_LAYOUT_MSG",
    [-323269370] = "SNITCH_KILLED",
    [-1321657966] = "INVITE_NEARBY_PLAYERS_INTO_APARTMENT",
    [-1489975132] = "READY_TO_START_INTRO_ANIMS",
    [763250190] = "HEIST_POSIX_AND_HASHED_MAC",
    [-331576754] = "BLOCK_SAVE_EOM_CAR_BEEN_DELIVERED",
    [-1604421397] = "LAUNCH_SYNCED_INTERACTION",
    [2025035989] = "SYNC_SPECTATOR_CELEBRATION_GLOBALS_1",
    [-1488914969] = "SYNC_SPECTATOR_CELEBRATION_GLOBALS_2",
    [-1795010198] = "SYNC_SPECTATOR_CELEBRATION_GLOBALS_3",
    [262551687] = "FMMC_PRI_STA_IG2_AUDIOSTREAM",
    [547174234] = "FMMC_SPECTATOR_PLAY_POSTFX",
    [-60356752] = "PROPERTY_DETAILS_ON_JOINING",
    [2134025627] = "CHECK_IF_ENTITY_IN_CORONA_AND_MOVE",
    [1927637822] = "SEND_LAST_FM_EVENT_VARIATION",
    [-1091407522] = "CHECKPOINT_COLLECTION_REACHED_CHECKPOINT",
    [1949038040] = "CHECKPOINT_COLLECTION_GIVE_REWARD",
    [907805624] = "HOT_TARGET_ROUTE",
    [-289807473] = "UW_TARGET_VEH_RESET",
    [-1522997624] = "UW_VEH_DAMAGEABLE_BY_REL_GROUP",
    [-798996443] = "UW_PED_DAMAGEABLE_BY_REL_GROUP",
    [-1257215590] = "UW_TARGET_ON_FOOT_RESET",
    [-1682859301] = "PENNED_IN_REMOVE_BOMB",
    [1649541577] = "HUNT_THE_BEAST_UPDATE_GLOBAL",
    [677929255] = "UW_PED_TOO_FAR_FROM_TARGETS",
    [1757455147] = "FLASH_BEAST_BLIP",
    [-1529273040] = "UW_KILL_LIST_SAVAGE_EMPTY",
    [-1195009211] = "UW_KILL_LIST_VEH_EMPTY",
    [1814121203] = "LAUNCH_FREEMODE_EVENT",
    [1008530949] = "BOSSVBOSS_DM_REQUEST",
    [568317294] = "BOSSVBOSS_DM_REPLY",
    [1475256484] = "BOSSVBOSS_DM_JOIN_MY_BOSS",
    [-1006718654] = "BOSS_DROP",
    [2059116267] = "KILL_ACTIVE_BOSS_MISSION",
    [-332947903] = "KILL_ACTIVE_BOSS_MISSION_LOCAL",
    [-1140090124] = "REQUEST_BOSS_LIMO",
    [-935999832] = "DELETE_OLD_BV",
    [1613825825] = "GB_BOSS_WORK_REQUEST_SERVER",
    [-1984060350] = "GB_BOSS_WORK_SERVER_CONFIRM",
    [618715507] = "GB_CLEAR_REMOTE_PLAYER_GANG_MEMBERSHIP",
    [-627920584] = "GB_REQUEST_JOIN_GANG",
    [1360435217] = "GB_CONFIRM_JOIN_GANG",
    [-245642440] = "GB_INVITE_TO_GANG",
    [1506966550] = "GB_CLEAR_GANG_INVITE",
    [-337848027] = "BEEN_PAID_GOON_CASH",
    [-1372296667] = "GB_PLAYER_COLLECTED_CASH",
    [-1141119736] = "GB_GIVE_GANG_BOSS_CUT_FROM_EARNINGS",
    [936332224] = "GB_REFRESH_LIMO_LOCKS",
    [-305178342] = "GB_BRIBE_POLICE",
    [-8632816] = "ACQUIRE_VEHICLE_DELIVERED_VEHICLE",
    [1508186571] = "SERVER_RECEIVED_ACQUIRE_VEHICLE_DELIVERED_VEHICLE_EVENT",
    [949664396] = "GB_SET_REMOTE_PLAYER_AS_TERMINATE_TARGET",
    [-11681548] = "GB_BOSS_STARTED_USING_SCTV",
    [2103624094] = "GB_BOSS_CHANGED_NAME",
    [85456166] = "CASHING_OUT_UPDATE_BLOCKED_ATMS",
    [-1533311581] = "CASHING_OUT_UPDATE_ATM_BLIP",
    [1757547104] = "AIRFREIGHT_RESTART_DISCONNECT_TIMER",
    [1848995112] = "CONTRABAND_SELL_START_RADAR_JAM",
    [-1042813739] = "CONTRABAND_SELL_STOP_RADAR_JAM",
    [885204421] = "GB_SET_VEHICLE_AS_TARGETABLE_BY_HOMING_MISSILE",
    [-1906536929] = "GB_TRIGGER_DEFEND_MISSION",
    [1531565154] = "GB_DISABLE_GOON_MEMBERSHIP",
    [-808991722] = "CONTRABAND_DESTROYED",
    [1499902640] = "VEHICLE_EXPORT_GIVE_WANTED_LEVEL",
    [-2141807967] = "VEHICLE_EXPORT_SWITCH_SCENARIOS",
    [1454233258] = "GB_JAILBREAK_UPDATE_PED_LOOKAT_DATA",
    [-1541764116] = "GB_SET_PLAYER_GANG_ROLE",
    [1450115979] = "GB_NON_BOSS_CHALLENGE_REQUEST",
    [-303464741] = "GB_MEMBER_ABANDONED_CLUB",
    [-870197185] = "GB_START_TARGET_RIVAL",
    [-1293290367] = "GB_NON_BOSS_DROP_REQUEST",
    [-275400208] = "GUNRUN_ENTITY_DESTROYED",
    [-1124103843] = "GUNRUN_GIVE_WANTED_LEVEL",
    [1701527465] = "BUSINESS_GIVE_WANTED_LEVEL",
    [1380319383] = "OPEN_SHUT_PV_DOOR",
    [234399205] = "SET_PV_NEON_LIGHTS",
    [516561068] = "SET_PV_RADIO_STATION",
    [1572141092] = "LEAVE_PV_ENGINE_RUNNING",
    [-693433553] = "SET_PV_LIGHTS",
    [639280612] = "SET_PV_STANCE",
    [-1449487290] = "SET_PV_ROOF",
    [420484319] = "SET_PV_HYDRAULICS",
    [1537359195] = "CLAIM_FM_PICKUP",
    [-797526379] = "RESPONSE_TO_CLAIM_FM_PICKUP",
    [-1503701661] = "REASSIGN_PRIVATE_YACHT",
    [-1326826303] = "RESERVE_PRIVATE_YACHT",
    [-1729437672] = "AIRDEF_EXPLOSION_PRIVATE_YACHT",
    [-157970864] = "AIRDEF_DIALOGUE_PRIVATE_YACHT",
    [-1942741326] = "DELETE_YACHT_VEHICLES_NOW",
    [-10776728] = "DISABLE_RECORDING_FOR_SPHERE",
    [-13748324] = "DELETE_ABANDONED_VEHICLES_ON_YACHT_NOW",
    [247853458] = "GANG_LEAVE_OFFICE_IN_HELI",
    [-1253241415] = "WARP_TO_QUICK_TRAVEL_DESTINATION",
    [-1059717102] = "LAND_ON_OFFICE_ROOFTOP",
    [-195193033] = "DM_PASS_THE_BOMB_TAGGED",
    [1948378614] = "DM_PLAYER_BLIP",
    [-151371384] = "DM_GIVE_TEAM_LIVES",
    [654315547] = "DM_PLAYER_OUT_OF_BOUNDS",
    [-2138576439] = "KOTH_FLASH_AREA",
    [114330056] = "KOTH_SET_CAPTURE_DIR",
    [-526446234] = "KOTH_GIVE_SCORE",
    [1604327849] = "KOTH_PLAYER_GOT_A_KILL",
    [1139523020] = "KOTH_EXPLODED_A_VEHICLE",
    [1758744649] = "TAKEOFF_WARP_DONE",
    [-1496371358] = "TRIGGER_EXIT_ALL_FROM_SIMPLE_INTERIOR",
    [-1943732854] = "TRIGGER_CASINO_ROOF_CELEB_MOCAP",
    [1790127094] = "REQUEST_SIMPLE_INTERIOR_INT_SCRIPT_INSTANCE",
    [57454917] = "CONFIRM_SIMPLE_INTERIOR_INT_SCRIPT_INSTANCE_USED",
    [1469411235] = "FREE_SIMPLE_INTERIOR_INT_SCRIPT_INSTANCE",
    [610587469] = "BOOS_POACH_METRIC",
    [-1483692319] = "ASYNC_GRID_WARP_REQUEST",
    [168585591] = "ASYNC_GRID_WARP_FINISH",
    [-800312339] = "ASYNC_GRID_WARP_REQUEST_CONFIRM",
    [1932558939] = "ASYNC_GRID_WARP_FINISH_CONFIRM",
    [-1638522928] = "PLAYERS_WARP_INSIDE_SIMPLE_INTERIOR",
    [331253544] = "PLAYERS_WARP_INSIDE_SIMPLE_INTERIOR_ON_DELIVERY",
    [1916113629] = "SKYDIVING_JUMP_COMPLETED",
    [-347033775] = "SKYDIVING_ALL_JUMPS_COMPLETED",
    [-1235428989] = "SKYDIVING_ALL_JUMPS_GOLD",
    [-512200431] = "WARP_THESE_PLAYERS_TO_MUSIC_STUDIO_SMOKING_ROOM",
    [288412940] = "NPC_INVITE_TO_SIMPLE_INTERIOR",
    [-1986344798] = "INVITE_TO_SIMPLE_INTERIOR",
    [252548743] = "CANCEL_INVITE_TO_SIMPLE_INTERIOR",
    [-21508430] = "UPDATE_CLUBHOUSE_MISSION_LIST",
    [1256087515] = "STOP_STUNT_VEHICLE_RESPAWNED",
    [756960095] = "OFFROAD_RACE_USING_SPAWNED_VEHICLE",
    [-1353750176] = "SET_PERSONAL_VEHICLE_AS_DESTROYED",
    [-1883896298] = "FMMC_PLAYER_COMMITED_SUICIDE",
    [435278553] = "REQUEST_WAREHOUSE_DATA",
    [-1101672680] = "WAREHOUSE_DATA_A",
    [-353458099] = "WAREHOUSE_DATA_B",
    [-1713699293] = "WAREHOUSE_DATA_C",
    [25942316] = "DELIVERED_SINGLE_CRATE",
    [-972329058] = "GANG_STATUS_CHANGED",
    [-355760685] = "DCTL_TURN",
    [79354218] = "DCTL_KILL",
    [443059258] = "DCTL_START",
    [-53885027] = "DCTL_RESHUFFLE",
    [-2013943038] = "SCGW_MINIGAME_PICKUP_COLLECTED",
    [296141736] = "SCGW_INITIALS_ENTERED",
    [385697842] = "SCGW_MINIGAME_SIDE_CLAIMED",
    [743327592] = "SCGW_MINIGAME_REQUEST_CARS",
    [444085151] = "SCGW_MINIGAME_DAMAGED",
    [-923880358] = "CMHDZ_INITIALS_ENTERED",
    [-1317020601] = "TLG_INITIALS_ENTERED",
    [457347143] = "CASINO_ARCADE_REQUEST_LEADERBOARD_EVENT",
    [-2031658982] = "CASINO_ARCADE_SEND_LEADERBOARD_EVENT",
    [1953474326] = "CASINO_ARCADE_UPDATE_LEADERBOARD_EVENT",
    [1103127469] = "GROUP_WARP",
    [-755078549] = "GB_FORCE_OBJECTIVE_UPDATE",
    [-795729444] = "BIKER_FACTORY_SUPPLY_DELIVERED",
    [-1465672381] = "BIKER_FAIL_CHECKPOINT",
    [-1251853784] = "LOCK_ANY_DUPE_AMBIENT_VEHICLES",
    [-1021750126] = "BIKER_PLAY_BLOOD_EFFECT",
    [-1189151448] = "MG_LAUNCH_REQUEST",
    [782289832] = "MG_LAUNCH_USER",
    [-507549791] = "MG_LEADER",
    [-1976279059] = "MG_FINISH",
    [-1791283509] = "MG_INTERACT_CHANGED",
    [-1817300978] = "MG_ALLOW_PARTICIPATE",
    [-1132370403] = "MG_FORCE_STOP_INTERACT",
    [-1434163096] = "MG_SCRIPT_ACTIVE",
    [-905010113] = "MG_DART_THROW",
    [-246874112] = "MG_DART_RESET",
    [-198838079] = "MG_DART_NEXT_PLAYER",
    [1314832288] = "MG_ARM_RUN_STATE",
    [1976190313] = "MG_ARM_WAITING",
    [-871965653] = "MG_ARM_RUNNING",
    [313842340] = "MG_ARM_WIN_LOSS",
    [1692415541] = "MG_ARM_CANCEL",
    [-2106618499] = "MG_REMATCH",
    [1074136593] = "MG_ARM_GAME_END",
    [-279129112] = "APART_ARM_WRESTLE_UPDATE",
    [-899807318] = "APART_ARM_WRESTLE_TABLE_ACTIVATE",
    [1512747414] = "APART_ARM_WRESTLE_TABLE_POSITIONS",
    [733525153] = "APART_ARM_WRESTLE_BUCKET_COLLECTION",
    [917162788] = "APART_DARTS_UPDATE",
    [-997026791] = "APART_DARTS_BOARD_ACTIVATE",
    [-1798499196] = "APART_DARTS_DANGER_ZONE_UPDATE",
    [2070031356] = "APART_DARTS_ENEMY_PRESENT",
    [2004874702] = "LAUNCH_DELIVERY_SCRIPT",
    [-858850233] = "START_DELIVERY_CUTSCENE",
    [1024992419] = "PLAYER_DELIVERED_VEHICLE",
    [1341432330] = "PLAYER_DELIVERED_VEHICLE_SCR",
    [-697373430] = "PLAYER_DELIVERED_VEHICLE_BUYER",
    [-36374257] = "OK_TO_CLEANUP_EXPORT_VEHICLE",
    [-644688386] = "REQUEST_SVM_START_HELI",
    [1603454446] = "GET_IN_SVM_HELI",
    [849081025] = "REQUEST_SERVER_PERMISSION_TO_CLEANUP_EXPORT_VEHICLE",
    [556010831] = "START_PRE_SELL_VEHICLE_MOD",
    [-1031449797] = "STOCKPILING_PACKAGE_COLLECTION",
    [483554543] = "STOCKPILING_PACKAGE_DESTROYED",
    [-1808230600] = "VELOCITY_CHECKPOINT_COLLECTION",
    [-205630711] = "EXPORT_VEHICLE_UPDATE_CURRENT_CHECKPOINT",
    [530297562] = "MOVE_BETWEEN_OFFICE_GARAGE_AND_MOD",
    [897061790] = "UPDATE_PV_LOCKSTATE",
    [1186805738] = "UPDATE_TRUCK_LOCKSTATE",
    [1433450626] = "UPDATE_HACKER_TRUCK_LOCKSTATE",
    [-1601328614] = "GUNRUN_VEHICLE_UPDATE_CURRENT_CHECKPOINT",
    [363257584] = "SMUGGLER_VEHICLE_UPDATE_CURRENT_CHECKPOINT",
    [241394468] = "OPEN_BOMB_BAY_DOORS",
    [-177816760] = "SET_CHAFF_LOCK_ON",
    [302119011] = "DECREMENT_AIRCRAFT_AMMO",
    [-1909656724] = "WARP_BUYSELL_SCRIPT_VEHICLE",
    [839452587] = "FREEMODE_DELIVERY_REQUEST_DELIVERABLE_ID",
    [-351465844] = "FREEMODE_DELIVERY_CLEANUP_DELIVERABLE_ID",
    [676123185] = "FREEMODE_DELIVERY_REQUEST_DROPOFF_ACTIVATION",
    [-258917302] = "FREEMODE_DELIVERY_REQUEST_DROPOFF_MISSION_ID_ASSIGNMENT",
    [-1098727618] = "DRIVER_ENTERED_SIMPL_INT",
    [259469385] = "BOSS_SHOULD_LAUNCH_WVM",
    [959168580] = "SHOOT_RANGE_TARGET_HIT",
    [9372724] = "SHOOT_RANGE_TARGET_SPAWN",
    [1372616349] = "SLIDING_DOOR_STATE",
    [-1243026642] = "OK_TO_CLEANUP_DELIVERABLE_ENTITY",
    [-353240116] = "OK_TO_KICK_ALL_PLAYERS_FROM_DELIVERABLE_ENTITY",
    [-330501227] = "FM_DELIVERABLE_DELIVERY",
    [-1852117343] = "FM_MULTIPLE_DELIVERABLE_DELIVERY",
    [716234734] = "TRUCK_RENOVATE",
    [-901348601] = "BAIL_ME_FOR_SCTV",
    [1504695802] = "REQUEST_BOSS_LIMO_FADE_IN",
    [-350684627] = "TRANSITION_IN_OUT_BUNKER_WITH_TRUCK",
    [1916741085] = "REQUEST_PLAYER_WARP_PV_NEAR_COORDS",
    [-92532912] = "FORCE_CONCEAL_PERSONAL_VEHICLE",
    [-1463438297] = "REQUEST_HANGAR_PRODUCT_DATA",
    [-1544003568] = "SEND_HANGAR_PRODUCT_DATA",
    [446749111] = "DELIVERED_HANGAR_MISSION_PRODUCT_DATA",
    [1720702241] = "REMOVE_HANGAR_MISSION_PRODUCT_DATA",
    [1587022256] = "ADD_HANGAR_MISSION_PRODUCT_DATA",
    [-2123771537] = "BUSINESS_VEHICLE_UPDATE_CURRENT_CHECKPOINT",
    [641708561] = "TRANSITION_IN_OUT_BASE_WITH_AVENGER",
    [2060355156] = "CONTROL_AVENGER_AUTOPILOT",
    [2018407638] = "UPDATE_AVENGER_LOCKSTATE",
    [2104340171] = "AVENGER_AUTOPILOT_ACTIVATED",
    [-33572719] = "CAR_COLLECTOR_VEHICLE_COLOURS",
    [-74072551] = "GANGOPS_VEHICLE_COLOURS",
    [-1095651866] = "GANGOPS_REBOOT_PLANNING_SCREEN",
    [1533986374] = "KILL_ACTIVE_EVENT",
    [1872545935] = "DRONE_EMP",
    [1850356933] = "MBS_TRIGGER_PTFX",
    [1405597168] = "FMEVENT_VEHICLE_UPDATE_CURRENT_CHECKPOINT",
    [693772881] = "ADD_FMBB_VARIATION_TO_HISTORY",
    [-1469949550] = "CREATE_HACKER_TRUCK_UNDER_MAP",
    [1177025702] = "MBS_PRINT_DELIVERY_TICKER",
    [-1961259095] = "UPDATE_NIGHTCLUB_PEDS_SPEECH",
    [960798860] = "PROCESS_CASINO_NIGHTCLUB_PEDS_EVENT",
    [984596259] = "OWNER_WARPING_FROM_HUB_TO_TRUCK",
    [1925866046] = "TRIGGER_PROPERTY_SCRIPT_PED_EVENT",
    [1181366824] = "INCREMENT_PLAYER_APPEARANCES_IN_CLUB",
    [-427907743] = "ENTERING_CLUB_OR_HUB_IN_VEHICLE",
    [-1581280276] = "TRIGGER_SMPL_INT_GHOST_CHAIR",
    [-290548457] = "UPDATE_FROSTED_GLASS",
    [-2119458362] = "FM_EVENT_GIVE_WANTED_LEVEL",
    [-281553427] = "UPDATE_NIGHTCLUB_POPULARITY",
    [-171282281] = "USED_DRONE_STATION",
    [-2104378353] = "UPDATE_AMBIENT_SPEECH",
    [764918047] = "COLLECT_CHECKPOINTS",
    [213561616] = "DANCE_ACTION",
    [-1979765145] = "VEHICLE_EXISTENCE",
    [623462469] = "REQUEST_PLAYER_DATA",
    [1982477645] = "RESPOND_TO_DATA_REQUEST",
    [1349212974] = "REQUEST_PLAYER_VEHICLE_NAME",
    [-710178565] = "REQUEST_CASH_TRANSACTION",
    [1982590640] = "REMOTE_DRONE_SCRIPT",
    [-527835094] = "ARENA_SPECTATOR_TURRET_MISSILE_FIRED",
    [299956876] = "CASINO_FM_MISSION_CHIPS_RECOVERED",
    [-1118718122] = "CASINO_SURVIVAL_AIR_VEHICLE_DESTROYED",
    [967594150] = "CASINO_SURVIVAL_HEAVY_UNIT_KILLED",
    [1974348723] = "CASINO_LUCKY_WHEEL_SPIN",
    [-445044249] = "INSIDE_TRACK_MAIN_EVENT_REWARD",
    [-1073111938] = "INSIDE_TRACK_MAIN_EVENT_PLACED_BET",
    [-1005242824] = "INSIDE_TRACK_MAIN_EVENT_COMPLETED",
    [-1496300030] = "UPDATE_CASINO_LIMO_DESTINATION",
    [1399150425] = "UPDATE_CASINO_LIMO_PED_TASKS",
    [850430383] = "JOIN_OWNER_IN_SIMPLE_INTERIOR_LIMO_SERVICE",
    [-1875429128] = "UPDATE_CASINO_PEDS_SPEECH",
    [-725328141] = "BJACK_CARD",
    [447218114] = "CASINO_LUCKY_WHEEL_WINNER_BINK",
    [1791662864] = "CASINO_UPDATED_STEAL_PAINTING_STATE",
    [-1951335381] = "CASINO_PLAY_HEIST_CUTSCENE",
    [414491523] = "PEYOTE_ANIMAL",
    [66206781] = "PLAY_ARCADE_CABINET_ANIM",
    [1300457931] = "PLAY_ARCADE_CABINET_AI_CONTEXT",
    [-994831906] = "SET_CASINO_HEIST_MISSION_CONFIG_DATA",
    [-1138569583] = "UPDATE_ARCADE_CABINET_PROPS",
    [1897175391] = "SCOPE_OUT_CASINO_MAIN_ENTRANCE_PHOTOGRAPHED",
    [595672365] = "STOP_CLAW_ANIM",
    [-528513542] = "UPDATE_ARCADE_PEDS_SPEECH",
    [1461088877] = "UPDATE_ARCADE_FORTUNE_TELLER_ANIMS",
    [-1862089016] = "VAULT_KEY_CARDS_2_OUTFIT_EQUIPED",
    [448528136] = "UPDATE_ARCADE_LESTER_FORTUNE_TELLER_DOOR_ANIMS",
    [-939100601] = "FREEMODE_CONTENT_GIVE_WANTED_LEVEL",
    [737639610] = "FREEMODE_CONTENT_TICKER_MESSAGE",
    [1453927864] = "FREEMODE_CONTENT_UPDATE_CURRENT_CHECKPOINT",
    [-1140641850] = "FREEMODE_CONTENT_SET_LOCAL_BIT",
    [-126218586] = "FM_RANDOM_EVENT_REQUEST",
    [1568389507] = "FM_RANDOM_EVENT_UPDATE_TRIGGER",
    [968269233] = "COLLECTIBLE_COLLECTED",
    [874022534] = "UPDATE_PED_SPEECH",
    [1797156700] = "SET_MAX_LOCAL_PEDS",
    [1799415011] = "SUBMARINE_MISSLIE_LAUNCH_VFX",
    [-2056497110] = "CASINO_NIGHTCLUB_ANIM_EVENT",
    [1480731099] = "RESTART_LOBBY",
    [-488983389] = "STRENGTH_TEST_SET_COUNTDOWN_TIMER",
    [1552856339] = "STRENGTH_TEST_START_COUNTDOWN_TIMER",
    [1470595759] = "STRENGTH_TEST_REQUEST_HIGHSCORE",
    [745995059] = "STRENGTH_TEST_SEND_HIGHSCORE",
    [845456029] = "STRENGTH_TEST_VALIDATE_HIGHSCORE",
    [1202908870] = "STRENGTH_TEST_SET_HIGHSCORE",
    [953310420] = "STRENGTH_TEST_PERFORM_SCORE",
    [-579894567] = "STRENGTH_TEST_MOVE_NETWORK_DATA",
    [1381718368] = "STRENGTH_TEST_RESET_PED_CAPSULE",
    [310371467] = "CLUB_MUSIC_INTENSITY",
    [-298693230] = "CLUB_MUSIC_NEXT_INTENSITY",
    [1903198983] = "CLUB_MUSIC_REQUEST_INTENSITY",
    [1608735052] = "CLUB_MUSIC_SEND_INTENSITY_TO_PLAYER",
    [-2128328191] = "CLUB_MUSIC_DJ_SWITCH_SCENE",
    [761448019] = "CLUB_MUSIC_UPDATE_DJ_PED_AFTER_SWITCH_SCENE",
    [373376135] = "INVITE_TO_HEIST_ISLAND_BEACH_PARTY",
    [1669592503] = "HEIST_ISLAND_WARP_TRANSITION",
    [1859445565] = "CANCEL_INVITE_TO_HEIST_ISLAND_BEACH_PARTY",
    [578768314] = "SET_HEIST_ISLAND_CONFIG_DATA",
    [-418572806] = "NHPG_PREP_COMPLETED",
    [-375628860] = "ISLAND_BACKUP_HELI_LAUNCH",
    [-388078569] = "CLEANUP_SYNCED_AMBIENT_PICKUP",
    [2021051510] = "DELETE_SYNCED_AMBIENT_PICKUP",
    [-1731262701] = "SET_SYNCED_AMBIENT_PICKUP_COORDS",
    [606464409] = "CREATE_FMC_INVITE",
    [1894566603] = "UPDATE_FMC_INVITE",
    [1770122689] = "SET_PED_FADE_OUT",
    [-852119003] = "SET_PED_FADE_OUT_FOR_OTHER_PLAYERS",
    [-192018217] = "MUSIC_STUDIO_CHANGE_DRE_WORK_STATE",
    [1307088748] = "MUSIC_STUDIO_UPDATE_PEDS_AFTER_SWITCH_SCENE",
    [-1616114832] = "UPDATE_AGENCY_SUV_DESTINATION",
    [-1457947843] = "UPDATE_AGENCY_SUV_PED_TASKS",
    [778946289] = "LAUNCH_CUSTOM_PED_UPDATE_ACTION"
}

local ScriptEventDetails = memory.alloc(8 * 2)
menu.toggle_loop(Script_Event_Test, "Get Network Script Event", {}, "", function()
    -- SCRIPT_EVENT_QUEUE_NETWORK = 1
    local eventType = 174 -- EVENT_NETWORK_SCRIPT_EVENT

    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        if SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex) == eventType then
            if SCRIPT.GET_EVENT_DATA(1, eventIndex, ScriptEventDetails, 2) then
                local eventHash = memory.read_int(ScriptEventDetails)
                local FromPlayerIndex = memory.read_int(ScriptEventDetails + 8)

                local eventName = AllScriptEvents[eventHash]
                if eventName then
                    eventName = eventName .. " (" .. eventHash .. ")"
                else
                    eventName = eventHash
                end

                local text = string.format(
                    "Script Event: %s\nFrom Player: %s\nTime: %s",
                    eventName,
                    players.get_name(FromPlayerIndex),
                    os.date("%Y-%m-%d %H:%M:%S", util.current_unix_time_seconds())
                )

                toast(text)
            end
        end
    end
end)

menu.action(Script_Event_Test, "log current time", {}, "", function()
    local text = os.date("%Y-%m-%d %H:%M:%S", util.current_unix_time_seconds())
    toast(text)
end)





-- local function GB_SET_PLAYER_CONTRABAND_MISSION_DATA(iWarehouse, contrabandSize, contrabandType, bSpecialItem)
--     local contrabandMissionData = GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData()
--     GLOBAL_SET_INT(contrabandMissionData.iMissionWarehouse, iWarehouse)
--     GLOBAL_SET_INT(contrabandMissionData.contrabandSize, contrabandSize)
--     GLOBAL_SET_INT(contrabandMissionData.contrabandType, contrabandType)
--     GLOBAL_SET_BOOL(contrabandMissionData.bSpecialItem, bSpecialItem)
-- end

-- menu.action(Menu_Root, "GB_BOSS_REQUEST_CONTRABAND_MISSION_LAUNCH_FROM_SERVER", {}, "", function()
--     -- GB_BOSS_REQUEST_CONTRABAND_MISSION_LAUNCH_FROM_SERVER(iMissionID, iSelectedSCWarehouse, eSelectedShipmentSize, eActiveContrabandType, bActivateSpecialItemMission)

--     GB_SET_PLAYER_CONTRABAND_MISSION_DATA(0, 10, 8, false)
--     GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(167, -1, -1, 0)
-- end)


-- local function GB_SET_PLAYER_GUNRUNNING_MISSION_DATA(eLocation)
--     local gunrunningMissionData = GlobalplayerBD_FM_3.sMagnateGangBossData.gunrunningMissionData()
--     GLOBAL_SET_INT(gunrunningMissionData.eLocation, eLocation)
-- end

-- menu.action(Menu_Root, "GB_BOSS_REQUEST_GUNRUNNING_MISSION_LAUNCH_FROM_SERVER", {}, "", function()
--     -- GB_BOSS_REQUEST_GUNRUNNING_MISSION_LAUNCH_FROM_SERVER(INT iMission, FREEMODE_DELIVERY_LOCATION eLocation = FREEMODE_DELIVERY_LOCATION_CITY)

--     GB_SET_PLAYER_GUNRUNNING_MISSION_DATA(0)
--     GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(225, -1, -1, -1)
-- end)




--- @param script string|integer
--- @param pattern string
--- @param patch function
local function patch_script_byte(script, pattern, patch)
    local addr = memory.scan_script(script, pattern)
    if not addr or addr == 0 then
        toast("Scan pattern failed!\n" .. script .. ": " .. pattern)
        return
    end

    patch(addr)
end
