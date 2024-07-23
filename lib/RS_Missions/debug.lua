local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "DEBUG")

local Freemode_Mission = Menu_Root
local Heist_Mission = Menu_Root




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




----------------------------------------
--    Start Freemode Mission
----------------------------------------

local Start_Freemode_Mission <const> = menu.list(Heist_Mission, "开始自由模式任务", {}, "")

local StartFreemodeMission = {
    iMission = 0,
    iVariation = -1,
    iSubVariation = -1,
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
}


menu.list_select(Start_Freemode_Mission, "Mission", {}, "", FreemodeMissions, 0, function(value)
    StartFreemodeMission.iMission = value
end)

menu.slider(Start_Freemode_Mission, "Variation", {}, "",
    -1, 999, -1, 1, function(value)
        StartFreemodeMission.iVariation = value
    end)
menu.slider(Start_Freemode_Mission, "Sub Variation", {}, "",
    -1, 999, -1, 1, function(value)
        StartFreemodeMission.iSubVariation = value
    end)

menu.action(Start_Freemode_Mission, "Start Mission", {}, "", function()
    if StartFreemodeMission.iMission == 0 then
        return
    end
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(StartFreemodeMission.iMission,
        StartFreemodeMission.iVariation, StartFreemodeMission.iSubVariation)
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

menu.toggle_loop(Freemode_Test, "Show Local Info", { "t" }, "", function()
    local script = "am_pi_menu"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local text = string.format(
        "ePiStage: %s, bCursorAccept: %s, iCursorValueChange: %s\nbiStoreActive: %s, bGBMenuShouldRefresh: %s, biListenForDoubleTap: %s",
        LOCAL_GET_INT(script, 1526),
        LOCAL_GET_INT(script, 1679),
        LOCAL_GET_INT(script, 1683),
        LOCAL_BIT_TEST(script, 1691, 18),
        LOCAL_GET_INT(script, 1501),
        LOCAL_BIT_TEST(script, 1691, 31)

    )

    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show Global Info", {}, "", function()
    -- Global_2710523.f_8191
    -- PIMenuData.iCurrentSelection

    -- Global_2710428
    -- g_iPIM_SubMenu

    -- Global_4541816
    -- g_iMenuCursorItem

    -- Global_2672855.f_990.f_6
    -- MPGlobals.PlayerInteractionData.iLaunchStage

    -- Global_2710431
    -- g_bPIM_ResetMenuNow

    -- Global_2710523.f_8192, 1
    -- PIMenuData.iMenuBitSet, biM_MenuSetup

    -- Global_2710429
    -- g_bPIM_SelectAvailable


    local text = string.format(
        "iCurrentSelection: %s, g_iPIM_SubMenu: %s, g_iMenuCursorItem: %s\nPlayerInteractionData.iLaunchStage: %s\nbiM_MenuSetup: %s, g_bPIM_SelectAvailable:%s\niBS_PauseMenuFlags: %s",
        GLOBAL_GET_INT(2710523 + 8191),
        GLOBAL_GET_INT(2710428),
        GLOBAL_GET_INT(4541816),
        GLOBAL_GET_INT(2672855 + 990 + 6),
        GLOBAL_BIT_TEST(2710523 + 8192, 1),
        GLOBAL_GET_INT(2710429),
        GLOBAL_GET_INT(1574589)
    )

    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show CUTSCENE", {}, "", function()
    local text = string.format(
        "IS_CUTSCENE_PLAYING: %s\nIS_CUTSCENE_ACTIVE: %s\nIS_PLAYER_IN_CUTSCENE: %s\nNETWORK_IS_IN_MP_CUTSCENE: %s",
        CUTSCENE.IS_CUTSCENE_PLAYING(),
        CUTSCENE.IS_CUTSCENE_ACTIVE(),
        NETWORK.IS_PLAYER_IN_CUTSCENE(players.user()),
        NETWORK.NETWORK_IS_IN_MP_CUTSCENE()
    )
    draw_text(text)
end)
menu.toggle_loop(Freemode_Test, "Show SESSION", {}, "", function()
    local text = string.format(
        "NETWORK_SESSION_IS_PRIVATE: %s\nNETWORK_IS_SESSION_ACTIVE: %s\nNETWORK_IS_IN_SESSION: %s\nNETWORK_IS_SESSION_STARTED: %s\nNETWORK_IS_SESSION_BUSY: %s",
        NETWORK.NETWORK_SESSION_IS_PRIVATE(),
        NETWORK.NETWORK_IS_SESSION_ACTIVE(),
        NETWORK.NETWORK_IS_IN_SESSION(),
        NETWORK.NETWORK_IS_SESSION_STARTED(),
        NETWORK.NETWORK_IS_SESSION_BUSY()
    )
    draw_text(text)
end)



menu.action(Freemode_Test, "注册为CEO", {}, "", function()
    local ePiStage = 1526

    local g_iPIM_SubMenu = 2710428
    local PIMenuData = {
        iCurrentSelection = 2710523 + 8191
    }
    local g_bPIM_ResetMenuNow = 2710431


    local script = "am_pi_menu"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- PLAYER_CONTROL, INPUT_INTERACTION_MENU
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1.0)

    repeat
        util.yield()
    until LOCAL_GET_INT(script, ePiStage) == 1

    GLOBAL_SET_INT(g_iPIM_SubMenu, 116) -- REGISTER AS A BOSS
    GLOBAL_SET_INT(PIMenuData.iCurrentSelection, 0)

    GLOBAL_SET_BOOL(g_bPIM_ResetMenuNow, true)

    util.yield(50)

    -- FRONTEND_CONTROL, INPUT_CELLPHONE_SELECT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 176, 1.0)

    repeat
        util.yield()
    until GLOBAL_GET_INT(g_iPIM_SubMenu) == 27 -- Start an Organization
    GLOBAL_SET_INT(PIMenuData.iCurrentSelection, 0)

    util.yield(10)

    -- FRONTEND_CONTROL, INPUT_CELLPHONE_SELECT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 176, 1.0)

    util.yield(10)

    -- FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)

    util.yield(10)

    if LOCAL_GET_INT(script, ePiStage) == 1 then
        -- PLAYER_CONTROL, INPUT_INTERACTION_MENU
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1.0)
    end
