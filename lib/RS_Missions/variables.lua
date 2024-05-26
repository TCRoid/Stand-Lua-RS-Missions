-- Game Variables
-- 1.68-3179

--------------------------------
-- Globals
--------------------------------

Globals = {
    -- GlobalplayerBD[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD = function()
        return 2657921 + 1 + players.user() * 463
    end,

    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM = function()
        return 1845263 + 1 + players.user() * 877
    end,

    -- GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_2 = function()
        return 1882422 + 1 + players.user() * 142
    end,

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_3 = function()
        return 1886967 + 1 + players.user() * 609
    end,

    MPGlobalsAmbience = 2738587,


    bBrowserVisible = 76369,

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos]
    sMissionHeaderVars = 794744 + 4 + 1,


    -- g_FMMC_STRUCT_ENTITIES.sPlacedZones[iZone].iZoneTimer_EnableTime
    CasinoVault_ZoneTimer_EnableTime = 4718592 + 207244 + 1 + 0 * 190 + 41,
}

g_sMPTunables = 262145


-- GlobalPlayerBroadcastDataFM_3
GlobalplayerBD_FM_3 = {
    _sMagnateGangBossData = function()
        -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData
        return Globals.GlobalplayerBD_FM_3() + 10
    end,
    _contrabandMissionData = function()
        -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData.contrabandMissionData
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 183
    end,
}

-- STRUCT_MAGNATE_GANG_BOSS_GLOBAL_PLAYER_BD
GlobalplayerBD_FM_3.sMagnateGangBossData = {
    iMissionToLaunch = function()
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 32
    end,
    iNumGoonsInGang = function()
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 19
    end,
}

-- CONTRABAND_MISSION_DATA
GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData = {
    contrabandSize = function()
        return GlobalplayerBD_FM_3._contrabandMissionData() + 1
    end,
    bSpecialItem = function()
        return GlobalplayerBD_FM_3._contrabandMissionData() + 3
    end,
}



-- MPGlobalsAmbienceStruct
MPGlobalsAmbience = {
    -- MAGNATE_GANG_BOSS_LOCAL_GLOBALS
    sMagnateGangBossData = {
        iMissionVariation = Globals.MPGlobalsAmbience + 5234 + 346,
    },
}


-- CONTACT_REQUEST_GB_MISSION_LAUNCH_STRUCT
g_sContactRequestGBMissionLaunch = 1977909
ContactRequestGBMissionLaunch = {
    iType = g_sContactRequestGBMissionLaunch,
    iVariation = g_sContactRequestGBMissionLaunch + 1,
    iSubvariation = g_sContactRequestGBMissionLaunch + 2,
    iDelay = g_sContactRequestGBMissionLaunch + 3,
    iBitSet = g_sContactRequestGBMissionLaunch + 4,
    Timer = g_sContactRequestGBMissionLaunch + 5
}

-- PAYPHONE_FLOW_GLOBAL_STRUCT
g_PayphoneFlow = 2708777
PayphoneFlow = {
    iBitset = g_PayphoneFlow + 1,
}

-- FIXER_FLOW_DATA
g_sFixerFlow = 1974552
FixerFlow = {
    -- FIXER_SECURITY_CONTRACT_DATA
    SecurityContracts = g_sFixerFlow + 20
}


-- FMMC_GLOBAL_STRUCT
g_FMMC_STRUCT = 4718592
FMMC_STRUCT = {
    iNumParticipants = g_FMMC_STRUCT + 3248,
    iMinNumParticipants = g_FMMC_STRUCT + 3249,

    iDifficulity = g_FMMC_STRUCT + 3251,
    iNumberOfTeams = g_FMMC_STRUCT + 3252,
    iMaxNumberOfTeams = g_FMMC_STRUCT + 3253,
    iNumPlayersPerTeam = g_FMMC_STRUCT + 3255 + 1, -- +[0~3]

    iRootContentIDHash = g_FMMC_STRUCT + 126144,
    tl63MissionName = g_FMMC_STRUCT + 126151,
    tl31LoadedContentID = g_FMMC_STRUCT + 126431,
    tl23NextContentID = g_FMMC_STRUCT + 126459 + 1, -- +[0~5]

    iFixedCamera = g_FMMC_STRUCT + 154310,
    iCriticalMinimumForTeam = g_FMMC_STRUCT + 176675 + 1 -- +[0~3]
}

