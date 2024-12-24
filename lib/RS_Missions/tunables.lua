-- Game Variables
-- 1.70-3411

--------------------------------
--  Tunables
--------------------------------

local TunablesI = {
    ["GR_RESUPPLY_PACKAGE_VALUE"] = 21240,
    ["GR_RESUPPLY_VEHICLE_VALUE"] = 21241,
    ["ACID_LAB_RESUPPLY_CRATE_VALUE"] = 32025,
    ["BIKER_RESUPPLY_PACKAGE_VALUE"] = 18227,
    ["BIKER_RESUPPLY_VEHICLE_VALUE"] = 18228,
    ["SR_JUGGERNAUT_RESEARCH_REWARD"] = 31905,

    -- Freemode Mission Cash Reward
    ["TunerClientVehicleDeliveryPayment"] = {
        30431, -- TUNER_CLIENT_VEHICLE_DELIVERY_LOW_PAYMENT
        30432, -- TUNER_CLIENT_VEHICLE_DELIVERY_MID_PAYMENT
        30433, -- TUNER_CLIENT_VEHICLE_DELIVERY_HIGH_PAYMENT
    },
    ["TunerClientVehicleBouns"] = {
        30443, -- ITUNER_CLIENT_VEHICLE_BONUS_L1
        30444, -- ITUNER_CLIENT_VEHICLE_BONUS_L2
        30445, -- ITUNER_CLIENT_VEHICLE_BONUS_L3
        30446, -- ITUNER_CLIENT_VEHICLE_BONUS_L4
    },
    ["CUSTOMER_BIKE_DELIVERY_DEFAULT_CASH_BONUS_REWARD"] = 32194,
    ["BikerClientVehicleBouns"] = {
        31935, -- BIKER_CLIENT_VEHICLE_BONUS_L1
        31936, -- BIKER_CLIENT_VEHICLE_BONUS_L2
        31937, -- BIKER_CLIENT_VEHICLE_BONUS_L3
        31938, -- BIKER_CLIENT_VEHICLE_BONUS_L4
    },
    ["SecurityContractCashReward"] = {
        31071 + 1 + 0, -- FIXER_SECURITY_CONTRACT_MIN_REWARD0
        31071 + 1 + 1, -- FIXER_SECURITY_CONTRACT_MIN_REWARD1
        31071 + 1 + 2, -- FIXER_SECURITY_CONTRACT_MIN_REWARD2
        31075 + 1 + 0, -- FIXER_SECURITY_CONTRACT_MAX_REWARD0
        31075 + 1 + 1, -- FIXER_SECURITY_CONTRACT_MAX_REWARD1
        31075 + 1 + 2, -- FIXER_SECURITY_CONTRACT_MAX_REWARD2
    },
    ["ClientWorkCashReward"] = {
        24184, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_BANK_JOB
        24185, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_DATA_HACK
        24186, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_INFILTRATION
        24187, -- BB_HACKER_WORK_CLIENT_WORK_CASH_REWARD_JEWEL_STORE_GRAB
    },
    ["FIXER_PAYPHONE_HIT_STANDARD_KILL_METHOD_CASH_REWARD"] = 31063,
    ["FIXER_PAYPHONE_HIT_BONUS_KILL_METHOD_CASH_REWARD"] = 31064,
    ["XM22_DRUG_LAB_WORK_CASH_REWARD"] = 33154,
    ["VC_WORK_CASH_REWARD"] = 26641,
    ["VC_WORK_CHIP_REWARD"] = 26647,
    ["SmugglerOperationCashReward"] = {
        33003 + 1 + 0, -- SMUGGLER_OPERATION_MIN_REWARD_0
        33003 + 1 + 1, -- SMUGGLER_OPERATION_MIN_REWARD_1
        33006 + 1 + 0, -- SMUGGLER_OPERATION_MAX_REWARD_0
        33006 + 1 + 1, -- SMUGGLER_OPERATION_MAX_REWARD_1
        33009,         -- -464886572
        33010,         -- 1818346009
    },
    ["SMUGGLER_OPERATION_BONUS_OBJECTIVE_REWARD"] = 33011,

    -- Heist Mission Cash Reward
    ["HeistFinalCashReward"] = {
        9171, -- HEIST_FLEECA_JOB_CASH_REWARD
        9172, -- HEIST_PRISON_BREAK_CASH_REWARD
        9173, -- HEIST_HUMANE_LABS_RAID_CASH_REWARD
        9174, -- HEIST_SERIES_A_FUNDING_CASH_REWARD
        9175, -- HEIST_PACIFIC_STANDARD_JOB_CASH_REWARD
    },
    ["GangopsFinalCashReward"] = {
        9176, -- GANGOPS_THE_IAA_JOB_CASH_REWARD
        9177, -- GANGOPS_THE_SUBMARINE_JOB_CASH_REWARD
        9178, -- GANGOPS_THE_MISSILE_SILO_JOB_CASH_REWARD
    },
    ["GangopsPrepCashReward"] = {
        9179, -- GANGOPS_PREP_THE_IAA_JOB_CASH_REWARD
        9180, -- GANGOPS_PREP_THE_SUBMARINE_JOB_CASH_REWARD
        9181, -- GANGOPS_PREP_THE_MISSILE_SILO_JOB_CASH_REWARD
    },
    ["IslandHeistPrimaryTargetValue"] = {
        29458, -- IH_PRIMARY_TARGET_VALUE_TEQUILA
        29459, -- IH_PRIMARY_TARGET_VALUE_PEARL_NECKLACE
        29460, -- IH_PRIMARY_TARGET_VALUE_BEARER_BONDS
        29461, -- IH_PRIMARY_TARGET_VALUE_PINK_DIAMOND
        29462, -- IH_PRIMARY_TARGET_VALUE_MADRAZO_FILES
        29463, -- IH_PRIMARY_TARGET_VALUE_SAPPHIRE_PANTHER_STATUE
    },
    ["TunerRobberyLeaderCashReward"] = {
        30338 + 1 + 0, -- TUNER_ROBBERY_LEADER_CASH_REWARD0
        30338 + 1 + 1, -- TUNER_ROBBERY_LEADER_CASH_REWARD1
        30338 + 1 + 2, -- TUNER_ROBBERY_LEADER_CASH_REWARD2
        30338 + 1 + 3, -- TUNER_ROBBERY_LEADER_CASH_REWARD3
        30338 + 1 + 4, -- TUNER_ROBBERY_LEADER_CASH_REWARD4
        30338 + 1 + 5, -- TUNER_ROBBERY_LEADER_CASH_REWARD5
        30338 + 1 + 6, -- TUNER_ROBBERY_LEADER_CASH_REWARD6
        30338 + 1 + 7, -- TUNER_ROBBERY_LEADER_CASH_REWARD7
    },
    ["FIXER_FINALE_LEADER_CASH_REWARD"] = 31084,
    ["-2000196818"] = 7361,

    -- Reward
    ["NightclubSourceRewardAmount"] = {
        31927, -- NC_SOURCE_CARGO_UNIT_REWARD_AMOUNT
        31928, -- NC_SOURCE_WEAPONS_UNIT_REWARD_AMOUNT
        31929, -- NC_SOURCE_COKE_UNIT_REWARD_AMOUNT
        31930, -- NC_SOURCE_METH_UNIT_REWARD_AMOUNT
        31931, -- NC_SOURCE_WEED_UNIT_REWARD_AMOUNT
        31932, -- NC_SOURCE_FORGED_DOCS_UNIT_REWARD_AMOUNT
        31933, -- NC_SOURCE_COUNTERFEIT_CASH_UNIT_REWARD_AMOUNT
    },

    -- Product Sale Value
    ["SpecialCargoSaleValue"] = {
        15732, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD1
        15733, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD2
        15734, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD3
        15735, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD4
        15736, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD5
        15737, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD6
        15738, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD7
        15739, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD8
        15740, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD9
        15741, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD10
        15742, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD11
        15743, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD12
        15744, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD13
        15745, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD14
        15746, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD15
        15747, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD16
        15748, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD17
        15749, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD18
        15750, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD19
        15751, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD20
        15752, -- EXEC_CONTRABAND_SALE_VALUE_THRESHOLD21
    },
    ["SpecialItemSaleValue"] = {
        15926, -- EXEC_CONTRABAND_FILM_REEL_VALUE
        15928, -- EXEC_CONTRABAND_SASQUATCH_HIDE_VALUE
        15930, -- EXEC_CONTRABAND_GOLDEN_MINIGUN_VALUE
        15932, -- EXEC_CONTRABAND_ORNAMENTAL_EGG_VALUE
        15934, -- EXEC_CONTRABAND_XL_DIAMOND_VALUE
        15936, -- EXEC_CONTRABAND_POCKET_WATCH_VALUE
    },
    ["GunrunProductSaleValue"] = {
        21254, -- GR_MANU_PRODUCT_VALUE
        21255, -- GR_MANU_PRODUCT_VALUE_STAFF_UPGRADE
        21256, -- GR_MANU_PRODUCT_VALUE_EQUIPMENT_UPGRADE
    },
    ["SmugProductSaleValue"] = {
        22492, -- SMUG_SELL_PRICE_PER_CRATE_MIXED
        22493, -- SMUG_SELL_PRICE_PER_CRATE_ANIMAL_MATERIALS
        22494, -- SMUG_SELL_PRICE_PER_CRATE_ART_AND_ANTIQUES
        22495, -- SMUG_SELL_PRICE_PER_CRATE_CHEMICALS
        22496, -- SMUG_SELL_PRICE_PER_CRATE_COUNTERFEIT_GOODS
        22497, -- SMUG_SELL_PRICE_PER_CRATE_JEWELRY_AND_GEMSTONES
        22498, -- SMUG_SELL_PRICE_PER_CRATE_MEDICAL_SUPPLIES
        22499, -- SMUG_SELL_PRICE_PER_CRATE_NARCOTICS
        22500, -- SMUG_SELL_PRICE_PER_CRATE_TOBACCO_AND_ALCOHOL
    },
    ["AcidProductSaleValue"] = {
        17324, -- BIKER_ACID_PRODUCT_VALUE
        17330, -- BIKER_ACID_PRODUCT_VALUE_EQUIPMENT_UPGRADE
    },
    ["NightclubProductSaleValue"] = {
        23963, -- BB_BUSINESS_BASIC_VALUE_WEAPONS
        23964, -- BB_BUSINESS_BASIC_VALUE_COKE
        23965, -- BB_BUSINESS_BASIC_VALUE_METH
        23966, -- BB_BUSINESS_BASIC_VALUE_WEED
        23967, -- BB_BUSINESS_BASIC_VALUE_FORGED_DOCUMENTS
        23968, -- BB_BUSINESS_BASIC_VALUE_COUNTERFEIT_CASH
        23969, -- BB_BUSINESS_BASIC_VALUE_CARGO
    },
    ["BikerProductSaleValue"] = {
        17320, -- BIKER_COUNTERCASH_PRODUCT_VALUE
        17326, -- BIKER_COUNTERCASH_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17332, -- BIKER_COUNTERCASH_PRODUCT_VALUE_STAFF_UPGRADE
        17321, -- BIKER_CRACK_PRODUCT_VALUE
        17327, -- BIKER_CRACK_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17333, -- BIKER_CRACK_PRODUCT_VALUE_STAFF_UPGRADE
        17319, -- BIKER_FAKEIDS_PRODUCT_VALUE
        17325, -- BIKER_FAKEIDS_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17331, -- BIKER_FAKEIDS_PRODUCT_VALUE_STAFF_UPGRADE
        17322, -- BIKER_METH_PRODUCT_VALUE
        17328, -- BIKER_METH_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17334, -- BIKER_METH_PRODUCT_VALUE_STAFF_UPGRADE
        17323, -- BIKER_WEED_PRODUCT_VALUE
        17329, -- BIKER_WEED_PRODUCT_VALUE_EQUIPMENT_UPGRADE
        17335, -- BIKER_WEED_PRODUCT_VALUE_STAFF_UPGRADE
    },

    -- Import Export
    ["ImpExpWantedCap"] = {
        16604, -- EXEC_BUY_LOSE_THE_COPS_WANTED_CAP
        19086, -- IMPEXP_STEAL_HARD_WANTED_CAP
        19090, -- IMPEXP_STEAL_MEDIUM_WANTED_CAP
        19096, -- IMPEXP_STEAL_EASY_WANTED_CAP
        19113, -- IMPEXP_POLICE_CHASE_WANTED_CAP
    },
    ["ImpExpReduction"] = {
        19408, -- IMPEXP_STEAL_REDUCTION_HARD
        19409, -- IMPEXP_STEAL_REDUCTION_MEDIUM
        19410, -- IMPEXP_STEAL_REDUCTION_EASY
        19161, -- IMPEXP_SELL_REDUCTION_BUYER1_HARD
        19162, -- IMPEXP_SELL_REDUCTION_BUYER1_MEDIUM
        19163, -- IMPEXP_SELL_REDUCTION_BUYER1_EASY
        19164, -- IMPEXP_SELL_REDUCTION_BUYER2_HARD
        19165, -- IMPEXP_SELL_REDUCTION_BUYER2_MEDIUM
        19166, -- IMPEXP_SELL_REDUCTION_BUYER2_EASY
        19167, -- IMPEXP_SELL_REDUCTION_BUYER3_HARD
        19168, -- IMPEXP_SELL_REDUCTION_BUYER3_MEDIUM
        19169, -- IMPEXP_SELL_REDUCTION_BUYER3_EASY
    },
    ["ImpExpGangChase"] = {
        19087, -- IMPEXP_STEAL_HARD_GANG_CHASE
        19093, -- IMPEXP_STEAL_MEDIUM_GANG_CHASE
        19099, -- IMPEXP_STEAL_EASY_GANG_CHASE
        19141, -- IMPEXP_SELL_GANG_CHASE_SMALL_SESSIONS
    },
    ["ImpExpSellOffer"] = {
        19172, -- IMPEXP_SELL_BUYER1_OFFER_EASY
        19171, -- IMPEXP_SELL_BUYER1_OFFER_MED
        19170, -- IMPEXP_SELL_BUYER1_OFFER_HARD
    },

    -- Salvage Yard Robbery
    ["SalvageYardRobberyID"] = {
        33023 + 1 + 0, -- SALV23_VEHICLE_ROBBERY_0
        33023 + 1 + 1, -- SALV23_VEHICLE_ROBBERY_1
        33023 + 1 + 2, -- SALV23_VEHICLE_ROBBERY_2
    },
    ["SalvageYardRobberyCanKeep"] = {
        33027 + 1 + 0, -- SALV23_VEHICLE_ROBBERY_CAN_KEEP_0
        33027 + 1 + 1, -- SALV23_VEHICLE_ROBBERY_CAN_KEEP_1
        33027 + 1 + 2, -- SALV23_VEHICLE_ROBBERY_CAN_KEEP_2
    },
    ["SalvageYardRobberyVehicleID"] = {
        33031 + 1 + 0, -- SALV23_VEHICLE_ROBBERY_ID_0
        33031 + 1 + 1, -- SALV23_VEHICLE_ROBBERY_ID_1
        33031 + 1 + 2, -- SALV23_VEHICLE_ROBBERY_ID_2
    },
    ["SalvageYardRobberyValue"] = {
        33035 + 1 + 0, -- SALV23_VEHICLE_ROBBERY_VALUE_0
        33035 + 1 + 1, -- SALV23_VEHICLE_ROBBERY_VALUE_1
        33035 + 1 + 2, -- SALV23_VEHICLE_ROBBERY_VALUE_2
    },

    -- Freemode Mission
    ["BountyTargetsProcessCooldown"] = {
        35537, -- 681684666
        35538, -- 314999556
        35539, -- -107622345
    },

    -- Business
    ["DisableBusinessRaid"] = {
        15620, -- EXEC_DISABLE_DEFEND_MISSIONS
        15621, -- EXEC_DISABLE_DEFEND_FLEEING
        15622, -- EXEC_DISABLE_DEFEND_UNDER_ATTACK

        18427, -- BIKER_DISABLE_DEFEND_POLICE_RAID
        18431, -- BIKER_DISABLE_DEFEND_SHOOTOUT
        18433, -- BIKER_DISABLE_DEFEND_GETAWAY
        18435, -- BIKER_DISABLE_DEFEND_CRASH_DEAL
        18437, -- BIKER_DISABLE_DEFEND_RETRIEVAL
        18439, -- BIKER_DISABLE_DEFEND_SNITCH
    },
    ["BusinessRaidThreshold"] = {
        21412, -- GR_GENERAL_STOCK_LEVEL_LAUNCH_THRESHOLD
    },

    ["NpcCut"] = {
        28313, -- CH_LESTER_CUT
        28339, -- HEIST3_PREPBOARD_GUNMEN_KARL_CUT
        28340, -- HEIST3_PREPBOARD_GUNMEN_GUSTAVO_CUT
        28341, -- HEIST3_PREPBOARD_GUNMEN_CHARLIE_CUT
        28342, -- HEIST3_PREPBOARD_GUNMEN_CHESTER_CUT
        28343, -- HEIST3_PREPBOARD_GUNMEN_PATRICK_CUT
        28344, -- HEIST3_DRIVERS_KARIM_CUT
        28345, -- HEIST3_DRIVERS_TALIANA_CUT
        28346, -- HEIST3_DRIVERS_EDDIE_CUT
        28347, -- HEIST3_DRIVERS_ZACH_CUT
        28348, -- HEIST3_DRIVERS_CHESTER_CUT
        28349, -- HEIST3_HACKERS_RICKIE_CUT
        28350, -- HEIST3_HACKERS_CHRISTIAN_CUT
        28351, -- HEIST3_HACKERS_YOHAN_CUT
        28352, -- HEIST3_HACKERS_AVI_CUT
        28353, -- HEIST3_HACKERS_PAIGE_CUT
    },

    ["MissionCooldowns"] = {
        15499, -- EXEC_BUY_COOLDOWN
        15500, -- EXEC_SELL_COOLDOWN

        19077, -- IMPEXP_STEAL_COOLDOWN
        19153, -- IMPEXP_SELL_COOLDOWN

        19432, -- IMPEXP_SELL_1_CAR_COOLDOWN
        19433, -- IMPEXP_SELL_2_CAR_COOLDOWN
        19434, -- IMPEXP_SELL_3_CAR_COOLDOWN
        19435, -- IMPEXP_SELL_4_CAR_COOLDOWN

        22433, -- SMUG_STEAL_EASY_COOLDOWN_TIMER
        22434, -- SMUG_STEAL_MED_COOLDOWN_TIMER
        22435, -- SMUG_STEAL_HARD_COOLDOWN_TIMER
        22436, -- SMUG_STEAL_ADDITIONAL_CRATE_COOLDOWN_TIME
        22474, -- SMUG_SELL_SELL_COOLDOWN_TIMER

        26794, -- VC_WORK_REQUEST_COOLDOWN
        31038, -- FIXER_SECURITY_CONTRACT_COOLDOWN_TIME
        31118, -- REQUEST_FRANKLIN_PAYPHONE_HIT_COOLDOWN
        31892, -- EXPORT_CARGO_LAUNCH_CD_TIME
        32005, -- SUM2_BUNKER_DUNELOADER_TIMER
        32183, -- BUNKER_SOURCE_RESEARCH_CD_TIME
        32184, -- NIGHTCLUB_SOURCE_GOODS_CD_TIME
        33141, -- JUGALLO_BOSS_WORK_COOLDOWN_TIME
        34219, -- SMUGGLER_OPERATION_COOLDOWN

        24026, -- BB_CLUB_MANAGEMENT_CLUB_MANAGEMENT_MISSION_COOLDOWN
        24067, -- BB_SELL_MISSIONS_MISSION_COOLDOWN
        31880, -- NC_TROUBLEMAKER_MIN_DELAY_IN_MINUTES
        31881, -- NC_TROUBLEMAKER_MAX_DELAY_IN_MINUTES

        24208, -- BB_HACKER_WORK_CLIENT_WORK_GLOBAL_COOLDOWN
        24209, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_BANK_JOB
        24210, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_DATA_HACK
        24211, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_INFILTRATION
        24212, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_JEWEL_STORE_GRAB

        24213, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_GLOBAL_COOLDOWN
        24214, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_SECURITY_VANS
        24215, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_TARGET_PURSUIT

        18571, -- BIKER_CLUB_WORK_COOLDOWN_GLOBAL
        31870, -- BIKER_RESUPPLY_MISSION_COOLDOWN
    },
    ["HeistCooldowns"] = {
        4382,  -- ON_CALL_HEIST_COOLDOWN
        4387,  -- NEXT_TEXT_DELAY_H
        4388,  -- PLAYED_NEXT_TEXT_DELAY_H

        4383,  -- H2_ON_CALL_FINALE_COOLDOWN_2_PLAYER
        4384,  -- H2_ON_CALL_FINALE_COOLDOWN_3_PLAYER
        4385,  -- H2_ON_CALL_FINALE_COOLDOWN_4_PLAYER
        23010, -- H2_IAA_REPLAY_COOLDOWN_TIME
        23011, -- H2_SUB_REPLAY_COOLDOWN_TIME
        23012, -- H2_REPLAY_COOLDOWN_2_PLAYER_IAA
        23013, -- H2_REPLAY_COOLDOWN_2_PLAYER_SUB
        23014, -- H2_REPLAY_COOLDOWN_2_PLAYER_SILO
        23015, -- H2_REPLAY_COOLDOWN_3_PLAYER_IAA
        23016, -- H2_REPLAY_COOLDOWN_3_PLAYER_SUB
        23017, -- H2_REPLAY_COOLDOWN_3_PLAYER_SILO
        23018, -- H2_REPLAY_COOLDOWN_4_PLAYER_IAA
        23019, -- H2_REPLAY_COOLDOWN_4_PLAYER_SUB
        23020, -- H2_REPLAY_COOLDOWN_4_PLAYER_SILO
        23021, -- H2_SILO_REPLAY_COOLDOWN_TIME

        4364,  -- CASINO_HEIST_ON_CALL_COOL_DOWN
        28399, -- H3_HEIST_COOLDOWN_BEFORE_REPLAY

        4365,  -- ISLAND_HEIST_ON_CALL_COOL_DOWN
        29380, -- H4_COOLDOWN_TIME
        29381, -- H4_COOLDOWN_HARD_TIME
        29382, -- H4_SOLO_COOLDOWN

        30357, -- TUNER_ROBBERY_COOLDOWN_TIME
        31036, -- FIXER_STORY_COOLDOWN_POSIX
        33064, -- SALV23_VEH_ROB_COOLDOWN_TIME
        33065, -- SALV23_CFR_COOLDOWN_TIME
    },
    ["RequestCooldowns"] = {
        11708, -- PEGASUS_CRIM_COOL_DOWN
        11942, -- LESTER_VEHICLE_CRIM_COOL_DOWN
        12813, -- GB_CALL_VEHICLE_COOLDOWN
        19018, -- SV_MECHANIC_COOLDOWN
        21286, -- GR_MOBILE_OPERATIONS_CENTRE_COOLDOWN_TIMER
        21289, -- AA_TRAILER_EQ_COOLDOWN_TIMER
        21573, -- ACID_LAB_REQUEST_COOLDOWN
        22371, -- SMUG_REQUEST_PERSONAL_AIRCRAFT_COOLDOWN
        22743, -- H2_AVENGER_INTN_MENU_REQUEST_AVENGER_COOLDOWN
        24068, -- BB_SELL_MISSIONS_DELIVERY_VEHICLE_COOLDOWN_AFTER_SELL_MISSION
        24234, -- BB_TERRORBYTE_DRONE_COOLDOWN_TIME
        24266, -- BB_TERRORBYTE_TERRORBYTE_COOLDOWN_TIMER
        24282, -- BB_SUBMARINE_REQUEST_COOLDOWN_TIMER
        24283, -- BB_SUBMARINE_DINGHY_REQUEST_COOLDOWN_TIMER
        25373, -- BANDITO_COOLDOWN_TIME
        25374, -- TANK_COOLDOWN_TIME
        27932, -- VC_COOLDOWN_REQUEST_CAR_SERVICE
        27933, -- VC_COOLDOWN_REQUEST_LIMO_SERVICE
        27968, -- OPPRESSOR2CD
        30224, -- IH_MOON_POOL_COOLDOWN
        31119, -- REQUEST_COMPANY_SUV_SERVICE_COOLDOWN
        31114, -- IMANI_SOURCE_MOTORCYCLE_COOLDOWN
        32538, -- TONY_LIMO_COOLDOWN_TIME
        32539, -- BUNKER_VEHICLE_COOLDOWN_TIME
        33142, -- JUGALLO_BOSS_VEHICLE_COOLDOWN_TIME

        12815, -- GB_DROP_AMMO_COOLDOWN
        12816, -- GB_DROP_ARMOR_COOLDOWN
        12817, -- GB_DROP_BULLSHARK_COOLDOWN
        12818, -- GB_GHOST_ORG_COOLDOWN
        12819, -- GB_BRIBE_AUTHORITIES_COOLDOWN

        20906, -- BALLISTICARMOURREQUESTCOOLDOWN
        23609, -- H2_STRIKE_TEAM_COOLDOWN_TIMER
        31112, -- FRANKLIN_SUPPLY_STASH_COOLDOWN
        31116, -- IMANI_OUT_OF_SIGHT_COOLDOWN
    },
}