end)
menu.action(Freemode_Test, "切换到 邀请战局", {}, "", function()
    local g_Private_Players_FM_SESSION_Menu_Choice = 1575035
    local g_PauseMenuMissionCreatorData = {
        iBS_PauseMenuFlags = 1574589
    }

    -- FM_SESSION_MENU_CHOICE_JOIN_CLOSED_INVITE_ONLY
    GLOBAL_SET_INT(g_Private_Players_FM_SESSION_Menu_Choice, 11)

    -- bsPauseRequestingTransition, bsPauseMenuRequestingNewSession
    GLOBAL_SET_BITS(g_PauseMenuMissionCreatorData.iBS_PauseMenuFlags, 0, 5)

    util.yield(200)

    GLOBAL_SET_INT(g_PauseMenuMissionCreatorData.iBS_PauseMenuFlags, 0)
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
        "iActiveMission: %s\niMissionToLaunch: %s",
        GLOBAL_GET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.iActiveMission()),
        GLOBAL_GET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.iMissionToLaunch())
    )

    draw_text(text)
end)


menu.divider(Test_Start_Mission, "Freemode Mission")

menu.click_slider(Test_Start_Mission, "Request FMMC_TYPE Mission", { "fmmcReq" }, "", 0, 400, 0, 1, function(value)
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(value)
end)
menu.click_slider(Test_Start_Mission, "Start FMMC_TYPE Mission", { "fmmcStart" }, "", 0, 400, 0, 1, function(value)
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
        "MissionName: %s, iRootContentIDHash: %s, iArrayPos: %s\ntl31LoadedContentID: %s\ntl23NextContentID: %s, %s, %s\niEndCutscene: %s",
        GLOBAL_GET_STRING(FMMC_STRUCT.tl63MissionName),
        iRootContentID,
        iArrayPos,

        GLOBAL_GET_STRING(FMMC_STRUCT.tl31LoadedContentID),

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
    -- GLOBAL_SET_INT(4718592 + 178859, 5)

    -- ciMISSION_CUTSCENE_ISLAND_HEIST_HS4F_DRP_OFF
    -- LOCAL_SET_INT(script, 50150 + 3016, 69)    -- MISSION_HAS_VALID_MOCAP
    -- LOCAL_SET_INT(script, 50150 + 2525 + 1, 0) -- SHOULD_PLAY_END_MOCAP



    if GLOBAL_GET_BOOL(sStrandMissionData.bIsThisAStrandMission) then
        GLOBAL_SET_BOOL(sStrandMissionData.bPassedFirstMission, true)
        GLOBAL_SET_BOOL(sStrandMissionData.bPassedFirstStrandNoReset, true)
        GLOBAL_SET_BOOL(sStrandMissionData.bLastMission, true)
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
    local eCoronaStatus = GLOBAL_GET_INT(1845281 + 1 + players.user() * 883 + 193)
    if CORONA_STATUS[eCoronaStatus] then
        eCoronaStatus = CORONA_STATUS[eCoronaStatus]
    end


    local text = string.format(
        "eCoronaStatus: %s\niSwitchState: %s, iArrayPos: %s, IsThisAStrandMission: %s\nIS_A_STRAND_MISSION_BEING_INITIALISED: %s\nHAS_NEXT_STRAND_MISSION_HAS_BEEN_DOWNLOADED: %s\nIS_NEXT_STRAND_MISSION_READY_TO_SET_UP: %s\nIS_STRAND_MISSION_READY_TO_START_DOWNLOAD: %s\niVoteStatus: %s, iCelebrationType: %s",
        eCoronaStatus,

        GLOBAL_GET_INT(2684504 + 43 + 3),   -- g_sTransitionSessionData.sStrandMissionData.iSwitchState
        GLOBAL_GET_INT(2684504 + 43),       -- g_sTransitionSessionData.sStrandMissionData.iArrayPos
        GLOBAL_GET_BOOL(2684504 + 43 + 57), -- g_sTransitionSessionData.sStrandMissionData.bIsThisAStrandMission

        -- g_sTransitionSessionData.sStrandMissionData.iBitSet
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 0), -- ciSTRAND_BITSET_A_STRAND_MISSION_BEING_INITIALISED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 6), -- ciSTRAND_BITSET_MISSION_HAS_BEEN_DOWNLOADED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 7), -- ciSTRAND_BITSET_MISSION_READY_TO_SET_UP
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 8), -- ciSTRAND_BITSET_MISSION_READY_TO_START_DOWNLOAD

        GLOBAL_GET_INT(1919969 + 9),          -- g_sFMMCEOM.iVoteStatus
        GLOBAL_GET_INT(4718592 + 178859)      -- g_FMMC_STRUCT.iCelebrationType
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



menu.toggle_loop(Job_Mission_Test, "Show Global Info 2", {}, "", function()
    local text = string.format(
        "tlGlobalFinaleRContID: %s\nmhcContentID: %s\ng_HeistPlanningClient.eHeistFlowState: %s\ng_HeistPrePlanningClient.eHeistFlowState: %s",
        GLOBAL_GET_STRING(1934536 + 10),    -- g_HeistSharedClient.tlGlobalFinaleRContID
        GLOBAL_GET_STRING(2635126 + 3 + 1), -- g_sLocalMPHeistControl.lhcMyCorona.mhcContentID
        GLOBAL_GET_INT(1930926 + 2768),     -- g_HeistPlanningClient.eHeistFlowState
        GLOBAL_GET_INT(1928993)
    )

    draw_text(text)
end)



local iCoronaBitSet = 2685444 + 1 + 2813

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

    local MC_serverBD = 19746

    local iTeam = 0

    local text = string.format(
        "iServerGameState: %s",
        LOCAL_GET_INT(script, MC_serverBD)
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

    local iTeam = 0

    local text = string.format(
        "iServerGameState: %s",
        LOCAL_GET_INT(script, MC_serverBD)
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
