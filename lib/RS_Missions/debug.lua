local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "DEBUG")


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


menu.divider(Instant_Finish_Test, "")

menu.action(Instant_Finish_Test, "Test Complete Mission", {}, "", function()
    local script = "gb_smuggler"
    if not IS_SCRIPT_RUNNING(script) then return end

    LOCAL_SET_BIT(script, 1932 + 6 + 63 + 1 + 0 * 3 + 1 + 0, 6) -- SET_SMUGGLER_ENTITY_BIT(iSmugglerEntity, eSMUGGLERENTITYBITSET_DELIVERED)
    LOCAL_SET_BIT(script, 1117 + 1 + 3, 16)                     -- SET_LOCAL_BIT(eLOCALBITSET_I_WON)
    LOCAL_SET_INT(script, 1932 + 771, 3)                        -- SET_END_REASON(eENDREASON_SMUGGLER_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, 1932 + 770, 18)                       -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)

menu.action(Instant_Finish_Test, "Test Complete FM_CONTENT Mission", {}, "", function()
    local script = "fm_content_stash_house"
    if not IS_SCRIPT_RUNNING(script) then return end

    INSTANT_FINISH_FM_CONTENT_MISSION(script, 3433, 3484 + 475)
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

menu.divider(Test_Start_Mission, "")

menu.action(Test_Start_Mission, "启动差事", {}, "", function()
    local Data = {
        iRootContentID = -590337633,
        iMissionEnteryType = 29,
    }



    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(Data.iRootContentID)

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].tlName
    local tlName = GLOBAL_GET_STRING(Globals.sMissionHeaderVars + iArrayPos * 89)
    toast(tlName)


    -- SET_HEIST_AM_I_HEIST_LEADER_GLOBAL(TRUE)
    ---- g_TransitionSessionNonResetVars.bAmIHeistLeader = bValue
    GLOBAL_SET_INT(2685249 + 6357, 1)

    -- SET_HEIST_NONRESET_AUTO_CONFIGURE(FALSE)
    ---- g_TransitionSessionNonResetVars.bAutoProgressToConfigure = bNewState
    GLOBAL_SET_INT(g_TransitionSessionNonResetVars + 6360, 0)


    local iMissionIndex = 0 -- ci_HEIST_PRE_PLAN_MISSION_0
    local net_player_id = PLAYER.NETWORK_PLAYER_ID_TO_INT()

    -- GlobalplayerBD_FM_HeistPlanning[NETWORK_PLAYER_ID_TO_INT()].iPreviousPropertyIndex = GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].propertyDetails.iCurrentlyInsideProperty
    local iCurrentlyInsideProperty = GLOBAL_GET_INT(1845263 + 1 + players.user() * 877 + 267 + 34)
    GLOBAL_SET_INT(1877075 + 1 + net_player_id * 77 + 8, iCurrentlyInsideProperty)

    -- GlobalplayerBD_FM_HeistPlanning[NETWORK_PLAYER_ID_TO_INT()].iCurrentHeistSetupIndex = iMissionIndex
    GLOBAL_SET_INT(1877075 + 1 + net_player_id * 77 + 9, iMissionIndex)

    -- g_TransitionSessionNonResetVars.iHeistSetupIdx = iMissionIndex
    GLOBAL_SET_INT(g_TransitionSessionNonResetVars + 6380, iMissionIndex)



    -- Setup_My_Heist_Corona_From_ContentID(tlMissionContID)
    local lhcMyCorona = 2635125 + 3

    GLOBAL_SET_INT(lhcMyCorona, 1)
    GLOBAL_SET_STRING(lhcMyCorona + 1, tlName)
    GLOBAL_SET_INT(lhcMyCorona + 7, 0)
    GLOBAL_SET_INT(lhcMyCorona + 8, 0)
    GLOBAL_SET_INT(lhcMyCorona + 9, 0)
    GLOBAL_SET_INT(lhcMyCorona + 10, -1)
    GLOBAL_SET_INT(lhcMyCorona + 11, 0)
    GLOBAL_SET_INT(lhcMyCorona + 12, 0)
    GLOBAL_SET_INT(lhcMyCorona + 13, 0)



    -- SET_FM_JOB_ENTERY_TYPE(ciMISSION_ENTERY_TYPE_XXX)
    ---- g_iMissionEnteryType = iType
    GLOBAL_SET_INT(g_iMissionEnteryType, Data.iMissionEnteryType)

    -- SET_HEIST_CORONA_FROM_PLANNING_BOARD(TRUE)
    ---- g_TransitionSessionNonResetVars.bCoronaLaunchFromPlanningBoard = bValue
    GLOBAL_SET_INT(g_TransitionSessionNonResetVars + 6367, 1)

    -- SET_HEIST_FLOW_TOGGLE_RENDERPHASE_STATE(ci_HEIST_BS_RP_LEADER_LAUNCHED_FROM_BOARD)
    ---- SET_BIT(g_HeistSharedClient.iRenderphaseBitset, iRenderPhaseBit)
    GLOBAL_SET_BIT(1933811 + 55, 0)
    -- g_HeistSharedClient.iRenderphaseWaitCount = 0
    GLOBAL_SET_INT(1933811 + 56, 0)

    -- SET_HEIST_PREPLAN_STATE(HEIST_PRE_FLOW_UPDATE_APT_THREAD_BUFFER)

    -- SET_HEIST_UPDATE_AVAILABLE(TRUE)
    -- g_HeistPrePlanningClient.bHeistBoardUpdateReady = bValue
    GLOBAL_SET_INT(1928268 + 1782, 1)
    -- g_HeistPrePlanningClient.eHeistFlowState = eNewState
    GLOBAL_SET_INT(1928268, 5)