local TunablesF = {
    ["NpcCut"] = {
        22475, -- SMUG_SELL_RONS_CUT
        24074, -- BB_SELL_MISSIONS_TONYS_CUT
        29467, -- IH_DEDUCTION_FENCING_FEE
        29468, -- IH_DEDUCTION_PAVEL_CUT
        30334, -- TUNER_ROBBERY_CONTACT_FEE
    },
    ["BusinessRaidThreshold"] = {
        24160, -- BB_DEFEND_MISSIONS_STOCK_THRESHOLD_FOR_MISSION_LAUNCH_DEFAULT
        24161, -- BB_DEFEND_MISSIONS_STOCK_THRESHOLD_FOR_MISSION_LAUNCH_UPGRADED
    },

    ["HIGH_ROCKSTAR_MISSIONS_MODIFIER"] = 2403,
    ["LOW_ROCKSTAR_MISSIONS_MODIFIER"] = 2407,

    ["XP_MULTIPLIER"] = 1,
}

local g_sMPTunables <const> = 262145

--------------------------------
--  Functions
--------------------------------

Tunables = {}

--- @param tunable_name string
--- @param value int
function Tunables.SetInt(tunable_name, value)
    GLOBAL_SET_INT(g_sMPTunables + TunablesI[tunable_name], value)