-- TRANSITION_SESSION_NON_RESET_VARS
g_TransitionSessionNonResetVars = 2685249
TransitionSessionNonResetVars = {
    bAmIHeistLeader = g_TransitionSessionNonResetVars + 6357,
    bHasQuickRestartedDuringStrandMission = g_TransitionSessionNonResetVars + 6463,
    bAnyPlayerDiedDuringMission = g_TransitionSessionNonResetVars + 6464
}

-- FMMC_STRAND_MISSION_DATA
g_sTransitionSessionData = 2684312
sStrandMissionData = g_sTransitionSessionData + 43
StrandMissionData = {
    bPassedFirstMission = sStrandMissionData + 55,
    bPassedFirstStrandNoReset = sStrandMissionData + 56,
    bIsThisAStrandMission = sStrandMissionData + 57,
    bLastMission = sStrandMissionData + 58
}


-- HEIST_CLIENT_PRE_PLANNING_LOCAL_DATA
g_HeistPrePlanningClient = 1928268
HeistPrePlanningClient = {
    eHeistFlowState = g_HeistPrePlanningClient,
    iCurrentBoardDepth = g_HeistPrePlanningClient + 1708,
}

-- CASINO_HEIST_MISSION_CONFIGURATION_DATA
g_sCasinoHeistMissionConfigData = 1963911
CasinoHeistMissionConfigData = {
    -- Not determined by players
    eChosenApproachType = g_sCasinoHeistMissionConfigData,
    eTarget = g_sCasinoHeistMissionConfigData + 1,
    -- Optional Preps that affect the finale, not selected on heist board
    bSecurityCameraLocationsScoped = g_sCasinoHeistMissionConfigData + 2,
    bGuardPatrolRoutesScoped = g_sCasinoHeistMissionConfigData + 3,
    eShipmentDisruptionLevel = g_sCasinoHeistMissionConfigData + 4,
    bStealthNightVisionAcquired = g_sCasinoHeistMissionConfigData + 5,
    bHandheldDrillAcquired = g_sCasinoHeistMissionConfigData + 6,
    bEMPAcquired = g_sCasinoHeistMissionConfigData + 7,
    -- selectable on heist board without Preps
    eDropoffLocation = g_sCasinoHeistMissionConfigData + 8,
    eDropoffSubLocation = g_sCasinoHeistMissionConfigData + 9,
    bDecoyCrewMemberPurchased = g_sCasinoHeistMissionConfigData + 10,
    bSwitchGetawayVehiclePurchased = g_sCasinoHeistMissionConfigData + 11,
    eVehicleModPresetChosen = g_sCasinoHeistMissionConfigData + 12,
    -- FM prep that unlocks the choice on the heist board
    eCrewWeaponsExpertChosen = g_sCasinoHeistMissionConfigData + 13,
    eCrewWeaponsLoadoutChosen = g_sCasinoHeistMissionConfigData + 14,
    eCrewDriverChosen = g_sCasinoHeistMissionConfigData + 15,
    eCrewVehiclesLoadoutChosen = g_sCasinoHeistMissionConfigData + 16,
    eCrewHackerChosen = g_sCasinoHeistMissionConfigData + 17,
    eCrewKeyAccessLevel = g_sCasinoHeistMissionConfigData + 18,
    eEntranceChosen = g_sCasinoHeistMissionConfigData + 19,
    eExitChosen = g_sCasinoHeistMissionConfigData + 20,
    eMasksChosen = g_sCasinoHeistMissionConfigData + 21,
    -- Subterfuge approach only
    eSubterfugeOutfitsIn = g_sCasinoHeistMissionConfigData + 22,
    eSubterfugeOutfitsOut = g_sCasinoHeistMissionConfigData + 23,
    bOfficeInfested = g_sCasinoHeistMissionConfigData + 24,
    -- Extra Data
    iAccessPointBitset = g_sCasinoHeistMissionConfigData + 25,
    bRappelGearAcquired = g_sCasinoHeistMissionConfigData + 26,
    bHardMode = g_sCasinoHeistMissionConfigData + 27
}

-- HEIST_ISLAND_PLAYER_BD_DATA
GlobalPlayerBD_HeistIsland = {
    -- HEIST_ISLAND_CONFIG
    sConfig = function()
        -- GlobalPlayerBD_HeistIsland[NATIVE_TO_INT(sData.piLeader)].sConfig
        return 1972721 + 1 + players.user() * 53 + 5
    end,
}