end)

menu.toggle_loop(Test_Start_Mission, "Show mhcContentID", {}, "", function()
    local text = GLOBAL_GET_STRING(2635125 + 3 + 1)
    draw_text("mhcContentID: " .. text)
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


menu.action(Job_Mission_Test, "Force Ready (Global)", {}, "", function()
    local pid = menu.get_value(TestPlayerSelect)
    if pid == -1 or not players.exists(pid) then
        return
    end

    menu.trigger_commands("scripthost")
    util.request_script_host("fmmc_launcher")


    GLOBAL_SET_BIT(1882422 + 1 + pid * 142 + 14, 5)
    local bHasPlayerVoted = GLOBAL_GET_INT(1882422 + 1 + pid * 142 + 31)
    if bHasPlayerVoted == 1 then
        bHasPlayerVoted = 0
    elseif bHasPlayerVoted == 0 then
        bHasPlayerVoted = 1
    end
    GLOBAL_SET_INT(1882422 + 1 + pid * 142 + 31, bHasPlayerVoted)

    local iClientSyncID = GLOBAL_GET_INT(1845263 + 1 + pid * 877 + 96 + 31)
    GLOBAL_SET_INT(1845263 + 1 + pid * 877 + 96 + 31, iClientSyncID + 1)
end)
menu.action(Job_Mission_Test, "Force Ready (Local)", {}, "", function()
    local pid = menu.get_value(TestPlayerSelect)
    if pid == -1 or not players.exists(pid) then
        return
    end

    local script = "fmmc_launcher"

    menu.trigger_commands("scripthost")
    util.request_script_host(script)

    local bVoted = LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2 + 1)
    if bVoted == 1 then
        bVoted = 0
    elseif bVoted == 0 then
        bVoted = 1
    end
    LOCAL_SET_INT(script, 17208 + 845 + 1 + pid * 2 + 1, bVoted)

    local iClientSyncID = LOCAL_GET_INT(script, 17208 + 845 + 1 + pid * 2)
    LOCAL_SET_INT(script, 17208 + 845 + 1 + pid * 2, iClientSyncID + 1)
end)
menu.toggle_loop(Job_Mission_Test, "sCoronaTimer", {}, "", function()
    GLOBAL_SET_INT(1882422 + 1 + players.user() * 142 + 32, NETWORK.GET_NETWORK_TIME())
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


menu.toggle_loop(Job_Mission_Test, "g_bEmergencyCallsSuppressed = False", {}, "", function()
    GLOBAL_SET_INT(33054, 0)
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


menu.action(Script_Event_Test, "BROADCAST_DELIVERED_HANGAR_MISSION_PRODUCT", {}, "", function()
    util.trigger_script_event(1 << players.user(),
        {
            446749111, -- SCRIPT_EVENT_DATA_DELIVERED_HANGAR_MISSION_PRODUCT_DATA
            players.user(),
            -1,
            0,
            7
        })
end)

menu.divider(Script_Event_Test, "")

local TransitionGamerInstruction = memory.alloc(8 * 44)
menu.toggle_loop(Script_Event_Test, "Get NETWORK_TRANSITION_GAMER_INSTRUCTION", {}, "", function()
    -- SCRIPT_EVENT_QUEUE_NETWORK = 1
    local eventType = 214 -- EVENT_NETWORK_TRANSITION_GAMER_INSTRUCTION

    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        if SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex) == eventType then
            if SCRIPT.GET_EVENT_DATA(1, eventIndex, TransitionGamerInstruction, 44) then
                local nInstruction = memory.read_int(TransitionGamerInstruction + 8 * 42)

                local hToGamer = memory.read_int(TransitionGamerInstruction + 8 * 13)
                local nInstructionParam = memory.read_int(TransitionGamerInstruction + 8 * 43)


                local text = string.format(
                    "nInstruction: %s\nhToGamer: %s\nnInstructionParam: %s\nTime: %s",
                    nInstruction,
                    hToGamer,
                    nInstructionParam,
                    os.date("%Y-%m-%d %H:%M:%S", util.current_unix_time_seconds())
                )

                toast(text)
            end
        end
    end
end)
