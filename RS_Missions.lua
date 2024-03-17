--------------------------------
-- Author: Rostal
--------------------------------

util.require_natives("3095a", "init")

local SCRIPT_VERSION <const> = "2024/3/17"

local SUPPORT_GTAO <const> = 1.68


--#region base functions

----------------------------
-- Local Player Functions
----------------------------

---@param entity Entity
---@param coords v3
---@param heading? float
function TP_ENTITY(entity, coords, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

---@param entity Entity
---@param offsetX? float
---@param offsetY? float
---@param offsetZ? float
function TP_ENTITY_TO_ME(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    TP_ENTITY(entity, coords)
end

--- @param vehicle Vehicle
function TP_VEHICLE_TO_ME(vehicle)
    ENTITY.SET_ENTITY_HEADING(vehicle, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    TP_ENTITY_TO_ME(vehicle)

    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_TEAMS(vehicle, false)
    VEHICLE.SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(vehicle, false)

    ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)

    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(vehicle)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
end

----------------------------
-- Misc Functions
----------------------------


----------------------------
-- Script Functions
----------------------------

--- @param script string
--- @return boolean
function IS_SCRIPT_RUNNING(script)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(script)) > 0
end

--- @param script string
--- @param arg_count integer
--- @return boolean
function START_SCRIPT(script, arg_count)
    if not SCRIPT.DOES_SCRIPT_EXIST(script) then
        return false
    end
    if IS_SCRIPT_RUNNING(script) then
        return true
    end
    SCRIPT.REQUEST_SCRIPT(script)
    while not SCRIPT.HAS_SCRIPT_LOADED(script) do
        util.yield()
    end
    SYSTEM.START_NEW_SCRIPT(script, arg_count or 0)
    SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(script)
    return true
end

----------------------------
-- Global Functions
----------------------------

--- @param global integer
--- @param value integer
function GLOBAL_SET_INT(global, value)
    memory.write_int(memory.script_global(global), value)
end

--- @param global integer
--- @param value float
function GLOBAL_SET_FLOAT(global, value)
    memory.write_float(memory.script_global(global), value)
end

--- @param global integer
--- @param value string
function GLOBAL_SET_STRING(global, value)
    memory.write_string(memory.script_global(global), value)
end

--- @param global integer
--- @param value boolean
function GLOBAL_SET_BOOL(global, value)
    memory.write_int(memory.script_global(global), value and 1 or 0)
end

--- @param global integer
--- @return integer
function GLOBAL_GET_INT(global)
    return memory.read_int(memory.script_global(global))
end

--- @param global integer
--- @return float
function GLOBAL_GET_FLOAT(global)
    return memory.read_float(memory.script_global(global))
end

--- @param global integer
---@return string
function GLOBAL_GET_STRING(global)
    return memory.read_string(memory.script_global(global))
end

--- @param global integer
--- @return boolean
function GLOBAL_GET_BOOL(global)
    return memory.read_int(memory.script_global(global)) == 1
end

--- @param global integer
--- @param bit integer
function GLOBAL_SET_BIT(global, bit)
    local script_global = memory.script_global(global)
    memory.write_int(script_global, SET_BIT(memory.read_int(script_global), bit))
end

--- @param global integer
--- @param bit integer
function GLOBAL_CLEAR_BIT(global, bit)
    local script_global = memory.script_global(global)
    memory.write_int(script_global, CLEAR_BIT(memory.read_int(script_global), bit))
end

--- @param global integer
--- @param bit integer
--- @return boolean
function GLOBAL_BIT_TEST(global, bit)
    return BIT_TEST(GLOBAL_GET_INT(global), bit)
end

--- @param global integer
--- @param ... bits
function GLOBAL_SET_BITS(global, ...)
    local script_global = memory.script_global(global)
    memory.write_int(script_global, SET_BITS(memory.read_int(script_global), ...))
end

---------------------------
-- Local Functions
---------------------------

--- @param script string
--- @param script_local integer
--- @param value integer
function LOCAL_SET_INT(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_int(memory.script_local(script, script_local), value)
    end
end

--- @param script string
--- @param script_local integer
--- @param value float
function LOCAL_SET_FLOAT(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_float(memory.script_local(script, script_local), value)
    end
end

--- @param script string
--- @param script_local integer
---@return integer
function LOCAL_GET_INT(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        local value = memory.read_int(memory.script_local(script, script_local))
        if value ~= nil then
            return value
        end
    end
end

--- @param script string
--- @param script_local integer
---@return float
function LOCAL_GET_FLOAT(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        local value = memory.read_float(memory.script_local(script, script_local))
        if value ~= nil then
            return value
        end
    end
end

--- @param script string
--- @param script_local integer
--- @param bit integer
function LOCAL_SET_BIT(script, script_local, bit)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, SET_BIT(memory.read_int(addr), bit))
    end
end

--- @param script string
--- @param script_local integer
--- @param bit integer
function LOCAL_CLEAR_BIT(script, script_local, bit)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, CLEAR_BIT(memory.read_int(addr), bit))
    end
end

--- @param script string
--- @param script_local integer
--- @param ... bits
function LOCAL_SET_BITS(script, script_local, ...)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, SET_BITS(memory.read_int(addr), ...))
    end
end

--- @param script string
--- @param script_local integer
--- @param ... bits
function LOCAL_CLEAR_BITS(script, script_local, ...)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, CLEAR_BITS(memory.read_int(addr), ...))
    end
end

---------------------------
-- Bit Functions
---------------------------

--- @param bits integer
--- @param place integer
--- @return integer
function SET_BIT(bits, place)
    return (bits | (1 << place))
end

--- @param bits integer
--- @param place integer
--- @return integer
function CLEAR_BIT(bits, place)
    return (bits & ~(1 << place))
end

--- @param bits integer
--- @param place integer
--- @return integer
function BIT_TEST(bits, place)
    return (bits & (1 << place)) ~= 0
end

---@param int integer
---@param ... bits
---@return integer
function SET_BITS(int, ...)
    local bits = { ... }
    for _, bit in ipairs(bits) do
        int = int | (1 << bit)
    end
    return int
end

---@param int integer
---@param ... bits
---@return integer
function CLEAR_BITS(int, ...)
    local bits = { ... }
    for ind, bit in ipairs(bits) do
        int = int & ~(1 << bit)
    end
    return int
end

---------------------------
-- Stat Functions
---------------------------

--- @param stat string
--- @param value integer
function STAT_SET_INT(stat, value)
    STATS.STAT_SET_INT(util.joaat(stat), value, true)
end

--- @param stat string
--- @param value boolean
function STAT_SET_BOOL(stat, value)
    STATS.STAT_SET_BOOL(util.joaat(stat), value, true)
end

--- @param stat int|string
---@return integer
function STAT_GET_INT(stat)
    local ptr = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(stat), ptr, -1)
    return memory.read_int(ptr)
end

--- @param stat int|string
---@return string
function STAT_GET_STRING(stat)
    return STATS.STAT_GET_STRING(util.joaat(stat), -1)
end

--- @param stat string
---@return string
function ADD_MP_INDEX(stat)
    return "MP" .. util.get_char_slot() .. "_" .. stat
end

--#endregion


local get_label_text = util.get_label_text

local Consts <const> = {
    -- MISSION DIFFICULTY
    DIFF_HARD = 2,
}

------------------------
-- Globals
------------------------

local Globals <const> = {
    sMagnateGangBossData = function()
        -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData
        return 1886967 + 1 + players.user() * 609 + 10
    end,
    sContactRequestGBMissionLaunch = 1977909,

    FixerFlowBitset = 1974552,
    FixerFlowContract = 1974552 + 20,
    PayphoneFlowBitset = 2708777 + 1,

    -- MPGlobalsAmbience.sMagnateGangBossData.iMissionVariation
    iMissionVariation = 2738587 + 5234 + 346,

    bBrowserVisible = 76369,

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos]
    sMissionHeaderVars = 794744 + 4 + 1,

}

local g_sMPTunables <const> = 262145

-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
local g_sClientVehicleSetupStruct <const> = 2709112

-- FMMC_GLOBAL_STRUCT
local g_FMMC_STRUCT <const> = 4718592
local FMMC_STRUCT <const> = {
    iNumParticipants = g_FMMC_STRUCT + 3248,
    iMinNumParticipants = g_FMMC_STRUCT + 3249,
    iDifficulity = g_FMMC_STRUCT + 3251,
    iNumberOfTeams = g_FMMC_STRUCT + 3252,
    iMaxNumberOfTeams = g_FMMC_STRUCT + 3253,
    iNumPlayersPerTeam = g_FMMC_STRUCT + 3255 + 1, -- +[0~3]

    iRootContentIDHash = g_FMMC_STRUCT + 126144,
    tl63MissionName = g_FMMC_STRUCT + 126151,
    tl23NextContentID = g_FMMC_STRUCT + 126459 + 1, -- +[0~5]

    iFixedCamera = g_FMMC_STRUCT + 154310,
    iCriticalMinimumForTeam = g_FMMC_STRUCT + 176675 + 1, -- +[0~3]
}

-- TRANSITION_SESSION_NON_RESET_VARS
local g_TransitionSessionNonResetVars <const> = 2685249
local TransitionSessionNonResetVars <const> = {
    bAmIHeistLeader = g_TransitionSessionNonResetVars + 6357,
    bHasQuickRestartedDuringStrandMission = g_TransitionSessionNonResetVars + 6463,
    bAnyPlayerDiedDuringMission = g_TransitionSessionNonResetVars + 6464,
}

-- FMMC_STRAND_MISSION_DATA
local g_sTransitionSessionData <const> = 2684312
local sStrandMissionData <const> = g_sTransitionSessionData + 43
local StrandMissionData <const> = {
    bPassedFirstMission = sStrandMissionData + 55,
    bPassedFirstStrandNoReset = sStrandMissionData + 56,
    bIsThisAStrandMission = sStrandMissionData + 57,
    bLastMission = sStrandMissionData + 58,
}