-- WAREHOUSE_CARGO_SOURCING_DATA_STRUCT
g_sWarehouseCargoSourcingData = 1882389
WarehouseCargoSourcingData = {
    bRequestDeliverCargo = g_sWarehouseCargoSourcingData + 4 + 1, -- +[0~4]
    iNumCargo = g_sWarehouseCargoSourcingData + 12,
    iSpecialCargoType = g_sWarehouseCargoSourcingData + 13,
    iNumSpecialCargo = g_sWarehouseCargoSourcingData + 14,
    eType = g_sWarehouseCargoSourcingData + 15
}

g_sHangarCargoSourcingData = 1882413
HangarCargoSourcingData = {
    iNum = g_sHangarCargoSourcingData + 6,
    eType = g_sHangarCargoSourcingData + 7
}

g_sHangarCargoSourcingDataBitset = function()
    return Globals.GlobalplayerBD() + 201
end


-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sClientVehicleSetupStruct = 2709112

-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sBikerClientVehicleSetupStruct = 2709998

g_iFactoryPaidResupplyTimers = 1662873

-- BUSINESS_APP_MANAGEMENT_DATA
g_sBusAppManagement = 1962105
BusAppManagement = {
    iPropertyID = g_sBusAppManagement,
    bRunningPrimaryApp = g_sBusAppManagement + 1,
    bSecuroSpecCargo = g_sBusAppManagement + 2
}


--------------------------------
-- Locals
--------------------------------

Locals = {
    ContrabandBuy = {
        iServerBitSet1 = 601 + 186,
        iLocalBitset5 = 476,
        eEndReason = 601 + 192,
        eModeState = 601 + 191,
        contrabandSize = 601 + 1, -- serverBD.sContraband.sContrabandMissionData.contrabandSize
        eType = 601 + 5           -- serverBD.sContraband.eType
    },
    ContrabandSell = {
        eSellVar = 543 + 7,
        eEndReason = 543 + 6,
        eModeState = 543 + 5
    },
    Gunrunning = {
        iGunrunEntityBitSet = 1209 + 4 + 63,
        eEndReason = 1209 + 582,
        eModeState = 1209 + 581,
        eMissionVariation = 1209 + 1,
        iNumEntitiesThisVariation = 1209 + 774,
        iTotalDeliveredCount = 1209 + 816
    },
    Smuggler = {
        iSmugglerEntityBitSet = 1932 + 6 + 63,
        eEndReason = 1932 + 771,
        eModeState = 1932 + 770,
        eMissionVariation = 1932 + 2,
        iNumEntitiesThisVariation = 1932 + 1035,
        iTotalDeliveredCount = 1932 + 1078
    },
    AcidLabSource = {
        iGenericBitset = 7542,
        eEndReason = 7614 + 1162
    },
    AcidLabSell = {
        iGenericBitset = 5388,
        eEndReason = 5450 + 1294,
        iDropOffCount = 117 + 9 + 1,
        iTotalDropoffs = 117 + 9
    },
    NightclubSell = {
        eEndReason = 2310 + 25,
        eModeState = 2310 + 24,
        sMissionEntity = 2310 + 31,
        iTotalDeliveredCount = 2310 + 201,
        iTotalDeliveriesToMake = 2310 + 202
    },
    ClubSource = {
        eGoodsType = 3509 + 720 + 3,
        iLocalParticipantIndexAsInt = 3427,
        iGoodsToTransfer = function(iLocalParticipantIndexAsInt)
            return 4267 + 1 + iLocalParticipantIndexAsInt * 125 + 73
        end,
        iGenericBitset = 3441,
        eEndReason = 3509 + 674
    },
    BikerSteal = {
        iIllicitGoodBitset0 = 935 + 796,
        eEndReason = 935 + 506,
        eModeState = 935 + 505
    },
    BikerSell = {
        eSellVar = 702 + 17,
        iVehicleCountDeliveredAllContraband = 702 + 978,
        iDroppedOffCount = 702 + 122,
        eEndReason = 702 + 15,
        eModeState = 702 + 14
    },
    VehicleExport = {
        iExportEntityNetId = 834 + 29,
        eModeState = 834 + 459,
        sCarBombStruct = {
            iCarBombBitSet = 367 + 1
        },
    },


    SecurityContract = {
        iGenericBitset = 7022,
        eEndReason = 7095 + 1278
    },
    PayphoneHit = {
        iMissionServerBitSet = 5639 + 740,
        iGenericBitset = 5583,
        eEndReason = 5639 + 683
    },
    ClientJobs = {
        BankJob = {
            iMissionEntityBitSet = 1225 + 7 + 1 + 0 * 4 + 1 + 1 + 0, -- iMissionEntity = 0
            eModeState = 1225 + 5,
            eEndReason = 1225 + 6
        },
        DataHack = {
            eEndReason = 1925 + 7
        }
    },
    DrugLabWork = {
        iGenericBitset = 7844,
        eEndReason = 7845 + 1253
    },
    StashHouse = {
        iGenericBitset = 3433,
        eEndReason = 3484 + 475
    },
    AutoShopDelivery = {
        iMissionEntityBitSet = 1543 + 2 + 5,
        iGenericBitset = 1492,
        eEndReason = 1543 + 83
    },
    BikeShopDelivery = {
        iMissionEntityBitSet = 1545 + 2 + 5,
        iGenericBitset = 1492,
        eEndReason = 1543 + 83
    },

    IslandHeist = {
        iGenericBitset = 13176,
        eEndReason = 13262 + 1339
    },
    TunerRobbery = {
        iGenericBitset = 7189,
        eEndReason = 7271 + 1194
    },
    VipContract = {
        iGenericBitset = 8582,
        eEndReason = 8650 + 1157
    },
    Gangops = {
        iPhotosTaken = 1961 + 1194,
        iNumEntitiesThisVariation = 1961 + 1040,
        iMissionEntityBitSet = 1961 + 6 + 63,
        eEndReason = 1961 + 782,
        eModeState = 1961 + 781
    },


    CasinoHeistPlanning = {
        iScriptStage = 183,
    },
    GangOpsPlanning = {
        iScriptStage = 182,
    },
    HeistIslandPlanning = {
        iScriptStage = 1544,
    },
    TunerPlanning = {
        iScriptStage = 381,
    },
    VehrobPlanning = {
        iScriptStage = 510,
    },


    ["fm_mission_controller"] = {
        iNextMission = 19728 + 1062,
        iTeamScore = 19728 + 1232 + 1, -- +[0~3]
        iServerBitSet = 19728 + 1,
        iServerBitSet1 = 19728 + 2,

        iCashGrabTotalTake = 19728 + 2686,
        iTeamKills = 19728 + 1725 + 1,
        iTeamHeadshots = 19728 + 1740 + 1,

        iLocalBoolCheck11 = 15149,

        iAdditionalTeamLives = 26154 + 1325 + 1,      -- +[0~3]

        tdObjectiveLimitTimer = 26154 + 740 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 26154 + 749 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 26154 + 765 + 1,   -- +[0~3]

        stZoneTimers = 59854 + 1 + 0 * 2,             -- casino vault
    },
    ["fm_mission_controller_2020"] = {
        iNextMission = 48513 + 1578,
        iTeamScore = 48513 + 1765 + 1, -- +[0~3]
        iServerBitSet = 48513 + 1,
        iServerBitSet1 = 48513 + 2,

        iLocalBoolCheck11 = 47286,

        iAdditionalTeamLives = 55004 + 868 + 1,       -- +[0~3]

        tdObjectiveLimitTimer = 55004 + 297 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 55004 + 306 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 55004 + 322 + 1,   -- +[0~3]
    },

    CarmodShop = {
        iPersonalCarModShopFlags = 1583
    },
    ShopController = {
        iLocalBS = 308,
        iAutoShopRandomTime = 309,
        iBikerShopRandomTime = 323
    },
}