end

--- @param tunable_list_name string
--- @param value int
function Tunables.SetIntList(tunable_list_name, value)
    for _, offset in pairs(TunablesI[tunable_list_name]) do
        GLOBAL_SET_INT(g_sMPTunables + offset, value)
    end
end

--- @param tunable_name string
--- @param value float
function Tunables.SetFloat(tunable_name, value)
    GLOBAL_SET_FLOAT(g_sMPTunables + TunablesF[tunable_name], value)
end

--- @param tunable_list_name string
--- @param value float
function Tunables.SetFloatList(tunable_list_name, value)
    for _, offset in pairs(TunablesF[tunable_list_name]) do
        GLOBAL_SET_FLOAT(g_sMPTunables + offset, value)
    end
end

--- @param tunable_list_name string
--- @param multiplier float
function Tunables.SetIntListMultiplier(tunable_list_name, multiplier)
    for _, offset in pairs(TunablesI[tunable_list_name]) do
        local default_value = TunableDefaults[offset]
        local new_value = default_value * multiplier
        GLOBAL_SET_INT(g_sMPTunables + offset, new_value)
    end
end

--------------------------------
--  Default Functions
--------------------------------

local TunableDefaults = {}

--- @param tunable_name string
function Tunables.SaveIntDefault(tunable_name)
    local offset = TunablesI[tunable_name]
    TunableDefaults[offset] = GLOBAL_GET_INT(g_sMPTunables + offset)