-- CASINO_HEIST_MISSION_CONFIGURATION_DATA
local g_sCasinoHeistMissionConfigData <const> = 1963911
local CasinoHeistMissionConfigData <const> = {
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


------------------------
-- Locals
------------------------

local Locals <const> = {
    ContrabandBuy = {
        iServerBitSet1 = 601 + 186,
        iLocalBitset5 = 476,
        eEndReason = 601 + 192,
        eModeState = 601 + 191,

        contrabandSize = 601 + 1, -- serverBD.sContraband.sContrabandMissionData.contrabandSize
        eType = 601 + 5,          -- serverBD.sContraband.eType
    },
    ContrabandSell = {
        eSellVar = 543 + 7,
        eEndReason = 543 + 6,
        eModeState = 543 + 5,
    },
    Gunrunning = {
        iGunrunEntityBitSet = 1209 + 4 + 63,
        eEndReason = 1209 + 582,
        eModeState = 1209 + 581,
        eMissionVariation = 1209 + 1,
        iNumEntitiesThisVariation = 1209 + 774,
        iTotalDeliveredCount = 1209 + 816,
    },
    Smuggler = {
        iSmugglerEntityBitSet = 1932 + 6 + 63,
        eEndReason = 1932 + 771,
        eModeState = 1932 + 770,
        eMissionVariation = 1932 + 2,
        iNumEntitiesThisVariation = 1932 + 1035,
        iTotalDeliveredCount = 1932 + 1078,
    },
    AcidLabSource = {
        iGenericBitset = 7542,
        eEndReason = 7614 + 1162,
    },
    AcidLabSell = {
        iGenericBitset = 5388,
        eEndReason = 5450 + 1294,
        iDropOffCount = 117 + 9 + 1,
        iTotalDropoffs = 117 + 9,
    },
    NightclubSell = {
        eEndReason = 2310 + 25,
        eModeState = 2310 + 24,
        sMissionEntity = 2310 + 31,
        iTotalDeliveredCount = 2310 + 201,
        iTotalDeliveriesToMake = 2310 + 202,
    },
    ClubSource = {
        eGoodsType = 3509 + 720 + 3,
        iLocalParticipantIndexAsInt = 3427,
        iGoodsToTransfer = function(iLocalParticipantIndexAsInt)
            return 4267 + 1 + iLocalParticipantIndexAsInt * 125 + 73
        end,
        iGenericBitset = 3441,
        eEndReason = 3509 + 674,
    },

    SecurityContract = {
        iGenericBitset = 7022,
        eEndReason = 7095 + 1278,
    },
    PayphoneHit = {
        iMissionServerBitSet = 5639 + 740,
        iGenericBitset = 5583,
        eEndReason = 5639 + 683,
    },
    ClientJobs = {
        BankJob = {
            iMissionEntityBitSet = 1225 + 7 + 1 + 0 * 4 + 1 + 1 + 0, -- iMissionEntity = 0
            eModeState = 1225 + 5,
            eEndReason = 1225 + 6,
        },
        DataHack = {
            eEndReason = 1925 + 7,
        },
    },
    DrugLabWork = {
        iGenericBitset = 7844,
        eEndReason = 7845 + 1253,
    },
    StashHouse = {
        iGenericBitset = 3433,
        eEndReason = 3484 + 475,
    },
    AutoShopDelivery = {
        iMissionEntityBitSet = 1543 + 2 + 5,
        iGenericBitset = 1492,
        eEndReason = 1543 + 83,
    },

    IslandHeist = {
        iGenericBitset = 13176,
        eEndReason = 13262 + 1339,
    },
    TunerRobbery = {
        iGenericBitset = 7189,
        eEndReason = 7271 + 1194,
    },
    VipContract = {
        iGenericBitset = 8582,
        eEndReason = 8650 + 1157,
    },
    Gangops = {
        iPhotosTaken = 1961 + 1194,
        iNumEntitiesThisVariation = 1961 + 1040,
        iMissionEntityBitSet = 1961 + 6 + 63,
        eEndReason = 1961 + 782,
        eModeState = 1961 + 781,
    },

    MissionController = {
        -- MC_serverBD
        iNextMission = 19728 + 1062,
        iTeamScore = 19728 + 1232 + 1, -- +[0~3]
        iServerBitSet = 19728 + 1,
        iServerBitSet1 = 19728 + 2,

        iCashGrabTotalTake = 19728 + 2686,
        iTeamKills = 19728 + 1725 + 1,
        iTeamHeadshots = 19728 + 1740 + 1,

        iLocalBoolCheck11 = 15149,
    },
    MissionController2020 = {
        -- MC_serverBD
        iNextMission = 48513 + 1578,
        iTeamScore = 48513 + 1765 + 1, -- +[0~3]
        iServerBitSet = 48513 + 1,
        iServerBitSet1 = 48513 + 2,

        iLocalBoolCheck11 = 47286,
    },

    ShopController = {
        iLocalBS = 308,
        iAutoShopRandomTime = 309,
    },
}

-- MISSION_TO_LAUNCH_DETAILS --- `fmmc_launcher.c`
local sLaunchMissionDetails <const> = 19331
local LaunchMissionDetails <const> = {
    iMinPlayers = sLaunchMissionDetails + 15,
    iMissionVariation = sLaunchMissionDetails + 34,
}


------------------------
-- Labels
------------------------

local Labels <const>             = {
    LaunchMission = get_label_text("HEIST_IB_LAUNCH"),
    EliteChallenge = get_label_text("CH_END_9ST"),

    None = get_label_text("NONE"),
    Default = get_label_text("DEFAULT_LABEL"),
    Yes = get_label_text("HUD_YES"),
    No = get_label_text("HUD_NO"),
    RANDOM = get_label_text("EF_RANDOM"),
    Sell = get_label_text("HC_SELL"),
    Source = get_label_text("HC_STEAL"),
    Buy = get_label_text("ITEM_BUY"),
    Computer = get_label_text("MP_CLUB_HUB_PC"),

    PREP = get_label_text("H4P_PREP_TAB"),
    FINALE = get_label_text("H4P_FINALE_TAB"),

    Terrorbyte = get_label_text("TERBYTE"),
    Bunker = get_label_text("CELL_BUNKER"),
    Hangar = get_label_text("CELL_HANGAR"),

    O_W_F_INS_FIN = "仅在直接完成任务生效",
    E_B_S_M = "确保在任务开启前启用",
    SelectMission = "选择任务",
}

Labels.LaunchMissionByTerrorbyte = string.format("%s (%s%s)", Labels.LaunchMission, Labels.Terrorbyte, Labels.Computer)
Labels.LaunchMissionByBunker     = string.format("%s (%s%s)", Labels.LaunchMission, Labels.Bunker, Labels.Computer)
Labels.LaunchMissionByHangar     = string.format("%s (%s%s)", Labels.LaunchMission, Labels.Hangar, Labels.Computer)


------------------------
-- Tables
------------------------

local Tables <const> = {
    -- Business Mission
    ContrabandBuy = {
        { -1, Labels.RANDOM,              {}, "" },
        { 0,  "Vehicle Collection",       {}, "" },
        { 1,  "Moved Collection",         {}, "" },
        { 2,  "Cargo Drop",               {}, "" },
        { 3,  "Moving Vehicle",           {}, "" },
        { 4,  "Break Up Deal",            {}, "" },
        { 5,  "Ambushed",                 {}, "" },
        { 6,  "Steal Riot Van",           {}, "" },
        { 7,  "Gang Hideout",             {}, "" },
        { 8,  "Heli Takedown",            {}, "" },
        { 9,  "Valkyrie Takedown",        {}, "" },
        { 10, "Crash Site",               {}, "" },
        { 11, "Thief",                    {}, "" },
        { 12, "Trapped",                  {}, "" },
        { 13, "Aftermath",                {}, "" },
        { 14, "Trackify",                 {}, "" },
        { 15, "Assassination",            {}, "" },
        { 16, "Boat Attack",              {}, "" },
        { 17, "Multiple Moving Vehicles", {}, "" },
    },
    ContrabandSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "Default",        {}, "Single drop-off. Simple collect and deliver." },
        { 1,  "Multiple",       {}, "5 drop-offs across city. Paid per location (20%)." },
        { 2,  "Sting",          {}, "5 drop-offs across city. Paid per location (20%). One location will randomly trigger a 3 star Wanted Rating when the contraband is dropped off." },
        { 3,  "Land Damage",    {}, "Buyer wants the vehicle in mint condistion.$10,000 bonus appears on screen but every small knocks damages the contraband and lowers its value slightly (player must drive carefully)." },
        { 4,  "Land Trackify",  {}, "Single Drop Off. Player receives text from PA saying buyer is overly cautious. Use trackify to find the drop off location." },
        { 5,  "Land Attack",    {}, "" },
        { 6,  "Land Defend",    {}, "Contraband vehicle gets attacked after vehicle is dropped off.	" },
        { 7,  "Air Low",        {}, "Drive to LSIA to collect a plane then make 5 drops across the map. Fly low to avoid detection from the cops. If you go to high you gain 3 stars and must lost the cops to continue." },
        { 8,  "Air Drop",       {}, "Drive to LSIA to collect a plane then make 5 drops across the map." },
        { 9,  "Air Clear Area", {}, "Drive to LSIA to collect a plane then take plane to the country side drop off, kill enemies at drop off." },
        { 10, "Air Restricted", {}, "Drive to LSIA to collect a plane, make the four drop off, last is in a restricted area, lose the cops to complete the mission." },
        { 11, "Air Attack",     {}, "Drive to LSIA to collect a plane then make 5 drops across the map, get attacked by AI choppers." },
        { 12, "Sea Attack",     {}, "Go to the docks and collect a speeder to meet a contact out at sea. Attacked on route by AI gang peds in boats and helicopter." },
        { 13, "Sea Defend",     {}, "Go to the docks and kill enemies that are surrounding your Speeder before you get in it to meet a contact out at sea." },
    },

    SmugglerBuy = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "Beacon Grab",    {}, "" },
        { 1,  "Black Box",      {}, "" },
        { 2,  "Bomb Base",      {}, "" },
        { 3,  "Bombing Run",    {}, "" },
        { 4,  "Cargo Plane",    {}, "" },
        { 5,  "Bomb Roof",      {}, "" },
        { 6,  "Crate Chase",    {}, "" },
        { 7,  "Dogfight",       {}, "" },
        { 8,  "Escort",         {}, "" },
        { 9,  "Infiltration",   {}, "" },
        { 10, "Roof Attack",    {}, "" },
        { 11, "Splash Landing", {}, "" },
        { 12, "Steal Aircraft", {}, "" },
        { 13, "Stunt Pilot",    {}, "" },
        { 14, "Thermal Scope",  {}, "" },
    },
    SmugglerSell = {
        { -1, Labels.RANDOM,        {}, "" },
        { 15, "Agile Delivery",     {}, "" },
        { 16, "Air Delivery",       {}, "" },
        { 17, "Air Police",         {}, "" },
        { 18, "Air Transfer",       {}, "" },
        { 19, "Bombardment",        {}, "" },
        { 20, "Contested",          {}, "" },
        { 21, "Flying Fortress",    {}, "" },
        { 22, "Fly Low",            {}, "" },
        { 23, "Heavy Lifting",      {}, "" },
        { 24, "Precision Delivery", {}, "" },
        { 25, "Under The Radar",    {}, "" },
    },

    GunrunResupply = {
        { -1, Labels.RANDOM,     {}, "" },
        { 1,  "Altruists",       {}, "" },
        { 2,  "Destroy Trucks",  {}, "" },
        { 3,  "Diversion",       {}, "" },
        { 4,  "Flashlight",      {}, "" },
        { 5,  "Fly Swatter",     {}, "" },
        { 6,  "Rival Operation", {}, "" },
        { 7,  "Steal Apc",       {}, "" },
        { 8,  "Steal Miniguns",  {}, "" },
        { 9,  "Steal Railguns",  {}, "" },
        { 10, "Steal Rhino",     {}, "" },
        { 11, "Steal Technical", {}, "" },
        { 12, "Steal Van",       {}, "" },
        { 13, "Yacht Search",    {}, "" },
    },
    GunrunSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 14, "Ambushed",          {}, "" },
        { 15, "Follow The Leader", {}, "" },
        { 16, "Hill Climb",        {}, "" },
        { 17, "Move Weapons",      {}, "" },
        { 18, "Phantom",           {}, "" },
        { 19, "Rough Terrain",     {}, "" },
    },

    AcidLabSource = {
        { -1, Labels.RANDOM,        {}, "" },
        { 0,  "Chemical Spill",     {}, "" },
        { 1,  "Volatile Chemicals", {}, "" },
        { 2,  "Stealing Grain",     {}, "" },
        { 3,  "Missing Air Drop",   {}, "" },
        { 4,  "Deludomal Vans",     {}, "" },
    },
    AcidLabSell = {
        { -1, Labels.RANDOM,    {}, "" },
        { 0,  "Paperboy",       {}, "" },
        { 1,  "Police Sting",   {}, "" },
        { 2,  "Stash Delivery", {}, "" },
    },

    NightclubSell = {
        { -1, Labels.RANDOM,       {}, "" },
        { 6,  "Single Drop",       {}, "" },
        { 7,  "Multi Drop",        {}, "" },
        { 8,  "Hack Drop",         {}, "" },
        { 9,  "Roadblock",         {}, "" },
        { 10, "Protect Buyer",     {}, "" },
        { 11, "Undercover Cops",   {}, "" },
        { 12, "Offshore Transfer", {}, "" },
        { 13, "Not a Scratch",     {}, "" },
        { 14, "Follow Heli",       {}, "" },
        { 15, "Find Buyer",        {}, "" },
    },

    -- Freemode Mission
    SecurityContract = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FXR_STSTART_RP") }, -- FSV_RECOVERY_PACKAGE
        { 1,  get_label_text("FXR_STSTART_RV") }, -- FSV_RECOVERY_VEHICLE
        { 2,  get_label_text("FXR_STSTART_AS") }, -- FSV_RECOVERY_ASSAULT
        { 3,  get_label_text("FXR_STSTART_RE") }, -- FSV_RECOVERY_RESCUE
        { 4,  get_label_text("FXR_STSTART_PR") }, -- FSV_RECOVERY_PROTECT
        { 5,  get_label_text("FXR_STSTART_TD") }, -- FSV_RECOVERY_TAIL
    },
    PayphoneHit = {
        { -1, Labels.RANDOM },
        { 0,  get_label_text("FXR_OT_TAR1") }, -- FPV_TAXI
        { 1,  get_label_text("FXR_OT_TAR2") }, -- FPV_GOLF
        { 2,  get_label_text("FXR_OT_TAR3") }, -- FPV_MOTEL
        { 3,  get_label_text("FXR_OT_TAR5") }, -- FPV_HIT_LIST
        { 4,  get_label_text("FXR_OT_TAR7") }, -- FPV_COORD_ATTACK
        { 5,  get_label_text("FXR_OT_TAR4") }, -- FPV_CONSTRUCTION
        { 6,  get_label_text("FXR_OT_TAR6") }, -- FPV_JOYRIDER
        { 7,  get_label_text("FXR_OT_TAR8") }, -- FPV_APPROACH
    },
    ClubSource = {
        { -1, Labels.RANDOM },
        { 0,  "Tugboat" },
        { 1,  "Truck" },
    },
    GoodsType = {
        { -1, Labels.Default },
        { 0,  get_label_text("CLUB_STOCK0"), {}, get_label_text("HAPP_BTYPE_HP0") }, -- BUSINESS_TYPE_CARGO
        { 1,  get_label_text("CLUB_STOCK1"), {}, get_label_text("HAPP_BTYPE_HP1") }, -- BUSINESS_TYPE_WEAPONS
        { 2,  get_label_text("CLUB_STOCK2"), {}, get_label_text("HAPP_BTYPE_HP2") }, -- BUSINESS_TYPE_COKE
        { 3,  get_label_text("CLUB_STOCK3"), {}, get_label_text("HAPP_BTYPE_HP3") }, -- BUSINESS_TYPE_METH
        { 4,  get_label_text("CLUB_STOCK4"), {}, get_label_text("HAPP_BTYPE_HP4") }, -- BUSINESS_TYPE_WEED
        { 5,  get_label_text("CLUB_STOCK5"), {}, get_label_text("HAPP_BTYPE_HP5") }, -- BUSINESS_TYPE_FORGED_DOCS
        { 6,  get_label_text("CLUB_STOCK6"), {}, get_label_text("HAPP_BTYPE_HP6") }, -- BUSINESS_TYPE_COUNTERFEIT_CASH
    },
    DrugLabWork = {
        { -1, Labels.RANDOM,  {}, "" },
        { 0,  "Crop Dusting", {}, "" },
        { 1,  "Weed Farm",    {}, "" },
        { 2,  "Vehicle Bomb", {}, "" },
        { 3,  "Supply Line",  {}, "" },
        { 4,  "Drug Lord",    {}, "" },
    },
    CasinoWork = {
        { -1, Labels.RANDOM,                {}, "" },
        { 0,  get_label_text("GBC_ST_BP"),  {}, "" }, -- CSV_BAD_PRESS
        { 1,  get_label_text("GBC_ST_BD"),  {}, "" }, -- CSV_BODY_DISPOSAL
        { 2,  get_label_text("GBC_ST_CC"),  {}, "" }, -- CSV_COUNTERFEIT_CHIPS
        { 3,  get_label_text("GBC_ST_DC"),  {}, "" }, -- CSV_DEFEND_CASINO
        { 4,  get_label_text("GBC_ST_ED"),  {}, "" }, -- CSV_ESCORT_DUTY
        { 5,  get_label_text("GBC_ST_HE"),  {}, "" }, -- CSV_HEISTERS
        { 6,  get_label_text("GBC_ST_HR"),  {}, "" }, -- CSV_HIGH_ROLLER
        { 7,  get_label_text("GBC_ST_HRT"), {}, "" }, -- CSV_HIGH_ROLLER_TOUR
        { 8,  get_label_text("GBC_ST_IJ"),  {}, "" }, -- CSV_INTIMIDATE_JUDGE
        { 9,  get_label_text("GBC_ST_MD"),  {}, "" }, -- CSV_MISSING_DELIVERY
        { 10, get_label_text("GBC_ST_PO"),  {}, "" }, -- CSV_PASSED_OUT
        { 11, get_label_text("GBC_ST_RLC"), {}, "" }, -- CSV_RECOVER_LUXURY_CAR
        { 12, get_label_text("GBC_ST_SM"),  {}, "" }, -- CSV_SLOT_MACHINES
        { 13, get_label_text("GBC_ST_SP"),  {}, "" }, -- CSV_STAFF_PROBLEMS
        { 14, get_label_text("GBC_ST_TC"),  {}, "" }, -- CSV_TRACKING_CHIPS
        { 15, get_label_text("GBC_ST_UTI"), {}, "" }, -- CSV_UNDER_THE_INFLUENCE
    },

    -- Freemode Preps
    TunerRobbery = {
        { -1, Labels.RANDOM,                    {}, "", "" },
        { 0,  get_label_text("TR_STSTART_STP"), {}, "", get_label_text("TR_STSTART_T2") }, -- TRV_SETUP
        { 1,  get_label_text("TR_STSTART_EP"),  {}, "", get_label_text("TUNPLAN_ROB0") },  -- TRV_ELEVATOR_PASS
        { 2,  get_label_text("TR_STSTART_VK"),  {}, "", get_label_text("TUNPLAN_ROB0") },  -- TRV_VAULT_KEY_CODES
        { 3,  get_label_text("TR_STSTART_ST"),  {}, "", get_label_text("TUNPLAN_ROB1") },  -- TRV_SCOPE_TRANSPORTER
        { 4,  get_label_text("TR_STSTART_CV"),  {}, "", get_label_text("TUNPLAN_ROB1") },  -- TRV_COMPUTER_VIRUS
        { 5,  get_label_text("TR_STSTART_TC"),  {}, "", get_label_text("TUNPLAN_ROB2") },  -- TRV_THERMAL_CHARGES
        { 6,  get_label_text("TR_STSTART_SJ"),  {}, "", get_label_text("TUNPLAN_ROB2") },  -- TRV_SIGNAL_JAMMERS
        { 7,  get_label_text("TR_STSTART_CM"),  {}, "", get_label_text("TUNPLAN_ROB3") },  -- TRV_CONTAINER_MANIFEST
        { 8,  get_label_text("TR_STSTART_TS"),  {}, "", get_label_text("TUNPLAN_ROB3") },  -- TRV_TRAIN_SCHEDULE
        { 9,  get_label_text("TR_STSTART_IM"),  {}, "", get_label_text("TUNPLAN_ROB4") },  -- TRV_INSIDE_MAN
        { 10, get_label_text("TR_STSTART_SR"),  {}, "", get_label_text("TUNPLAN_ROB4") },  -- TRV_STUNT_RAMP
        { 11, get_label_text("TR_STSTART_IA"),  {}, "", get_label_text("TUNPLAN_ROB5") },  -- TRV_IAA_PASS
        { 12, get_label_text("TR_STSTART_SS"),  {}, "", get_label_text("TUNPLAN_ROB5") },  -- TRV_SEWER_SCHEMATICS
        { 13, get_label_text("TR_STSTART_ML"),  {}, "", get_label_text("TUNPLAN_ROB6") },  -- TRV_METH_LAB_LOCATIONS
        { 14, get_label_text("TR_STSTART_MT"),  {}, "", get_label_text("TUNPLAN_ROB6") },  -- TRV_METH_TANKER
        { 15, get_label_text("TR_STSTART_LB"),  {}, "", get_label_text("TUNPLAN_ROB7") },  -- TRV_LOCATE_BUNKER
        { 16, get_label_text("TR_STSTART_WD"),  {}, "", get_label_text("TUNPLAN_ROB7") },  -- TRV_WAREHOUSE_DEFENCES
    },
    FixerVIP = {
        { -1, Labels.RANDOM,                        {}, "" },
        { 0,  get_label_text("FXR_BM_VC_T_S"),      {}, "" },                              -- FVV_SETUP
        { 1,  get_label_text("FIX_APP_DATA_L1_T1"), {}, get_label_text("FIX_APP_DL1_T") }, -- FVV_NIGHTCLUB
        { 2,  get_label_text("FIX_APP_DATA_L1_T2"), {}, get_label_text("FIX_APP_DL1_T") }, -- FVV_YACHT
        { 3,  get_label_text("FIX_APP_DATA_L2_T1"), {}, get_label_text("FIX_APP_DL2_T") }, -- FVV_LIMO
        { 4,  get_label_text("FIX_APP_DATA_L2_T2"), {}, get_label_text("FIX_APP_DL2_T") }, -- FVV_WAY_IN
        { 5,  get_label_text("FIX_APP_DATA_L3_T1"), {}, get_label_text("FIX_APP_DL3_T") }, -- FVV_FAMILIES
        { 6,  get_label_text("FIX_APP_DATA_L3_T2"), {}, get_label_text("FIX_APP_DL3_T") }, -- FVV_BALLAS
    },

    -- Auto Shop Robbery
    TunerRobberyFinal = {
        { 2064133602,  get_label_text("TUNPLAN_ROB0") }, -- TR_UNION_DEPOSITORY
        { 1364299584,  get_label_text("TUNPLAN_ROB1") }, -- TR_MILITARY_CONVOY
        { 14434931,    get_label_text("TUNPLAN_ROB2") }, -- TR_FLEECA_BANK
        { 808119513,   get_label_text("TUNPLAN_ROB3") }, -- TR_FREIGHT_TRAIN
        { -554734818,  get_label_text("TUNPLAN_ROB4") }, -- TR_BOLINGBROKE
        { -1750247281, get_label_text("TUNPLAN_ROB5") }, -- TR_IAA_RAID
        { 1767266297,  get_label_text("TUNPLAN_ROB6") }, -- TR_METH_JOB
        { -1931849607, get_label_text("TUNPLAN_ROB7") }, -- TR_BUNKER
    },
    -- Apartment Heist
    HeistAwards = {
        { 1, get_label_text("AWT_777") }, -- All In Order
        { 2, get_label_text("AWT_778") }, -- Loyalty
        { 3, get_label_text("AWT_779") }, -- Criminal Mastermind
        { 4, get_label_text("AWT_785") }, -- Another Perspective
        { 5, get_label_text("AWT_786") }  -- Supporting Role
    },
    HeistAwardsStats = {
        -- ProgressBitset, AwardBool
        [1] = { "MPPLY_HEISTFLOWORDERPROGRESS", "MPPLY_AWD_HST_ORDER" },
        [2] = { "MPPLY_HEISTTEAMPROGRESSBITSET", "MPPLY_AWD_HST_SAME_TEAM" },
        [3] = { "MPPLY_HEISTNODEATHPROGREITSET", "MPPLY_AWD_HST_ULT_CHAL" },
        [4] = { "MPPLY_HEIST_1STPERSON_PROG", "MPPLY_AWD_COMPLET_HEIST_1STPER" },
        [5] = { "MPPLY_HEISTMEMBERPROGRESSBITSET", "MPPLY_AWD_COMPLET_HEIST_MEM" }
    },
    -- Doomsday Heist
    GangopsAwards = {
        { 1, get_label_text("AWD_GANGOPA") },  -- All In Order II
        { 2, get_label_text("AWD_GANGOPL2") }, -- Loyalty II
        { 3, get_label_text("AWD_GANGOPL3") }, -- Loyalty III
        { 4, get_label_text("AWD_GANGOPL4") }, -- Loyalty IV
        { 5, get_label_text("AWD_GANGOPM2") }, -- Criminal Mastermind II
        { 6, get_label_text("AWD_GANGOPM3") }, -- Criminal Mastermind III
        { 7, get_label_text("AWD_GANGOPM4") }, -- Criminal Mastermind IV
        { 8, get_label_text("AWD_GANGOPSR") }  -- Supporting Role II
    },
    GangopsAwardsStats = {
        -- ProgressBitset, AwardBool
        [1] = { "MPPLY_GANGOPS_ALLINORDER", "MPPLY_AWD_GANGOPS_ALLINORDER" },
        [2] = { "MPPLY_GANGOPS_LOYALTY2", "MPPLY_AWD_GANGOPS_LOYALTY2" },
        [3] = { "MPPLY_GANGOPS_LOYALTY3", "MPPLY_AWD_GANGOPS_LOYALTY3" },
        [4] = { "MPPLY_GANGOPS_LOYALTY", "MPPLY_AWD_GANGOPS_LOYALTY" },
        [5] = { "MPPLY_GANGOPS_CRIMMASMD2", "MPPLY_AWD_GANGOPS_CRIMMASMD2" },
        [6] = { "MPPLY_GANGOPS_CRIMMASMD3", "MPPLY_AWD_GANGOPS_CRIMMASMD3" },
        [7] = { "MPPLY_GANGOPS_CRIMMASMD", "MPPLY_AWD_GANGOPS_CRIMMASMD" },
        [8] = { "MPPLY_GANGOPS_SUPPORT", "MPPLY_AWD_GANGOPS_SUPPORT" }
    },
    -- Casino Heist
    CasinoHeistApproach = {
        { 1, get_label_text("CHB_APPROACH_1") }, -- Silent & Sneaky
        { 2, get_label_text("CHB_APPROACH_2") }, -- The Big Con
        { 3, get_label_text("CHB_APPROACH_3") }  -- Aggressive
    },
    CasinoHeistTarget = {
        { 0, get_label_text("CSH_TCK_TRGCS") }, -- Cash
        { 1, get_label_text("CSH_TCK_TRGGD") }, -- Gold
        { 2, get_label_text("CSH_TCK_TRGAR") }, -- Art
        { 3, get_label_text("CSH_TCK_TRGDI") }  -- Diamonds
    },
    CasinoHeistFinal = {
        [1] = -954000712, -- ciCASINO_HEIST_MISSION_STEALTH_STAGE_5A
        [2] = 1069383608, -- ciCASINO_HEIST_MISSION_SUBTERFUGE_STAGE_5A
        [3] = -1313224488 -- ciCASINO_HEIST_MISSION_DIRECT_STAGE_5A
    },



    EliteChallenge = {
        { 0, Labels.Default },
        { 1, "完成" },
        { 2, "未完成" }
    },
}