-- `fmmc_launcher`
-- MISSION_TO_LAUNCH_DETAILS
sLaunchMissionDetails = 19331
LaunchMissionDetails = {
    iMinPlayers = sLaunchMissionDetails + 15,
    iMissionVariation = sLaunchMissionDetails + 34
}

-- `freemode` Time Trial
-- AMTT_VARS_STRUCT
sTTVarsStruct = 14232
TTVarsStruct = {
    iVariation = sTTVarsStruct + 11,
    trialTimer = sTTVarsStruct + 13,
    iPersonalBest = sTTVarsStruct + 25,
    eAMTT_Stage = sTTVarsStruct + 29
}

-- `freemode` RC Bandito Time Trial
-- AMRCTT_VARS_STRUCT
sRCTTVarsStruct = 14282
RCTTVarsStruct = {
    eVariation = sRCTTVarsStruct,
    eRunStage = sRCTTVarsStruct + 2,
    timerTrial = sRCTTVarsStruct + 6,
    iPersonalBest = sRCTTVarsStruct + 21
}





--------------------------------
-- Functions
--------------------------------

g_sCURRENT_UGC_STATUS = 2693219
g_iMissionEnteryType = 1057441

function LAUNCH_MISSION(Data)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(Data.iRootContentID)

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].tlName
    local tlName = GLOBAL_GET_STRING(Globals.sMissionHeaderVars + iArrayPos * 89)
    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMaxPlayers
    local iMaxPlayers = GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 71)

    -- g_TransitionSessionNonResetVars.bSaveBeforeCoronaVehicle = TRUE
    GLOBAL_SET_INT(g_TransitionSessionNonResetVars + 3836, 1)

    -- CLEAR_PAUSE_MENU_IS_USING_UGC()
    ---- g_sCURRENT_UGC_STATUS.g_bPAUSE_MENU_USING_UGC = FALSE
    GLOBAL_SET_INT(g_sCURRENT_UGC_STATUS + 1, 0)

    -- SET_TRANSITION_SESSIONS_SKIP_JOB_WARNING()
    ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_SKIP_JOB_WARNING)
    GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 2)

    -- SET_FM_JOB_ENTERY_TYPE(ciMISSION_ENTERY_TYPE_XXX)
    ---- g_iMissionEnteryType = iType
    GLOBAL_SET_INT(g_iMissionEnteryType, Data.iMissionEnteryType)



    if Data.iMissionType == 274 then
        -- FMMC_TYPE_TUNER_ROBBERY_FINALE

        -- SET_TRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 13)

        -- SET_PLAYER_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 30, 28)
    elseif Data.iMissionType == 260 then
        -- FMMC_TYPE_HEIST_ISLAND_FINALE

        -- SET_TRANSITION_SESSIONS_LAUNCHING_ISLAND_HEIST_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_ISLAND_HEIST_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 11)

        -- HEIST_ISLAND__FLOW_SET_LAUNCHING_HEIST_IN_SUB()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_ISLAND_HEIST_IN_SUB)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 30, 27)
    elseif Data.iMissionType == 158 then
        -- FMMC_TYPE_GB_CASINO_HEIST

        -- SET_TRANSITION_SESSIONS_LAUNCHING_CASINO_HEIST_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_CASINO_HEIST_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 10)

        -- SMV_FLOW_SET_LAUNCHING_SMV_IN_OFFICE()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_SMV_IN_OFFICE)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 30, 12)
    end


    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_TYPE(FMMC_TYPE_XXX)
    ---- g_sTransitionSessionData.iMissionType = iMissionType
    GLOBAL_SET_INT(g_sTransitionSessionData + 9, Data.iMissionType)


    -- SET_MY_TRANSITION_SESSION_CONTENT_ID(tlName)
    ---- g_sTransitionSessionData.stFileName = stPassed
    GLOBAL_SET_STRING(g_sTransitionSessionData + 860, tlName)

    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_MAX_PLAYERS(iMaxPlayers)
    ---- g_sTransitionSessionData.iMaxPlayers = iMaxPlayers
    GLOBAL_SET_INT(g_sTransitionSessionData + 42, iMaxPlayers)


    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP()
    ---- CLEAR_BIT(g_sTransitionSessionData.iSecondBitSet, ciTRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData + 2, 14)

    -- SET_TRANSITION_SESSIONS_STARTING_QUICK_MATCH()
    ---- SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_STARTING_QUICK_MATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 5)
    ---- SET_TRANSITION_SESSIONS_SETTING_UP_QUICKMATCH()
    ------ SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_SETTING_UP_QUICKMATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 8)

    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 7)

    -- CLEAR_TRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 15)

    -- SET_TRANSITION_SESSIONS_FORCE_ME_HOST_QUICK_MATCH()
    ---- g_sTransitionSessionData.bForceMeHost = TRUE
    GLOBAL_SET_INT(g_sTransitionSessionData + 717, 1)


    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].iFmLauncherGameState = FMMC_LAUNCHER_STATE_LOAD_MISSION_FOR_TRANSITION_SESSION
    GLOBAL_SET_INT(Globals.GlobalplayerBD_FM() + 95, 8)
