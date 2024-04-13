-- Game Variables
-- 1.68-3095

------------------------
-- Globals
------------------------

Globals = {
    -- GlobalplayerBD[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD = function()
        return 2657921 + 1 + players.user() * 463
    end,

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_3 = function()
        return 1886967 + 1 + players.user() * 609
    end,

    MPGlobalsAmbience = 2738587,


    bBrowserVisible = 76369,

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos]
    sMissionHeaderVars = 794744 + 4 + 1
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
    eChosenApproachType = g_sCasinoHeistMissionConfigData,
    eTarget = g_sCasinoHeistMissionConfigData + 1,

    bSecurityCameraLocationsScoped = g_sCasinoHeistMissionConfigData + 2,
    bGuardPatrolRoutesScoped = g_sCasinoHeistMissionConfigData + 3,
    eShipmentDisruptionLevel = g_sCasinoHeistMissionConfigData + 4,
    bStealthNightVisionAcquired = g_sCasinoHeistMissionConfigData + 5,
    bHandheldDrillAcquired = g_sCasinoHeistMissionConfigData + 6,
    bEMPAcquired = g_sCasinoHeistMissionConfigData + 7,

    eDropoffLocation = g_sCasinoHeistMissionConfigData + 8,
    eDropoffSubLocation = g_sCasinoHeistMissionConfigData + 9,
    bDecoyCrewMemberPurchased = g_sCasinoHeistMissionConfigData + 10,
    bSwitchGetawayVehiclePurchased = g_sCasinoHeistMissionConfigData + 11,
    eVehicleModPresetChosen = g_sCasinoHeistMissionConfigData + 12,

    eCrewWeaponsExpertChosen = g_sCasinoHeistMissionConfigData + 13,
    eCrewWeaponsLoadoutChosen = g_sCasinoHeistMissionConfigData + 14,
    eCrewDriverChosen = g_sCasinoHeistMissionConfigData + 15,
    eCrewVehiclesLoadoutChosen = g_sCasinoHeistMissionConfigData + 16,
    eCrewHackerChosen = g_sCasinoHeistMissionConfigData + 17,
    eCrewKeyAccessLevel = g_sCasinoHeistMissionConfigData + 18,
    eEntranceChosen = g_sCasinoHeistMissionConfigData + 19,
    eExitChosen = g_sCasinoHeistMissionConfigData + 20,
    eMasksChosen = g_sCasinoHeistMissionConfigData + 21,

    eSubterfugeOutfitsIn = g_sCasinoHeistMissionConfigData + 22,
    eSubterfugeOutfitsOut = g_sCasinoHeistMissionConfigData + 23,
    bOfficeInfested = g_sCasinoHeistMissionConfigData + 24,

    iAccessPointBitset = g_sCasinoHeistMissionConfigData + 25,
    bRappelGearAcquired = g_sCasinoHeistMissionConfigData + 26,
    bHardMode = g_sCasinoHeistMissionConfigData + 27
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


------------------------
-- Locals
------------------------

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

        iLocalBoolCheck11 = 15149
    },
    ["fm_mission_controller_2020"] = {
        iNextMission = 48513 + 1578,
        iTeamScore = 48513 + 1765 + 1, -- +[0~3]
        iServerBitSet = 48513 + 1,
        iServerBitSet1 = 48513 + 2,

        iLocalBoolCheck11 = 47286
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


------------------------
-- Tunables
------------------------

TunablesI = {
    ["GR_RESUPPLY_PACKAGE_VALUE"] = 21733,
    ["GR_RESUPPLY_VEHICLE_VALUE"] = 21734,
    ["ACID_LAB_RESUPPLY_CRATE_VALUE"] = 33039,
    ["BIKER_RESUPPLY_PACKAGE_VALUE"] = 18590,
    ["BIKER_RESUPPLY_VEHICLE_VALUE"] = 18591,

    -- Freemode Mission Cash Reward
    ["TunerClientVehicleDeliveryPayment"] = {
        31417, -- TUNER_CLIENT_VEHICLE_DELIVERY_LOW_PAYMENT
        31418, -- TUNER_CLIENT_VEHICLE_DELIVERY_MID_PAYMENT
        31419, -- TUNER_CLIENT_VEHICLE_DELIVERY_HIGH_PAYMENT
    },
    ["TunerClientVehicleBouns"] = {
        31429, -- ITUNER_CLIENT_VEHICLE_BONUS_L1
        31430, -- ITUNER_CLIENT_VEHICLE_BONUS_L2
        31431, -- ITUNER_CLIENT_VEHICLE_BONUS_L3
        31432, -- ITUNER_CLIENT_VEHICLE_BONUS_L4
    },
    ["CUSTOMER_BIKE_DELIVERY_DEFAULT_CASH_BONUS_REWARD"] = 33209,
    ["BikerClientVehicleBouns"] = {
        32949, -- BIKER_CLIENT_VEHICLE_BONUS_L1
        32950, -- BIKER_CLIENT_VEHICLE_BONUS_L2
        32951, -- BIKER_CLIENT_VEHICLE_BONUS_L3
        32952, -- BIKER_CLIENT_VEHICLE_BONUS_L4
    },
    ["SecurityContractCashReward"] = {
        32058 + 1 + 0, -- FIXER_SECURITY_CONTRACT_MIN_REWARD0
        32058 + 1 + 1, -- FIXER_SECURITY_CONTRACT_MIN_REWARD1
        32058 + 1 + 2, -- FIXER_SECURITY_CONTRACT_MIN_REWARD2
        32062 + 1 + 0, -- FIXER_SECURITY_CONTRACT_MAX_REWARD0
        32062 + 1 + 1, -- FIXER_SECURITY_CONTRACT_MAX_REWARD1
        32062 + 1 + 2, -- FIXER_SECURITY_CONTRACT_MAX_REWARD2
    },
    ["ClientWorkCashReward"] = {
        24820, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_BANK_JOB
        24821, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_DATA_HACK
        24822, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_SURVEILLANCE
        24823, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_INFILTRATION
        24824, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_JEWEL_STORE_GRAB
    },
    ["FIXER_PAYPHONE_HIT_STANDARD_KILL_METHOD_CASH_REWARD"] = 32050,
    ["FIXER_PAYPHONE_HIT_BONUS_KILL_METHOD_CASH_REWARD"] = 32051,
    ["XM22_DRUG_LAB_WORK_CASH_REWARD"] = 34209,
    ["VC_WORK_CASH_REWARD"] = 27346,
    ["VC_WORK_CHIP_REWARD"] = 27353,


    -- Heist Mission Cash Reward
    ["HeistFinalCashReward"] = {
        9314, -- HEIST_FLEECA_JOB_CASH_REWARD
        9315, -- HEIST_PRISON_BREAK_CASH_REWARD
        9316, -- HEIST_HUMANE_LABS_RAID_CASH_REWARD
        9317, -- HEIST_SERIES_A_FUNDING_CASH_REWARD
        9318, -- HEIST_PACIFIC_STANDARD_JOB_CASH_REWARD
    },
    ["GangopsFinalCashReward"] = {
        9319, -- GANGOPS_THE_IAA_JOB_CASH_REWARD
        9320, -- GANGOPS_THE_SUBMARINE_JOB_CASH_REWARD
        9321, -- GANGOPS_THE_MISSILE_SILO_JOB_CASH_REWARD
    },
    ["GangopsPrepCashReward"] = {
        9322, -- GANGOPS_PREP_THE_IAA_JOB_CASH_REWARD
        9323, -- GANGOPS_PREP_THE_SUBMARINE_JOB_CASH_REWARD
        9324, -- GANGOPS_PREP_THE_MISSILE_SILO_JOB_CASH_REWARD
    },
    ["IslandHeistPrimaryTargetValue"] = {
        30259, -- IH_PRIMARY_TARGET_VALUE_TEQUILA
        30260, -- IH_PRIMARY_TARGET_VALUE_PEARL_NECKLACE
        30261, -- IH_PRIMARY_TARGET_VALUE_BEARER_BONDS
        30262, -- IH_PRIMARY_TARGET_VALUE_PINK_DIAMOND
        30263, -- IH_PRIMARY_TARGET_VALUE_MADRAZO_FILES
        30264, -- IH_PRIMARY_TARGET_VALUE_SAPPHIRE_PANTHER_STATUE
    },
    ["TunerRobberyLeaderCashReward"] = {
        31323 + 1 + 0, -- TUNER_ROBBERY_LEADER_CASH_REWARD0
        31323 + 1 + 1, -- TUNER_ROBBERY_LEADER_CASH_REWARD1
        31323 + 1 + 2, -- TUNER_ROBBERY_LEADER_CASH_REWARD2
        31323 + 1 + 3, -- TUNER_ROBBERY_LEADER_CASH_REWARD3
        31323 + 1 + 4, -- TUNER_ROBBERY_LEADER_CASH_REWARD4
        31323 + 1 + 5, -- TUNER_ROBBERY_LEADER_CASH_REWARD5
        31323 + 1 + 6, -- TUNER_ROBBERY_LEADER_CASH_REWARD6
        31323 + 1 + 7, -- TUNER_ROBBERY_LEADER_CASH_REWARD7
    },
    ["FIXER_FINALE_LEADER_CASH_REWARD"] = 32071,
    ["-2000196818"] = 7339,

    -- Reward
    ["NightclubSourceRewardAmount"] = {
        32941, -- NC_SOURCE_CARGO_UNIT_REWARD_AMOUNT
        32942, -- NC_SOURCE_WEAPONS_UNIT_REWARD_AMOUNT
        32943, -- NC_SOURCE_COKE_UNIT_REWARD_AMOUNT
        32944, -- NC_SOURCE_METH_UNIT_REWARD_AMOUNT
        32945, -- NC_SOURCE_WEED_UNIT_REWARD_AMOUNT
        32946, -- NC_SOURCE_FORGED_DOCS_UNIT_REWARD_AMOUNT
        32947, -- NC_SOURCE_COUNTERFEIT_CASH_UNIT_REWARD_AMOUNT
    },

    -- Product Sale Value
    ["SpecialCargoSaleValue"] = {
        15991, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD1
        15992, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD2
        15993, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD3
        15994, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD4
        15995, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD5
        15996, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD6
        15997, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD7
        15998, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD8
        15999, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD9
        16000, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD10
        16001, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD11
        16002, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD12
        16003, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD13
        16004, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD14
        16005, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD15
        16006, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD16
        16007, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD17
        16008, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD18
        16009, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD19
        16010, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD20
        16011, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD21
    },
    ["SpecialItemSaleValue"] = {
        16190, -- EXEC_CONTRABAND_FILM_REEL_VALUE
        16192, -- EXEC_CONTRABAND_SASQUATCH_HIDE_VALUE
        16194, -- EXEC_CONTRABAND_GOLDEN_MINIGUN_VALUE
        16196, -- EXEC_CONTRABAND_ORNAMENTAL_EGG_VALUE
        16198, -- EXEC_CONTRABAND_XL_DIAMOND_VALUE
        16200, -- EXEC_CONTRABAND_POCKET_WATCH_VALUE
    },
    ["GunrunProductSaleValue"] = {
        21747, -- GR_MANU_PRODUCT_VALUE
        21748, -- GR_MANU_PRODUCT_VALUE_STAFF_UPGRADE
        21749, -- GR_MANU_PRODUCT_VALUE_EQUIPMENT_UPGRADE
    },
    ["SmugProductSaleValue"] = {
        23020, -- SMUG_SELL_PRICE_PER_CRATE_MIXED
        23021, -- SMUG_SELL_PRICE_PER_CRATE_ANIMAL_MATERIALS
        23022, -- SMUG_SELL_PRICE_PER_CRATE_ART_AND_ANTIQUES
        23023, -- SMUG_SELL_PRICE_PER_CRATE_CHEMICALS
        23024, -- SMUG_SELL_PRICE_PER_CRATE_COUNTERFEIT_GOODS
        23025, -- SMUG_SELL_PRICE_PER_CRATE_JEWELRY_AND_GEMSTONES
        23026, -- SMUG_SELL_PRICE_PER_CRATE_MEDICAL_SUPPLIES
        23027, -- SMUG_SELL_PRICE_PER_CRATE_NARCOTICS
        23028, -- SMUG_SELL_PRICE_PER_CRATE_TOBACCO_AND_ALCOHOL
    },
    ["AcidProductSaleValue"] = {
        17633, -- BIKER_ACID_PRODUCT_VALUE
        17639, -- BIKER_ACID_PRODUCT_VALUE_EQUIPMENT_UPGRADE
    },
    ["NightclubProductSaleValue"] = {
        24593, -- BB_BUSINESS_BASIC_VALUE_WEAPONS
        24594, -- BB_BUSINESS_BASIC_VALUE_COKE
        24595, -- BB_BUSINESS_BASIC_VALUE_METH
        24596, -- BB_BUSINESS_BASIC_VALUE_WEED
        24597, -- BB_BUSINESS_BASIC_VALUE_FORGED_DOCUMENTS
        24598, -- BB_BUSINESS_BASIC_VALUE_COUNTERFEIT_CASH
        24599, -- BB_BUSINESS_BASIC_VALUE_CARGO
    },
    ["BikerProductSaleValue"] = {
        17629, -- BIKER_COUNTERCASH_PRODUCT_VALUE
        17635, -- BIKER_COUNTERCASH_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17641, -- BIKER_COUNTERCASH_PRODUCT_VALUE_STAFF_UPGRADE
        17630, -- BIKER_CRACK_PRODUCT_VALUE
        17636, -- BIKER_CRACK_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17642, -- BIKER_CRACK_PRODUCT_VALUE_STAFF_UPGRADE
        17628, -- BIKER_FAKEIDS_PRODUCT_VALUE
        17634, -- BIKER_FAKEIDS_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17640, -- BIKER_FAKEIDS_PRODUCT_VALUE_STAFF_UPGRADE
        17631, -- BIKER_METH_PRODUCT_VALUE
        17637, -- BIKER_METH_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17643, -- BIKER_METH_PRODUCT_VALUE_STAFF_UPGRADE
        17632, -- BIKER_WEED_PRODUCT_VALUE
        17638, -- BIKER_WEED_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17644, -- BIKER_WEED_PRODUCT_VALUE_STAFF_UPGRADE
    },


    ["NpcCut"] = {
        29068, -- CH_LESTER_CUT
        29094, -- HEIST3_PREPBOARD_GUNMEN_KARL_CUT
        29095, -- HEIST3_PREPBOARD_GUNMEN_GUSTAVO_CUT
        29096, -- HEIST3_PREPBOARD_GUNMEN_CHARLIE_CUT
        29097, -- HEIST3_PREPBOARD_GUNMEN_CHESTER_CUT
        29098, -- HEIST3_PREPBOARD_GUNMEN_PATRICK_CUT
        29099, -- HEIST3_DRIVERS_KARIM_CUT
        29100, -- HEIST3_DRIVERS_TALIANA_CUT
        29101, -- HEIST3_DRIVERS_EDDIE_CUT
        29102, -- HEIST3_DRIVERS_ZACH_CUT
        29103, -- HEIST3_DRIVERS_CHESTER_CUT
        29104, -- HEIST3_HACKERS_RICKIE_CUT
        29105, -- HEIST3_HACKERS_CHRISTIAN_CUT
        29106, -- HEIST3_HACKERS_YOHAN_CUT
        29107, -- HEIST3_HACKERS_AVI_CUT
        29108, -- HEIST3_HACKERS_PAIGE_CUT
    },


    -- Import Export
    ["ImpExpWantedCap"] = {
        16872, -- EXEC_BUY_LOSE_THE_COPS_WANTED_CAP
        19533, -- IMPEXP_STEAL_HARD_WANTED_CAP
        19537, -- IMPEXP_STEAL_MEDIUM_WANTED_CAP
        19543, -- IMPEXP_STEAL_EASY_WANTED_CAP
        19562, -- IMPEXP_POLICE_CHASE_WANTED_CAP
    },
    ["ImpExpReduction"] = {
        19868, -- IMPEXP_STEAL_REDUCTION_HARD
        19869, -- IMPEXP_STEAL_REDUCTION_MEDIUM
        19870, -- IMPEXP_STEAL_REDUCTION_EASY
        19613, -- IMPEXP_SELL_REDUCTION_BUYER1_HARD
        19614, -- IMPEXP_SELL_REDUCTION_BUYER1_MEDIUM
        19615, -- IMPEXP_SELL_REDUCTION_BUYER1_EASY
        19616, -- IMPEXP_SELL_REDUCTION_BUYER2_HARD
        19617, -- IMPEXP_SELL_REDUCTION_BUYER2_MEDIUM
        19618, -- IMPEXP_SELL_REDUCTION_BUYER2_EASY
        19619, -- IMPEXP_SELL_REDUCTION_BUYER3_HARD
        19620, -- IMPEXP_SELL_REDUCTION_BUYER3_MEDIUM
        19621, -- IMPEXP_SELL_REDUCTION_BUYER3_EASY
    },
    ["ImpExpGangChase"] = {
        19534, -- IMPEXP_STEAL_HARD_GANG_CHASE
        19540, -- IMPEXP_STEAL_MEDIUM_GANG_CHASE
        19546, -- IMPEXP_STEAL_EASY_GANG_CHASE
        19593, -- IMPEXP_SELL_GANG_CHASE_SMALL_SESSIONS
    },
    ["ImpExpSellOffer"] = {
        19624, -- IMPEXP_SELL_BUYER1_OFFER_EASY
        19623, -- IMPEXP_SELL_BUYER1_OFFER_MED
        19622, -- IMPEXP_SELL_BUYER1_OFFER_HARD
    },


    ["MissionCooldowns"] = {
        15756, -- EXEC_BUY_COOLDOWN
        15757, -- EXEC_SELL_COOLDOWN

        19524, -- IMPEXP_STEAL_COOLDOWN
        19605, -- IMPEXP_SELL_COOLDOWN

        19892, -- IMPEXP_SELL_1_CAR_COOLDOWN
        19893, -- IMPEXP_SELL_2_CAR_COOLDOWN
        19894, -- IMPEXP_SELL_3_CAR_COOLDOWN
        19895, -- IMPEXP_SELL_4_CAR_COOLDOWN

        22961, -- SMUG_STEAL_EASY_COOLDOWN_TIMER
        22962, -- SMUG_STEAL_MED_COOLDOWN_TIMER
        22963, -- SMUG_STEAL_HARD_COOLDOWN_TIMER
        22964, -- SMUG_STEAL_ADDITIONAL_CRATE_COOLDOWN_TIME
        23002, -- SMUG_SELL_SELL_COOLDOWN_TIMER

        32024, -- FIXER_SECURITY_CONTRACT_COOLDOWN_TIME
        32105, -- REQUEST_FRANKLIN_PAYPHONE_HIT_COOLDOWN
        33198, -- BUNKER_SOURCE_RESEARCH_CD_TIME
        33199, -- NIGHTCLUB_SOURCE_GOODS_CD_TIME
        27510, -- VC_WORK_REQUEST_COOLDOWN
        34195, -- JUGALLO_BOSS_WORK_COOLDOWN_TIME

        24659, -- BB_CLUB_MANAGEMENT_CLUB_MANAGEMENT_MISSION_COOLDOWN
        24701, -- BB_SELL_MISSIONS_MISSION_COOLDOWN

        24848, -- BB_HACKER_WORK_CLIENT_WORK_GLOBAL_COOLDOWN
        24849, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_BANK_JOB
        24850, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_DATA_HACK
        24851, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_INFILTRATION
        24852, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_JEWEL_STORE_GRAB

        24853, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_GLOBAL_COOLDOWN
        24854, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_SECURITY_VANS
        24855, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_TARGET_PURSUIT

        19043, -- BIKER_CHALLENGES_COOLDOWN_GLOBAL
        19044, -- BIKER_CHALLENGES_COOLDOWN_SPECIFIC
        18841, -- BIKER_CLUBHOUSE_COOLDOWN
        18956, -- BIKER_CLUB_WORK_COOLDOWN_GLOBAL
    },

    ["RequestCooldowns"] = {
        11911, -- PEGASUS_CRIM_COOL_DOWN
        12151, -- LESTER_VEHICLE_CRIM_COOL_DOWN
        13032, -- GB_CALL_VEHICLE_COOLDOWN
        19463, -- PV_MECHANIC_COOLDOWN
        19464, -- SV_MECHANIC_COOLDOWN
        21779, -- GR_MOBILE_OPERATIONS_CENTRE_COOLDOWN_TIMER
        21783, -- AA_TRAILER_EQ_COOLDOWN_TIMER
        22076, -- ACID_LAB_REQUEST_COOLDOWN
        22899, -- SMUG_REQUEST_PERSONAL_AIRCRAFT_COOLDOWN
        23305, -- H2_AVENGER_INTN_MENU_REQUEST_AVENGER_COOLDOWN
        24702, -- BB_SELL_MISSIONS_DELIVERY_VEHICLE_COOLDOWN_AFTER_SELL_MISSION
        24908, -- BB_TERRORBYTE_TERRORBYTE_COOLDOWN_TIMER
        24926, -- BB_SUBMARINE_REQUEST_COOLDOWN_TIMER
        24927, -- BB_SUBMARINE_DINGHY_REQUEST_COOLDOWN_TIMER
        26046, -- BANDITO_COOLDOWN_TIME
        26047, -- TANK_COOLDOWN_TIME
        28649, -- VC_COOLDOWN_REQUEST_CAR_SERVICE
        28650, -- VC_COOLDOWN_REQUEST_LIMO_SERVICE
        28685, -- OPPRESSOR2CD
        31190, -- IH_MOON_POOL_COOLDOWN
        32106, -- REQUEST_COMPANY_SUV_SERVICE_COOLDOWN
        32101, -- IMANI_SOURCE_MOTORCYCLE_COOLDOWN
        33588, -- TONY_LIMO_COOLDOWN_TIME
        33589, -- BUNKER_VEHICLE_COOLDOWN_TIME
        34196, -- JUGALLO_BOSS_VEHICLE_COOLDOWN_TIME

        13034, -- GB_DROP_AMMO_COOLDOWN
        13035, -- GB_DROP_ARMOR_COOLDOWN
        13036, -- GB_DROP_BULLSHARK_COOLDOWN
        13037, -- GB_GHOST_ORG_COOLDOWN
        13038, -- GB_BRIBE_AUTHORITIES_COOLDOWN

        21393, -- BALLISTICARMOURREQUESTCOOLDOWN
        32099, -- FRANKLIN_SUPPLY_STASH_COOLDOWN
        32103, -- IMANI_OUT_OF_SIGHT_COOLDOWN
    },
}

TunablesF = {
    ["NpcCut"] = {
        23003, -- SMUG_SELL_RONS_CUT
        24708, -- BB_SELL_MISSIONS_TONYS_CUT
        30269, -- IH_DEDUCTION_PAVEL_CUT
        31319, -- TUNER_ROBBERY_CONTACT_FEE
    },

    ["HIGH_ROCKSTAR_MISSIONS_MODIFIER"] = 2430,
    ["LOW_ROCKSTAR_MISSIONS_MODIFIER"] = 2434,
}


------------------------
-- Functions
------------------------

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
    GLOBAL_SET_INT(2693219 + 1, 0)

    -- SET_TRANSITION_SESSIONS_SKIP_JOB_WARNING()
    ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_SKIP_JOB_WARNING)
    GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 2)

    -- SET_FM_JOB_ENTERY_TYPE(ciMISSION_ENTERY_TYPE_XXX)
    ---- g_iMissionEnteryType = iType
    GLOBAL_SET_INT(1057441, Data.iMissionEnteryType)

    -- FMMC_TYPE_TUNER_ROBBERY_FINALE
    if Data.iMissionType == 274 then
        -- SET_TRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 13)

        -- SET_PLAYER_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP)
        GLOBAL_SET_BIT(1882422 + 1 + players.user() * 142 + 30, 28)
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
    GLOBAL_SET_INT(1845263 + 1 + players.user() * 877 + 95, 8)
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
    GLOBAL_SET_INT(1845263 + 1 + players.user() * 877 + 95, 8)
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

function COMPLETE_WEEKLY_CHALLENGE()
    local g_sWeeklyChallenge = 2737646

    local target = GLOBAL_GET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 2)
    if GLOBAL_GET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1) < target then
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 3, 0)
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 4, 0)
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1, target)
    end
end