------------------------
-- Tunables
------------------------

local TunablesI <const> = {
    ["GR_RESUPPLY_PACKAGE_VALUE"] = 21733,
    ["GR_RESUPPLY_VEHICLE_VALUE"] = 21734,
    ["ACID_LAB_RESUPPLY_CRATE_VALUE"] = 33039,


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


    ["COOLDOWNS"] = {
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

        24659, -- BB_CLUB_MANAGEMENT_CLUB_MANAGEMENT_MISSION_COOLDOWN
        24701, -- BB_SELL_MISSIONS_MISSION_COOLDOWN
        32024, -- FIXER_SECURITY_CONTRACT_COOLDOWN_TIME
        32105, -- REQUEST_FRANKLIN_PAYPHONE_HIT_COOLDOWN
        33198, -- BUNKER_SOURCE_RESEARCH_CD_TIME
        33199, -- NIGHTCLUB_SOURCE_GOODS_CD_TIME
        27510, -- VC_WORK_REQUEST_COOLDOWN
        34195, -- JUGALLO_BOSS_WORK_COOLDOWN_TIME

        24848, -- BB_HACKER_WORK_CLIENT_WORK_GLOBAL_COOLDOWN
        24849, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_BANK_JOB
        24850, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_DATA_HACK
        24851, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_INFILTRATION
        24852, -- BB_HACKER_WORK_CLIENT_WORK_COOLDOWN_JEWEL_STORE_GRAB
        24853, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_GLOBAL_COOLDOWN
        24854, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_SECURITY_VANS
        24855, -- BB_HACKER_WORK_HACKER_CHALLENGE_COOLDOWN_TARGET_PURSUIT
    },
}

local TunablesF <const> = {
    ["NpcCut"] = {
        23003, -- SMUG_SELL_RONS_CUT
        24708, -- BB_SELL_MISSIONS_TONYS_CUT
        30269, -- IH_DEDUCTION_PAVEL_CUT
        31319, -- TUNER_ROBBERY_CONTACT_FEE
    },
}


------------------------
-- Tunable Functions
------------------------

local Tunables = {}
local TunableDefaults = {}

--#region

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

-- Tunable Default Functions

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
function Tunables.SaveIntDefaults_T(list)
    for _, item in pairs(list) do
        if type(item) == "number" then
            TunableDefaults[item] = GLOBAL_GET_INT(g_sMPTunables + item)
        elseif type(item) == "table" then
            Tunables.SaveIntDefaults_T(item)
        end
    end
end

--- @param list table
function Tunables.SaveFloatDefaults_T(list)
    for _, item in pairs(list) do
        if type(item) == "number" then
            TunableDefaults[item] = GLOBAL_GET_FLOAT(g_sMPTunables + item)
        elseif type(item) == "table" then
            Tunables.SaveFloatDefaults_T(item)
        end
    end
end

Tunables.SaveIntDefaults_T(TunablesI)
Tunables.SaveFloatDefaults_T(TunablesF)

--#endregion



------------------------
-- Functions
------------------------

local function LAUNCH_MISSION(Data)
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
    if iMissionType == 274 then
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

local function INSTANT_FINISH_CASINO_HEIST_PREPS()
    local script = "gb_casino_heist"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local serverBD = 4280

    local eMissionVariation = LOCAL_GET_INT(script, 4280 + 1457)
    if eMissionVariation == 4 then
        LOCAL_SET_INT(script, 4280 + 1700, 10)
    elseif eMissionVariation == 2 then
        LOCAL_SET_BIT(script, 4280 + 1604 + 1 + 3, 22)
    elseif eMissionVariation == 1 then
        LOCAL_SET_INT(script, 4280 + 1461, 17)
    elseif eMissionVariation == 32 or eMissionVariation == 31 or eMissionVariation == 30 then
        LOCAL_SET_INT(script, 4280 + 1763, 30)
    elseif eMissionVariation == 28 or eMissionVariation == 29 then
        LOCAL_SET_BITS(script, 4280 + 1777, 0, 1)
    elseif eMissionVariation == 52 then
        LOCAL_SET_BIT(script, 4280 + 1604 + 1 + 1, 30)
    elseif eMissionVariation == 37 then
        local iOrganisationSizeOnLaunch = LOCAL_GET_INT(script, 4280 + 1648)
        if iOrganisationSizeOnLaunch == 1 then
            LOCAL_SET_BITS(script, 4280 + 1777, 1, 2, 3)
        else
            LOCAL_SET_BITS(script, 4280 + 1777, 1, 2, 3, 4, 5)
        end
    end
    LOCAL_SET_INT(script, 4280 + 1461, 3) -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
end


--- Instant Finish Mission (fm_content_xxx)
--- @param script string
--- @param iGenericBitset integer
--- @param eEndReason integer
local function INSTANT_FINISH_FM_CONTENT_MISSION(script, iGenericBitset, eEndReason)
    LOCAL_SET_BIT(script, iGenericBitset + 1 + 0, 11) -- SET_GENERIC_BIT(eGENERICBITSET_I_WON)
    LOCAL_SET_INT(script, eEndReason, 3)              -- SET_END_REASON(eENDREASON_MISSION_PASSED)
end


--- Instant Finish `fm_mission_controller`
---
--- Check if the script is running before calling this!
local function INSTANT_FINISH_FM_MISSION_CONTROLLER()
    local script = "fm_mission_controller"

    -- String Null, get out
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
        if tl23NextContentID ~= "" then
            GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
        end
    end
    -- More than max (FMMC_MAX_STRAND_MISSIONS), get out
    LOCAL_SET_INT(script, Locals.MissionController.iNextMission, 6)

    if GLOBAL_GET_BOOL(StrandMissionData.bIsThisAStrandMission) then
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstMission, true)
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstStrandNoReset, true)
        GLOBAL_SET_BOOL(StrandMissionData.bLastMission, true)
    end

    -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
    LOCAL_SET_BIT(script, Locals.MissionController.iLocalBoolCheck11, 7)

    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT(script, Locals.MissionController.iTeamScore + i, 999999)
    end

    -- SSBOOL_TEAMx_FINISHED, SBBOOL_MISSION_OVER
    LOCAL_SET_BITS(script, Locals.MissionController.iServerBitSet, 9, 10, 11, 12, 16)
end

--- Instant Finish `fm_mission_controller_2020`
---
--- Check if the script is running before calling this!
local function INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
    local script = "fm_mission_controller_2020"

    -- String Null, get out
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
        if tl23NextContentID ~= "" then
            GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
        end
    end
    -- More than max (FMMC_MAX_STRAND_MISSIONS), get out
    LOCAL_SET_INT(script, Locals.MissionController2020.iNextMission, 6)

    if GLOBAL_GET_BOOL(StrandMissionData.bIsThisAStrandMission) then
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstMission, true)
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstStrandNoReset, true)
        GLOBAL_SET_BOOL(StrandMissionData.bLastMission, true)
    end

    -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
    LOCAL_SET_BIT(script, Locals.MissionController2020.iLocalBoolCheck11, 7)

    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT("fm_mission_controller_2020", Locals.MissionController2020.iTeamScore + i, 999999)
    end

    -- SSBOOL_TEAMx_FINISHED, SBBOOL_MISSION_OVER
    LOCAL_SET_BITS("fm_mission_controller_2020", Locals.MissionController2020.iServerBitSet, 9, 10, 11, 12, 16)
end


--- Start Mission
--- @param iMission integer
--- @param iVariation integer?
--- @param iSubVariation integer?
local function GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iVariation, iSubVariation)
    ------------------------------------------------------
    ---- GB_SET_PLAYER_LAUNCHING_GANG_BOSS_MISSION
    ------------------------------------------------------

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData.iMissionToLaunch = iMission
    GLOBAL_SET_INT(Globals.sMagnateGangBossData() + 32, iMission)

    --------------------------------------------------
    ---- BROADCAST_GB_BOSS_WORK_REQUEST_SERVER
    --------------------------------------------------

    -- Type = SCRIPT_EVENT_GB_BOSS_WORK_REQUEST_SERVER
    -- FromPlayerIndex
    -- iMission
    -- iRequestedVariation
    -- iRequestedVariation2
    -- iRequestedVariation3
    -- iWarehouse

    util.trigger_script_event(1 << players.user(), {
        1613825825, players.user(), iMission, iVariation or -1, iSubVariation or -1, -1, -1, -1
    })
end

--- Request Mission
--- @param iMission integer
--- @param iVariation integer?
--- @param iSubVariation integer?
local function SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iVariation, iSubVariation)
    GLOBAL_SET_INT(Globals.sContactRequestGBMissionLaunch, iMission)                       -- iType
    GLOBAL_SET_INT(Globals.sContactRequestGBMissionLaunch + 1, iVariation or -1)           -- iVariation
    GLOBAL_SET_INT(Globals.sContactRequestGBMissionLaunch + 2, iSubVariation or -1)        -- iSubvariation
    GLOBAL_SET_INT(Globals.sContactRequestGBMissionLaunch + 3, 0)                          -- iDelay
    GLOBAL_SET_INT(Globals.sContactRequestGBMissionLaunch + 5, NETWORK.GET_NETWORK_TIME()) -- MissionLaunchTime

    -- GLOBAL_SET_BIT(Globals.sContactRequestGBMissionLaunch + 4, 0) -- iBitSet = ciCONTACT_REQUEST_GB_MISSION_LAUNCH_BS_ALLOW_ALT_TYPES
end

--- @param iVariation integer
--- @param iSubvariation integer?
--- @param iLocation integer?
local function GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(iVariation, iSubvariation, iLocation)
    GLOBAL_SET_INT(Globals.iMissionVariation, iVariation)

    if iSubvariation ~= nil then
        GLOBAL_SET_INT(Globals.iMissionVariation + 1, iSubvariation)
    end
    if iLocation ~= nil then
        GLOBAL_SET_INT(Globals.iMissionVariation + 2, iLocation)
    end
end


local APP_INTERNET_STACK_SIZE <const> = 4592
local OPEN_COMPUTER = {
    TERRORBYTE = function()
        GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appHackerTruck", APP_INTERNET_STACK_SIZE)
    end,
    HANGAR = function()
        GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appsmuggler", APP_INTERNET_STACK_SIZE)
    end,
    BUNKER = function()
        GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appbunkerbusiness", APP_INTERNET_STACK_SIZE)
    end,
    NIGHTCLUB = function()
        GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appbusinesshub", APP_INTERNET_STACK_SIZE)
    end,
}

local function draw_text(text)
    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end


local rs = {}

--- Your `on_change` function will be called with value, prev_value and click_type.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function rs.menu_slider(parent, menu_name, command_names, help_text,
                        min_value, max_value, default_value, step_size, on_change)
    local command = menu.slider(parent, menu_name, command_names, help_text,
        min_value, max_value, default_value, step_size, on_change)

    menu.add_value_replacement(command, -1, Labels.Default)

    return command
end

-- Backend Loop
local LoopHandler = {
    Tunables = {}
}



------------------------
-- Start Menu
------------------------

local GTAO = tonumber(NETWORK.GET_ONLINE_VERSION())
if SUPPORT_GTAO ~= GTAO then
    util.toast(string.format("支持的GTA线上版本: %s\n当前GTA线上版本: %s\n不支持当前版本,建议停止使用!",
        SUPPORT_GTAO, GTAO))
end


local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "RS Missions")

menu.action(Menu_Root, "Restart Script", {}, "", function()
    util.restart_script()
end)



--------------------------------
--    Business Mission
--------------------------------

local Business_Mission <const> = menu.list(Menu_Root, "资产任务", {}, "")

--------------------------------
--    Special Cargo
--------------------------------

local Special_Cargo <const> = menu.list(Business_Mission, get_label_text("ABH_BUS_SC"), {}, "")

local SpecialCargo = {
    Source = {
        eMissionVariation = -1,
        iContrabandSize = 3,
        bSpecialItem = -1,
        iContrabandSizeInsFin = -1,
    },
    Sell = {
        iSaleValue = -1,
        iSpecialSaleValue = -1,
        eMissionVariation = -1,
    },
}

menu.divider(Special_Cargo, Labels.Source)

menu.list_select(Special_Cargo, Labels.SelectMission, {}, "", Tables.ContrabandBuy, -1, function(value)
    SpecialCargo.Source.eMissionVariation = value
end)

rs.menu_slider(Special_Cargo, "货物数量", {}, "", -1, 10, 3, 1, function(value)
    SpecialCargo.Source.iContrabandSize = value
end)
menu.list_select(Special_Cargo, "特殊货物", {}, "", {
    { -1, Labels.Default },
    { 1,  Labels.Yes },
    { 0,  Labels.No }
}, -1, function(value)
    SpecialCargo.Source.bSpecialItem = value
end)

menu.toggle_loop(Special_Cargo, "设置购买任务数据", {}, Labels.E_B_S_M, function()
    local contrabandMissionData = Globals.sMagnateGangBossData() + 183

    if SpecialCargo.Source.iContrabandSize ~= -1 then
        GLOBAL_SET_INT(contrabandMissionData + 1, SpecialCargo.Source.iContrabandSize)
    end
    if SpecialCargo.Source.bSpecialItem ~= -1 then
        GLOBAL_SET_INT(contrabandMissionData + 3, SpecialCargo.Source.bSpecialItem)
    end

    if SpecialCargo.Source.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(SpecialCargo.Source.eMissionVariation)
    end
end)

menu.action(Special_Cargo, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_contraband_buy") then
        return
    end

    OPEN_COMPUTER.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.718, 0.272)
end)

rs.menu_slider(Special_Cargo, "货物数量", {}, Labels.O_W_F_INS_FIN, -1, 10, -1, 1, function(value)
    SpecialCargo.Source.iContrabandSizeInsFin = value
end)
menu.action(Special_Cargo, "直接完成 特种货物 购买任务", {}, "", function(value)
    local script = "gb_contraband_buy"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if SpecialCargo.Source.iContrabandSizeInsFin ~= -1 then
        LOCAL_SET_INT(script, Locals.ContrabandBuy.contrabandSize, SpecialCargo.Source.iContrabandSizeInsFin)
    end

    LOCAL_SET_INT(script, Locals.ContrabandBuy.eType, 1)      -- eCONTRABANDTYPE_CAR
    LOCAL_SET_INT(script, Locals.ContrabandBuy.eEndReason, 4) -- SET_END_REASON(eENDREASON_CONTRABAND_DELIVERED)
    LOCAL_SET_INT(script, Locals.ContrabandBuy.eModeState, 8) -- SET_MODE_STATE(eMODESTATE_REWARDS)


    ---  [[ OLD FUNCTIONS ]]  ---
    -- SET_SERVER_BIT1(eSERVERBITSET1_CONTRABAND_0_DELIVERED, ...)
    -- LOCAL_SET_BITS(script, Locals.ContrabandBuy.iServerBitSet1, 23, 24, 25)
    -- SET_LOCAL_BIT5(eLOCALBITSET5_CONTRABAND_0_IS_BEING_DELIVERED, ..., eLOCALBITSET5_I_AM_IN_VEHICLE_INSIDE_DROP_OFF_WITH_A_CONTRABAND_0_HOLDER, ...)
    -- LOCAL_SET_BITS(script, Locals.ContrabandBuy.iLocalBitset5, 0, 1, 2, 4, 5, 6)
end)