end

function LAUNCH_DOOMSDAY_HEIST_MISSION(Data)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(Data.iRootContentID)

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].tlName
    local tlName = GLOBAL_GET_STRING(Globals.sMissionHeaderVars + iArrayPos * 89)
    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMaxPlayers
    local iMaxPlayers = GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 71)


    -- SET_TRANSITION_SESSIONS_PICKED_SPECIFIC_JOB()
    ---- SET_BIT(g_sTransitionSessionData.iSecondBitSet, ciTRANSITION_SESSIONS_PICKED_SPECIFIC_JOB)
    GLOBAL_SET_BIT(g_sTransitionSessionData + 2, 29)


    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_TYPE(FMMC_TYPE_XXX)
    ---- g_sTransitionSessionData.iMissionType = iMissionType
    GLOBAL_SET_INT(g_sTransitionSessionData + 9, Data.iMissionType)


    -- SET_MY_TRANSITION_SESSION_CONTENT_ID(tlName)
    ---- g_sTransitionSessionData.stFileName = stPassed
    GLOBAL_SET_STRING(g_sTransitionSessionData + 860, tlName)

    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_MAX_PLAYERS(iMaxPlayers)
    ---- g_sTransitionSessionData.iMaxPlayers = iMaxPlayers
    GLOBAL_SET_INT(g_sTransitionSessionData + 42, iMaxPlayers)


    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP()
    ---- CLEAR_BIT(g_sTransitionSessionData.iSecondBitSet, ciTRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData + 2, 14)

    -- SET_TRANSITION_SESSIONS_STARTING_QUICK_MATCH()
    ---- SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_STARTING_QUICK_MATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 5)
    ---- SET_TRANSITION_SESSIONS_SETTING_UP_QUICKMATCH()
    ------ SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_SETTING_UP_QUICKMATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 8)

    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 7)

    -- CLEAR_TRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 15)

    -- CLEAR_TRANSITION_SESSIONS_RECIEVED_FAILED_TO_LAUNCH()
    ---- g_sTransitionSessionData.bTransitionSessionJoinFailed = FALSE
    GLOBAL_SET_INT(g_sTransitionSessionData + 718, 0)

    -- SET_TRANSITION_SESSIONS_FORCE_ME_HOST_QUICK_MATCH()
    ---- g_sTransitionSessionData.bForceMeHost = TRUE
    GLOBAL_SET_INT(g_sTransitionSessionData + 717, 1)


    -- SVM_FLOW_SET_TRANSITION_SESSIONS_LAUNCHING_SMV_FROM_LAPTOP()
    ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_SVM_FROM_LAPTOP)
    GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 4)


    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].iFmLauncherGameState = FMMC_LAUNCHER_STATE_LOAD_MISSION_FOR_TRANSITION_SESSION
    GLOBAL_SET_INT(Globals.GlobalplayerBD_FM() + 95, 8)