end

--- @param tunable_name string
function Tunables.RestoreIntDefault(tunable_name)
    local offset = TunablesI[tunable_name]
    GLOBAL_SET_INT(g_sMPTunables + offset, TunableDefaults[offset])
end

--- @param tunable_list_name string
function Tunables.SaveIntDefaults(tunable_list_name)
    for name, offset in pairs(TunablesI[tunable_list_name]) do
        TunableDefaults[offset] = GLOBAL_GET_INT(g_sMPTunables + offset)
    end
end

--- @param tunable_list_name string
function Tunables.RestoreIntDefaults(tunable_list_name)
    for _, offset in pairs(TunablesI[tunable_list_name]) do
        GLOBAL_SET_INT(g_sMPTunables + offset, TunableDefaults[offset])
    end
end

--- @param tunable_name string
function Tunables.SaveFloatDefault(tunable_name)
    local offset = TunablesF[tunable_name]
    TunableDefaults[offset] = GLOBAL_GET_FLOAT(g_sMPTunables + offset)
end

--- @param tunable_name string
function Tunables.RestoreFloatDefault(tunable_name)
    local offset = TunablesF[tunable_name]
    GLOBAL_GET_FLOAT(g_sMPTunables + offset, TunableDefaults[offset])
end

--- @param tunable_list_name string
function Tunables.SaveFloatDefaults(tunable_list_name)
    for name, offset in pairs(TunablesF[tunable_list_name]) do
        TunableDefaults[offset] = GLOBAL_GET_FLOAT(g_sMPTunables + offset)
    end
end

--- @param tunable_list_name string
function Tunables.RestoreFloatDefaults(tunable_list_name)
    for _, offset in pairs(TunablesF[tunable_list_name]) do
        GLOBAL_SET_FLOAT(g_sMPTunables + offset, TunableDefaults[offset])
    end
end

--- @param list table
function Tunables.__SaveIntDefaults_T(list)
    for _, item in pairs(list) do
        if type(item) == "number" then
            TunableDefaults[item] = GLOBAL_GET_INT(g_sMPTunables + item)
        elseif type(item) == "table" then
            Tunables.__SaveIntDefaults_T(item)
        end
    end
end

--- @param list table
function Tunables.__SaveFloatDefaults_T(list)
    for _, item in pairs(list) do
        if type(item) == "number" then
            TunableDefaults[item] = GLOBAL_GET_FLOAT(g_sMPTunables + item)
        elseif type(item) == "table" then
            Tunables.__SaveFloatDefaults_T(item)
        end
    end
end

Tunables.__SaveIntDefaults_T(TunablesI)
Tunables.__SaveFloatDefaults_T(TunablesF)