menu.divider(Special_Cargo, Labels.Sell)

menu.list_select(Special_Cargo, Labels.SelectMission, {}, "", Tables.ContrabandSell, -1, function(value)
    SpecialCargo.Sell.eMissionVariation = value
end)

menu.toggle_loop(Special_Cargo, "设置出售任务数据", {}, Labels.E_B_S_M, function()
    local script = "gb_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if SpecialCargo.Sell.eMissionVariation ~= -1 then
        LOCAL_SET_INT(script, Locals.ContrabandSell.eSellVar, SpecialCargo.Sell.eMissionVariation)
    end
end)

menu.action(Special_Cargo, "直接完成 特种货物 出售任务", {}, "", function()
    local script = "gb_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals.ContrabandSell.eEndReason, 6) -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)
    LOCAL_SET_INT(script, Locals.ContrabandSell.eModeState, 2) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Special_Cargo, "出售价值")

rs.menu_slider(Special_Cargo, "特种货物单位价值", { "SpecialCargoSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    SpecialCargo.Sell.iSaleValue = value
end)
rs.menu_slider(Special_Cargo, "特殊货物单位价值", { "SpecialItemSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    SpecialCargo.Sell.iSpecialSaleValue = value
end)
menu.toggle_loop(Special_Cargo, "设置出售价值", {}, "", function()
    if SpecialCargo.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("SpecialCargoSaleValue", SpecialCargo.Sell.iSaleValue)
    end
    if SpecialCargo.Sell.iSpecialSaleValue ~= -1 then
        Tunables.SetIntList("SpecialItemSaleValue", SpecialCargo.Sell.iSpecialSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("SpecialCargoSaleValue")
    Tunables.RestoreIntDefaults("SpecialItemSaleValue")
end)


--------------------------------
--    Gunrunning Supplies
--------------------------------

local Gunrunning_Supplies <const> = menu.list(Business_Mission, get_label_text("ABH_BUS_GUNS"), {}, "")

local Gunrunning = {
    iResupplyValue = 60,
    Steal = {
        eMissionVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
}

menu.divider(Gunrunning_Supplies, Labels.Source)

menu.list_select(Gunrunning_Supplies, Labels.SelectMission, {}, "", Tables.GunrunResupply, -1, function(value)
    Gunrunning.Steal.eMissionVariation = value
end)

rs.menu_slider(Gunrunning_Supplies, "原材料补给数量(%)", { "GunrunResupplyValue" }, "",
    -1, 100, 60, 10, function(value)
        Gunrunning.iResupplyValue = value
    end)

menu.action(Gunrunning_Supplies, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_gunrunning") then
        return
    end

    if Gunrunning.Steal.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Gunrunning.Steal.eMissionVariation)
    end

    if Gunrunning.iResupplyValue ~= -1 then
        Tunables.SetInt("GR_RESUPPLY_PACKAGE_VALUE", Gunrunning.iResupplyValue)
        Tunables.SetInt("GR_RESUPPLY_VEHICLE_VALUE", Gunrunning.iResupplyValue)
    end

    OPEN_COMPUTER.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.501, 0.651)
end)

menu.action(Gunrunning_Supplies, "直接完成 地堡 原材料补给任务", {}, "", function()
    local script = "gb_gunrunning"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, Locals.Gunrunning.iGunrunEntityBitSet + 1 + 0 * 3 + 1 + 0, 6) -- SET_GUNRUN_ENTITY_BIT(iGunrunEntity, eGUNRUNENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals.Gunrunning.eEndReason, 3)                              -- SET_END_REASON(eENDREASON_GUNRUN_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.Gunrunning.eModeState, 14)                             -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)



menu.divider(Gunrunning_Supplies, Labels.Sell)

menu.list_select(Gunrunning_Supplies, Labels.SelectMission, {}, "", Tables.GunrunSell, -1, function(value)
    Gunrunning.Sell.eMissionVariation = value
end)

menu.action(Gunrunning_Supplies, Labels.LaunchMissionByBunker, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_gunrunning") then
        return
    end

    if Gunrunning.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Gunrunning.Sell.eMissionVariation)
    end

    OPEN_COMPUTER.BUNKER()
    PAD.SET_CURSOR_POSITION(0.481, 0.581)
end)

menu.action(Gunrunning_Supplies, "直接完成 地堡 出售任务", {}, "", function()
    local script = "gb_gunrunning"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, Locals.Gunrunning.eMissionVariation)
    local deliverableQuantity = 1
    if eMissionVariation == 16 then -- GRV_SELL_HILL_CLIMB
        deliverableQuantity = 5
    end
    -- Set sGangBossManageRewardsData.iNumDropsMade = sGangBossManageRewardsData.iTotalDrops
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals.Gunrunning.iNumEntitiesThisVariation)
    LOCAL_SET_INT(script, Locals.Gunrunning.iTotalDeliveredCount, iNumEntitiesThisVariation * deliverableQuantity)

    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        LOCAL_SET_BIT(script, Locals.Gunrunning.iGunrunEntityBitSet + 1 + i * 3 + 1 + 0, 6) -- SET_GUNRUN_ENTITY_BIT(iGunrunEntity, eGUNRUNENTITYBITSET_DELIVERED)
    end

    LOCAL_SET_INT(script, Locals.Gunrunning.eEndReason, 3)  -- SET_END_REASON(eENDREASON_GUNRUN_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.Gunrunning.eModeState, 14) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Gunrunning_Supplies, "出售价值")

rs.menu_slider(Gunrunning_Supplies, "货物单位价值", { "GunrunSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    Gunrunning.Sell.iSaleValue = value
end)
menu.toggle_loop(Gunrunning_Supplies, "设置出售价值", {}, "", function()
    if Gunrunning.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("GunrunProductSaleValue", Gunrunning.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("GunrunProductSaleValue")
end)



--------------------------------
--    Air-Freight Cargo
--------------------------------

local AirFreight_Cargo <const> = menu.list(Business_Mission, get_label_text("ABH_BUS_AIR"), {}, "")

local Smuggler = {
    Source = {
        eMissionVariation = -1,
        iNumEntitiesThisVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    }
}

menu.divider(AirFreight_Cargo, Labels.Source)

menu.list_select(AirFreight_Cargo, Labels.SelectMission, {}, "", Tables.SmugglerBuy, -1, function(value)
    Smuggler.Source.eMissionVariation = value
end)

menu.action(AirFreight_Cargo, Labels.LaunchMissionByHangar, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_smuggler") then
        return
    end

    if Smuggler.Source.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Smuggler.Source.eMissionVariation)
    end

    OPEN_COMPUTER.HANGAR()
    PAD.SET_CURSOR_POSITION(0.631, 0.0881)
end)

rs.menu_slider(AirFreight_Cargo, "货物数量", {}, Labels.O_W_F_INS_FIN, -1, 3, -1, 1, function(value)
    Smuggler.Source.iNumEntitiesThisVariation = value
end)

menu.action(AirFreight_Cargo, "直接完成 机库空运货物 偷取任务", {}, "", function()
    local script = "gb_smuggler"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if Smuggler.Source.iNumEntitiesThisVariation ~= -1 then
        LOCAL_SET_INT(script, Locals.Smuggler.iNumEntitiesThisVariation, Smuggler.Source.iNumEntitiesThisVariation)
    end

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals.Smuggler.iNumEntitiesThisVariation)
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        LOCAL_SET_BIT(script, Locals.Smuggler.iSmugglerEntityBitSet + 1 + i * 3 + 1 + 0, 6) -- SET_SMUGGLER_ENTITY_BIT(iSmugglerEntity, eSMUGGLERENTITYBITSET_DELIVERED)
    end

    LOCAL_SET_INT(script, Locals.Smuggler.eEndReason, 3)  -- SET_END_REASON(eENDREASON_SMUGGLER_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.Smuggler.eModeState, 18) -- SET_MODE_STATE(eMODESTATE_REWARDS)

    if iNumEntitiesThisVariation > 1 then
        util.yield(800)
        LOCAL_SET_INT(script, Locals.Smuggler.eModeState, 19) -- SET_MODE_STATE(eMODESTATE_END)
    end
end)


menu.divider(AirFreight_Cargo, Labels.Sell)

menu.list_select(AirFreight_Cargo, Labels.SelectMission, {}, "", Tables.SmugglerSell, -1, function(value)
    Smuggler.Sell.eMissionVariation = value
end)

menu.action(AirFreight_Cargo, Labels.LaunchMissionByHangar, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_smuggler") then
        return
    end

    if Smuggler.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Smuggler.Sell.eMissionVariation)
    end

    OPEN_COMPUTER.HANGAR()
    PAD.SET_CURSOR_POSITION(0.772, 0.101)
end)

local SmugglerDeliverableQuantity = {
    [20] = 5,
    [15] = 2,
    [24] = 2,
    [21] = 3,
    [22] = 5,
    [16] = 5,
    [17] = 5,
    [25] = 5,
}

menu.action(AirFreight_Cargo, "直接完成 机库空运货物 出售任务", {}, "", function()
    local script = "gb_smuggler"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, Locals.Smuggler.eMissionVariation)

    local deliverableQuantity = SmugglerDeliverableQuantity[eMissionVariation]
    if deliverableQuantity == nil then
        deliverableQuantity = 1
    end

    -- Set sGangBossManageRewardsData.iNumDropsMade = sGangBossManageRewardsData.iTotalDrops
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals.Smuggler.iNumEntitiesThisVariation)
    LOCAL_SET_INT(script, Locals.Smuggler.iTotalDeliveredCount, iNumEntitiesThisVariation * deliverableQuantity)

    LOCAL_SET_INT(script, Locals.Smuggler.eEndReason, 3)  -- SET_END_REASON(eENDREASON_SMUGGLER_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.Smuggler.eModeState, 18) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)

menu.divider(AirFreight_Cargo, "出售价值")

rs.menu_slider(AirFreight_Cargo, "货物单位价值", { "SmugSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    Smuggler.Sell.iSaleValue = value
end)
menu.toggle_loop(AirFreight_Cargo, "设置出售价值", {}, "", function()
    if Smuggler.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("SmugProductSaleValue", Smuggler.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("SmugProductSaleValue")
end)



--------------------------------
--    Acid Lab
--------------------------------

local Acid_Lab <const> = menu.list(Business_Mission, get_label_text("ACID_LAB_TITLE"), {}, "")

local AcidLab = {
    iResupplyValue = 60,
    Source = {
        eMissionVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
}

menu.divider(Acid_Lab, Labels.Source)

menu.list_select(Acid_Lab, Labels.SelectMission, {}, "",
    Tables.AcidLabSource, -1, function(value)
        AcidLab.Source.eMissionVariation = value
    end)
menu.slider(Acid_Lab, "原材料补给数量(%)", { "AcidResupplyValue" }, "",
    0, 100, 60, 10, function(value)
        AcidLab.iResupplyValue = value
    end)

menu.action(Acid_Lab, Labels.LaunchMission, {}, "", function()
    Tunables.SetInt("ACID_LAB_RESUPPLY_CRATE_VALUE", AcidLab.iResupplyValue)

    -- FMMC_TYPE_ACID_LAB_SOURCE
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(305, AcidLab.Source.eMissionVariation)
end)

menu.action(Acid_Lab, "直接完成 致幻剂实验室 原材料补给任务", {}, "", function()
    local script = "fm_content_acid_lab_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.AcidLabSource.iGenericBitset, Locals.AcidLabSource.eEndReason)
end)


menu.divider(Acid_Lab, Labels.Sell)

menu.list_select(Acid_Lab, Labels.SelectMission, {}, "",
    Tables.AcidLabSell, -1, function(value)
        AcidLab.Sell.eMissionVariation = value
    end)
menu.toggle_loop(Acid_Lab, "设置出售任务数据", {}, Labels.E_B_S_M, function()
    if AcidLab.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(AcidLab.Sell.eMissionVariation)
    end
end)

menu.action(Acid_Lab, "直接完成 致幻剂实验室 出售任务", {}, "", function()
    local script = "fm_content_acid_lab_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    util.create_tick_handler(function()
        if IS_SCRIPT_RUNNING(script) then
            -- Set sLocalVariables.sRewards.iDropOffCount = sLocalVariables.sRewards.iTotalDropoffs
            local iTotalDropoffs = LOCAL_GET_INT(script, Locals.AcidLabSell.iTotalDropoffs)
            LOCAL_SET_INT(script, Locals.AcidLabSell.iDropOffCount, iTotalDropoffs)
        else
            util.toast("Done")
            return false
        end
    end)
    util.yield(200)
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.AcidLabSell.iGenericBitset, Locals.AcidLabSell.eEndReason)
end)


menu.divider(Acid_Lab, "出售价值")

rs.menu_slider(Acid_Lab, "货物单位价值", { "AcidSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    AcidLab.Sell.iSaleValue = value
end)
menu.toggle_loop(Acid_Lab, "设置出售价值", {}, "", function()
    if AcidLab.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("AcidProductSaleValue", AcidLab.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("AcidProductSaleValue")
end)



--------------------------------
--    Nightclub
--------------------------------

local Nightclub_Business <const> = menu.list(Business_Mission, get_label_text("CLUB_TITLE"), {}, "")

menu.action(Nightclub_Business, "夜总会电脑", {}, "", function()
    OPEN_COMPUTER.NIGHTCLUB()
end)

--------------------------------------------
--    Request Nightclub Goods (Yohan)
--------------------------------------------

local Club_Source = menu.list(Nightclub_Business,
    string.format("%s (%s)", get_label_text("YOHN_OP1_T"), get_label_text("CELL_YOHAN_N")), {}, "")

local ClubSource = {
    eMissionVariation = -1,
    fAmountMultiplier = -1,
    eGoodsType = -1,
}

menu.list_select(Club_Source, Labels.SelectMission, {}, "",
    Tables.ClubSource, -1, function(value)
        ClubSource.eMissionVariation = value
    end)

rs.menu_slider(Club_Source, "获取货物数量倍数", {}, "", -1, 10, -1, 1, function(value)
    ClubSource.fAmountMultiplier = value
end)
menu.list_select(Club_Source, "选择货物类型", {}, "",
    Tables.GoodsType, -1, function(value)
        ClubSource.eGoodsType = value
    end)
menu.toggle_loop(Club_Source, "设置任务数据", {}, Labels.E_B_S_M, function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if ClubSource.fAmountMultiplier ~= -1 then
        for _, offset in pairs(TunablesI["NightclubSourceRewardAmount"]) do
            local default_value = TunableDefaults[offset]
            local new_value = default_value * ClubSource.fAmountMultiplier
            GLOBAL_SET_INT(g_sMPTunables + offset, new_value)
        end
    end

    if ClubSource.eGoodsType ~= -1 then
        LOCAL_SET_INT(script, Locals.ClubSource.eGoodsType, ClubSource.eGoodsType)
    end
end, function()
    Tunables.RestoreIntDefaults("NightclubSourceRewardAmount")
end)


menu.textslider(Club_Source, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 301 -- FMMC_TYPE_CLUB_SOURCE
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, ClubSource.eMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, ClubSource.eMissionVariation)
    end
end)

menu.action(Club_Source, "已送达货物到夜总会", {}, "增加夜总会货物数量, 可以无限次送达", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iLocalParticipantIndexAsInt = LOCAL_GET_INT(script, Locals.ClubSource.iLocalParticipantIndexAsInt)
    LOCAL_SET_INT(script, Locals.ClubSource.iGoodsToTransfer(iLocalParticipantIndexAsInt), 1)
end)

menu.action(Club_Source, "收集夜总会货物", {}, "Only work for Truck Mission", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local blip = HUD.GET_NEXT_BLIP_INFO_ID(478)
    if not HUD.DOES_BLIP_EXIST(blip) then
        return
    end
    local entity = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return
    end
    if ENTITY.IS_ENTITY_ATTACHED(entity) then
        ENTITY.DETACH_ENTITY(entity, true, true)
        ENTITY.SET_ENTITY_VISIBLE(entity, true, false)
    end
    OBJECT.SET_PICKUP_OBJECT_COLLECTABLE_IN_VEHICLE(entity)
    OBJECT.ATTACH_PORTABLE_PICKUP_TO_PED(entity, players.user_ped())
end)

menu.action(Club_Source, "结束任务", {}, "", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.ClubSource.iGenericBitset, Locals.ClubSource.eEndReason)
end)


menu.divider(Nightclub_Business, Labels.Sell)

local ClubSell = {
    eMissionVariation = -1,
    iSaleValue = -1,
}

menu.list_select(Nightclub_Business, Labels.SelectMission, {}, "",
    Tables.NightclubSell, -1, function(value)
        ClubSell.eMissionVariation = value
    end)
menu.toggle_loop(Nightclub_Business, "设置出售任务数据", {}, Labels.E_B_S_M, function()
    if ClubSell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(ClubSell.eMissionVariation)
    end
end)

menu.action(Nightclub_Business, "直接完成 夜总会 出售任务", {}, "", function()
    local script = "business_battles_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iMissionEntity = 0

    -- Set serverBD.iTotalDeliveredCount = serverBD.iTotalDeliveriesToMake
    local iTotalDeliveriesToMake = LOCAL_GET_INT(script, Locals.NightclubSell.iTotalDeliveriesToMake)
    LOCAL_SET_INT(script, Locals.NightclubSell.iTotalDeliveredCount, iTotalDeliveriesToMake)

    -- Set serverBD.sMissionEntity[iMissionEntity].iDeliveriesMade = serverBD.sMissionEntity[iMissionEntity].iDeliveriesToMake
    local iDeliveriesToMake = LOCAL_GET_INT(script, Locals.NightclubSell.sMissionEntity + 1 + iMissionEntity * 42 + 30)
    LOCAL_SET_INT(script, Locals.NightclubSell.sMissionEntity + 1 + iMissionEntity * 42 + 29, iDeliveriesToMake)

    LOCAL_SET_BIT(script, Locals.NightclubSell.sMissionEntity + 1 + iMissionEntity * 42 + 11 + 1 + 0, 1) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals.NightclubSell.eEndReason, 4)                                            -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.NightclubSell.eModeState, 30)                                           -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Nightclub_Business, "出售价值")