end

function INSTANT_FINISH_CASINO_HEIST_PREPS()
    local script = "gb_casino_heist"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local serverBD = 4280

    local eMissionVariation = LOCAL_GET_INT(script, serverBD + 1457)
    if eMissionVariation == 4 then
        LOCAL_SET_INT(script, serverBD + 1700, 10)
    elseif eMissionVariation == 2 then
        LOCAL_SET_BIT(script, serverBD + 1604 + 1 + 3, 22)
    elseif eMissionVariation == 1 then
        LOCAL_SET_INT(script, serverBD + 1461, 17)
    elseif eMissionVariation == 32 or eMissionVariation == 31 or eMissionVariation == 30 then
        LOCAL_SET_INT(script, serverBD + 1763, 30)
    elseif eMissionVariation == 28 or eMissionVariation == 29 then
        LOCAL_SET_BITS(script, serverBD + 1777, 0, 1)
    elseif eMissionVariation == 52 then
        LOCAL_SET_BIT(script, serverBD + 1604 + 1 + 1, 30)
    elseif eMissionVariation == 37 then
        local iOrganisationSizeOnLaunch = LOCAL_GET_INT(script, serverBD + 1648)
        if iOrganisationSizeOnLaunch == 1 then
            LOCAL_SET_BITS(script, serverBD + 1777, 1, 2, 3)
        else
            LOCAL_SET_BITS(script, serverBD + 1777, 1, 2, 3, 4, 5)
        end
    end
    LOCAL_SET_INT(script, serverBD + 1461, 3) -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
end

function COMPLETE_DAILY_CHALLENGE()
    -- g_savedMPGlobalsNew.g_savedMPGlobals[GET_SAVE_GAME_ARRAY_SLOT()].MpSavedGeneral.Current_Daily_Objectives[i].bCompleted
    for i = 0, 2, 1 do
        GLOBAL_SET_INT(2359296 + 1 + 0 * 5569 + 681 + 4243 + 1 + i * 3 + 1, 1)
    end
end

function COMPLETE_WEEKLY_CHALLENGE(bComplete)
    local g_sWeeklyChallenge = 2737646

    GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 3, 0)
    GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 4, 0)

    if bComplete then
        local target = GLOBAL_GET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 2)
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1, target)
    else
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1, 0)
    end
end

function CLEAR_BIG_MESSAGE()
    for i = 0, 3 do
        -- MPGlobals.g_BigMessage[i].iMessageState
        GLOBAL_SET_INT(2672741 + 2518 + 1 + i * 80 + 2, 5) -- BIG_MESSAGE_STATE_CLEANUP

        -- MPGlobals.g_BigMessage[i].iBigMessageBitSet
        GLOBAL_SET_BIT(2672741 + 2518 + 1 + i * 80 + 69, 1) -- BIG_MESSAGE_BIT_CLEANUP_ALL
    end
end

--------------------------------
-- Hacking Functions
--------------------------------

local HACKING_MINIGAME = {}

local iHackStage = 4543271

HACKING_MINIGAME.MISSION_CONTROLLER = function(script)
    local sFingerprintCloneGameplay = 52985
    local sOrderUnlockGameplay = 54047
    local sVaultDrillData = {
        iBitset = 10107,
        iCurrentState = 10107 + 2
    }

    local eHotwireState = 1543
    local hpsCurPassState = 1512

    local sBeamHackGameplayData = {
        eBeamHackState = 1269 + 135
    }
    local e_CircuitHackingMinigameState = 11776 + 24 -- hackingMinigameData.e_CircuitHackingMinigameState

    local sDrillData = {
        iCurrentState = 10067 + 2
    }
    local sHackingData = 9773

    local SafeCrackData = {
        iBitSet = 11147,
        iSafeCrackStage = 11147 + 5,
    }


    if LOCAL_GET_INT(script, sFingerprintCloneGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sFingerprintCloneGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, sOrderUnlockGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sOrderUnlockGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, sVaultDrillData.iCurrentState) == 5 then -- VAULT_DRILL_MINIGAME_STATE_DRILLING
        LOCAL_SET_BIT(script, sVaultDrillData.iBitset, 13)            -- VAULT_DRILL_BITSET_HAS_PLAYER_PASSED_MINIGAME
    end

    if GLOBAL_GET_INT(iHackStage) > 0 then
        -- MC_playerBD[iLocalPart].iVehFollowing
        local iVehFollowing = LOCAL_GET_INT(script, 31603 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 292 + 125)
        if iVehFollowing ~= -1 then
            -- MC_serverBD_1.tdControlVehTimer[iVeh]
            LOCAL_SET_INT(script, 22942 + 1 + iVehFollowing * 2, 0)
        end
    end

    if LOCAL_GET_INT(script, eHotwireState) == 1 then -- HOTWIRE_PLAY
        LOCAL_SET_INT(script, hpsCurPassState, 3)     -- HPS_SUCCESS
        LOCAL_SET_INT(script, eHotwireState, 2)       -- HOTWIRE_PASS
    end

    if LOCAL_GET_INT(script, sBeamHackGameplayData.eBeamHackState) == 2 then -- BEAM_HACK_PLAY
        LOCAL_SET_INT(script, sBeamHackGameplayData.eBeamHackState, 3)       -- BEAM_HACK_PASS
    end

    if LOCAL_GET_INT(script, e_CircuitHackingMinigameState) == 3 then -- CHMS_RUNNING
        LOCAL_SET_INT(script, e_CircuitHackingMinigameState, 7)       -- CHMS_SYSTEM_HACKED
    end

    if LOCAL_GET_INT(script, sDrillData.iCurrentState) == 1 then -- DRILL_MINIGAME_STATE_DRILLING
        LOCAL_SET_INT(script, sDrillData.iCurrentState, 2)       -- DRILL_MINIGAME_STATE_CLEANUP
    end

    if LOCAL_BITS_TEST(script, sHackingData, 0, 29) then -- BS_IS_HACKING, BS_WALLPAPER_INITIALISED
        -- BS_BRUTE_FORCE_GAME_SOLVED, BS_HACK_CONNECT_GAME_SOLVED
        LOCAL_SET_BITS(script, sHackingData, 9, 18)
    end

    if LOCAL_BIT_TEST(script, SafeCrackData.iBitSet, 1) then    -- SC_BS_IS_PLAYER_SAFE_CRACKING
        LOCAL_SET_INT(script, SafeCrackData.iSafeCrackStage, 3) -- MAX_NUM_LOCKS
    end
end