rs.menu_slider(Nightclub_Business, "货物单位价值", { "NightclubSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    ClubSell.iSaleValue = value
end)
menu.toggle_loop(Nightclub_Business, "设置出售价值", {}, "", function()
    if ClubSell.iSaleValue ~= -1 then
        Tunables.SetIntList("NightclubProductSaleValue", ClubSell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("NightclubProductSaleValue")
end)







local Freemode_Mission <const> = menu.list(Menu_Root, "自由模式任务", {}, "")

----------------------------------------
--    Security Contract (Franklin)
----------------------------------------

local Fixer_Security = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("FXR_STSTART_T"), get_label_text("PIM_FRANK")), {}, "")

local Fixer_Security_Mission = menu.list_select(Fixer_Security, Labels.SelectMission, {}, "",
    Tables.SecurityContract, -1, function() end)
local Fixer_Security_Difficulty = menu.list_select(Fixer_Security, "选择难度", {}, "", {
    { -1, Labels.RANDOM },
    { 0,  get_label_text("FAPP_NORMAL") }, -- FSCD_DEFAULT
    { 1,  get_label_text("FAPP_HARD") },   -- FSCD_HARD
    { 2,  get_label_text("FAPP_VERSUS") }, -- FSCD_HARD_WITH_RIVALS
}, -1, function() end)

menu.textslider(Fixer_Security, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local thisDifficulty = menu.get_value(Fixer_Security_Difficulty)
    if thisDifficulty ~= -1 then
        for iSlot = 0, 2 do
            GLOBAL_SET_INT(Globals.FixerFlowContract + 1 + iSlot * 3 + 1, thisDifficulty)
        end
    end

    local iMission = 263 -- FMMC_TYPE_FIXER_SECURITY
    local iMissionVariation = menu.get_value(Fixer_Security_Mission)
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Fixer_Security, "直接完成 安保合约", {}, "", function()
    local script = "fm_content_security_contract"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.SecurityContract.iGenericBitset, Locals.SecurityContract.eEndReason)
end)


----------------------------------------
--    Payphone Hit (Franklin)
----------------------------------------

local Fixer_Payphone = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("FXR_BM_PH_T"), get_label_text("PIM_FRANK")), {}, "")

menu.action(Fixer_Payphone, "请求任务", {}, "显示电话亭图标\n随机暗杀任务", function()
    -- PAYPHONEFLOW_SET_BIT(ePAYPHONEFLOWBITSET_REQUESTED)
    GLOBAL_SET_BIT(Globals.PayphoneFlowBitset + 1 + 0, 0)
end)

local Fixer_Payphone_Mission = menu.list_select(Fixer_Payphone, Labels.SelectMission, {}, "",
    Tables.PayphoneHit, -1, function() end)

menu.textslider(Fixer_Payphone, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 262 -- FMMC_TYPE_FIXER_PAYPHONE
    local iMissionVariation = menu.get_value(Fixer_Payphone_Mission)
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

local Fixer_Payphone_Bouns = menu.toggle(Fixer_Payphone, "暗杀奖励", {}, "", function(toggle)
end)

menu.action(Fixer_Payphone, "直接完成 电话暗杀", {}, "", function()
    local script = "fm_content_payphone_hit"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if menu.get_value(Fixer_Payphone_Bouns) then
        -- SET_MISSION_SERVER_BIT(eMISSIONSERVERBITSET_GENERIC_BONUS_KILL_ACTIVE)
        LOCAL_SET_BIT(script, Locals.PayphoneHit.iMissionServerBitSet + 1, 1)
    end

    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.PayphoneHit.iGenericBitset, Locals.PayphoneHit.eEndReason)
end)


----------------------------------------
--    Client Jobs (Terrorbyte)
----------------------------------------

local Client_Jobs = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("HTD_WORK"), Labels.Terrorbyte), {}, "")

-- Robbery in Progress
menu.divider(Client_Jobs, get_label_text("HT_BW_T0"))

menu.textslider(Client_Jobs, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 242 -- FMMC_TYPE_FMBB_BANK_JOB
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission)
    end
end)

menu.action(Client_Jobs, "直接完成 银行劫案", {}, "", function()
    local script = "gb_bank_job"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, Locals.ClientJobs.BankJob.iMissionEntityBitSet, 2) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals.ClientJobs.BankJob.eModeState, 7)           -- SET_MODE_STATE(eMODESTATE_REWARDS)
    LOCAL_SET_INT(script, Locals.ClientJobs.BankJob.eEndReason, 4)           -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)
end)

-- Data Sweep
menu.divider(Client_Jobs, get_label_text("HT_BW_T1"))

menu.textslider(Client_Jobs, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 244 -- FMMC_TYPE_FMBB_DATA_HACK
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission)
    end
end)

menu.action(Client_Jobs, "直接完成 数据检索", {}, "", function()
    local script = "gb_data_hack"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    LOCAL_SET_INT(script, Locals.ClientJobs.DataHack.eEndReason, 6) -- SET_END_REASON(eENDREASON_GOODS_DELIVERED_LAUNCHING_GANG)
end)


----------------------------------------
--    Fooligan Jobs
----------------------------------------

local Drug_Lab_Work = menu.list(Freemode_Mission, "蠢人帮差事 (达克斯)", {}, "")

local Drug_Lab_Work_Mission = menu.list_select(Drug_Lab_Work, Labels.SelectMission, {}, "",
    Tables.DrugLabWork, -1, function() end)

menu.textslider(Drug_Lab_Work, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 307 -- FMMC_TYPE_DRUG_LAB_WORK
    local iMissionVariation = menu.get_value(Drug_Lab_Work_Mission)
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Drug_Lab_Work, "直接完成 蠢人帮差事", {}, "", function()
    local script = "fm_content_drug_lab_work"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.DrugLabWork.iGenericBitset, Locals.DrugLabWork.eEndReason)
end)


------------------------------------
--    Stash House
------------------------------------

local Stash_House = menu.list(Freemode_Mission, get_label_text("SH_BIGM_T"), {}, "")

menu.action(Stash_House, "传送到 藏匿屋", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(845)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TP_ENTITY(players.user_ped(), coords)
    else
        util.toast("Not Found In Map")
    end
end)
menu.action(Stash_House, Labels.LaunchMission, {}, "", function()
    -- FMMC_TYPE_STASH_HOUSE
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(308)
end)
menu.action(Stash_House, "直接完成 藏匿屋", {}, "", function()
    local script = "fm_content_stash_house"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.StashHouse.iGenericBitset, Locals.StashHouse.eEndReason)
end)


------------------------------------
--    Casino Work
------------------------------------

local Casino_Work = menu.list(Freemode_Mission, "赌场工作 (贝克女士)", {}, "")

local Casino_Work_Mission = menu.list_select(Casino_Work, Labels.SelectMission, {}, "",
    Tables.CasinoWork, -1, function() end)

menu.textslider(Casino_Work, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 243 -- FMMC_TYPE_GB_CASINO
    local iMissionVariation = menu.get_value(Casino_Work_Mission)
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)


menu.action(Casino_Work, "直接完成 赌场工作", {}, "", function()
    local script = "gb_casino"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, 2845 + 1321)
    if eMissionVariation == 14 then -- CSV_TRACKING_CHIPS
        for i = 0, 4 do
            -- SET_FIND_ITEM_BIT(iChip, eFINDITEMBITSET_COLLECTED)
            LOCAL_SET_BIT(script, 2845 + 1573 + 1 + i, 1)
        end
    end

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, 2845 + 1541)
    local partId = NETWORK.NETWORK_GET_PARTICIPANT_INDEX(players.user())
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
        LOCAL_SET_BIT(script, 2845 + 63 + 1 + i * 3 + 1 + 0, 4)

        -- SET_MISSION_ENTITY_CLIENT_BIT(iMissionEntity, NETWORK_GET_PARTICIPANT_INDEX(playerID), eMISSIONENTITYCLIENTBITSET_MY_GANG_DELIVERED_MISSION_ENTITY)
        LOCAL_SET_BIT(script, 4517 + 1 + partId * 266 + 9 + 1 + i * 3 + 1 + 1, 3)
    end

    LOCAL_SET_INT(script, 2845 + 1324, 3)  -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, 2845 + 1323, 33) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.toggle_loop(Casino_Work, "Show Info", {}, "", function()
    local script = "gb_casino"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, 2845 + 1321)
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, 2845 + 1541)
    local partId = NETWORK.NETWORK_GET_PARTICIPANT_INDEX(players.user())

    local text = string.format(
        "eMissionVariation: %s\niNumEntitiesThisVariation: %s\npartId: %s",

        eMissionVariation, iNumEntitiesThisVariation, partId
    )

    draw_text(text)
end)


------------------------------------
--    Auto Shop Service
------------------------------------

local Auto_Shop_Service = menu.list(Freemode_Mission, get_label_text("TDEL_ES_T"), {}, "")

menu.action(Auto_Shop_Service, "获得新的客户载具", {}, "在改装铺外面生效", function()
    local script = "shop_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("TUNER_CLIENT_VEHICLE_POSSIX"), 0)

    LOCAL_SET_INT(script, Locals.ShopController.iAutoShopRandomTime, 0)
    -- LOCAL_BIT_SET_AUTO_SHOP_RAND_TIME, LOCAL_BIT_SHOULD_GIVE_VEHICLE_THIS_TIME
    LOCAL_SET_BITS(script, Locals.ShopController.iLocalBS, 0, 1)
end)

menu.action(Auto_Shop_Service, "跳过客户载具改装", {}, "在改装铺内部生效", function()
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_BODYWORK_DONE          0
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PERFORMANCE_DONE       1
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_SERVICE_DONE           2
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_WHEELS_DONE            3
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PRIMARY_COLOR_DONE     4

    for i = 0, 1 do
        -- g_sClientVehicleSetupStruct[GET_TUNER_CLIENT_VEHICLE_SLOT()].iVehicleBS
        GLOBAL_SET_BITS(g_sClientVehicleSetupStruct + 1 + i * 106 + 105, 0, 1, 2, 3, 4)
    end
end)

menu.action(Auto_Shop_Service, "直接完成 改装铺服务", {}, "", function()
    local script = "fm_content_auto_shop_delivery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end

    local iMissionEntity = 0
    LOCAL_SET_BIT(script, Locals.AutoShopDelivery.iMissionEntityBitSet + 1 + iMissionEntity * 3 + 1 + 0, 4) -- eMISSIONENTITYBITSET_DELIVERED
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.AutoShopDelivery.iGenericBitset, Locals.AutoShopDelivery.eEndReason)
end)


menu.divider(Auto_Shop_Service, "奖励收入")

local AutoShopServiceVars = {
    iCashReward = -1,
    iBonusAmount = -1,
}

-- Payment for Delivery
rs.menu_slider(Auto_Shop_Service, get_label_text("TDEL_ES_PAY"), { "AutoShopServiceCashReward" }, "",
    -1, 1000000, -1, 1000, function(value)
        AutoShopServiceVars.iCashReward = value
    end)

-- Satisfaction
rs.menu_slider(Auto_Shop_Service, get_label_text("TDEL_ES_SAT"), { "AutoShopServiceBonusAmount" }, "",
    -1, 1000000, -1, 1000, function(value)
        AutoShopServiceVars.iBonusAmount = value
    end)

menu.toggle_loop(Auto_Shop_Service, "设置任务数据", {}, Labels.E_B_S_M, function()
    if AutoShopServiceVars.iCashReward ~= -1 then
        Tunables.SetIntList("TunerClientVehicleDeliveryPayment", AutoShopServiceVars.iCashReward)
    end
    if AutoShopServiceVars.iBonusAmount ~= -1 then
        Tunables.SetIntList("TunerClientVehicleBouns", AutoShopServiceVars.iBonusAmount)
    end
end, function()
    Tunables.RestoreIntDefaults("TunerClientVehicleDeliveryPayment")
    Tunables.RestoreIntDefaults("TunerClientVehicleBouns")
end)






------------------------
--    Other
------------------------

menu.action(Freemode_Mission, "完成每日挑战", {}, "", function()
    -- g_savedMPGlobalsNew.g_savedMPGlobals[GET_SAVE_GAME_ARRAY_SLOT()].MpSavedGeneral.Current_Daily_Objectives[i].bCompleted
    for i = 0, 2, 1 do
        GLOBAL_SET_INT(2359296 + 1 + 0 * 5569 + 681 + 4243 + 1 + i * 3 + 1, 1)
    end
end)







--------------------------------
--    Heist Mission
--------------------------------

local Heist_Mission <const> = menu.list(Menu_Root, "抢劫任务", {}, "")


menu.toggle_loop(Heist_Mission, "最小玩家数为1", {}, "强制任务单人可开", function()
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
    GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam, 0)
    -- for i = 0, 3 do
    --     GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam + i, 1)
    --     GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam + i, 0)
    -- end
end)

local SetMissionMaxTeams = menu.toggle_loop(Heist_Mission, "最大团队数为1", {}, "用于多团队任务", function()
    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, 1)
end)

menu.click_slider(Heist_Mission, "设置最大团队数", {}, "", 1, 4, 2, 1, function(value)
    menu.set_value(SetMissionMaxTeams, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, value)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, value)
end)



--------------------------------
--    Heist Mission Helper
--------------------------------

local Heist_Mission_Helper = menu.list(Heist_Mission, "抢劫任务助手", {}, "")

menu.action(Heist_Mission_Helper, "跳到下一个检查点", {}, "", function()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        -- SBBOOL1_PROGRESS_OBJECTIVE_FOR_TEAM_0
        LOCAL_SET_BIT(script, Locals.MissionController.iServerBitSet1, 17)
        return
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        -- SBBOOL1_PROGRESS_OBJECTIVE_FOR_TEAM_0
        LOCAL_SET_BIT(script, Locals.MissionController2020.iServerBitSet1, 17)
    end
end)

menu.toggle_loop(Heist_Mission_Helper, "禁止因触发惊动而任务失败", {}, "", function()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        -- SBBOOL1_AGGRO_TRIGGERED_FOR_TEAM_0, SBBOOL1_AGGRO_WILL_FAIL_FOR_TEAM_0
        LOCAL_CLEAR_BITS(script, Locals.MissionController.iServerBitSet1, 24, 28)
        return
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        -- SBBOOL1_AGGRO_TRIGGERED_FOR_TEAM_0, SBBOOL1_AGGRO_WILL_FAIL_FOR_TEAM_0
        LOCAL_CLEAR_BITS(script, Locals.MissionController2020.iServerBitSet1, 24, 28)
    end
end)

menu.toggle_loop(Heist_Mission_Helper, "禁止任务失败", {}, "", function()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
        LOCAL_SET_BIT(script, Locals.MissionController.iLocalBoolCheck11, 7)
        return
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
        LOCAL_SET_BIT(script, Locals.MissionController2020.iLocalBoolCheck11, 7)
    end
end)


local Heist_Mission_Vehicle
Heist_Mission_Vehicle = menu.list(Heist_Mission_Helper, "传送任务载具到我", {}, "", function()
    local menu_children = menu.get_children(Heist_Mission_Vehicle)
    if #menu_children > 0 then
        for _, command in pairs(menu_children) do
            menu.delete(command)
        end
    end

    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        script = "fm_mission_controller_2020"
        if not IS_SCRIPT_RUNNING(script) then
            return
        end
    end

    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle) then
            local entity_script = ENTITY.GET_ENTITY_SCRIPT(vehicle, 0)
            if entity_script ~= nil and string.lower(entity_script) == script then
                local display_name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle))
                local menu_name = get_label_text(display_name)
                local help_text = ""

                local blip = HUD.GET_BLIP_FROM_ENTITY(vehicle)
                if HUD.DOES_BLIP_EXIST(blip) then
                    local blip_sprite = HUD.GET_BLIP_SPRITE(blip)
                    if blip_sprite == 1 then
                        menu_name = menu_name .. " [Objective]"
                    else
                        menu_name = menu_name .. " [Blip]"
                    end
                end

                if vehicle == PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) then
                    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
                        menu_name = menu_name .. "[Current Vehicle]"
                    else
                        menu_name = menu_name .. "[Last Vehicle]"
                    end
                end

                menu.action(Heist_Mission_Vehicle, menu_name, {}, help_text, function()
                    TP_VEHICLE_TO_ME(vehicle)
                end)
            end
        end
    end
end)