HACKING_MINIGAME.MISSION_CONTROLLER_2020 = function(script)
    local sFingerprintCloneGameplay = 24333
    local erUnderwaterTunnel_WeldStage = 29118
    local sGlassCuttingData = {
        iBitset = 30357,
        fGlassCuttingProgress = 30357 + 3
    }

    local eEnterSafeCombinationStage = 30332
    local sEnterSafeCombinationData = {
        iCurrentlySelectedDisplayPanel = 30333,
        sEnterSafePanels = 30333 + 1 + 1, -- +[0~2]*2
    }

    local Voltage = {
        iTargetValue = 1721,
        iCurrentValue = 1722,
        iLinkCount = 1723,
        eCurrentState = 1737,
    }

    local sBeamHackGameplayData = {
        eBeamHackState = 978 + 135
    }


    if LOCAL_GET_INT(script, sFingerprintCloneGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sFingerprintCloneGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, erUnderwaterTunnel_WeldStage) == 4 then -- UNDERWATER_TUNNEL_WELD_STAGE__RUNNING
        LOCAL_SET_INT(script, erUnderwaterTunnel_WeldStage, 6)       -- UNDERWATER_TUNNEL_WELD_STAGE__PASSED
    end

    if LOCAL_BITS_TEST(script, sGlassCuttingData.iBitset, 0, 2) then -- ciGLASS_CUTTING_BITSET__STARTED, ciGLASS_CUTTING_BITSET__STARTED_TIMECYCLE_MOD
        LOCAL_SET_FLOAT(script, sGlassCuttingData.fGlassCuttingProgress, 100)
    end

    if LOCAL_GET_INT(script, eEnterSafeCombinationStage) == 3 then -- ENTER_SAFE_COMBINATION_STAGE__RUNNING
        for iPanel = 0, 2, 1 do
            -- sEnterSafeCombinationData.sEnterSafePanels[iPanel].fCurrentSafeValue
            LOCAL_SET_FLOAT(script, sEnterSafeCombinationData.sEnterSafePanels + iPanel * 2, 0)
            -- sEnterSafeCombinationData.sEnterSafePanels[iPanel].iCorrectSafeValue
            LOCAL_SET_INT(script, sEnterSafeCombinationData.sEnterSafePanels + iPanel * 2 + 1, 0)
        end
        LOCAL_SET_INT(script, sEnterSafeCombinationData.iCurrentlySelectedDisplayPanel, 2)

        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- INPUT_CURSOR_ACCEPT
    end

    if LOCAL_GET_INT(script, Voltage.eCurrentState) == 3 then -- VS_PICK_LINK
        LOCAL_SET_INT(script, Voltage.iTargetValue, 0)
        LOCAL_SET_INT(script, Voltage.iCurrentValue, 0)
        LOCAL_SET_INT(script, Voltage.iLinkCount, 3)

        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- INPUT_FRONTEND_ACCEPT
    end

    if LOCAL_GET_INT(script, sBeamHackGameplayData.eBeamHackState) == 2 then -- BEAM_HACK_PLAY
        LOCAL_SET_INT(script, sBeamHackGameplayData.eBeamHackState, 3)       -- BEAM_HACK_PASS
    end

    if GLOBAL_GET_INT(iHackStage) > 0 then
        -- MC_playerBD[iLocalPart].iVehCapturing
        local iVehCapturing = LOCAL_GET_INT(script, 60496 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 261 + 111)
        if iVehCapturing ~= -1 then
            -- MC_serverBD_1.iControlVehTimer[iVeh]
            LOCAL_SET_INT(script, 51882 + 224 + 1 + iVehCapturing, 0)
        end
    end
end

HACKING_MINIGAME["fm_content_stash_house"] = function(script)
    local sSafeData = {
        eSafeStage = 117 + 15,
        iCurrentlySelectedPanel = 117 + 20,
        sSafePanel = 117 + 22 + 1,
    }


    if LOCAL_GET_INT(script, sSafeData.eSafeStage) == 3 then -- eSAFE_COMBINATIONSTAGE_RUN
        for iPanel = 0, 2, 1 do
            -- sLocalVariables.sSafeData.sSafePanel[iPanel].fCurrentValue
            LOCAL_SET_FLOAT(script, sSafeData.sSafePanel + iPanel * 2, 0)
            -- sLocalVariables.sSafeData.sSafePanel[iPanel].iCorrectValue
            LOCAL_SET_INT(script, sSafeData.sSafePanel + iPanel * 2 + 1, 0)
        end
        LOCAL_SET_INT(script, sSafeData.iCurrentlySelectedPanel, 2)

        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- INPUT_CURSOR_ACCEPT
    end
end

function SKIP_HACKING_MINIGAME()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        HACKING_MINIGAME.MISSION_CONTROLLER(script)
        return
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        HACKING_MINIGAME.MISSION_CONTROLLER_2020(script)
        return
    end

    local script_list = {
        "fm_content_stash_house",
    }
    for _, script_name in pairs(script_list) do
        HACKING_MINIGAME[script_name](script_name)
        return
    end
end