menu.action(Heist_Mission, "直接完成任务 (通用)", {}, "联系人任务", function()
    if IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
        -- menu.trigger_commands("scripthost")
        INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
    elseif IS_SCRIPT_RUNNING("fm_mission_controller") then
        -- menu.trigger_commands("scripthost")
        INSTANT_FINISH_FM_MISSION_CONTROLLER()
    end
end)




menu.divider(Heist_Mission, "")

local function HANDLE_HEIST_ELITE_CHALLENGE(script, eEliteChallenge)
    if eEliteChallenge == 0 then
        return
    end
    if eEliteChallenge == 2 then
        GLOBAL_SET_BOOL(TransitionSessionNonResetVars.bHasQuickRestartedDuringStrandMission, true)
        return
    end

    GLOBAL_SET_BOOL(TransitionSessionNonResetVars.bHasQuickRestartedDuringStrandMission, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, Consts.DIFF_HARD)
    LOCAL_SET_INT(script, Locals.MissionController.iTeamKills, 150)
    LOCAL_SET_INT(script, Locals.MissionController.iTeamHeadshots, 150)
end

--------------------------------
--    Apartment Heist
--------------------------------

local Apartment_Heist <const> = menu.list(Heist_Mission, "公寓抢劫", {}, "")

local ApartmentHeistVars = {
    eEliteChallenge = 0,
    iCashReward = -1,
    iCashTotalTake = -1,
}

menu.list_action(Apartment_Heist, "完成奖章挑战", {}, "进行任务时使用", Tables.HeistAwards, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if value == 3 then
        -- Ultimate Challenge
        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, Consts.DIFF_HARD)
    elseif value == 4 then
        -- First Person
        GLOBAL_SET_INT(FMMC_STRUCT.iFixedCamera, 1)
    elseif value == 5 then
        -- Member
        GLOBAL_SET_INT(TransitionSessionNonResetVars.bAmIHeistLeader, 0)
        -- MC_playerBD[PARTICIPANT_ID_TO_INT()].iClientBitSet, PBBOOL_HEIST_HOST
        LOCAL_CLEAR_BIT(script, 31603 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 292 + 127, 20)
    end

    local HeistAwardCompleteBitset = 268435455 -- 2^28-1
    local stats = Tables.HeistAwardsStats[value]
    STAT_SET_INT(stats[1], HeistAwardCompleteBitset)
end)

menu.list_action(Apartment_Heist, "清空奖章挑战记录", {}, "", Tables.HeistAwards, function(value)
    local stats = Tables.HeistAwardsStats[value]
    STAT_SET_INT(stats[1], 0)
    STAT_SET_BOOL(stats[2], false)

    if value == 2 then
        -- Same Team
        STAT_SET_INT("MPPLY_HEISTTEAMPROGRESSCOUNTER", 0)
    end
end)


menu.list_select(Apartment_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    ApartmentHeistVars.eEliteChallenge = value
end)

rs.menu_slider(Apartment_Heist, "终章奖励收入", { "ApartmentHeistCashReward" },
    "困难模式*1.25\n" .. Labels.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        ApartmentHeistVars.iCashReward = value
    end)

rs.menu_slider(Apartment_Heist, "拿取财物收入", { "ApartmentHeistTotalTake" },
    "用于太平洋标准银行抢劫\n" .. Labels.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        ApartmentHeistVars.iCashTotalTake = value
    end)

menu.action(Apartment_Heist, "直接完成 公寓抢劫", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if ApartmentHeistVars.iCashTotalTake ~= -1 then
        Tunables.SetIntList("HeistFinalCashReward", ApartmentHeistVars.iCashTotalTake)
    end
    if ApartmentHeistVars.iCashTotalTake ~= -1 then
        LOCAL_SET_INT(script, Locals.MissionController.iCashGrabTotalTake, ApartmentHeistVars.iCashTotalTake)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, ApartmentHeistVars.eEliteChallenge)

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)




--------------------------------
--    The Doomsday Heist
--------------------------------

local Doomsday_Heist <const> = menu.list(Heist_Mission, get_label_text("FMMC_RSTAR_MHS2"), {}, "")

local DoomsdayHeistVars = {
    eEliteChallenge = 0,
    iCashReward = -1,
}

-- menu.divider(Doomsday_Heist, Labels.PREP)

menu.action(Doomsday_Heist, "直接完成 末日豪劫 前置任务", {}, "", function()
    local script = "gb_gangops"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals.Gangops.iPhotosTaken, 10) -- ciAMATEUR_PHOTOGRAPHY_MAX_PHOTOS

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals.Gangops.iNumEntitiesThisVariation)
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        LOCAL_SET_BIT(script, Locals.Gangops.iMissionEntityBitSet + 1 + i * 3 + 1 + 0, 6) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    end

    LOCAL_SET_INT(script, Locals.Gangops.eEndReason, 3)  -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals.Gangops.eModeState, 24) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Doomsday_Heist, Labels.FINALE)

menu.list_action(Doomsday_Heist, "完成奖章挑战", {}, "进行任务时使用\n不是全部有效", Tables.GangopsAwards, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local GangopsAwardCompleteBitset = 536870911 -- 2^29-1
    local stats = Tables.GangopsAwardsStats[value]
    STAT_SET_INT(stats[1], GangopsAwardCompleteBitset)

    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, Consts.DIFF_HARD)
    GLOBAL_SET_INT(TransitionSessionNonResetVars.bAnyPlayerDiedDuringMission, 0)
end)

menu.list_action(Doomsday_Heist, "清空奖章挑战记录", {}, "", Tables.GangopsAwards, function(value)
    local stats = Tables.GangopsAwardsStats[value]
    STAT_SET_INT(stats[1], 0)
    STAT_SET_BOOL(stats[2], false)
end)


menu.list_select(Doomsday_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    DoomsdayHeistVars.eEliteChallenge = value
end)


rs.menu_slider(Doomsday_Heist, "终章奖励收入", { "DoomsdayHeistCashReward" },
    "困难模式*1.25\n" .. Labels.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        DoomsdayHeistVars.iCashReward = value
    end)

menu.action(Doomsday_Heist, "直接完成 末日豪劫", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if DoomsdayHeistVars.iCashReward ~= -1 then
        Tunables.SetIntList("GangopsFinalCashReward", DoomsdayHeistVars.iCashReward)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, DoomsdayHeistVars.eEliteChallenge)

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)




--------------------------------
--    Diamond Casino Heist
--------------------------------

local Casino_Heist <const> = menu.list(Heist_Mission, get_label_text("DPAD_CSH_VC"), {}, "")

local CasinoHeistVars = {
    eEliteChallenge = 0,
    iCashTotalTake = -1,
    bResetPrepStats = false,

    Config = {
        eChosenApproachType = 1,
        eTarget = 1,
        bHardMode = true,

        bSecurityCameraLocationsScoped = true,
        bGuardPatrolRoutesScoped = true,
        eShipmentDisruptionLevel = 2,
        bStealthNightVisionAcquired = true,
        bHandheldDrillAcquired = true,
        bEMPAcquired = true,

        eDropoffLocation = 6,
        eDropoffSubLocation = 0,
        bDecoyCrewMemberPurchased = false,
        bSwitchGetawayVehiclePurchased = false,
        eVehicleModPresetChosen = 0,

        eCrewWeaponsExpertChosen = 1,
        eCrewWeaponsLoadoutChosen = 0,
        eCrewDriverChosen = 1,
        eCrewVehiclesLoadoutChosen = 0,
        eCrewHackerChosen = 1,
        eCrewKeyAccessLevel = 2,
        eEntranceChosen = 1,
        eExitChosen = 1,
        eMasksChosen = 0,

        eSubterfugeOutfitsIn = 1,
        eSubterfugeOutfitsOut = 6,
        bOfficeInfested = false,

        bRappelGearAcquired = true,
    },
}

-- menu.divider(Casino_Heist, Labels.PREP)

local Casino_Heist_Preps = menu.list(Casino_Heist, "Casino Heist Preps", {}, "")

menu.textslider(Casino_Heist_Preps, "必选前置任务", {}, "", {
    "Complete All", "Clear All"
}, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET1"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET1"), 0)
    end
end)
menu.textslider(Casino_Heist_Preps, "可选前置任务", {}, "", {
    "Complete All", "Clear All"
}, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET0"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET0"), 0)
    end
end)
menu.textslider(Casino_Heist_Preps, "支援队伍", {}, "", {
    "Complete All (Low Cut%)", "Clear All"
}, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWWEAP"), 1)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_WEAPS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWDRIVER"), 1)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_VEHS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWHACKER"), 1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWWEAP"), 0)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_WEAPS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWDRIVER"), 0)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_VEHS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWHACKER"), 0)
    end
end)

menu.action(Casino_Heist_Preps, "直接完成 赌场抢劫 前置任务", {}, "", function()
    INSTANT_FINISH_CASINO_HEIST_PREPS()
end)


menu.divider(Casino_Heist, Labels.FINALE)

local Casino_Heist_Mission_Config = menu.list(Casino_Heist, "Casino Heist Mission Config", {}, "")

--#region

menu.toggle_loop(Casino_Heist_Mission_Config, "Set Mission Config", {}, Labels.E_B_S_M, function()
    -- look at these beautiful code... :)

    local Data = CasinoHeistVars.Config
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eChosenApproachType, Data.eChosenApproachType)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eTarget, Data.eTarget)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bHardMode, Data.bHardMode)

    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bSecurityCameraLocationsScoped, Data.bSecurityCameraLocationsScoped)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bGuardPatrolRoutesScoped, Data.bGuardPatrolRoutesScoped)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eShipmentDisruptionLevel, Data.eShipmentDisruptionLevel)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bStealthNightVisionAcquired, Data.bStealthNightVisionAcquired)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bHandheldDrillAcquired, Data.bHandheldDrillAcquired)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bEMPAcquired, Data.bEMPAcquired)

    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eDropoffLocation, Data.eDropoffLocation)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eDropoffSubLocation, Data.eDropoffSubLocation)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bDecoyCrewMemberPurchased, Data.bDecoyCrewMemberPurchased)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bSwitchGetawayVehiclePurchased, Data.bSwitchGetawayVehiclePurchased)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eVehicleModPresetChosen, Data.eVehicleModPresetChosen)

    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewWeaponsExpertChosen, Data.eCrewWeaponsExpertChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewWeaponsLoadoutChosen, Data.eCrewWeaponsLoadoutChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewDriverChosen, Data.eCrewDriverChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewVehiclesLoadoutChosen, Data.eCrewVehiclesLoadoutChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewHackerChosen, Data.eCrewHackerChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eCrewKeyAccessLevel, Data.eCrewKeyAccessLevel)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eEntranceChosen, Data.eEntranceChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eExitChosen, Data.eExitChosen)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eMasksChosen, Data.eMasksChosen)

    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eSubterfugeOutfitsIn, Data.eSubterfugeOutfitsIn)
    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eSubterfugeOutfitsOut, Data.eSubterfugeOutfitsOut)
    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bOfficeInfested, Data.bOfficeInfested)

    GLOBAL_SET_BOOL(CasinoHeistMissionConfigData.bRappelGearAcquired, Data.bRappelGearAcquired)
end)

menu.divider(Casino_Heist_Mission_Config, "Approach & Target")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_APPROACH"), {}, "",
    Tables.CasinoHeistApproach, 1, function(value)
        CasinoHeistVars.Config.eChosenApproachType = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_TARGET"), {}, "",
    Tables.CasinoHeistTarget, 1, function(value)
        CasinoHeistVars.Config.eTarget = value
    end)
menu.toggle(Casino_Heist_Mission_Config, "Hard Mode", {}, "", function(toggle)
    CasinoHeistVars.Config.bHardMode = toggle
end, true)


menu.divider(Casino_Heist_Mission_Config, "Optional")
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CHB_SEC_CAM"), {}, "", function(toggle)
    CasinoHeistVars.Config.bSecurityCameraLocationsScoped = toggle
end, true)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CHB_GUARD"), {}, "", function(toggle)
    CasinoHeistVars.Config.bGuardPatrolRoutesScoped = toggle
end, true)
menu.slider(Casino_Heist_Mission_Config, get_label_text("CHB_SHIPMENTS"), {}, "", 0, 3, 2, 1, function(value)
    CasinoHeistVars.Config.eShipmentDisruptionLevel = value
end)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CH_MISS_ST_3"), {}, "", function(toggle)
    CasinoHeistVars.Config.bStealthNightVisionAcquired = toggle
end, true)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CHB_DRILLS"), {}, "", function(toggle)
    CasinoHeistVars.Config.bHandheldDrillAcquired = toggle
end, true)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CH_MISS_ST_2"), {}, "", function(toggle)
    CasinoHeistVars.Config.bEMPAcquired = toggle
end, true)


menu.divider(Casino_Heist_Mission_Config, "Selectable Without Preps")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_DROP_OFF"), {}, "",
    {
        { 0, "Short 1",  {}, "", get_label_text("CH_DROPOFF_0") },
        { 1, "Short 2",  {}, "", get_label_text("CH_DROPOFF_0") },
        { 2, "Short 3",  {}, "", get_label_text("CH_DROPOFF_0") },
        { 3, "Medium 1", {}, "", get_label_text("CH_DROPOFF_1") },
        { 4, "Medium 2", {}, "", get_label_text("CH_DROPOFF_1") },
        { 5, "Medium 3", {}, "", get_label_text("CH_DROPOFF_2") },
        { 6, "Long 1",   {}, "", get_label_text("CH_DROPOFF_2") },
        { 7, "Long 2",   {}, "", get_label_text("CH_DROPOFF_2") },
        { 8, "Long 3",   {}, "", get_label_text("CH_DROPOFF_2") },
    }, 6, function(value)
        CasinoHeistVars.Config.eDropoffLocation = value
    end)
menu.list_select(Casino_Heist_Mission_Config, "Force Dropoff Sub Location", {}, "",
    {
        { 0, Labels.None },
        { 1, "Location 1" },
        { 2, "Location 2" },
        { 3, "Location 3" },
    }, 0, function(value)
        CasinoHeistVars.Config.eDropoffSubLocation = value
    end)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CHB_DECOY"), {}, "", function(toggle)
    CasinoHeistVars.Config.bDecoyCrewMemberPurchased = toggle
end)
menu.toggle(Casino_Heist_Mission_Config, get_label_text("CHB_SWITCH"), {}, "", function(toggle)
    CasinoHeistVars.Config.bSwitchGetawayVehiclePurchased = toggle
end)
menu.list_select(Casino_Heist_Mission_Config, "Vehicle Mod", {}, "",
    {
        { 0, Labels.None },
        { 1, "Preset 1" },
        { 2, "Preset 2" },
        { 3, "Preset 3" },
    }, 0, function(value)
        CasinoHeistVars.Config.eVehicleModPresetChosen = value
    end)


menu.divider(Casino_Heist_Mission_Config, "FM Preps")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_GUNMAN"), {}, "",
    {
        { 1, get_label_text("CH_WE_NAME_0B") }, -- KARL_ABOLAJI
        { 2, get_label_text("CH_WE_NAME_1B") }, -- GUSTAVO_MOTA
        { 3, get_label_text("CH_WE_NAME_2B") }, -- CHARLIE
        { 4, get_label_text("CH_WE_NAME_3B") }, -- WEAPONS_EXPERT
        { 5, get_label_text("CH_WE_NAME_4B") }, -- PACKIE_MCREARY
    }, 1, function(value)
        CasinoHeistVars.Config.eCrewWeaponsExpertChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_WEAP"), {}, "",
    {
        { 0, Labels.Default },
        { 1, "Alternate" },
    }, 0, function(value)
        CasinoHeistVars.Config.eCrewWeaponsLoadoutChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_DRIVER"), {}, "",
    {
        { 1, get_label_text("CH_DR_NAME_0") }, -- KARIM_DENZ
        { 2, get_label_text("CH_DR_NAME_1") }, -- TALIANA_MARTINEZ
        { 3, get_label_text("CH_DR_NAME_2") }, -- EDDIE_TOH
        { 4, get_label_text("CH_DR_NAME_3") }, -- ZACH
        { 5, get_label_text("CH_DR_NAME_4") }, -- WEAPONS_EXPERT
    }, 1, function(value)
        CasinoHeistVars.Config.eCrewDriverChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_VEH"), {}, "",
    {
        { 0, Labels.Default },
        { 1, "Alternate 1" },
        { 2, "Alternate 2" },
        { 3, "Alternate 3" },
    }, 0, function(value)
        CasinoHeistVars.Config.eCrewVehiclesLoadoutChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_HACKER"), {}, "",
    {
        { 1, get_label_text("CH_HR_NAME_0") }, -- RICKIE_LUKENS
        { 2, get_label_text("CH_HR_NAME_1") }, -- CHRISTIAN_FELTZ
        { 3, get_label_text("CH_HR_NAME_2") }, -- YOHAN
        { 4, get_label_text("CH_HR_NAME_3") }, -- AVI_SCHWARTZMAN
        { 5, get_label_text("CH_HR_NAME_4") }, -- PAIGE_HARRIS
    }, 1, function(value)
        CasinoHeistVars.Config.eCrewHackerChosen = value
    end)
menu.slider(Casino_Heist_Mission_Config, get_label_text("CHB_INSIDE_MAN"), {}, "", 0, 2, 2, 1, function(value)
    CasinoHeistVars.Config.eCrewKeyAccessLevel = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_ENTRANCE"), {}, "",
    {
        { 0,  get_label_text("CH_ACCPNT_0") },  -- MAIN_ENTRANCE
        { 1,  get_label_text("CH_ACCPNT_1") },  -- STAFF_ENTRANCE
        { 2,  get_label_text("CH_ACCPNT_2") },  -- GARBAGE_ENTRANCE
        { 3,  get_label_text("CH_ACCPNT_3") },  -- SOUTH_WEST_ROOF_TERRACE_ENTRANCE
        { 4,  get_label_text("CH_ACCPNT_4") },  -- NORTH_WEST_ROOF_TERRACE_ENTRANCE
        { 5,  get_label_text("CH_ACCPNT_5") },  -- SOUTH_EAST_ROOF_TERRACE_ENTRANCE
        { 6,  get_label_text("CH_ACCPNT_6") },  -- NORTH_EAST_ROOF_TERRACE_ENTRANCE
        { 7,  get_label_text("CH_ACCPNT_7") },  -- SOUTH_HELIPAD_ENTRANCE
        { 8,  get_label_text("CH_ACCPNT_8") },  -- NORTH_HELIPAD_ENTRANCE
        { 9,  get_label_text("CH_ACCPNT_9") },  -- SECURITY_VEHICLE_ENTRANCE
        { 10, get_label_text("CH_ACCPNT_10") }, -- SEWER_ENTRANCE
    }, 1, function(value)
        CasinoHeistVars.Config.eEntranceChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_EXIT"), {}, "",
    {
        { 0, get_label_text("CH_ACCPNT_0") }, -- MAIN_ENTRANCE
        { 1, get_label_text("CH_ACCPNT_1") }, -- STAFF_ENTRANCE
        { 2, get_label_text("CH_ACCPNT_2") }, -- GARBAGE_ENTRANCE
        { 3, get_label_text("CH_ACCPNT_3") }, -- SOUTH_WEST_ROOF_TERRACE_ENTRANCE
        { 4, get_label_text("CH_ACCPNT_4") }, -- NORTH_WEST_ROOF_TERRACE_ENTRANCE
        { 5, get_label_text("CH_ACCPNT_5") }, -- SOUTH_EAST_ROOF_TERRACE_ENTRANCE
        { 6, get_label_text("CH_ACCPNT_6") }, -- NORTH_EAST_ROOF_TERRACE_ENTRANCE
        { 7, get_label_text("CH_ACCPNT_7") }, -- SOUTH_HELIPAD_ENTRANCE
        { 8, get_label_text("CH_ACCPNT_8") }, -- NORTH_HELIPAD_ENTRANCE
    }, 1, function(value)
        CasinoHeistVars.Config.eExitChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_MASKS"), {}, "",
    {
        { 0,  Labels.None },
        { 1,  get_label_text("MASK_GEOMETRIC") },
        { 2,  get_label_text("MASK_HUNTERS") },
        { 3,  get_label_text("MASK_ONIHALF") },
        { 4,  get_label_text("MASK_EMOJIS") },
        { 5,  get_label_text("MASK_ORNSKULL") },
        { 6,  get_label_text("MASK_LFRUITS") },
        { 7,  get_label_text("MASK_GUERILLA") },
        { 8,  get_label_text("MASK_CLOWNS") },
        { 9,  get_label_text("MASK_ANIMAL") },
        { 10, get_label_text("MASK_RIOT") },
        { 11, get_label_text("MASK_ONIFULL") },
        { 12, get_label_text("MASK_HOCKEY") },

    }, 0, function(value)
        CasinoHeistVars.Config.eMasksChosen = value
    end)


menu.divider(Casino_Heist_Mission_Config, "Subterfuge Approach Only")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_OUTFIT_IN"), {}, "",
    {
        { 0, Labels.None },
        { 1, get_label_text("CH_OUTFIT_0") }, -- BUGSTAR
        { 2, get_label_text("CH_OUTFIT_1") }, -- MECHANIC
        { 3, get_label_text("CH_OUTFIT_2") }, -- GRUPPE_SECHS
        { 4, get_label_text("CH_OUTFIT_3") }, -- CELEBRITY
    }, 1, function(value)
        CasinoHeistVars.Config.eSubterfugeOutfitsIn = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_OUTFIT_OUT"), {}, "",
    {
        { 5, Labels.None },
        { 6, get_label_text("CH_OUTFIT_4") }, -- SWAT
        { 7, get_label_text("CH_OUTFIT_5") }, -- FIREMAN
        { 8, get_label_text("CH_OUTFIT_6") }, -- HIGH_ROLLER
    }, 6, function(value)
        CasinoHeistVars.Config.eSubterfugeOutfitsOut = value
    end)
menu.toggle(Casino_Heist_Mission_Config, "Office Infested", {}, "", function(toggle)
    CasinoHeistVars.Config.bOfficeInfested = toggle
end)


menu.divider(Casino_Heist_Mission_Config, "Stealth & Direct Approach Only")
menu.toggle(Casino_Heist_Mission_Config, "Rappel Gear", {}, "", function(toggle)
    CasinoHeistVars.Config.bRappelGearAcquired = toggle
end, true)

--#endregion



menu.list_select(Casino_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    CasinoHeistVars.eEliteChallenge = value
end)

local Casino_Heist_CashTake = rs.menu_slider(Casino_Heist, "拿取财物收入", { "CasinoHeistTotalTake" }, Labels.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        CasinoHeistVars.iCashTotalTake = value
    end)


menu.toggle(Casino_Heist, "重置前置任务面板", {}, "不重置则可以直接重复进行终章", function(toggle)
    CasinoHeistVars.bResetPrepStats = toggle
end)

menu.list_action(Casino_Heist, "直接完成 赌场抢劫", {}, "", Tables.CasinoHeistApproach, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if CasinoHeistVars.iCashTotalTake ~= -1 then
        LOCAL_SET_INT(script, Locals.MissionController.iCashGrabTotalTake, CasinoHeistVars.iCashTotalTake)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, CasinoHeistVars.eEliteChallenge)

    GLOBAL_SET_INT(CasinoHeistMissionConfigData.eChosenApproachType, value)

    if CasinoHeistVars.bResetPrepStats then
        GLOBAL_SET_INT(FMMC_STRUCT.iRootContentIDHash, Tables.CasinoHeistFinal[value])
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)




-- menu.divider(Heist_Mission, "")

--------------------------------
--    Cayo Perico Heist
--------------------------------

local Island_Heist <const> = menu.list(Heist_Mission, get_label_text("IH_TITLE"), {}, "")

local IslandHeistVars = {
    eEliteChallenge = 0,
    iTargetValue = -1,
    bResetPrepStats = false,
}

-- menu.divider(Island_Heist, Labels.PREP)

menu.action(Island_Heist, "直接完成 佩里科岛抢劫 前置任务", {}, "", function()
    local script = "fm_content_island_heist"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.IslandHeist.iGenericBitset, Locals.IslandHeist.eEndReason)
end)


menu.divider(Island_Heist, Labels.FINALE)

menu.list_select(Island_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    IslandHeistVars.eEliteChallenge = value
end)

rs.menu_slider(Island_Heist, "主要目标价值", { "IslandHeistTargetValue" }, Labels.O_W_F_INS_FIN,
    -1, 2550000, -1, 50000, function(value)
        IslandHeistVars.iTargetValue = value
    end)


menu.toggle(Island_Heist, "重置前置任务面板", {}, "不重置则可以直接重复进行终章", function(toggle)
    IslandHeistVars.bResetPrepStats = toggle
end)

menu.action(Island_Heist, "直接完成 佩里科岛抢劫", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if IslandHeistVars.iTargetValue ~= -1 then
        Tunables.SetIntList("IslandHeistPrimaryTargetValue", IslandHeistVars.iTargetValue)
    end

    if IslandHeistVars.bResetPrepStats then
        GLOBAL_SET_INT(FMMC_STRUCT.iRootContentIDHash, 1601836271) -- H4_STEALTH_3
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
end)



--------------------------------
--    Auto Shop Robbery
--------------------------------

local Tuner_Robbery <const> = menu.list(Heist_Mission, get_label_text("TUN_ROB_CONTR"), {}, "")

local TunerRobberyVars = {
    iMissionVariation = -1,
    iCashReward = -1,
}

menu.divider(Tuner_Robbery, Labels.PREP)

menu.list_select(Tuner_Robbery, Labels.SelectMission, {}, "",
    Tables.TunerRobbery, -1, function(value)
        TunerRobberyVars.iMissionVariation = value
    end)

menu.textslider(Tuner_Robbery, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 271 -- FMMC_TYPE_TUNER_ROBBERY
    local iMissionVariation = TunerRobberyVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Tuner_Robbery, "直接完成 改装铺抢劫 前置任务", {}, "", function()
    local script = "fm_content_tuner_robbery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.TunerRobbery.iGenericBitset, Locals.TunerRobbery.eEndReason)
end)


menu.divider(Tuner_Robbery, Labels.FINALE)

menu.list_action(Tuner_Robbery, "启动差事: 改装铺抢劫", {}, "",
    Tables.TunerRobberyFinal, function(value)
        if STAT_GET_INT(ADD_MP_INDEX("AUTO_SHOP_OWNED")) == 0 then
            util.toast("你需要拥有改装铺")
            return
        end
        if players.get_org_type(players.user()) == -1 then
            util.toast("你需要注册为老大")
            return
        end
        if INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 285953 then
            util.toast("你需要在改装铺里面")
            return
        end

        local Data = {
            iRootContentID = value,
            iMissionType = 274,      -- FMMC_TYPE_TUNER_ROBBERY_FINALE
            iMissionEnteryType = 69, -- ciMISSION_ENTERY_TYPE_TUNER_JOB_BOARD
        }

        LAUNCH_MISSION(Data)
        util.toast("请稍等...")
    end)

rs.menu_slider(Tuner_Robbery, "奖励收入", { "TunerRobberyCashReward" },
    Labels.O_W_F_INS_FIN, -1, 2000000, -1, 50000, function(value)
        TunerRobberyVars.iCashReward = value
    end)

menu.action(Tuner_Robbery, "直接完成 改装铺抢劫", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if TunerRobberyVars.iCashReward ~= -1 then
        Tunables.SetIntList("TunerRobberyLeaderCashReward", TunerRobberyVars.iCashReward)
    end
    INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
end)



------------------------------------
--    The Contract: Dr. Dre
------------------------------------

local Fixer_VIP <const> = menu.list(Heist_Mission, get_label_text("FAPP_THE_CONTRACT_DR_DRE"), {}, "")

local FixerVipVars = {
    iMissionVariation = -1,
    iCashReward = -1,
}

menu.divider(Fixer_VIP, Labels.PREP)

menu.list_select(Fixer_VIP, Labels.SelectMission, {}, "",
    Tables.FixerVIP, -1, function(value)
        FixerVipVars.iMissionVariation = value
    end)

menu.textslider(Fixer_VIP, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 264 -- FMMC_TYPE_FIXER_VIP
    local iMissionVariation = FixerVipVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Fixer_VIP, "直接完成 合约德瑞博士 前置任务", {}, "", function()
    local script = "fm_content_vip_contract_1"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script, Locals.VipContract.iGenericBitset, Locals.VipContract.eEndReason)
end)


menu.divider(Fixer_VIP, Labels.FINALE)

menu.action(Fixer_VIP, "启动差事: 别惹德瑞", {}, "", function()
    if STAT_GET_INT(ADD_MP_INDEX("FIXER_HQ_OWNED")) == 0 then
        util.toast("你需要拥有事务所")
        return
    end
    if players.get_org_type(players.user()) == -1 then
        util.toast("你需要注册为老大")
        return
    end

    local Data = {
        iRootContentID = 1645353926,
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 81, -- ciMISSION_ENTERY_TYPE_FIXER_WORLD_TRIGGER
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)

rs.menu_slider(Fixer_VIP, "奖励收入", { "FixerVIPCashReward" }, Labels.O_W_F_INS_FIN,
    -1, 2000000, -1, 50000, function(value)
        FixerVipVars.iCashReward = value
    end)

menu.action(Fixer_VIP, "直接完成 别惹德瑞", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if FixerVipVars.iCashReward ~= -1 then
        Tunables.SetInt("FIXER_FINALE_LEADER_CASH_REWARD", FixerVipVars.iCashReward)
    end
    INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
end)



----------------------------------------
--    The Cluckin' Bell Farm Raid
----------------------------------------

local Chicken_Factory_Raid <const> = menu.list(Heist_Mission, get_label_text("DLCC_CFRAI"), {}, "")

menu.list_action(Chicken_Factory_Raid, "启动差事: 犯罪现场", {}, "", {
    { 13546844, "潜行" },
    { 2107866924, "强攻" },
}, function(value)
    local Data = {
        iRootContentID = value,
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 32, -- ciMISSION_ENTERY_TYPE_V2_CORONA
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)

local FarmRaidCashReward = rs.menu_slider(Chicken_Factory_Raid, "奖励收入", { "FarmRaidCashReward" }, Labels.O_W_F_INS_FIN,
    -1, 1000000, -1, 50000, function(value) end)

menu.action(Chicken_Factory_Raid, "直接完成 当当钟农场突袭", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local cash_reward = menu.get_value(FarmRaidCashReward)
    if cash_reward ~= -1 then
        Tunables.SetInt("-2000196818", cash_reward)
    end
    INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
end)








menu.divider(Menu_Root, "")

menu.toggle_loop(Menu_Root, "移除任务冷却时间", {}, "", function()
    Tunables.SetIntList("COOLDOWNS", 0)
end, function()
    Tunables.RestoreIntDefaults("COOLDOWNS")
end)
menu.action(Menu_Root, "移除任务冷却时间", {}, "切换战局会失效", function()
    Tunables.SetIntList("COOLDOWNS", 0)
end)

menu.toggle_loop(Menu_Root, "移除NPC分红", {}, "", function()
    Tunables.SetIntList("NpcCut", 0)
    Tunables.SetFloatList("NpcCut", 0)
end, function()
    Tunables.RestoreIntDefaults("NpcCut")
    Tunables.RestoreFloatDefaults("NpcCut")
end)
menu.action(Menu_Root, "移除NPC分红", {}, "切换战局会失效", function()
    Tunables.SetIntList("NpcCut", 0)
    Tunables.SetFloatList("NpcCut", 0)
end)









menu.divider(Menu_Root, "DEBUG")

----------------------------------------
--    Instant Finish Test
----------------------------------------

local Instant_Finish_Test <const> = menu.list(Menu_Root, "Instant Finish Test", {}, "")


menu.divider(Instant_Finish_Test, "fm_content Mission")

local TestScript1 = "fm_content_auto_shop_delivery"

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

    LOCAL_SET_BIT(script, 1543 + 2 + 5 + 1 + 0 * 3 + 1 + 0, 4)
    INSTANT_FINISH_FM_CONTENT_MISSION(script, 1492, 1543 + 83)

    LOCAL_SET_INT(script, 1543 + 82, 3)
end)



menu.divider(Instant_Finish_Test, "gb Mission")

local TestScript2 = "gb_vehicle_export"

menu.action(Instant_Finish_Test, "SET_SERVER_BIT", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, 834 + 435 + 1, 19) -- SET_SERVER_BIT
    -- LOCAL_SET_BITS(script, 476, 0, 1, 2, 4, 5, 6) -- SET_LOCAL_BIT5
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 459, 14) -- SET_MODE_STATE(eMODESTATE_END)
end)

menu.action(Instant_Finish_Test, "Set ModeState", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 459, 12)
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
menu.action(Instant_Finish_Test, "Test Complete Vehicle Export Sell", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- SET_EXPORT_ENTITY_BIT(iExportEntity,
    -- eEXPORTENTITYBITSET_DELIVERED, eEXPORTENTITYBITSET_FADED_OUT_FOR_DELIVERY, eEXPORTENTITYBITSET_DELIVERED_BY_KEY_ORGINISATION
    -- LOCAL_SET_BITS(script, 834 + 48 + 1 + 0 * 2 + 1 + 0, 6, 16, 18)

    -- serverBD.eDropOffDeliveredTo[iExportEntity]
    LOCAL_SET_INT(script, 834 + 626 + 1 + 0, 10)


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


menu.action(Freemode_Test, "Fill Bunker Supplies", {}, "", function()
    GLOBAL_SET_INT(1662873 + 6, 1)
end)
menu.action(Freemode_Test, "Fill Acid Lab Supplies", {}, "", function()
    GLOBAL_SET_INT(1662873 + 7, 1)
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




----------------------------------------
--    Instant Finish Job Mission
----------------------------------------

local Finish_Job_Mission_Test <const> = menu.list(Menu_Root, "Instant Finish Job Mission Test", {}, "")

menu.toggle_loop(Finish_Job_Mission_Test, "Show g_FMMC_STRUCT Info", {}, "", function()
    local iRootContentID = GLOBAL_GET_INT(4718592 + 126144)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)

    local text = string.format(
        "MissionName: %s, iRootContentIDHash: %s, iArrayPos: %s\niMissionType: %s, iMissionSubType: %s, tl23NextContentID[0]: %s\niMinNumberOfTeams: %s, iMaxNumberOfTeams: %s, iNumberOfTeams: %s\niMinNumParticipants: %s, iNumParticipants: %s\niNumPlayersPerTeam[]: %s, %s, %s, %s\niCriticalMinimumForTeam[]: %s, %s, %s, %s\niCriticalMinimumForRole[]: %s, %s, %s, %s\niMissionEndType: %s, iTargetScore: %s, iMissionTargetScore[]: %s, %s, %s, %s\niMyTeam: %s, iTeamChosen: %s",
        GLOBAL_GET_STRING(4718592 + 126151),
        iRootContentID,
        iArrayPos,

        GLOBAL_GET_INT(4718592 + 0),
        GLOBAL_GET_INT(4718592 + 2),
        GLOBAL_GET_STRING(4718592 + 126459 + 1 + 0 * 6),

        GLOBAL_GET_INT(4718592 + 3254),
        GLOBAL_GET_INT(4718592 + 3253),
        GLOBAL_GET_INT(4718592 + 3252),

        GLOBAL_GET_INT(4718592 + 3249),
        GLOBAL_GET_INT(4718592 + 3248),

        GLOBAL_GET_INT(4718592 + 3255 + 1),
        GLOBAL_GET_INT(4718592 + 3255 + 2),
        GLOBAL_GET_INT(4718592 + 3255 + 3),
        GLOBAL_GET_INT(4718592 + 3255 + 4),

        GLOBAL_GET_INT(4718592 + 176675 + 1),
        GLOBAL_GET_INT(4718592 + 176675 + 2),
        GLOBAL_GET_INT(4718592 + 176675 + 3),
        GLOBAL_GET_INT(4718592 + 176675 + 4),

        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 0),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 1),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 2),
        GLOBAL_GET_INT(4718592 + 176680 + 1 + 0 + 1 + 3),

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



menu.toggle_loop(Finish_Job_Mission_Test, "Set JoinedPlayers = 2", {}, "", function()
    -- Global_2685249.f_1.f_2805;
    -- g_TransitionSessionNonResetVars.sTransVars.iNumberOfJoinedPlayers
    GLOBAL_SET_INT(2685249 + 1 + 2805, 2)
end, function()
    GLOBAL_SET_INT(2685249 + 1 + 2805, 1)
end)
menu.click_slider(Finish_Job_Mission_Test, "iTeam", {}, "", 0, 3, 0, 1, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- SET_BIT(iLocalBoolCheck11, LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION)
    LOCAL_SET_BIT(script, 15149, 7)

    -- Local_19728.f_1004[0]
    -- MC_serverBD.iNumberOfPlayingPlayers[iteam]

    -- Local_19728.f_1777
    -- MC_serverBD.iTotalNumStartingPlayers

    -- LOCAL_SET_INT(script, 19728 + 1004 + 1 + 0, 1)
    -- LOCAL_SET_INT(script, 19728 + 1004 + 1 + 1, 1)

    -- iMyTeam = MC_playerBD[ iLocalPart ].iTeam
    -- Local_31603[bLocal_3229 /*292*/].f_1;
    LOCAL_SET_INT(script, 31603 + 1 + 1, value)
end)

menu.toggle_loop(Finish_Job_Mission_Test, "Show fmmc_launcher Info", {}, "", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- sLaunchMissionDetails.iMissionVariation Local_19331.f_34
    -- sLaunchMissionDetails.iMinPlayers Local_19331.f_15

    local text = string.format(
        "iMissionVariation: %s, iMinPlayers: %s",
        LOCAL_GET_INT(script, 19331 + 34),
        LOCAL_GET_INT(script, 19331 + 15)
    )

    draw_text(text)
end)



menu.divider(Finish_Job_Mission_Test, "fm_mission_controller")

menu.toggle_loop(Finish_Job_Mission_Test, "Show Global Info", {}, "", function()
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

menu.toggle_loop(Finish_Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- GET_HEIST_AWARD_COMPLETE_BITSET()
    -- GET_HEIST_AWARD_BOOL_HASH(20) -- 1639364235 MPPLY_AWD_COMPLET_HEIST_1STPER
    -- util.toast(STAT_GET_INT("MPPLY_HEIST_1STPERSON_PROG"))

    -- MC_playerBD[iPartToUse].iObjectiveTypeCompleted LOCAL_GET_INT(script, 31603 + 1 + iPartToUse * 292 + 120)
    -- MC_playerBD[iPartToUse].iCurrentLoc LOCAL_GET_INT(script, 31603 + 1 + iPartToUse * 292 + 3)
    -- iNextObjective LOCAL_GET_INT(script, 19728 + 1057 + 1 + 0)

    local iPartToUse = LOCAL_GET_INT(script, 3228)
    local iPartToUse2 = LOCAL_GET_INT(script, 3229)
    local text = string.format(
        "iPartToUse: %s, iPartToUse2: %s\niClientLogicStage: %s, iServerGameState: %s\niCurrentHighestPriority[0]: %s, iNextObjective[0]: %s, iMaxObjectives: %s, iNextMission: %s\niCurrentHeistMissionIndex: %s",
        iPartToUse, iPartToUse2,

        LOCAL_GET_INT(script, 31603 + 1 + iPartToUse * 292),
        LOCAL_GET_INT(script, 19728 + 0),

        LOCAL_GET_INT(script, 28347 + 1),        -- MC_serverBD_4.iCurrentHighestPriority
        LOCAL_GET_INT(script, 19728 + 1057 + 1), -- MC_serverBD.iNextObjective
        LOCAL_GET_INT(script, 19728 + 1565),     -- MC_serverBD.iMaxObjectives
        LOCAL_GET_INT(script, 19728 + 1062),     -- MC_serverBD.iNextMission

        LOCAL_GET_INT(script, 1639)
    )

    draw_text(text)
end)

menu.action(Finish_Job_Mission_Test, "Go To Next Objective", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, Locals.MissionController.iServerBitSet1, 17) -- SBBOOL1_PROGRESS_OBJECTIVE_FOR_TEAM_0
end)

menu.action(Finish_Job_Mission_Test, "Test Finish", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- LOCAL_SET_INT(script, 19728 + 1062, -1)
    LOCAL_SET_INT(script, 28347 + 1, 9999)
    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT(script, Locals.MissionController.iTeamScore + i, 999999)
    end
end)


menu.action(Finish_Job_Mission_Test, "Toast Info", {}, "", function()
    local text = ""
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(4718592 + 126459 + 1 + i * 6)
        if tl23NextContentID ~= "" then
            text = text ..
                tostring(i) .. "    " .. tl23NextContentID .. "    " .. tostring(util.joaat(tl23NextContentID)) .. "\n"
        end
    end

    util.toast(text, TOAST_ALL)
end)


menu.divider(Finish_Job_Mission_Test, "fm_mission_controller_2020")

menu.click_slider(Finish_Job_Mission_Test, "iCashReward", { "FMMC_iCashReward" }, "",
    0, 1000000, 0, 10000, function(value)
        local script = "fm_mission_controller_2020"
        if not IS_SCRIPT_RUNNING(script) then
            return
        end

        local iLocalPart = LOCAL_GET_INT(script, 18938)
        util.toast(iLocalPart)
        LOCAL_SET_INT(script, 60496 + 1 + iLocalPart * 261 + 91, value)
    end)



menu.divider(Finish_Job_Mission_Test, "")

menu.action(Finish_Job_Mission_Test, "Get Content Info", { "getContentInfo" }, "", function()
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
        util.toast(text, TOAST_ALL)
    end

    -- local iRootContentID = util.joaat(NETWORK.UGC_GET_ROOT_CONTENT_ID(0))
    -- local iRootContentID = 2064133602
    local iRootContentID = GLOBAL_GET_INT(4718592 + 126144)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)
    util.toast(string.format("iRootContentID: %s, iArrayPos: %s", iRootContentID, iArrayPos), TOAST_ALL)
end)








----------------------------------------
--    Job Mission Test
----------------------------------------

local Job_Mission_Test <const> = menu.list(Menu_Root, "Job Mission Test", {}, "")


local function GET_NET_TIMER_DIFFERENCE_WITH_CURRENT_TIME(timer)
    if NETWORK.NETWORK_IS_GAME_IN_PROGRESS() then
        return NETWORK.GET_TIME_DIFFERENCE(NETWORK.GET_NETWORK_TIME(), timer)
    end
    return NETWORK.GET_TIME_DIFFERENCE(MISC.GET_GAME_TIMER(), timer)
end

local function format_milliseconds(ms)
    local total_seconds = math.floor(ms / 1000)
    local hours = math.floor(total_seconds / 3600)
    local minutes = math.floor((total_seconds % 3600) / 60)
    local seconds = total_seconds % 60
    local formatted = string.format("%02d:%02d:%02d", hours, minutes, seconds)

    return formatted
end


local function h4_get_mission_time()
    local mission_time = 0

    if globals.get_int(2684312 + 43 + 55) or globals.get_int(2684312 + 43 + 56) then
        mission_time = locals.get_int("fm_mission_controller_2020", 51882 + 1517 + 29)
        if locals.get_int("fm_mission_controller_2020", 48513 + 1490) <= 0 then
            mission_time = mission_time + get_net_difference(locals.get_int("fm_mission_controller_2020", 48513 + 1487))
        end
    else
        mission_time = locals.get_int("fm_mission_controller_2020", 48513 + 1490)
        if mission_time <= 0 then
            mission_time = get_net_difference(locals.get_int("fm_mission_controller_2020", 48513 + 1487))
        end
    end

    mission_time = mission_time + 10000

    return mission_time
end

local function get_mission_time_2020()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iTotalMissionTime = 0
    -- bPassedFirstMission or bPassedFirstStrandNoReset
    if GLOBAL_GET_INT(2684312 + 43 + 55) or GLOBAL_GET_INT(2684312 + 43 + 56) then
        iTotalMissionTime = LOCAL_GET_INT(script, 51882 + 1517 + 29) -- MC_serverBD_1.sMissionContinuityVars.iTotalMissionTime

        if LOCAL_GET_INT(script, 48513 + 1490) <= 0 then
            iTotalMissionTime = iTotalMissionTime +
                GET_NET_TIMER_DIFFERENCE_WITH_CURRENT_TIME(LOCAL_GET_INT(script, 48513 + 1487)) -- MC_serverBD.tdMissionLengthTimer
        end
    else
        iTotalMissionTime = LOCAL_GET_INT(script, 48513 + 1490) -- MC_serverBD.iTotalMissionEndTime

        if iTotalMissionTime < 0 then
            iTotalMissionTime = GET_NET_TIMER_DIFFERENCE_WITH_CURRENT_TIME(LOCAL_GET_INT(script, 48513 + 1487)) -- MC_serverBD.tdMissionLengthTimer
        end
    end

    iTotalMissionEndTime = iTotalMissionEndTime + 10000

    local text = format_milliseconds(iTotalMissionEndTime)
    draw_text(text)
end


menu.toggle_loop(Job_Mission_Test, "Show Mission Time", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iTotalMissionEndTime = 0
    iTotalMissionEndTime = LOCAL_GET_INT(script, 19728 + 987) -- MC_serverBD.iTotalMissionEndTime

    if iTotalMissionEndTime <= 0 then
        iTotalMissionEndTime = GET_NET_TIMER_DIFFERENCE_WITH_CURRENT_TIME(LOCAL_GET_INT(script, 19728 + 985)) -- MC_serverBD.tdMissionLengthTimer
    end
    iTotalMissionEndTime = iTotalMissionEndTime + 10000

    -- bPassedFirstMission or bPassedFirstStrandNoReset
    -- if GLOBAL_GET_INT(2684312 + 43 + 55) or GLOBAL_GET_INT(2684312 + 43 + 56) then
    --     iTotalMissionEndTime = GLOBAL_GET_INT(2685249 + 6465) -- g_TransitionSessionNonResetVars.iTotalMissionEndTime
    -- end

    -- local text = string.format(
    --     "iTotalMissionEndTime: %s, format time: %s\niTotalMissionEndTime: %s, tdMissionLengthTimer: %s",
    --     iTotalMissionEndTime,
    --     format_milliseconds(iTotalMissionEndTime),
    --     LOCAL_GET_INT(script, 19728 + 987),
    --     LOCAL_GET_INT(script, 19728 + 985)
    -- )
    local text = "Mission Time: " .. format_milliseconds(iTotalMissionEndTime)
    draw_text(text)
end)


menu.toggle_loop(Job_Mission_Test, "Show Info GLOBAL", {}, "", function()
    local text = string.format(
        "g_iRoundsCombinedTime: %s",
        GLOBAL_GET_INT(1836217)
    )

    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end)

menu.toggle_loop(Job_Mission_Test, "Show Info", {}, "fm_mission_controller_2020", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    local text = string.format(
        "iCoopMissionTargetScore: %s, iMissionTargetScore: %s\niTeamScore: %s, %s, %s, %s, iTeamFailRequests: %s\niMissionEndType: %s\ng_iRoundsCombinedTime: %s",
        GLOBAL_GET_INT(4718592 + 107203),
        GLOBAL_GET_INT(4718592 + 3318 + 1 + 59),
        LOCAL_GET_INT(script, 48513 + 1765 + 1 + 0),
        LOCAL_GET_INT(script, 48513 + 1765 + 1 + 1),
        LOCAL_GET_INT(script, 48513 + 1765 + 1 + 2),
        LOCAL_GET_INT(script, 48513 + 1765 + 1 + 3),

        LOCAL_GET_INT(script, 48513 + 3220 + 1 + 0),
        GLOBAL_GET_INT(4718592 + 3274),
        GLOBAL_GET_INT(1836217)
    )

    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end)


menu.toggle_loop(Job_Mission_Test, "Max Reward", {}, "", function(toggle)
    if not IS_SCRIPT_RUNNING("fm_mission_controller") and not IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
        return
    end

    for i = 0, 8 do
        GLOBAL_SET_INT(262145 + Tunables["CONTACT_MISSION_TIME_PERIOD_1"] + i, 0)
    end
    for i = 0, 9 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_CASH_TIME_PERIOD_1_PERCENTAGE"] + i, 2.0)
    end
    for i = 0, 3 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_CASH_PLAYER_MULTIPLIER_1"] + i, 1.3)
    end
    for i = 0, 2 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_CASH_DIFFICULTY_MULTIPLIER_EASY"] + i, 1.5)
    end
    for i = 0, 8 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_FAIL_CASH_TIME_PERIOD_2_DIVIDER"] + i, 3.5)
    end
    for i = 0, 9 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_RP_TIME_PERIOD_1_PERCENTAGE"] + i, 2.0)
    end
    for i = 0, 2 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_RP_DIFFICULTY_MULTIPLIER_EASY"] + i, 1.5)
    end
    for i = 0, 8 do
        GLOBAL_SET_FLOAT(262145 + Tunables["CONTACT_MISSION_FAIL_RP_TIME_PERIOD_2_DIVIDER"] + i, 2.5)
    end
end)
menu.action(Job_Mission_Test, "Instant Finish Job Missions", {}, "", function()
    if IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
        -- menu.trigger_commands("scripthost")
        INSTANT_FINISH_FM_MISSION_CONTROLLER_2020()
    elseif IS_SCRIPT_RUNNING("fm_mission_controller") then
        -- menu.trigger_commands("scripthost")
        INSTANT_FINISH_FM_MISSION_CONTROLLER()
    end
end)

menu.divider(Job_Mission_Test, "")


menu.toggle_loop(Job_Mission_Test, "Show Info 2020", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local text = string.format(
        "iTotalMissionTime: %s, iTotalMissionEndTime: %s\nNetwork Time: %s",
        LOCAL_GET_INT(script, 51882 + 1517 + 29),
        LOCAL_GET_INT(script, 48513 + 1490),
        NETWORK.GET_NETWORK_TIME()
    )

    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end)
menu.toggle_loop(Job_Mission_Test, "Show Info", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local tdMissionLengthTimer = LOCAL_GET_INT(script, 19728 + 985)
    local network_time = NETWORK.GET_NETWORK_TIME()

    local text = string.format(
        "iTotalMissionTime: %s, tdMissionLengthTimer: %s\nNetwork Time: %s, Time Difference: %s",
        LOCAL_GET_INT(script, 19728 + 987),
        tdMissionLengthTimer,
        network_time,
        NETWORK.GET_TIME_DIFFERENCE(network_time, tdMissionLengthTimer)
    )

    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end)


menu.action(Job_Mission_Test, "Set Mission Start Time", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- local tdMissionLengthTimer = LOCAL_GET_INT(script, 19728 + 985)
    LOCAL_SET_INT(script, 19728 + 985, 1000000)
end)
menu.action(Job_Mission_Test, "Set Mission Start Time 2020", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 51882 + 1517 + 29, 100000000)
    LOCAL_SET_INT(script, 48513 + 1490, 100000000)
end)



menu.divider(Job_Mission_Test, "")









local Details = memory.alloc(16 * 8)
menu.toggle_loop(Menu_Root, "Get EVENT_NETWORK_SCRIPT_EVENT", {}, "", function()
    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        local eventType = SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex)
        --if eventType == 174 then -- EVENT_NETWORK_SCRIPT_EVENT
        if SCRIPT.GET_EVENT_DATA(1, eventIndex, Details, 16) then
            local eventHash = memory.read_int(Details)

            local text = "SCRIPT_EVENT_PLAYER_DELIVERED_VEHICLE_WH\n"
            if eventHash == 1024992419 then
                text = text .. "Event Hash: " .. eventHash

                for i = 1, 9 do
                    text = text .. string.format(
                        "\nVar%s: %s",
                        i,
                        memory.read_int(Details + i * 8)
                    )
                end

                -- draw_text(text)
                util.toast(text, TOAST_ALL)
                util.toast(eventType, TOAST_ALL)
            end
        end
        -- end
    end
end)

local Details2 = memory.alloc(8)
menu.toggle_loop(Menu_Root, "Get Script Event", {}, "", function()
    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        if SCRIPT.GET_EVENT_DATA(1, eventIndex, Details2, 1) then
            local eventHash = memory.read_int(Details2)
            local eventType = SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex)

            local text = string.format(
                "Event Hash: %s\nEvent Type: %s",
                eventHash,
                eventType
            )
            util.toast(text, TOAST_ALL)
        end
    end
end)
