--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.9.16) ~  Much Love, Ferib 

]] --

local v0 = {}
local v1 = ShellInterface.sendMessage
ShellInterface.sendMessage = function(v448, v449, v450)
    v450.senderUserId = tostring(Game:getPlatformUserId())
    v1(v448, v449, json.encode(v450))
end
v0.init = function(v452)
    if (Platform.isWindow() and CGame.requireKeyboardEvent) then
        CGame.Instance():requireKeyboardEvent()
        CEvents.KeyUpEvent:registerCallBack(v452.onKeyUp)
        CEvents.KeyUpEvent:registerCallBack(v452.onEventHold)
    end
end
v0.OnUpdate = function(v453)
    local v454 = PlayerManager:getClientPlayer()
    if (v454 == nil) then
        return
    end
    local v455 = v454.Player:getPosition()
    MsgSender.sendTopTips(
        1,
        string.format(
            "XYZ: %s / %s / %s",
            tostring(math.floor(v455.x)),
            tostring(math.floor(v455.y)),
            tostring(math.floor(v455.z))
        )
    )
end
v0.onKeyUp = function(v456, v457)
    A = not A
    if (v456 == "T") then
        GUIGMControlPanel:show()
        UIHelper.showToast("^FF00EEPanel Open")
        if A then
            GUIGMControlPanel:hide()
            UIHelper.showToast("^FF00EEPanel Closed")
        end
        return
    end
    if (v456 == "R") then
        PlayerManager:getClientPlayer().Player:startParachute()
        return
    end
    if (v456 == "F") then
        local v3679 = VectorUtil.newVector3(0, 1.35, 0)
        local v3680 = PlayerManager:getClientPlayer()
        v3680.Player:setAllowFlying(true)
        v3680.Player:setFlying(true)
        v3680.Player:moveEntity(v3679)
        PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(150000)
        return
    end
    local v458 = tonumber(v456)
    return true
end
Game.init = function(v459)
    GMHelper:jeba()
    GMHelper:noway()
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
    ClientHelper.putBoolPrefs("IsCreatureBloodBar", true)
    ClientHelper.putFloatPrefs("PlayerBobbingScale", 0)
    ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 1)
    ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 1.1)
    ClientHelper.putFloatPrefs("PoleControlMaxDistance", 62)
    v459.CGame = CGame.Instance()
    v459.GameType = CGame.Instance():getGameType()
    v459.Blockman = Blockman.Instance()
    v459.World = Blockman.Instance():getWorld()
    v459.LowerDevice = CGame.Instance():isLowerDevice()
    EngineWorld:setWorld(v459.World)
end
Game.isOpenGM = function(v465)
    return isClient or TableUtil.include(AdminIds, tostring(Game:getPlatformUserId()))
end
local v8 = {}
GMHelper = {}
GMSetting = {}
local function v9(v466)
    if isClient then
        return true
    end
    return TableUtil.include(AdminIds, tostring(v466))
end
GMSetting.addTab = function(v467, v468, v469)
    for v1999, v2000 in pairs(v8) do
        if (v2000.name == v468) then
            v2000.items = {}
            return
        end
    end
    v469 = v469 or (#v8 + 1)
    table.insert(v8, v469, {name = v468, items = {}})
end
GMSetting.addItem = function(v470, v471, v472, v473, ...)
    local v474
    for v2001, v2002 in pairs(v8) do
        if (v2002.name == v471) then
            v474 = v2002
        end
    end
    if not v474 then
        GMSetting:addTab(v471)
        GMSetting:addItem(v471, v472, v473, ...)
        return
    end
    table.insert(v474.items, {name = v472, func = v473, params = {...}})
end
GMSetting.getSettings = function(v475)
    return v8
end
GMSetting:addTab("^800080Hack", 1)
GMSetting:addItem("^800080Hack", "^3333CCHead Text", "HeadText")
GMSetting:addItem("^800080Hack", "^3333CCY+", "inTheAirCheat")
GMSetting:addItem("^800080Hack", "^3333CCY+(Set)", "AdvancedUp")
GMSetting:addItem("^800080Hack", "^3333CCX+(Set)", "AdvancedIn")
GMSetting:addItem("^800080Hack", "^3333CCZ+(Set)", "AdvancedOn")
GMSetting:addItem("^800080Hack", "^3333CCXYZ(Set)", "AdvancedDirect")
GMSetting:addItem("^800080Hack", "^3333CCX+", "GoTO10Blocks")
GMSetting:addItem("^800080Hack", "^3333CCX-", "GoTO10BlocksDown")
GMSetting:addItem("^800080Hack", "^3333CCFly", "MyLoveFly")
GMSetting:addItem("^800080Hack", "^3333CCReach", "Reach")
GMSetting:addItem("^800080Hack", "^3333CCViewBobbing", "ViewBobbing")
GMSetting:addItem("^800080Hack", "^3333CCBlockmanCollision", "BlockmanCollision")
GMSetting:addItem("^800080Hack", "^3333CCFog", "Fog")
GMSetting:addItem("^800080Hack", "^3333CCWWE_Camera", "WWE_Camera")
GMSetting:addItem("^800080Hack", "^3333CCArmSpeed", "ArmSpeed")
GMSetting:addItem("^800080Hack", "^3333CCBowSpeed", "BowSpeed", 1000)
GMSetting:addItem("^800080Hack", "^3333CCBoy", "changePlayerActor", 1)
GMSetting:addItem("^800080Hack", "^3333CCGirl", "changePlayerActor", 2)
GMSetting:addItem("^800080Hack", "^3333CCAttackCD", "BanClickCD")
GMSetting:addItem("^800080Hack", "^3333CCShowAllCobtrol", "ShowAllCobtrolXD")
GMSetting:addItem("^800080Hack", "^3333CCJailBreakBypass", "JailBreakBypass")
GMSetting:addItem("^800080Hack", "^3333CCBreakSpeed", "FustBreakBlockMode")
GMSetting:addItem("^800080Hack", "^3333CCFreecam", "Freecam")
GMSetting:addItem("^800080Hack", "^3333CCNoclip", "Noclip")
GMSetting:addItem("^800080Hack", "^3333CCRespawn", "RespawnTool")
GMSetting:addItem("^800080Hack", "^3333CCChangeNick", "ChangeNick")
GMSetting:addItem("^800080Hack", "^3333CCDevFly", "DevFlyI")
GMSetting:addItem("^800080Hack", "^3333CCLongJump", "LongJump")
GMSetting:addItem("^800080Hack", "^3333CC/tp", "tpPos")
GMSetting:addItem("^800080Hack", "^3333CCJumpHeight", "JumpHeight")
GMSetting:addItem("^800080Hack", "^3333CCHideArm", "HideHoldItem")
GMSetting:addItem("^800080Hack", "^3333CCChangeScale", "changeScale")
GMSetting:addItem("^800080Hack", "^3333CCWaterPush", "WaterPush")
GMSetting:addItem("^800080Hack", "^3333CCSharpFly", "SharpFly")
GMSetting:addItem("^800080Hack", "^3333CCBlockOFF", "BlockOFF")
GMSetting:addItem("^800080Hack", "^3333CCBlockON", "BlockON")
GMSetting:addItem("^800080Hack", "^3333CCSpeed", "SpeedManager")
GMSetting:addItem("^800080Hack", "^3333CCSpeedUp", "SpeedUp")
GMSetting:addItem("^800080Hack", "^3333CCXRayManagerON", "XRayManagerON")
GMSetting:addItem("^800080Hack", "^3333CCXRayManagerOFF", "XRayManagerOFF")
GMSetting:addItem("^800080Hack", "^3333CCTeleportByUID", "TeleportByUID")
GMSetting:addItem("^800080Hack", "^3333CCSettingLongjump", "SettingLongjump")
GMSetting:addItem("^800080Hack", "^3333CCDevNoClip", "DevnoClip")
GMSetting:addItem("^800080Hack", "^3333CCStepHeight", "StepHeight")
GMSetting:addItem("^800080Hack", "^3333CCHideArmor", "SetHideAndShowArmor")
GMSetting:addItem("^800080Hack", "^3333CCChangeActorForMe", "ChangeActorForMe")
GMSetting:addItem("^800080Hack", "^3333CCTreasureHunterNoClip", "NoclipOP")
GMSetting:addItem("^800080Hack", "^3333CCNoFall", "NoFall")
GMSetting:addItem("^800080Hack", "^3333CCNoFall (Set)", "NoFallSet")
GMSetting:addItem("^800080Hack", "^FF0000ActtackReach (Set)", "ReachSet")
GMSetting:addItem("^800080Hack", "^FF0000BlockReachDistance (Set)", "BlockReachSet")
GMSetting:addItem("^800080Hack", "^FF0000Treasure Reset", "MineReset")
GMSetting:addItem("^800080Hack", "^FF0000QuickPlaceBlock", "quickblock")
GMSetting:addItem("^800080Hack", "^FF0000Parachute", "startParachute")
GMSetting:addItem("^800080Hack", "^FF0000FlyParachute", "FlyParachute")
GMSetting:addItem("^800080Hack", "^FF0000SpamRespawn", "SpamRespawn")
GMSetting:addItem("^800080Hack", "^FF0000BedWarsBypass", "BW")
GMSetting:addItem("^800080Hack", "^FF0000BedWarsBypassV2", "BWV2")
GMSetting:addItem("^800080Hack", "^FF0000Blink", "BlinkOP")
GMSetting:addItem("^800080Hack", "^FF0000ONDebug", "openDebug")
GMSetting:addItem("^800080Hack", "^FF0000OFFDebug", "closeDebug")
GMSetting:addItem("^800080Hack", "^FF0000Get Players Info", "ShowPlayersInfo")
GMSetting:addItem("^800080Hack", "^FF0000Copy Players Info", "CopyPlayersInfo")
GMSetting:addItem("^800080Hack", "^FF0000AlwaysParachute", "AlwaysParachute")
GMSetting:addItem("^800080Hack", "^FF0000InstantRespawn", "InstantRespawn")
GMSetting:addTab("testing", 2)
GMSetting:addItem("testing", "DDOS", "lagServer")
GMSetting:addItem("testing", "FollowPlayer", "FollowPlayer")
GMSetting:addItem("testing", "ScaffoldX1", "Scaffold")
GMSetting:addItem("testing", "ScaffoldX3", "Scaffold3")
GMSetting:addItem("testing", "ScaffoldX5", "Scaffold5")
GMSetting:addItem("testing", "ScaffoldX7", "Scaffold7")
GMSetting:addItem("testing", "StopScaffold", "StopScaffold")
GMSetting:addItem("testing", "LagServer 2", "LagServer2")
GMSetting:addItem("testing", "testZ", "ChatSend")
GMSetting:addItem("testing", "JustClick", "SendMSGTOSERVER")
GMSetting:addItem("testing", "info Players", "ayesh")
GMSetting:addItem("testing", "tp Players", "FollowPlayer2")
GMSetting:addItem("testing", "SetMaxFPS", "SetMaxFPS")
GMSetting:addItem("testing", "BedwarNodelay", "BedwarNodelay")
GMSetting:addItem("testing", "ArrowSpeed", "updateBedWarArro")
GMSetting:addItem("testing", "Tracer", "Tracer")
GMSetting:addItem("testing", "Rvanka", "Rvanka")
GMSetting:addItem("testing", "onClickVipRespawn", "onClickVipRespawn")
GMSetting:addItem("testing", "CustomPid", "CustomPid")
GMSetting:addItem("testing", "JetPack", "JetPack")
GMSetting:addItem("testing", "AFK", "AFKmode1")
GMSetting:addItem("testing", "TNT (Button)", "TntTag")
GMSetting:addItem("testing", "Parachute (Button)", "Parachuteg")
GMSetting:addItem("testing", "AutoParachute", "AutoParachute")
GMSetting:addItem("testing", "RandomPlayer (TP)", "TeleportToRandomPlayer")
GMSetting:addItem("testing", "AutoBridge", "AutoClickNearest")
GMSetting:addItem("testing", "HideHP", "HideHP")
GMSetting:addItem("testing", "ShowHP", "ShowHP")
GMSetting:addItem("testing", "NearestPlayer (TP)", "AutoMoveToNearestPlayer")
GMSetting:addItem("testing", "test", "RotateHeadTowardsNearestPlayer")
GMSetting:addItem("testing", "InfoXYZ", "AllPlayerLocations")
GMSetting:addItem("testing", "MyInfoXYZ", "MyLocation")
GMSetting:addItem("testing", "AutoSpawnNPC", "AutoSpawnNPC")
GMSetting:addItem("testing", "AutoSpeedChange", "AdjustSpeedBasedOnDistance")
GMSetting:addItem("testing", "1", "SwitchPerson", 0)
GMSetting:addItem("testing", "2", "SwitchPerson", 1)
GMSetting:addItem("testing", "3", "SwitchPerson", 2)
GMSetting:addItem("testing", "Cube", "SpawnCube")
GMSetting:addItem("testing", "Sphere", "SpawnSphere")
GMSetting:addItem("testing", "Pyramid", "SpawnPyramid")
GMSetting:addItem("testing", "Rhombus", "SpawnRhombus")
GMSetting:addItem("testing", "Hide", "HideST")
GMSetting:addItem("testing", "Show", "ShowST")
GMSetting:addItem("testing", "autoclick", "AutoClickzxc")
GMSetting:addItem("testing", "frezeui", "FreezeUI")
GMSetting:addItem("testing", "Hyeta", "testHui")
GMSetting:addItem("testing", "TeleportAura", "TeleportAura")
GMSetting:addItem("testing", "AimBot", "AimBo")
GMSetting:addItem("testing", "AimBotON", "StartAimBotTimer")
GMSetting:addItem("testing", "AimBotOFF", "StopAimBotTimer")
GMSetting:addItem("testing", "AimBot", "AimBot")
local v13 = false
GMHelper.AimBot = function(v476)
    v13 = not v13
    if v13 then
        UIHelper.showToast("^00FF00Aimbot = true")
    else
        UIHelper.showToast("^FF0000Aimbot = false")
    end
end
GMSetting:addItem("testing", "testZalupa", "testZalupa")
GMSetting:addItem("testing", "PlayersHitbox", "hitboxTest")
local v15
GMHelper.hitboxTest = function(v477)
    GMHelper:openInput(
        {""},
        function(v2003)
            for v3681, v3682 in pairs(PlayerManager:getPlayers()) do
                v15 = v2003
                v3682.Player.width = v15
                v3682.Player.length = v15
                PlayerManager:getClientPlayer().Player.width = v2003
            end
            UIHelper.showToast("Success, now the hitbox value is " .. PlayerManager:getClientPlayer().Player:getWidth())
            PlayerManager:getClientPlayer().Player.width = 0.6
            PlayerManager:getClientPlayer().Player.length = 0.6
            CustomDialog.hide()
        end
    )
    CustomDialog.hide()
end
GMSetting:addItem("testing", "HitboxHeight", "HitboxHeight")
local v17
GMHelper.HitboxHeight = function(v478)
    GMHelper:openInput(
        {""},
        function(v2006)
            v17 = v2006
            for v3686, v3687 in pairs(PlayerManager:getPlayers()) do
                v3687.Player.height = v17
            end
            UIHelper.showToast(
                "Done, now player hitbox height is " .. PlayerManager:getClientPlayer().Player:getHeight()
            )
            PlayerManager:getClientPlayer().Player.height = 1.8
            CustomDialog.hide()
        end
    )
    CustomDialog.hide()
end
GMSetting:addItem("testing", "AutoHitboxWidth", "AutoHitbox")
GMHelper.AutoHitbox = function(v479)
    for v2008, v2009 in pairs(PlayerManager:getPlayers()) do
        v2009.Player.width = v15
        v2009.Player.length = v15
    end
    PlayerManager:getClientPlayer().Player.width = 0.6
    PlayerManager:getClientPlayer().Player.length = 0.6
end
GMSetting:addItem("testing", "AutoHitboxHeight", "AutoHitboxHeight")
GMHelper.AutoHitboxHeight = function(v482)
    for v2012, v2013 in pairs(PlayerManager:getPlayers()) do
        v2013.Player.height = v17
    end
    PlayerManager:getClientPlayer().Player.height = 1.8
end
GMSetting:addItem("testing", "ResetHitbox", "ResetHitbox")
GMHelper.ResetHitbox = function(v484)
    CustomDialog.hide()
    CustomDialog.builder()
    CustomDialog.setTitleText("Tip")
    CustomDialog.setContentText("1 = Reset Width Hitbox \n 2 = Reset Height Hitbox \n 3 = Reset all hitbox")
    CustomDialog.show()
    GMHelper:openInput(
        {""},
        function(v2015)
            if (v2015 == "1") then
                for v4804, v4805 in pairs(PlayerManager:getPlayers()) do
                    v4805.Player.width = 0.6
                    v4805.Player.length = 0.6
                end
            elseif (v2015 == "2") then
                for v5144, v5145 in pairs(PlayerManager:getPlayers()) do
                    v5145.Player.height = 1.8
                end
            elseif (v2015 == "3") then
                for v5236, v5237 in pairs(PlayerManager:getPlayers()) do
                    v5237.Player.width = 0.6
                    v5237.Player.length = 0.6
                    v5237.Player.height = 1.8
                end
            end
        end
    )
end
GMSetting:addItem("testing", "LiveViewCamRot", "LiveViewCameraXandY")
local v22 = false
GMHelper.LiveViewCameraXandY = function(v485)
    v22 = not v22
    if v22 then
        UIHelper.showToast("^00FF00LiveViewCamRot = true")
    else
        UIHelper.showToast("^FF0000LiveViewCamRot = false")
    end
end
GMSetting:addItem("testing", "TestRespawnBW", "BedwarRespawn")
GMHelper.BedwarRespawn = function(v486)
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(0, -15, 0))
    LuaTimer:scheduleTimer(
        function()
            PacketSender:getSender():sendRebirth()
        end,
        150,
        1
    )
end
GMSetting:addItem("testing", "TestFly2", "Fly2")
local v25 = false
GMHelper.Fly2 = function(v487)
    v25 = not v25
    if v25 then
        UIHelper.showToast("^00FF00ON")
    else
        UIHelper.showToast("^FF0000OFF")
    end
end
GMSetting:addItem("testing", "TrackPlayer", "TrackPlayer")
local v27 = false
GMHelper.TrackPlayer = function(v488)
    v27 = not v27
    LuaTimer:cancel(keepTrack)
    UIHelper.showToast("Disabled!")
    if v27 then
        for v4473, v4474 in pairs(PlayerManager:getPlayers()) do
            if (not v4474.userId == tonumber(Game:getPlatformUserId())) then
                PlayerManager:getClientPlayer().Player:addGuideArrow(v4474:getPosition())
            end
        end
        UIHelper.showToast("Enabled!")
    end
end
GMSetting:addItem("testing", "ShowXYZ", "ShowXYZ")
local v29 = false
GMHelper.ShowXYZ = function(v489)
    v29 = not v29
    if v29 then
        UIHelper.showToast("ShowXYZ = true")
    else
        UIHelper.showToast("ShowXYZ = false")
    end
end
GMSetting:addItem("testing", "chatAa", "chatAa")
GMHelper.chatAa = function(v490)
    GMHelper:openInput(
        {""},
        function(v2016)
            LuaTimer:scheduleTimer(
                function()
                    GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v2016)
                end,
                5,
                1000000
            )
        end
    )
    UIHelper.showToast("SUCCESS")
end
GMSetting:addItem("testing", "Veloci", "setVelocity")
GMHelper.setVelocity = function(v491)
    GMHelper:openInput(
        {"x", "y", "z"},
        function(v2017, v2018, v2019)
            HAHAHAHWHEWEWAH = VectorUtil.newVector3(v2017, v2018, v2019)
            PlayerManager:getClientPlayer().Player:setVelocity(HAHAHAHWHEWEWAH)
        end
    )
end
GMSetting:addItem("testing", "hitiv", "ChangePlayerSize")
GMHelper.ChangePlayerSize = function(v492)
    local v493 = PlayerManager:getClientPlayer()
    local v494 = PlayerManager:getPlayers()
    for v2020, v2021 in pairs(v494) do
        if (v2021 ~= v493) then
            v2021:setScale(5)
        end
    end
end
GMSetting:addItem("testing", "rvankkk", "tpkill")
GMHelper.tpkill = function(v495)
    local v496 = PlayerManager:getClientPlayer()
    local v497 = VectorUtil.newVector3(1, 1, 1)
    LuaTimer:scheduleTimer(
        function()
            local v2022 = PlayerManager:getPlayers()
            for v3689, v3690 in pairs(v2022) do
                if (v3690 ~= v496) then
                    v496.Player:setPosition(v3690:getPosition())
                    v496.Player:moveEntity(v497)
                end
            end
        end,
        119,
        -1
    )
end
GMSetting:addItem("testing", "var + var", "VarPlusVar")
GMHelper.VarPlusVar = function(v498)
    GMHelper:openInput(
        {"var1", "var2"},
        function(v2023, v2024)
            local v2025 = v2023
            local v2026 = v2024
            UIHelper.showToast(v2025 + v2026)
        end
    )
end
GMSetting:addItem("testing", "var - var", "VarMinusVar")
GMHelper.VarMinusVar = function(v499)
    GMHelper:openInput(
        {"var1", "var2"},
        function(v2027, v2028)
            local v2029 = v2027
            local v2030 = v2028
            UIHelper.showToast(v2029 - v2030)
        end
    )
end
GMSetting:addItem("testing", "var / var", "VarDevideVar")
GMHelper.VarDevideVar = function(v500)
    GMHelper:openInput(
        {"var1", "var2"},
        function(v2031, v2032)
            local v2033 = v2031
            local v2034 = v2032
            UIHelper.showToast(v2033 / v2034)
        end
    )
end
GMSetting:addItem("testing", "var * var", "VarTimesVar")
GMHelper.VarTimesVar = function(v501)
    GMHelper:openInput(
        {"var1", "var2"},
        function(v2035, v2036)
            local v2037 = v2035
            local v2038 = v2036
            UIHelper.showToast(v2037 * v2038)
        end
    )
end
GMSetting:addItem("testing", "PutBoolPrefs", "putBoolPrefs")
GMSetting:addItem("testing", "PutFloatPrefs", "putFloatPrefs")
GMSetting:addItem("testing", "PutIntPrefs", "putIntPrefs")
GMSetting:addItem("testing", "PutStringPrefs", "putStringPrefs")
GMSetting:addItem("testing", "InjectLUA", "InjectLUA")
GMHelper.InjectLUA = function(v502)
    GMHelper:openInput(
        {""},
        function(v2039)
            pcall(load(v2039))
        end
    )
end
GMSetting:addItem("testing", "rain", "ChangeWeather")
GMHelper.ChangeWeather = function(v503)
    local v504 = EngineWorld:getWorld()
    if isRain then
        v504:setWorldWeather("rain")
        UIHelper.showToast("^00FF00Now Rain!")
        return
    end
    v504:setWorldWeather("sun")
    UIHelper.showToast("^00FF00Now Sunny!")
end
GMSetting:addTab("EternalTest")
GMSetting:addItem("EternalTest", "^00FFDDAutoClicker", "AutoClick")
GMSetting:addItem("EternalTest", "^00FFDDTracer", "Tracer")
GMSetting:addItem("EternalTest", "^00FFDDSetMaxFPS", "SetMaxFPS")
GMSetting:addItem("EternalTest", "^00FFDDChatSpammer", "SpamChat")
GMSetting:addItem("EternalTest", "^00FFDDRespawnV2", "RespawnV2")
GMSetting:addItem("EternalTest", "^00FFDDRespawnV3", "RespawnV3")
GMSetting:addItem("EternalTest", "^00FFDDSetVelocity", "setVelocity")
GMSetting:addItem("EternalTest", "^00FFDDSetVelocityV2", "setVelocityV2")
GMSetting:addItem("EternalTest", "^00FFDDAimBot", "aimbot")
GMSetting:addItem("EternalTest", "^00FFDDChatSpammer", "SpamChat")
GMSetting:addItem("EternalTest", "^00FFDDRespawnV4", "WarnTP")
GMSetting:addItem("testing", "canon", "wafexTest")
GMHelper.wafexTest = function(v505)
    GUIManager:getWindowByName("Main-Cannon"):SetVisible(true)
    GUIManager:getWindowByName("Main-Cannon", GUIType.Button):registerEvent(
        GUIEvent.ButtonClick,
        function()
            local v2040 = 2
            local v2041 = 3
            local v2042 = 4
            local v2043 = VectorUtil.newVector3(v2040, v2041, v2042)
            PlayerManager:getClientPlayer().Player:setVelocity(v2043)
        end
    )
end
GMSetting:addItem("testing", "Show", "show")
GMHelper.show = function(v506)
    local v507 = EngineWorld:getWorld()
    if isSnow then
        v507:setWorldWeather("snow")
        UIHelper.showToast("^00FF00Now Snowing!")
        return
    end
    v507:setWorldWeather("sun")
    UIHelper.showToast("^00FF00Now Sunny!")
end
GMSetting:addItem("testing", "^JetPackV2", "jetPackv2")
local v43
local v44 = false
GMHelper.jetPackv2 = function(v508)
    v44 = not v44
    if v44 then
        GMHelper:openInput(
            {"Speed"},
            function(v4475)
                v43 = tonumber(v4475)
                PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0, 1, 0))
                UIHelper.showToast("JetPack = true")
            end
        )
    else
        v43 = nil
        v44 = nil
        UIHelper.showToast("JetPack = false")
    end
end
GMSetting:addItem("testing", "sptpclk", "WarnTP")
GMHelper.WarnTP = function(v509)
    A = not A
    LuaTimer:cancel(v509.timer)
    UIHelper.showToast("^FF0000close")
    if A then
        GMHelper:openInput(
            {""},
            function(v4476)
                v4476 = tonumber(v4476)
                v509.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4808 = PlayerManager:getClientPlayer()
                        local v4809 = v4808.Player:getHealth()
                        if (v4809 <= v4476) then
                            local v5147 = PlayerManager:getClientPlayer():getPosition()
                            local v5148 = VectorUtil.newVector3(v5147.x, 0, v5147.z)
                            v4808.Player:setPosition(v5148)
                            PacketSender:getSender():sendRebirth()
                        end
                    end,
                    0.2,
                    9e+23
                )
                UIHelper.showToast("^00FF00open")
                GUIGMControlPanel:hide()
            end
        )
    end
end
GMSetting:addItem("testing", "autobridge", "ggg2228")
GMHelper.ggg2228 = function(v510)
    A = not A
    LuaTimer:cancel(v510.timer)
    UIHelper.showToast("^00FF00AutoClick OFF")
    if A then
        v510.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(2035, 621)
                UIHelper.showToast("^00FF00AutoClick ON")
            end,
            0.15,
            -1
        )
    end
end
GMSetting:addTab("ARDEN")
GMSetting:addItem("ARDEN", "TeleKill", "TeleKill")
local v48 = false
GMHelper.TeleKill = function(v511)
    v48 = not v48
    if v48 then
        UIHelper.showToast("^00FF00TeleKill = true")
    else
        UIHelper.showToast("^FF0000TeleKill = false")
    end
end
GMSetting:addItem("ARDEN", "BedwarRespawn", "BedwarRespawn")
GMHelper.BedwarRespawn = function(v512)
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(0, -15, 0))
    LuaTimer:schedule(
        function()
            PacketSender:getSender():sendRebirth()
        end,
        150
    )
end
GMSetting:addTab("Name colors")
GMSetting:addItem("Name colors", "▢FFFF0000Red", "SetNameColor", "Red")
GMSetting:addItem("Name colors", "▢FF0000FFBlue", "SetNameColor", "Blue")
GMSetting:addItem("Name colors", "▢FFFFFFFFBlack", "SetNameColor", "Black")
GMSetting:addItem("Name colors", "▢FFFFFFFFWhite", "SetNameColor", "White")
GMSetting:addItem("Name colors", "▢FF00FF00Green", "SetNameColor", "Green")
GMSetting:addItem("Name colors", "▢FFFFFF00Yellow", "SetNameColor", "Yellow")
GMSetting:addItem("Name colors", "▢FF884898Purple", "SetNameColor", "Purple")
GMSetting:addItem("Name colors", "▢FFFF1B89Pink", "SetNameColor", "Pink")
GMSetting:addItem("Name colors", "▢FFFF8000Orange", "SetNameColor", "Orange")
GMSetting:addItem("Name colors", "▢FFFFD700Gold", "SetNameColor", "Gold")
GMSetting:addItem("Name colors", "▢FF00FFFFAqua", "SetNameColor", "Aqua")
GMSetting:addTab("MadeInChina")
GMSetting:addItem("MadeInChina", "▢FF884898夺宝奇兵重置矿区", "MineReset")
GMSetting:addItem("MadeInChina", "▢FF884898夺宝奇兵透视", "NoclipOP")
GMSetting:addItem("MadeInChina", "▢FF0000FF生成落脚平台", "pingtai")
GMHelper.pingtai = function(v513)
    local v514 = PlayerManager:getClientPlayer():getPosition()
    for v2044 = -1, 1, 1 do
        for v3692 = -1, 1, 1 do
            local v3693 = VectorUtil.newVector3(v514.x + v2044, v514.y - 5, v514.z + v3692)
            EngineWorld:setBlock(v3693, 159)
        end
    end
end
GMSetting:addItem("MadeInChina", "^00FFDD无限连跳", "MyLoveFly")
GMSetting:addItem("MadeInChina", "▢FF884898长臂猿", "Reach")
GMSetting:addItem("MadeInChina", "▢FF884898攻击距离(自定)", "ReachSet")
GMSetting:addItem("MadeInChina", "▢FF884898长臂猿(自定)", "BlockReachSet")
GMSetting:addItem("MadeInChina", "▢FF884898秒方块", "FustBreakBlockMode")
GMSetting:addItem("MadeInChina", "^00FFDD观察者视角", "Freecam")
GMSetting:addItem("MadeInChina", "^00FFDD修改名字", "ChangeNick")
GMSetting:addItem("MadeInChina", "▢FF884898开启飞行", "DevFlyIS")
GMHelper.DevFlyIS = function(v515)
    local v516 = VectorUtil.newVector3(0, 1.35, 0)
    local v517 = PlayerManager:getClientPlayer()
    v517.Player:setAllowFlying(true)
    v517.Player:setFlying(true)
    v517.Player:moveEntity(v516)
    UIHelper.showToast("^FF00EE成功")
end
GMSetting:addItem("MadeInChina", "▢FF884898观战模式", "WatchModez")
GMHelper.WatchModez = function(v518)
    WatchMode2 = not WatchMode2
    if WatchMode2 then
        local v3694 = VectorUtil.newVector3(0, 1.35, 0)
        PlayerManager:getClientPlayer().Player:setAllowFlying(true)
        PlayerManager:getClientPlayer().Player:setFlying(true)
        PlayerManager:getClientPlayer().Player:setWatchMode(true)
        PlayerManager:getClientPlayer().Player:moveEntity(v3694)
        UIHelper.showToast("^FF00EE开")
    else
        PlayerManager:getClientPlayer().Player:setAllowFlying(false)
        PlayerManager:getClientPlayer().Player:setFlying(false)
        PlayerManager:getClientPlayer().Player:setWatchMode(false)
        UIHelper.showToast("^FF00EE关")
    end
end
GMSetting:addItem("MadeInChina", "▢FF0000FF自动搭路", "SpawnBlockv2")
GMSetting:addItem("MadeInChina", "▢FF0000FF十字型搭路", "btSpawnBlock")
GMHelper.btSpawnBlock = function(v519)
    GMHelper:openInput(
        {""},
        function(v2045)
            local v2046 = PlayerManager:getClientPlayer():getPosition()
            count = 1
            ceshi(v2046, v2045, count)
        end
    )
end
GMSetting:addTab("PlayerINFO")
GMSetting:addItem("PlayerINFO", "MyLocation", "MyLocation")
GMSetting:addItem("PlayerINFO", "AllPlayerLocations", "AllPlayerLocations")
GMSetting:addItem("PlayerINFO", "AllPlayerLocationsV2", "AllPlayerLocations2")
GMSetting:addItem("MadeInChina", "▢FF0000FF九宫格搭路(ID,半径)", "btSpawnBlockv2")
GMHelper.btSpawnBlockv2 = function(v520)
    GMHelper:openInput(
        {"", ""},
        function(v2047, v2048)
            local v2049 = PlayerManager:getClientPlayer():getPosition()
            count = 1
            ceshiv2(v2049, v2047, v2048, count)
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FF0000FF十字搭桥(ID,长度)", "SpawnBlockLong")
GMHelper.SpawnBlockLong = function(v521)
    GMHelper:openInput(
        {"", ""},
        function(v2050, v2051)
            local v2052 = PlayerManager:getClientPlayer():getPosition()
            for v3695 = -1 * v2051, v2051, 1 do
                local v3696 = VectorUtil.newVector3(v2052.x + v3695, v2052.y - 2, v2052.z)
                EngineWorld:setBlock(v3696, v2050)
            end
            for v3697 = -1 * v2051, v2051, 1 do
                local v3698 = VectorUtil.newVector3(v2052.x, v2052.y - 2, v2052.z + v3697)
                EngineWorld:setBlock(v3698, v2050)
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FF0000FF生成平台(ID,半径)", "SpawnBlockSize")
GMHelper.SpawnBlockSize = function(v522)
    GMHelper:openInput(
        {"", ""},
        function(v2053, v2054)
            local v2055 = PlayerManager:getClientPlayer():getPosition()
            for v3699 = -1 * v2054, v2054, 1 do
                for v4478 = -1 * v2054, v2054, 1 do
                    local v4479 = VectorUtil.newVector3(v2055.x + v3699, v2055.y - 2, v2055.z + v4478)
                    EngineWorld:setBlock(v4479, v2053)
                end
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FF0000FF自定义平台", "SpawnBlocksetSize")
GMSetting:addItem("MadeInChina", "▢FF0000FF实时平台", "SpawnBlocktimeSize")
GMHelper.SpawnBlocktimeSize = function(v523)
    local v524 = PlayerManager:getClientPlayer():getPosition()
    if (OFF <= 9999) then
        LuaTimer:schedule(
            function()
                for v4810 = -2, 2, 1 do
                    for v5001 = -2, 2, 1 do
                        local v5002 = VectorUtil.newVector3(v524.x + v4810, v524.y - 2, v524.z + v5001)
                        EngineWorld:setBlock(v5002, 0)
                    end
                end
                for v4811 = -1, 1, 1 do
                    for v5003 = -1, 1, 1 do
                        local v5004 = VectorUtil.newVector3(v524.x + v4811, v524.y - 2, v524.z + v5003)
                        EngineWorld:setBlock(v5004, 159)
                    end
                end
                GMHelper:SpawnBlocktimeSize()
            end,
            10
        )
    end
end
GMSetting:addItem("MadeInChina", "▢FF0000FF ~x ~y ~z ~x ~y ~z Blockid", "SpawnBlockfillSize")
GMHelper.SpawnBlockfillSize = function(v525)
    GMHelper:openInput(
        {"", "", "", "", "", "", ""},
        function(v2056, v2057, v2058, v2059, v2060, v2061, v2062)
            local v2063 = PlayerManager:getClientPlayer():getPosition()
            for v3700 = v2056, v2059, 1 do
                for v4480 = v2058, v2061, 1 do
                    for v4812 = v2057, v2060, 1 do
                        local v4813 = VectorUtil.newVector3(v2063.x + v3700, v2063.y + v4812, v2063.z + v4480)
                        EngineWorld:setBlock(v4813, v2062)
                    end
                end
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FF0000FF地面穿墙(稳定)", "SpawnBlockNoclip")
GMHelper.SpawnBlockNoclip = function(v526)
    local v527 = PlayerManager:getClientPlayer():getPosition()
    for v2064 = -1, 1, 1 do
        for v3701 = -1, 1, 1 do
            local v3702 = VectorUtil.newVector3(v527.x + v2064, v527.y - 2, v527.z + v3701)
            EngineWorld:setBlock(v3702, 0)
        end
    end
    ceshiv4()
end
function ceshiv4()
    local v528 = PlayerManager:getClientPlayer():getPosition()
    if (OFF <= 9999) then
        LuaTimer:schedule(
            function()
                for v4814 = -2, 2, 1 do
                    for v5005 = -2, 2, 1 do
                        for v5149 = -1, 0, 1 do
                            local v5150 = VectorUtil.newVector3(v528.x + v4814, v528.y + v5149, v528.z + v5005)
                            EngineWorld:setBlock(v5150, 0)
                        end
                    end
                end
                ceshiv4()
            end,
            10
        )
    end
end
GMSetting:addItem("MadeInChina", "▢FF0000FF方位搭桥(ID,长度,半径)", "SpawnBlockToword")
GMHelper.SpawnBlockToword = function(v529)
    GMHelper:openInput(
        {"", "", ""},
        function(v2065, v2066, v2067)
            local v2068 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2069 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
            v2068 = v2068 % 360
            if (v2068 < 0) then
                v2068 = v2068 + 360
            end
            local v2070 = (math.floor((v2068 + 22.5) / 45) % 8) + 1
            local v2071 = PlayerManager:getClientPlayer():getPosition()
            if (v2070 == 1) then
                for v4815 = -1 * v4815, v4815, 1 do
                    for v5006 = 1, v2066, 1 do
                        local v5007 = VectorUtil.newVector3(v2071.x + v4815, v2071.y - 2, v2071.z + v5006)
                        EngineWorld:setBlock(v5007, v2065)
                    end
                end
            end
            if (v2070 == 2) then
                for v4816 = -1 * v4816, v4816, 1 do
                    for v5008 = 1, v2066, 1 do
                        local v5009 =
                            VectorUtil.newVector3((v2071.x + v4816) - v5008, v2071.y - 2, v2071.z + v4816 + v5008)
                        EngineWorld:setBlock(v5009, v2065)
                    end
                end
            end
            if (v2070 == 3) then
                for v4817 = -1 * v4817, v4817, 1 do
                    for v5010 = 1, v2066, 1 do
                        local v5011 = VectorUtil.newVector3(v2071.x - v5010, v2071.y - 2, v2071.z + v4817)
                        EngineWorld:setBlock(v5011, v2065)
                    end
                end
            end
            if (v2070 == 4) then
                for v4818 = -1 * v4818, v4818, 1 do
                    for v5012 = 1, v2066, 1 do
                        local v5013 = VectorUtil.newVector3(v2071.x - v5012, v2071.y - 2, (v2071.z + v4818) - v5012)
                        EngineWorld:setBlock(v5013, v2065)
                    end
                end
            end
            if (v2070 == 5) then
                for v4819 = -1 * v4819, v4819, 1 do
                    for v5014 = 1, v2066, 1 do
                        local v5015 = VectorUtil.newVector3(v2071.x + v4819, v2071.y - 2, v2071.z - v5014)
                        EngineWorld:setBlock(v5015, v2065)
                    end
                end
            end
            if (v2070 == 6) then
                for v4820 = -1 * v4820, v4820, 1 do
                    for v5016 = 1, v2066, 1 do
                        local v5017 =
                            VectorUtil.newVector3(v2071.x + v4820 + v5016, v2071.y - 2, (v2071.z + v4820) - v5016)
                        EngineWorld:setBlock(v5017, v2065)
                    end
                end
            end
            if (v2070 == 7) then
                for v4821 = -1 * v4821, v4821, 1 do
                    for v5018 = 1, v2066, 1 do
                        local v5019 = VectorUtil.newVector3(v2071.x + v5018, v2071.y - 2, v2071.z + v4821)
                        EngineWorld:setBlock(v5019, v2065)
                    end
                end
            end
            if (v2070 == 8) then
                for v4822 = -1 * v4822, v4822, 1 do
                    for v5020 = 1, v2066, 1 do
                        local v5021 = VectorUtil.newVector3(v2071.x + v5020, v2071.y - 2, v2071.z + v4822 + v5020)
                        EngineWorld:setBlock(v5021, v2065)
                    end
                end
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FF0000FF一键搭桥", "SpawnBlockTowordv1")
GMHelper.SpawnBlockTowordv1 = function(v530)
    local v531 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v532 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
    v531 = v531 % 360
    if (v531 < 0) then
        v531 = v531 + 360
    end
    local v533 = (math.floor((v531 + 22.5) / 45) % 8) + 1
    local v534 = PlayerManager:getClientPlayer():getPosition()
    if (v533 == 1) then
        for v4481 = 1, 100, 1 do
            local v4482 = VectorUtil.newVector3(v534.x, v534.y - 2, v534.z + v4481)
            EngineWorld:setBlock(v4482, 159)
        end
    end
    if (v533 == 2) then
        for v4483 = 1, 100, 1 do
            local v4484 = VectorUtil.newVector3(v534.x - v4483, v534.y - 2, v534.z + v4483)
            EngineWorld:setBlock(v4484, 159)
        end
    end
    if (v533 == 3) then
        for v4485 = 1, 100, 1 do
            local v4486 = VectorUtil.newVector3(v534.x - v4485, v534.y - 2, v534.z)
            EngineWorld:setBlock(v4486, 159)
        end
    end
    if (v533 == 4) then
        for v4487 = 1, 100, 1 do
            local v4488 = VectorUtil.newVector3(v534.x - v4487, v534.y - 2, v534.z - v4487)
            EngineWorld:setBlock(v4488, 159)
        end
    end
    if (v533 == 5) then
        for v4489 = 1, 100, 1 do
            local v4490 = VectorUtil.newVector3(v534.x, v534.y - 2, v534.z - v4489)
            EngineWorld:setBlock(v4490, 159)
        end
    end
    if (v533 == 6) then
        for v4491 = 1, 100, 1 do
            local v4492 = VectorUtil.newVector3(v534.x + v4491, v534.y - 2, v534.z - v4491)
            EngineWorld:setBlock(v4492, 159)
        end
    end
    if (v533 == 7) then
        for v4493 = 1, 100, 1 do
            local v4494 = VectorUtil.newVector3(v534.x + v4493, v534.y - 2, v534.z)
            EngineWorld:setBlock(v4494, 159)
        end
    end
    if (v533 == 8) then
        for v4495 = 1, 100, 1 do
            local v4496 = VectorUtil.newVector3(v534.x + v4495, v534.y - 2, v534.z + v4495)
            EngineWorld:setBlock(v4496, 159)
        end
    end
end
GMSetting:addItem("MadeInChina", "▢FF0000FF一键铺路", "SpawnBlockTowordv2")
GMHelper.SpawnBlockTowordv2 = function(v535)
    local v536 = PlayerManager:getClientPlayer()
    if (v536 == nil) then
        return
    end
    local v537 = v536.Player.rotationYaw
    local v538 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
    v537 = v537 % 360
    if (v537 < 0) then
        v537 = v537 + 360
    end
    local v539 = (math.floor((v537 + 22.5) / 45) % 8) + 1
    local v540 = PlayerManager:getClientPlayer():getPosition()
    if (v539 == 1) then
        for v4497 = -2, 2, 1 do
            for v4823 = 1, 100, 1 do
                local v4824 = VectorUtil.newVector3(v540.x + v4497, v540.y - 2, v540.z + v4823)
                EngineWorld:setBlock(v4824, 159)
            end
        end
    elseif (v539 == 2) then
        for v5022 = -2, 2, 1 do
            for v5151 = 1, 100, 1 do
                local v5152 = VectorUtil.newVector3((v540.x + v5022) - v5151, v540.y - 2, v540.z + v5022 + v5151)
                EngineWorld:setBlock(v5152, 159)
            end
        end
    elseif (v539 == 3) then
        for v5223 = -2, 2, 1 do
            for v5241 = 1, 100, 1 do
                local v5242 = VectorUtil.newVector3(v540.x - v5241, v540.y - 2, v540.z + v5223)
                EngineWorld:setBlock(v5242, 159)
            end
        end
    elseif (v539 == 4) then
        for v5249 = -2, 2, 1 do
            for v5255 = 1, 100, 1 do
                local v5256 = VectorUtil.newVector3(v540.x - v5255, v540.y - 2, (v540.z + v5249) - v5255)
                EngineWorld:setBlock(v5256, 159)
            end
        end
    elseif (v539 == 5) then
        for v5259 = -2, 2, 1 do
            for v5261 = 1, 100, 1 do
                local v5262 = VectorUtil.newVector3(v540.x + v5259, v540.y - 2, v540.z - v5261)
                EngineWorld:setBlock(v5262, 159)
            end
        end
    elseif (v539 == 6) then
        for v5265 = -2, 2, 1 do
            for v5267 = 1, 100, 1 do
                local v5268 = VectorUtil.newVector3(v540.x + v5265 + v5267, v540.y - 2, (v540.z + v5265) - v5267)
                EngineWorld:setBlock(v5268, 159)
            end
        end
    elseif (v539 == 7) then
        for v5271 = -2, 2, 1 do
            for v5273 = 1, 100, 1 do
                local v5274 = VectorUtil.newVector3(v540.x + v5273, v540.y - 2, v540.z + v5271)
                EngineWorld:setBlock(v5274, 159)
            end
        end
    elseif (v539 == 8) then
        for v5277 = -2, 2, 1 do
            for v5279 = 1, 100, 1 do
                local v5280 = VectorUtil.newVector3(v540.x + v5279, v540.y - 2, v540.z + v5277 + v5279)
                EngineWorld:setBlock(v5280, 159)
            end
        end
    end
end
GMSetting:addItem("MadeInChina", "▢FF0000FF关闭搭路", "SpawnBlockOFF")
GMHelper.SpawnBlockOFF = function(v541)
    OFF = 10000
    UIHelper.showToast("^00FF00连锁搭路已被禁用")
end
GMSetting:addItem("MadeInChina", "▢FF0000FF开启搭路", "SpawnBlockON")
GMHelper.SpawnBlockON = function(v542)
    OFF = 0
    UIHelper.showToast("^FF0000连锁搭路已启用")
end
GMHelper.SpawnBlocktimeSize = function(v543)
    local v544 = PlayerManager:getClientPlayer():getPosition()
    if (OFF <= 9999) then
        LuaTimer:schedule(
            function()
                for v4825 = -2, 2, 1 do
                    for v5023 = -2, 2, 1 do
                        local v5024 = VectorUtil.newVector3(v544.x + v4825, v544.y - 2, v544.z + v5023)
                        EngineWorld:setBlock(v5024, 0)
                    end
                end
                for v4826 = -1, 1, 1 do
                    for v5025 = -1, 1, 1 do
                        local v5026 = VectorUtil.newVector3(v544.x + v4826, v544.y - 2, v544.z + v5025)
                        EngineWorld:setBlock(v5026, 159)
                    end
                end
                GMHelper:SpawnBlocktimeSize()
            end,
            10
        )
    end
end
GMSetting:addItem("MadeInChina", "^00FFDD生成游泳池", "SpawnBlockSwim")
GMHelper.SpawnBlockSwim = function(v545)
    local v546 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v547 = {"东", "南", "西", "北"}
    v546 = v546 % 360
    if (v546 < 0) then
        v546 = v546 + 360
    end
    local v548 = (math.floor((v546 + 45) / 90) % 4) + 1
    local v549 = PlayerManager:getClientPlayer():getPosition()
    GMHelper:openInput(
        {"填20,42,43,80都可以", "填8,9,10,11", "距离自己多远生成,推荐5", "距离自己多高生成,推荐0或者4"},
        function(v2072, v2073, v2074, v2075)
            local v2076 = PlayerManager:getClientPlayer():getPosition()
            if (v548 == 1) then
                for v4827 = -12, 12, 1 do
                    for v5027 = 0, 56, 1 do
                        for v5153 = -4, 0, 1 do
                            local v5154 =
                                VectorUtil.newVector3(v2076.x + v4827, v2076.y + v5153 + v2075, v2076.z + v5027 + v2074)
                            EngineWorld:setBlock(v5154, v2072)
                        end
                    end
                end
                for v4828 = -9, 9, 1 do
                    for v5028 = 3, 53, 1 do
                        for v5155 = -3, 0, 1 do
                            local v5156 =
                                VectorUtil.newVector3(v2076.x + v4828, v2076.y + v5155 + v2075, v2076.z + v5028 + v2074)
                            EngineWorld:setBlock(v5156, v2073)
                        end
                    end
                end
            end
            if (v548 == 2) then
                for v4829 = -12, 12, 1 do
                    for v5029 = -56, 0, 1 do
                        for v5157 = -4, 0, 1 do
                            local v5158 =
                                VectorUtil.newVector3(
                                (v2076.x + v5029) - v2074,
                                v2076.y + v5157 + v2075,
                                v2076.z + v4829
                            )
                            EngineWorld:setBlock(v5158, v2072)
                        end
                    end
                end
                for v4830 = -9, 9, 1 do
                    for v5030 = -53, -3, 1 do
                        for v5159 = -3, 0, 1 do
                            local v5160 =
                                VectorUtil.newVector3(
                                (v2076.x + v5030) - v2074,
                                v2076.y + v5159 + v2075,
                                v2076.z + v4830
                            )
                            EngineWorld:setBlock(v5160, v2073)
                        end
                    end
                end
            end
            if (v548 == 3) then
                for v4831 = -12, 12, 1 do
                    for v5031 = -56, 0, 1 do
                        for v5161 = -4, 0, 1 do
                            local v5162 =
                                VectorUtil.newVector3(
                                v2076.x + v4831,
                                v2076.y + v5161 + v2075,
                                (v2076.z + v5031) - v2074
                            )
                            EngineWorld:setBlock(v5162, v2072)
                        end
                    end
                end
                for v4832 = -9, 9, 1 do
                    for v5032 = -53, -3, 1 do
                        for v5163 = -3, 0, 1 do
                            local v5164 =
                                VectorUtil.newVector3(
                                v2076.x + v4832,
                                v2076.y + v5163 + v2075,
                                (v2076.z + v5032) - v2074
                            )
                            EngineWorld:setBlock(v5164, v2073)
                        end
                    end
                end
            end
            if (v548 == 4) then
                for v4833 = -12, 12, 1 do
                    for v5033 = 0, 56, 1 do
                        for v5165 = -4, 0, 1 do
                            local v5166 =
                                VectorUtil.newVector3(v2076.x + v5033 + v2074, v2076.y + v5165 + v2075, v2076.z + v4833)
                            EngineWorld:setBlock(v5166, v2072)
                        end
                    end
                end
                for v4834 = -9, 9, 1 do
                    for v5034 = 3, 53, 1 do
                        for v5167 = -3, 0, 1 do
                            local v5168 =
                                VectorUtil.newVector3(v2076.x + v5034 + v2074, v2076.y + v5167 + v2075, v2076.z + v4834)
                            EngineWorld:setBlock(v5168, v2073)
                        end
                    end
                end
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FFFF0000分身", "BlinkOP")
GMHelper.BlinkOP = function(v550)
    S = not S
    if A then
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        UIHelper.showToast("^FF0000分身已关闭,即将传送回本体")
        UIHelper.showToast("^00FF00分身已开启,你的行踪将不会被发现")
    else
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        UIHelper.showToast("^00FF00分身已开启,你的行踪将不会被发现")
    end
end
GMSetting:addItem("MadeInChina", "▢FFFF0000设置速度(0~1000)", "SpeedManager")
GMSetting:addItem("MadeInChina", "▢FFFF00000CD[开关]", "BanClickCD")
GMSetting:addItem("MadeInChina", "▢FFFF0000限制方块边缘摔落", "NoFall")
GMSetting:addItem("MadeInChina", "▢FFFF0000传送", "TeleportByUID")
GMSetting:addItem("MadeInChina", "▢FFFF0000设置摔落高度", "NoFallSet")
GMSetting:addItem("MadeInChina", "▢FFFF0000连叠", "SetUpBuild")
GMSetting:addItem("MadeInChina", "▢FFFF0000起床无限距离叠桥", "InfBD")
GMHelper.InfBD = function(v551)
    ModuleBlockConfig.init = function(v2077)
        local v2078 = FileUtil.getGameConfigFromYml("module_block/ModuleBlock", true) or {}
        v2077.placeBlockMaxDepth = v2078.placeBlockMaxDepth or 2
        v2077.placeBlockMaxBuildDistance = 6
        v2077.buildRoadModeMaxDistance = 6
        if isClient then
            ClientHelper.putIntPrefs("RunLimitCheck", v2078.limitBlockCheckRun or 10)
            ClientHelper.putIntPrefs("SprintLimitCheck", v2078.limitBlockCheckSprint or 10)
        end
        v2078 = FileUtil.getGameConfigFromCsv("module_block/ModuleBlock.csv", 2, true, true) or {}
        for v3703, v3704 in pairs(v2078) do
            local v3705 = {
                id = tonumber(v3704.id),
                itemId = tonumber(v3704.itemId),
                teamId = tonumber(v3704.teamId) or 0,
                consumeNum = tonumber(v3704.consumeNum) or 1,
                schematic = v3704.schematic,
                offsetX = tonumber(v3704.offsetX) or 0,
                offsetZ = tonumber(v3704.offsetZ) or 0,
                image = v3704.image,
                extraParam = tonumber(v3704.extraParam) or 0
            }
            v8[v3705.itemId] = v8[v3705.itemId] or {}
            table.insert(v8[v3705.itemId], v3705)
        end
        for v3707, v3708 in pairs(v8) do
            table.sort(
                v3708,
                function(v4498, v4499)
                    return v4498.id < v4499.id
                end
            )
        end
    end
    ModuleBlockConfig.getModuleBlock = function(v2082, v2083, v2084, v2085)
        local v2086 = v8[v2083]
        if not v2086 then
            return nil
        end
        if (v2084 and (v2084 ~= 0)) then
            for v4835, v4836 in pairs(v2086) do
                if (v4836.id == v2084) then
                    return v4836
                end
            end
        end
        for v3709, v3710 in pairs(v2086) do
            if (v3710.teamId == v2085) then
                return v3710
            end
        end
        if (v2085 == 0) then
            return nil
        else
            return v2082:getModuleBlock(v2083, v2084, 0)
        end
    end
    ModuleBlockConfig.getModuleBlocks = function(v2087, v2088)
        return v8[v2088]
    end
    ModuleBlockConfig.getDefaultModuleId = function(v2089, v2090)
        local v2091 = v8[v2090]
        if TableUtil.isEmpty(v2091) then
            return 0
        end
        return v2091[1].id
    end
    ModuleBlockConfig.hasConfig = function(v2092)
        return not TableUtil.isEmpty(v8)
    end
    ModuleBlockConfig:init()
    UIHelper.showToast("^00FF00ON")
    GUIGMControlPanel:hide()
end
GMSetting:addItem("MadeInChina", "▢FFFF0000锁人", "TPplayer")
GMHelper.TPplayer = function(v557)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2093)
            TPplayerv1(v2093)
        end
    )
end
GMSetting:addItem("MadeInChina", "▢FFFF0000中断锁人", "FunctionOFF")
GMHelper.FunctionOFF = function(v558)
    Off = 10000
    UIHelper.showToast("^00FF00本栏持续运行功能中断")
end
GMSetting:addItem("MadeInChina", "▢FFFF0000解除中断", "FunctionON")
GMHelper.FunctionON = function(v559)
    Off = 0
    UIHelper.showToast("^FF0000需要持续运行的功能可重新开启")
end
GMHelper.closeDebug = function(v560)
    CGame.Instance():toggleDebugMessageShown(false)
end
GMSetting:addItem("MadeInChina", "▢FFFF0000获取玩家id", "GetID")
GMHelper.GetID = function(v561)
    local v562 = PlayerManager:getPlayers()
    for v2094, v2095 in pairs(v562) do
        MsgSender.sendMsg(
            "^FF0000玩家信息: " ..
                string.format(
                    "^FF0000玩家名字: %s {} ID: %s {} 性别: %s",
                    v2095:getName(),
                    v2095.userId,
                    v2095.Player:getSex()
                )
        )
    end
end
GMSetting:addItem("MadeInChina", "^FFFF99陀螺旋转", "TL")
GMHelper.TL = function(v563)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                PlayerManager:getClientPlayer().Player.spYaw = true
                PlayerManager:getClientPlayer().Player.spYawRadian = 45
                TL1()
            end,
            50
        )
    end
end
GMSetting:addItem("MadeInChina", "^7803FF坐标", "tptest")
GMHelper.tptest = function(v564)
    LuaTimer:schedule(
        function()
            local v2096 = PlayerManager:getClientPlayer():getPosition()
            local v2097 = math.modf(v2096.y * 100)
            local v2098 = math.modf(v2096.x * 100)
            local v2099 = math.modf(v2096.z * 100)
            local v2100 = v2097 / 100
            local v2101 = v2098 / 100
            local v2102 = v2099 / 100
            local v2103 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2104 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
            v2103 = v2103 % 360
            if (v2103 < 0) then
                v2103 = v2103 + 360
            end
            local v2105 = (math.floor((v2103 + 22.5) / 45) % 8) + 1
            local v2106 = v2104[v2105]
            MsgSender.sendTopTips(
                10,
                "▢FFFFFF00[CryIsHere] ▢FFFFFFFF作者ID：569448335 \n 朝向:" ..
                    v2106 .. "\n X:" .. v2101 .. " Y:" .. v2100 .. " Z:" .. v2102
            )
            GMHelper:tptest()
        end,
        10
    )
end
GMSetting:addItem("MadeInChina", "^7803FF获取距离id", "getDistance")
GMHelper.getDistance = function(v565)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2107)
            Zimiao(v2107)
        end
    )
end
function Zimiao(v566)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                player = PlayerManager:getClientPlayer()
                Dplayer = PlayerManager:getPlayerByUserId(v566)
                if Dplayer then
                    for v5169 = 1, 999 do
                        play = player:getPosition()
                        UIDpos = Dplayer:getPosition()
                        local v5170 = ((UIDpos.x - play.x) ^ 2) + (play.z - UIDpos.z)
                        local v5171 = UIDpos.y - play.y
                        local v5172 = math.sqrt(v5170)
                        UIHelper.showToast("你与目标距离: " .. v5172 .. " 高度相差: " .. v5171)
                    end
                end
                Zimiao(v566)
            end,
            10
        )
    end
end
GMSetting:addItem("MadeInChina", "^7803FF记录存档点1", "")
GMSetting:addItem("MadeInChina", "^7803FF读取存档点1(分身)", "")
GMSetting:addItem("MadeInChina", "^7803FF读取存档点1(本体)", "")
GMSetting:addItem("MadeInChina", "^7803FF获取名字，生命，ID，队伍", "getName")
GMHelper.getName = function(v567)
    local v568 = PlayerManager:getPlayers()
    for v2108, v2109 in pairs(v568) do
        MsgSender.sendMsg(
            "^FFFF00玩家名字: " ..
                v2109:getName() ..
                    "^00FF00对应id:  " ..
                        v2109.userId .. "^FFFF00队伍: " .. v2109:getTeamId() .. "^00FF00生命: " .. v2109:getHealth()
        )
    end
end
GMSetting:addItem("MadeInChina", "^FFFF99血量传送", "WarnTP")
GMHelper.WarnTP = function(v569)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                local v4502 = PlayerManager:getClientPlayer()
                local v4503 = v4502.Player:getHealth()
                if (v4503 <= WarnHP) then
                    local v5035 = VectorUtil.newVector3(0, 1.35, 0)
                    local v5036 = PlayerManager:getClientPlayer()
                    v5036.Player:setPosition(ClientPos)
                end
                GMHelper:WarnTP()
            end,
            10
        )
    end
end
GMSetting:addItem("MadeInChina", "^FFFF99血量传送(记录位置)", "WarnJL")
GMHelper.WarnJL = function(v570)
    ClientPos = PlayerManager:getClientPlayer():getPosition()
    local v571 = VectorUtil.newVector3(ClientPos.x, ClientPos.y, ClientPos.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPos.x .. " " .. ClientPos.y .. " " .. ClientPos.z .. " ")
end
GMSetting:addItem("MadeInChina", "^FFFF99警示临界值+", "AddWarnLimit")
GMHelper.AddWarnLimit = function(v572)
    WarnHP = WarnHP + 1
    UIHelper.showToast("^FF0000当前血量警示临界值: " .. WarnHP)
end
GMHelper.SubWarnLimit = function(v573)
    WarnHP = WarnHP - 1
    UIHelper.showToast("^FF0000当前血量警示临界值: " .. WarnHP)
end
GMSetting:addItem("MadeInChina", "^FFFF99警示临界值-", "SubWarnLimit")
GMHelper.SubWarnLimit = function(v574)
    WarnHP = WarnHP - 1
    UIHelper.showToast("^FF0000当前血量警示临界值: " .. WarnHP)
end
GMSetting:addItem("MadeInChina", "^00FFDD无限复活", "Fuhuo")
GMHelper.Fuhuo = function(v575)
    LuaTimer:schedule(
        function()
            PacketSender:getSender():sendRebirth()
            GMHelper:Fuhuo()
        end,
        10
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD无限复活(自定)", "SpamRespawn2")
GMHelper.SpamRespawn2 = function(v576)
    GMHelper:openInput(
        {""},
        function(v2110)
            for v3711 = 1, v2110 do
                PacketSender:getSender():sendRebirth()
            end
        end
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD绕过加速检测", "BypassOP")
GMHelper.BypassOP = function(v577)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
                GMHelper:One()
            end,
            250
        )
    end
end
GMHelper.One = function(v578)
    LuaTimer:schedule(
        function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
            GMHelper:BypassOP()
        end,
        800
    )
end
GMSetting:addItem("MadeInChina", "^00FFDDTracer", "Tracezr")
GMHelper.Tracezr = function(v579)
    local v580 = PlayerManager:getClientPlayer()
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
            local v2111 = PlayerManager:getPlayers()
            for v3712, v3713 in pairs(v2111) do
                if (v3713 ~= v580) then
                    PlayerManager:getClientPlayer().Player:addGuideArrow(v3713:getPosition())
                end
            end
        end,
        (tonumber(tostring(111110877 - 777), 2)),
        -(tonumber(tostring(778 - 777), 2))
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD飞行", "Fly")
GMHelper.Fly = function(v581, v582)
    A = not A
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    ClientHelper.putBoolPrefs("EnableFly", true)
    if A then
        UIHelper.showToast("^00FF0已开启")
        return
    end
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    ClientHelper.putBoolPrefs("EnableFly", true)
    UIHelper.showToast("^FF0000 已关闭")
end
GMSetting:addItem("MadeInChina", "耐久性", "NaiJiu")
GMHelper.NaiJiu = function(v583)
    A = not A
    ClientHelper.putBoolPrefs("IsShowItemDurability", true)
    if A then
        UIHelper.showToast("^00FF00已开启")
        return
    end
    ClientHelper.putBoolPrefs("IsShowItemDurability", true)
    UIHelper.showToast("^FF0000已关闭")
end
GMSetting:addItem("MadeInChina", "自动 早点睡", "sendConnectorChatMsg", 10)
GMHelper.sendConnectorChatMsg = function(v584, v585)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4504 = T(Global, "ChatService")
                for v4837 = 1, v585 do
                    v4504:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {content = "［此信息为自动刷］\n早点睡觉\n别看了\n傻逼CRIEX菜鸡\n次数：" .. v4837}
                    )
                end
            end
            GMHelper:sendConnectorChatMsg(v585)
        end,
        1000
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD自动锁人", "Rvankza")
GMHelper.Rvankza = function(v586)
    LuaTimer:scheduleTimer(
        function()
            local v2112 = PlayerManager:getClientPlayer().Player
            local v2113 = PlayerManager:getPlayers()
            for v3714, v3715 in pairs(v3715) do
                MathUtil:distanceSquare2d(v3715:getPosition(), v2112:getPosition())
                if (v3715 ~= v2112) then
                    LuaTimer:scheduleTimer(
                        function()
                            local v5037 =
                                VectorUtil.newVector3(
                                v3715:getPosition().x,
                                v3715:getPosition().y + (tonumber(tostring(787 - 777), 2)),
                                v3715:getPosition().z
                            )
                            v2112:setPosition(v5037)
                        end,
                        (tonumber(tostring(1787 - 777), 2)),
                        (tonumber(tostring(1111101777 - 777), 2))
                    )
                end
            end
        end,
        (tonumber(tostring(1111101778 - 777), 2)),
        -(tonumber(tostring(778 - 777), 2))
    )
end
GMSetting:addItem("MadeInChina", "^00FFDDEsp定位", "Tracer")
GMSetting:addItem("MadeInChina", "显示方块ID", "Tracer2")
GMHelper.Tracer2 = function(v587)
    local v588 = PlayerManager:getClientPlayer()
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
            local v2114 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2115 = math.rad(v2114)
            local v2116 = math.sin(v2115)
            local v2117 = math.cos(v2115)
            local v2118 = PlayerManager:getPlayers()
            local v2119 = v588:getPosition()
            Quay = VectorUtil.newVector3((-50 * v2116) + v2119.x, v2119.y, (50 * v2117) + v2119.z)
            Que = VectorUtil.newVector3((-50 * v2116) + v2119.x, v2119.y - 2, (50 * v2117) + v2119.z)
            blockId = EngineWorld:getBlockId(Que)
            for v3716, v3717 in pairs(v2118) do
                if (v3717 ~= v588) then
                    PlayerManager:getClientPlayer().Player:addGuideArrow(v3717:getPosition())
                end
            end
        end,
        50,
        99999999
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD空岛强制交易", "Cry01")
GMHelper.Cry01 = function(v589)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2120)
            local v2121 = T(Global, "PidPacketSender")
            v2121:tryRequestTrade(tonumber(v2120))
        end
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD无限交易", "Cry02")
GMHelper.Cry02 = function(v590)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2122)
            LuaTimer:schedule(
                function()
                    local v3718 = T(Global, "PidPacketSender")
                    v3718:tryRequestTrade(tonumber(v2122))
                end
            )
            GMHelper:Cry02()
        end,
        1000
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD未知", "SetMaxFPsS")
GMHelper.SetMaxFPsS = function(v591)
    GMHelper:openInput(
        {""},
        function(v2123)
            CGame.Instance():SetMaxFps(v2123)
        end
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD测试1", "JumpTP")
GMSetting:addItem("MadeInChina", "^00FFDD关聊天", "OffChat")
GMHelper.OffChat = function(v592)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
end
GMSetting:addItem("MadeInChina", "^00FFDD开聊天", "OnChat")
GMHelper.OnChat = function(v593)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
end
GMSetting:addItem("MadeInChina", "^00FFDD刷信息", "SpamChat")
GMHelper.SpamChat = function(v594)
    GMHelper:openInput(
        {""},
        function(v2124)
            LuaTimer:scheduleTimer(
                function()
                    GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v2124)
                end,
                5,
                1000000
            )
        end
    )
end
GMSetting:addItem("MadeInChina", "^00FFDD关聊天", "OffChat")
GMSetting:addItem("MadeInChina", "^00FFDD关聊天", "OffChat")
GMSetting:addItem("MadeInChina", " ^00FFDD自动打", "Autoclicks")
GMHelper.Autoclicks = function(v595)
    A = not A
    LuaTimer:cancel(v595.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v595.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(816, 316)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD自动跳跃", "AutoJump")
GMHelper.AutoJump = function(v596)
    E = not E
    LuaTimer:cancel(v596.timer)
    UIHelper.showToast("^FF0000关闭")
    if E then
        v596.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4505 = PlayerManager:getClientPlayer().Player:getBaseAction()
                if ((v4505 >= 0) and (v4505 <= 1) and (Ins == 0)) then
                    local v5038 = VectorUtil.newVector3(0, 1.2, 0)
                    PlayerManager:getClientPlayer().Player:moveEntity(v5038)
                    Ins = 1
                elseif ((v4505 >= 18) and (v4505 <= 19)) then
                    Ins = 0
                end
            end,
            100,
            9000000
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD自动打(EW)", "Autoclickew")
GMHelper.Autoclickew = function(v597)
    A = not A
    LuaTimer:cancel(v597.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v597.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4506 = PlayerManager:getClientPlayer().Player:getHeldItemId()
                if ((v4506 >= 267) and (v4506 <= 279)) then
                    CGame.Instance():handleTouchClick(816, 316)
                end
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD自动点击聊天框", "Autoclick1")
GMHelper.Autoclick1 = function(v598)
    A = not A
    LuaTimer:cancel(v598.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v598.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(75, 25)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD自动塔桥（起床战争）", "Autoclick2")
GMHelper.Autoclick2 = function(v599)
    A = not A
    LuaTimer:cancel(v599.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v599.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4507 = PlayerManager:getClientPlayer().Player:getHeldItemId()
                if ((v4507 >= 2441) and (v4507 <= 2444)) then
                    CGame.Instance():handleTouchClick(1315, 416)
                end
            end,
            10,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD测试", "Autoclick3")
GMHelper.Autoclick3 = function(v600)
    A = not A
    LuaTimer:cancel(v600.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v600.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(1500, 317)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", " ^00FFDD测试", "Autoclick4")
GMHelper.Autoclick4 = function(v601)
    A = not A
    LuaTimer:cancel(v601.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v601.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(1600, 400)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMSetting:addItem("MadeInChina", "^F48FB1设置速度(0~1000)", "SpeedManager")
GMSetting:addItem("MadeInChina", "^F48FB1秒方块", "FustBreakBlockMode")
GMSetting:addItem("MadeInChina", "^F48FB1开启飞行", "DevFlyI")
GMSetting:addItem("MadeInChina", "^F48FB1分身", "BlinkOP")
GMSetting:addItem("MadeInChina", "^F48FB1传送", "TeleportByUID")
GMSetting:addItem("MadeInChina", "^F48FB1锁人", "TPplayer")
GMSetting:addItem("MadeInChina", "^F48FB1中断锁人", "FunctionOFF")
GMSetting:addItem("MadeInChina", "^F48FB1解除中断", "FunctionON")
GMSetting:addItem("MadeInChina", "^F48FB1一键铺路", "SpawnBlockTowordv2")
GMSetting:addItem("MadeInChina", "^F48FB1生成平台(ID,半径)", "SpawnBlockSize")
GMSetting:addItem("MadeInChina", "^F48FB1隐藏框(开)", "setShowGunFlameCoordinate", true)
GMSetting:addItem("MadeInChina", "^00FFDD自动锁人", "Rvanka")
GMSetting:addItem("MadeInChina", "^00FFDDEsp定位", "Tracer")
GMSetting:addItem("MadeInChina", "^7803FF记录存档点1", "getPosition")
GMSetting:addItem("MadeInChina", "^F48FB1记录存档点2", "getPositionv1")
GMSetting:addItem("MadeInChina", "^8D6E63记录存档点3", "getPositionv2")
GMSetting:addItem("MadeInChina", "^616161记录存档点4", "getPositionv3")
GMSetting:addItem("MadeInChina", "^455A64记录存档点5", "getPositionv4")
GMSetting:addItem("MadeInChina", "^FFF176记录存档点6", "getPositionv5")
GMSetting:addItem("MadeInChina", "^80CBC4记录存档点7", "getPositionv6")
GMSetting:addItem("MadeInChina", "^5C6BC0记录存档点8", "getPositionv7")
GMSetting:addItem("MadeInChina", "^CE93D8记录存档点9", "getPositionv8")
GMSetting:addItem("MadeInChina", "^EF9A9A记录存档点10", "getPositionv9")
GMSetting:addItem("MadeInChina", "^7803FF读取存档点1(分身)", "TpPosition")
GMSetting:addItem("MadeInChina", "^F48FB1读取存档点2(分身)", "TpPositionv1")
GMSetting:addItem("MadeInChina", "^8D6E63读取存档点3(分身)", "TpPositionv2")
GMSetting:addItem("MadeInChina", "^616161读取存档点4(分身)", "TpPositionv3")
GMSetting:addItem("MadeInChina", "^455A64读取存档点5(分身)", "TpPositionv4")
GMSetting:addItem("MadeInChina", "^FFF176读取存档点6(分身)", "TpPositionv5")
GMSetting:addItem("MadeInChina", "^80CBC4读取存档点7(分身)", "TpPositionv6")
GMSetting:addItem("MadeInChina", "^5C6BC0读取存档点8(分身)", "TpPositionv7")
GMSetting:addItem("MadeInChina", "^CE93D8读取存档点9(分身)", "TpPositionv8")
GMSetting:addItem("MadeInChina", "^EF9A9A读取存档点10(分身)", "TpPositionv9")
GMSetting:addItem("MadeInChina", "^7803FF读取存档点1(本体)", "ToPosition")
GMSetting:addItem("MadeInChina", "▢FF884898秒方块", "FustBreakBlockMode")
GMSetting:addItem("MadeInChina", "▢FF884898开启飞行", "DevFlyI")
GMSetting:addItem("MadeInChina", "▢FFFF0000分身", "BlinkOP")
GMSetting:addItem("MadeInChina", "^00FFDD头部信息", "HeadText")
GMSetting:addItem("MadeInChina", "^00FFDD设置高度", "AdvancedUp")
GMSetting:addItem("MadeInChina", "^00FFDD设置X坐标", "AdvancedIn")
GMSetting:addItem("MadeInChina", "^00FFDD设置Z坐标", "AdvancedOn")
GMSetting:addItem("MadeInChina", "^00FFDD设置三维坐标", "AdvancedDirect")
GMSetting:addItem("MadeInChina", "^00FFDDViewBobbing", "ViewBobbing")
GMSetting:addItem("MadeInChina", "^00FFDDBlockmanCollision", "BlockmanCollision")
GMSetting:addItem("MadeInChina", "^00FFDD去除迷雾", "Fog")
GMSetting:addItem("MadeInChina", "^00FFDDWWE_Camera", "WWE_Camera")
GMSetting:addItem("MadeInChina", "^00FFDD挥手速度", "ArmSpeed")
GMSetting:addItem("MadeInChina", "^00FFDD拉弓速度", "BowSpeed", 1000)
GMSetting:addItem("MadeInChina", "^00FFDD变成男模型", "changePlayerActor", 1)
GMSetting:addItem("MadeInChina", "^00FFDD变成女模型", "changePlayerActor", 2)
GMSetting:addItem("MadeInChina", "^00FFDDShowAllCobtrol", "ShowAllCobtrolXD")
GMSetting:addItem("MadeInChina", "^00FFDDJailBreakBypass", "JailBreakBypass")
GMSetting:addItem("MadeInChina", "^00FFDD穿墙", "Noclip")
GMSetting:addItem("MadeInChina", "^00FFDD长跳", "LongJump")
GMSetting:addItem("MadeInChina", "^00FFDD/tp", "tpPos")
GMSetting:addItem("MadeInChina", "^00FFDD跳跃高度", "JumpHeight")
GMSetting:addItem("MadeInChina", "^00FFDD隐藏手持物品", "HideHoldItem")
GMSetting:addItem("MadeInChina", "^00FFDD修改模型大小(巨人挂)", "changeScale")
GMSetting:addItem("MadeInChina", "^00FFDDWaterPush", "WaterPush")
GMSetting:addItem("MadeInChina", "^00FFDDSharpFly", "SharpFly")
GMSetting:addItem("MadeInChina", "^00FFDDBlockOFF", "BlockOFF")
GMSetting:addItem("MadeInChina", "^00FFDDBlockON", "BlockON")
GMSetting:addItem("MadeInChina", "^00FFDDSpeedUp", "SpeedUp")
GMSetting:addItem("MadeInChina", "^00FFDD开启透视方块(id)", "XRayManagerON")
GMSetting:addItem("MadeInChina", "^00FFDD关闭透视方块(id)", "XRayManagerOFF")
GMSetting:addItem("MadeInChina", "^00FFDDSettingLongjump", "SettingLongjump")
GMSetting:addItem("MadeInChina", "^00FFDD飞行穿墙", "DevnoClip")
GMSetting:addItem("MadeInChina", "^00FFDD爬墙高度", "StepHeight")
GMSetting:addItem("MadeInChina", "^00FFDD隐藏盔甲", "SetHideAndShowArmor")
GMSetting:addItem("MadeInChina", "^00FFDD改变自身模型", "ChangeActorForMe")
GMSetting:addItem("MadeInChina", "^00FFDD非石头类方块穿墙", "NoclipOP")
GMSetting:addItem("MadeInChina", "^00FFDDQuickPlaceBlock", "quickblock")
GMSetting:addItem("MadeInChina", "^00FFDDParachute", "startParachute")
GMSetting:addItem("MadeInChina", "^00FFDD滑翔伞飞行", "FlyParachute")
GMSetting:addItem("MadeInChina", "^FFFF99无视末地石", "NoEndStone1")
GMSetting:addItem("MadeInChina", "^FFFF99无视木板", "NoWool1")
GMSetting:addItem("MadeInChina", "^FFFF99无视羊毛", "NoOakPlanks1")
GMSetting:addItem("MadeInChina", "^FFFF99无视黑曜石", "NoObsidian1")
GMSetting:addItem("MadeInChina", "^FFFF99无视玻璃", "NoGlass1")
GMSetting:addItem("MadeInChina", "^FFFF99无视钻石炸弹", "NoBomb1")
GMSetting:addItem("MadeInChina", "^FFFF99无视铁门", "NoIDoor1")
GMSetting:addItem("MadeInChina", "^FFFF99无视石英", "NoQuartz1")
GMSetting:addItem("MadeInChina", "^00FFDD高度+", "inTheAirCheat")
GMSetting:addItem("MadeInChina", "^FFFF99X轴移动20格", "GoTO10Blocks")
GMSetting:addItem("MadeInChina", "^FFFF99X轴返回20格", "GoTO20Blocks")
GMSetting:addItem("MadeInChina", "^FFFF99Z轴移动20格", "GoTO10BlocksDown")
GMSetting:addItem("MadeInChina", "^FFFF99Z轴返回20格", "GoTO20BlocksDown")
GMSetting:addItem("MadeInChina", "^00FFDD直线传送50格", "linetp")
GMSetting:addItem("MadeInChina", "^FFFF99X轴返回50格", "XRTP50")
GMSetting:addItem("MadeInChina", "^FFFF99Z轴移动50格", "ZTP50")
GMSetting:addItem("MadeInChina", "^FFFF99Z轴返回50格", "ZRTP50")
GMSetting:addItem("MadeInChina", "^FFFF99起床战争绕过飞行检测", "AntiFlyDetect")
GMSetting:addItem("MadeInChina", "^00FFDD直线传送25格", "linetp25")
GMSetting:addItem("MadeInChina", "^FFFF99正东朝向", "East")
GMSetting:addItem("MadeInChina", "^FFFF99正西朝向", "West")
GMSetting:addItem("MadeInChina", "^FFFF99正南朝向", "south")
GMSetting:addItem("MadeInChina", "^FFFF99正北朝向", "north")
GMSetting:addItem("MadeInChina", "^00FFDD直线传送5格", "linetp5")
GMSetting:addItem("MadeInChina", "^FFFF99直线逆向传送50格", "linetpr")
GMSetting:addItem("MadeInChina", "^FFFF99直线逆向传送5格", "linetpr5")
GMSetting:addItem("MadeInChina", "^FFFF99关闭飞行", "OFFFLY")
GMSetting:addItem("MadeInChina", "^FFFF99X轴移动50格", "XTP50")
GMSetting:addItem("MadeInChina", "^FFFF99直线逆向传送25格", "linetpr25")
GMSetting:addItem("MadeInChina", "^FFFF99右转5°", "East5")
GMSetting:addItem("MadeInChina", "^FFFF99左转5°", "West5")
GMSetting:addItem("MadeInChina", "^FFFF99区域打印方块", "SpawnBlockClone")
GMSetting:addItem("MadeInChina", "^FFFF99存储建筑", "CloneBlocks")
GMSetting:addItem("MadeInChina", "^FFFF99打印建筑", "AddBlocks")
GMSetting:addItem("MadeInChina", "^FFFF99存储建筑(移动)", "CloneBlocksMove")
GMSetting:addItem("MadeInChina", "^FFFF99打印建筑(移动)", "AddBlocksMove")
GMSetting:addItem("MadeInChina", "^FFDD00设置时间", "SetTime")
GMSetting:addItem("MadeInChina", "^FFDD00白天", "ChangeTime", false)
GMSetting:addItem("MadeInChina", "^FFDD00黑夜", "ChangeTime", true)
GMSetting:addItem("MadeInChina", "^FFDD00开启/关闭 昼夜循环", "StartTime")
GMSetting:addItem("MadeInChina", "^FFDD00SetYaw", "setYaw")
GMSetting:addItem("MadeInChina", "^FFDD00生成NPC", "SpawnNPC")
GMSetting:addItem("MadeInChina", "^FFDD00生成掉落物", "SpawnItem")
GMSetting:addItem("MadeInChina", "^FFDD00擦除指定坐标方块", "SetBlockToAir")
GMSetting:addItem("MadeInChina", "^FFDD00生成方块(id)", "SpawnBlock")
GMSetting:addItem("MadeInChina", "^FFDD00生成车(id)", "spawnCar")
GMSetting:addItem("MadeInChina", "^FFDD00SpYaw", "SpYaw")
GMSetting:addItem("MadeInChina", "^FFDD00SpYawSet", "SpYawSet")
GMSetting:addItem("MadeInChina", "^FFDD00修改发饰", "ChangeHair")
GMSetting:addItem("MadeInChina", "^FFDD00修改面部", "ChangeFace")
GMSetting:addItem("MadeInChina", "^FFDD00顶部装饰", "ChangeTops")
GMSetting:addItem("MadeInChina", "^FFDD00ChangePants", "ChangePants")
GMSetting:addItem("MadeInChina", "^FFDD00修改翅膀", "ChangeWing")
GMSetting:addItem("MadeInChina", "^FFDD00ChangeScarf", "ChangeScarf")
GMSetting:addItem("MadeInChina", "^FFDD00修改眼镜", "ChangeGlasses")
GMSetting:addItem("MadeInChina", "^FFDD00修改鞋子", "ChangeShoes")
GMSetting:addTab("megaRICHHmade", 4)
GMSetting:addItem("megaRICHHmade", "Парашют", "startParachute")
GMSetting:addItem("megaRICHHmade", "Парашют+Полёт", "FlyParachute")
GMSetting:addItem("megaRICHHmade", "Джетпак", "JetPack")
GMSetting:addItem("megaRICHHmade", "Респавн®", "init1")
GMSetting:addItem("megaRICHHmade", "Невидимость", "init2")
GMSetting:addItem("megaRICHHmade", "Скрыть панель", "makeGmButtonTran")
GMSetting:addItem("megaRICHHmade", "Скольжение", "setGlide")
GMSetting:addItem("megaRICHHmade", "Респавн стандарт", "RespawnTool")
GMSetting:addItem("megaRICHHmade", "Вернуть панель", "makeGmButtonShow")
GMSetting:addItem("megaRICHHmade", "Ракета+Полёт", "test555")
GMSetting:addItem("megaRICHHmade", "????", "test666")
GMSetting:addItem("megaRICHHmade", "Дальнозоркость", "ReachIn")
GMSetting:addItem("megaRICHHmade", "ВключитьТемноту", "ONDARK")
GMSetting:addItem("megaRICHHmade", "Неизвестно", "test2222")
GMSetting:addItem("megaRICHHmade", "Неизвестно", "test1222")
GMSetting:addItem("megaRICHHmade", "Неизвестно", "test2300")
GMSetting:addItem("megaRICHHmade", "Включить ХП", "ShowHP")
GMSetting:addItem("megaRICHHmade", "Выключить ХП", "HideHP")
GMSetting:addItem("megaRICHHmade", "ДжоДжо Эффект Он", "SpeedLineMode")
GMSetting:addItem("megaRICHHmade", "ДжоДжо Эффект Офф", "SpeedLineModeDisable")
GMSetting:addItem("megaRICHHmade", "Темный Эффект Он", "PatternTorchMode")
GMSetting:addItem("megaRICHHmade", "Темный Эффект Офф", "PatternTorchModeOFF")
GMSetting:addItem("megaRICHHmade", "Тп 1", "Tus")
GMSetting:addItem("megaRICHHmade", "Тп 2", "EnterGameTest")
GMSetting:addItem("megaRICHHmade", "ShowYaw", "YawQ")
GMSetting:addItem("megaRICHHmade", "ShowID", "UserQ")
GMSetting:addItem("megaRICHHmade", "ItemReveal", "ItemQ")
GMSetting:addItem("megaRICHHmade", "ShowTime", "TimeW")
GMSetting:addItem("megaRICHHmade", "Славные крылья", "RainbowWing")
GMSetting:addItem("megaRICHHmade", "Святые крылья крылья", "XLGoldWing")
GMSetting:addItem("megaRICHHmade", "Красные крылья", "RedWing")
GMSetting:addItem("megaRICHHmade", "UwU", "CokieUwU")
GMSetting:addItem("megaRICHHmade", "Диалог+Скрипт", "customDialogScr")
GMSetting:addItem("megaRICHHmade", "Диалог 1", "noLeftDialog")
GMSetting:addItem("megaRICHHmade", "Диалог 2", "noRightDialog")
GMSetting:addItem("megaRICHHmade", "Тосты По Акции", "Toast")
GMSetting:addItem("megaRICHHmade", "Тостер", "Pizdec")
GMSetting:addItem("megaRICHHmade", "Диалог 3-4", "GetTextLang")
GMSetting:addItem("megaRICHHmade", "Показать ХП Игроков", "ToggleShowPlayersHP")
GMSetting:addItem("megaRICHHmade", "Copy Players Info", "CopyPlayersInfo")
GMSetting:addItem("megaRICHHmade", "Close Game", "CloseGame")
GMSetting:addItem("megaRICHHmade", "Switch 1st person", "SwitchPerson", 0)
GMSetting:addItem("megaRICHHmade", "Switch 2nd person", "SwitchPerson", 1)
GMSetting:addItem("megaRICHHmade", "Switch 3rd person", "SwitchPerson", 2)
GMSetting:addItem("megaRICHHmade", "Hide players actor", "HidePlayersActor")
GMSetting:addItem("megaRICHHmade", "Hide players", "HidePlayers")
GMSetting:addItem("megaRICHHmade", "AFKMode", "AFKmode")
GMSetting:addItem("megaRICHHmade", "MessageTest", "GUItest1")
GMSetting:addItem("megaRICHHmade", "FOV", "SetFOV")
GMSetting:addItem("megaRICHHmade", "PlayerReachAttack", "ReachSet")
GMSetting:addItem("megaRICHHmade", "BlockReachAttack", "BlockReachSet")
GMSetting:addItem("megaRICHHmade", "SpamRespawn", "SpamRespawn")
GMSetting:addItem("megaRICHHmade", "Scaffold", "Scaffold")
GMSetting:addItem("megaRICHHmade", "Scaffald", "Scaffald")
GMSetting:addItem("megaRICHHmade", "Scaffuld", "Scaffuld")
GMSetting:addItem("megaRICHHmade", "Модификатор", "Creator")
GMSetting:addItem("megaRICHHmade", "ViewParachute", "XLParachute")
GMSetting:addItem("megaRICHHmade", "ViewTNT", "TNTButtonView")
GMSetting:addItem("megaRICHHmade", "AutoParachute", "AutoParachute")
GMSetting:addItem("megaRICHHmade", "ViewFreecam", "ViewFreecam")
GMSetting:addItem("megaRICHHmade", "HideFreecam", "ViewFreecamX")
GMSetting:addItem("megaRICHHmade", "HideParachute", "XLParachuteX")
GMSetting:addItem("megaRICHHmade", "HideTNT", "TNTButtonViewX")
GMSetting:addItem("megaRICHHmade", "AutoSpawnNPC", "AutoSpawnNPC")
GMSetting:addItem("megaRICHHmade", "ViewBomba", "ViewBomba")
GMSetting:addItem("megaRICHHmade", "HideBomba", "ViewBombaX")
GMSetting:addItem("megaRICHHmade", "ViewRaket", "ViewRaket")
GMSetting:addItem("megaRICHHmade", "HideRaket", "ViewRaketX")
GMSetting:addItem("megaRICHHmade", "ViewRespawn", "ViewRespawn")
GMSetting:addItem("megaRICHHmade", "HideRespawn", "ViewRespawnX")
GMSetting:addItem("megaRICHHmade", "Iikj", "Iikj")
GMSetting:addItem("megaRICHHmade", "Razmer1", "Razmer1")
GMSetting:addItem("megaRICHHmade", "Razmer2", "Razmer2")
GMSetting:addItem("megaRICHHmade", "Razmer3", "Razmer3")
GMSetting:addItem("megaRICHHmade", "ViewXPWarnLevel", "XPWarnLevel")
GMSetting:addItem("megaRICHHmade", "openDebug", "openDebug")
GMSetting:addItem("megaRICHHmade", "closeDebug", "closeDebug")
GMSetting:addItem("megaRICHHmade", "openScreenRecord", "openScreenRecord")
GMSetting:addItem("megaRICHHmade", "Hitboxs1", "ChangeActorTextures", "package_1.zip")
GMSetting:addItem("megaRICHHmade", "Hitboxs2", "ChangeActorTextures", "package_2.zip")
GMSetting:addItem("megaRICHHmade", "BW", "BW")
GMSetting:addItem("megaRICHHmade", "BWV2", "BWV2")
GMSetting:addItem("megaRICHHmade", "setVelocity", "setVelocity")
GMSetting:addItem("megaRICHHmade", "SetMaxCPS", "SetMaxCPS")
GMSetting:addItem("megaRICHHmade", "SetMaxFPS", "SetMaxFPS")
GMSetting:addItem("megaRICHHmade", "tpkill", "tpkill")
GMSetting:addItem("megaRICHHmade", "Rvanka2", "Rvanka2")
GMSetting:addItem("megaRICHHmade", "AllPlayerLocations", "AllPlayerLocations")
GMSetting:addItem("megaRICHHmade", "MyLocation", "MyLocation")
GMSetting:addItem("megaRICHHmade", "SpamChat", "SpamChat")
GMSetting:addItem("megaRICHHmade", "GUISkyblockTest1", "GUISkyblockTest1")
GMSetting:addItem("megaRICHHmade", "GUISkyblockTest2", "GUISkyblockTest2")
GMSetting:addItem("megaRICHHmade", "GUISkyblockTest3", "GUISkyblockTest3")
GMSetting:addItem("megaRICHHmade", "testModiyScript", "testModiyScript")
GMSetting:addItem("megaRICHHmade", "setClearColorDisabled", "setClearColorDisabled")
GMSetting:addItem("megaRICHHmade", "Scaffold V2", "ScaffoldV2")
GMSetting:addItem("megaRICHHmade", "Bhop", "Bhop")
GMSetting:addItem("megaRICHHmade", "fuckclickcd", "fuckclickcd")
GMSetting:addItem("megaRICHHmade", "reachhit", "reachhit")
GMSetting:addItem("megaRICHHmade", "Respawn V2", "WarnTP")
GMSetting:addTab("^FFFF00Wafex", 5)
GMSetting:addItem("^FFFF00Wafex", "^00FFDDHealthBar", "ShowHealthBar")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDInfoBar", "testHui")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDInfoXYZ", "AllPlayerLocations")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDMyInfoXYZ", "MyLocation")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDCannon (Button)", "wafexTest")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDTeleportAura", "TeleportAura")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAimBot", "AimBotw")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAutoClick", "AutoClickzxc")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDJetPack", "JetPack")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDTurnHead", "AFKmode")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDTNT (Button)", "TntTag")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDParachute (Button)", "Parachute")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAutoParachute", "AutoParachute")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDRandomPlayer (TP)", "TeleportToRandomPlayer")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAutoBridge", "AutoClickNearest")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDHideHP", "HideHP")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDShowHP", "ShowHP")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDNearestPlayer (TP)", "AutoMoveToNearestPlayer")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDRotateHead", "RotateHeadTowardsNearestPlayer")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAutoSpawnNPC", "AutoSpawnNPC")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAutoSpeedChange", "AdjustSpeedBasedOnDistance")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChangeTargetAimBot", "ChangeTargetAimBot")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDSetMaxFPS", "SetMaxFPS")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChangePlayerSize", "ChangePlayerSize")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDTurnHead (All)", "wafexTest2")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDInfinite Bridge", "infbrid1")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDVelocity", "setVelocity")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDFreezeUI", "FreezeUI")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDSpamMessage", "popkashlen")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChatInfoXYZ", "testwafexlol")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChatInfiniteCount", "infiniteCountdownToChat")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChangeWeather", "ChangeWeather")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDshowRainbowText", "showRainbowText")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDTeleportOnClick", "TeleportOnClick")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDtest", "teleportAuraWafex")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDChatRGB", "showRainbowAnimation")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAirCraft", "teleportToPlane")
GMSetting:addItem("^FFFF00Wafex", "^00FFDDAimBot 2", "AimBot2")
GMSetting:addTab("testg")
for v602 = 1, 72 do
    GMSetting:addItem("testg", tostring(v602), "+" .. tostring(v602))
end
GMSetting:addTab("^013AA3AimBot")
GMSetting:addItem("^013AA3AimBot", "^00FFDDAimBotON", "StartAimBotTimer")
GMSetting:addItem("^013AA3AimBot", "^00FFDDAimBotOFF", "StopAimBotTimer")
GMSetting:addItem("^013AA3AimBot", "^00FFDDAimBot2ON", "StartAimBotTimer2")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDCube", "SpawnCube")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDSphere", "SpawnSphere")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDPyramid", "SpawnPyramid")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDRhombus", "SpawnRhombus")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDHide", "HideST")
GMSetting:addItem("^FF00FFConstruction", "^00FFDDShow", "ShowST")
GMSetting:addTab("^FFFF99NoBlocks", 3)
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoEndStone", "NoEndStone1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoWood", "NoWool1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoWool", "NoOakPlanks1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoObsidian", "NoObsidian1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoGlass", "NoGlass1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoDiamondBomb", "NoBomb1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoIronDoor", "NoIDoor1")
GMSetting:addItem("^FFFF99NoBlocks", "^FFFF99NoQuartzBlock", "NoQuartz1")
GMSetting:addTab("^FF00E2GUIManager", 4)
GMSetting:addItem("^FF00E2GUIManager", "test", "test2222")
GMSetting:addItem("^FF00E2GUIManager", "test2", "test1222")
GMSetting:addItem("^FF00E2GUIManager", "testINFO", "test2300")
GMSetting:addItem("^FF00E2GUIManager", "MessageTest", "GUItest1")
GMSetting:addTab("^FF00E2UIManager", 5)
GMSetting:addItem("^FF00E2UIManager", "^FF55FFOpen UI", "GUIOpener")
GMSetting:addItem("^FF00E2UIManager", "^FF55FFUI OFF", "GUIViewOFF")
GMSetting:addItem("^FF00E2UIManager", "^FF55FFInsideGUI", "InsideGUI")
GMSetting:addItem("^FF00E2UIManager", "^FF55FFSetAplhaGUI", "SetAlpha")
GMSetting:addTab("LuaInjection", 6)
GMSetting:addItem("LuaInjection", "PutBoolPrefs", "putBoolPrefs")
GMSetting:addItem("LuaInjection", "PutFloatPrefs", "putFloatPrefs")
GMSetting:addItem("LuaInjection", "PutIntPrefs", "putIntPrefs")
GMSetting:addItem("LuaInjection", "PutStringPrefs", "putStringPrefs")
GMSetting:addTab("Textures", 7)
GMSetting:addItem("Textures", "Reset", "ChangeBlockTextures", "")
GMSetting:addItem("Textures", "Texture1", "ChangeBlockTextures", "package_01_64.zip")
GMSetting:addItem("Textures", "2", "ChangeBlockTextures", "package_02_32.zip")
GMSetting:addItem("Textures", "Texture3", "ChangeBlockTextures", "package_03_32.zip")
GMSetting:addItem("Textures", "Texture4", "ChangeBlockTextures", "package_04_64.zip")
GMSetting:addItem("Textures", "Texture5", "ChangeBlockTextures", "package_05_64.zip")
GMSetting:addItem("Textures", "Texture6", "ChangeBlockTextures", "package_06_64.zip")
GMSetting:addItem("Textures", "Texture7", "ChangeBlockTextures", "package_07_64.zip")
GMSetting:addItem("Textures", "Texture8", "ChangeBlockTextures", "package_08_64.zip")
GMSetting:addItem("Textures", "Texture9", "ChangeBlockTextures", "package_09_64.zip")
GMSetting:addTab("^7803FFTeleport", 8)
GMSetting:addItem("^7803FFTeleport", "^7803FFHunger Games Map1", "EnterGame", "m1001_1", "g1001")
GMSetting:addItem("^7803FFTeleport", "^7803FFHunger Games Map2", "EnterGame", "m1001_2", "g1001")
GMSetting:addItem("^7803FFTeleport", "^7803FFHunger Games Map3", "EnterGame", "m1001_3", "g1001")
GMSetting:addItem("^7803FFTeleport", "^7803FFHunger Games Map4", "EnterGame", "m1001_4", "g1001")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Wars Map1", "EnterGame", "m1002_1", "g1002")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Wars Map2", "EnterGame", "m1002_2", "g1002")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Wars Map2", "EnterGame", "m1002_3", "g1002")
GMSetting:addItem("^7803FFTeleport", "^7803FFBow Spleef Map1", "EnterGame", "m701", "g1007")
GMSetting:addItem("^7803FFTeleport", "^7803FFBow Spleef Map2", "EnterGame", "m702", "g1007")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed War", "EnterGame", "m1008_2", "g1008")
GMSetting:addItem("^7803FFTeleport", "^7803FFMurder Mystery", "EnterGame", "m901", "g1009")
GMSetting:addItem("^7803FFTeleport", "^7803FFTnt Run", "EnterGame", "m1001", "g1010")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowBall Battle Map1", "EnterGame", "m1101", "g1011")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowBall Battle Map2", "EnterGame", "m1102", "g1011")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowBall Battle Map3", "EnterGame", "m1103", "g1011")
GMSetting:addItem("^7803FFTeleport", "^7803FFZombie Infecting", "EnterGame", "m1301", "g1013")
GMSetting:addItem("^7803FFTeleport", "^7803FFJail Break", "EnterGame", "m1401", "g1014")
GMSetting:addItem("^7803FFTeleport", "^7803FFTreasure Hunter", "EnterGame", "m1501_1", "g1015")
GMSetting:addItem("^7803FFTeleport", "^7803FFPUBG", "EnterGame", "m1601", "g1016")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide and seak", "EnterGame", "m1701", "g1017")
GMSetting:addItem("^7803FFTeleport", "^7803FFEgg Wars Map1", "EnterGame", "m1018_1", "g1018")
GMSetting:addItem("^7803FFTeleport", "^7803FFEgg Wars Map2", "EnterGame", "m1018_2", "g1018")
GMSetting:addItem("^7803FFTeleport", "^7803FFEgg Wars Map3", "EnterGame", "m1018_3", "g1018")
GMSetting:addItem("^7803FFTeleport", "^7803FFEgg Wars Map4", "EnterGame", "m1018_4", "g1018")
GMSetting:addItem("^7803FFTeleport", "^7803FFEgg Wars Map5", "EnterGame", "m1018_5", "g1018")
GMSetting:addItem("^7803FFTeleport", "^7803FFAliens Attack", "EnterGame", "m1019_1", "g1019")
GMSetting:addItem("^7803FFTeleport", "^7803FFMini Town", "EnterGame", "m1020_1", "g1020")
GMSetting:addItem("^7803FFTeleport", "^7803FFRainbow parkour Map1", "EnterGame", "m1021_1", "g1021")
GMSetting:addItem("^7803FFTeleport", "^7803FFRainbow parkour Map2", "EnterGame", "m1021_2", "g1021")
GMSetting:addItem("^7803FFTeleport", "^7803FFRainbow parkour Map3", "EnterGame", "m1021_3", "g1021")
GMSetting:addItem("^7803FFTeleport", "^7803FFCapture The Flag", "EnterGame", "m1022_1", "g1022")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild Battle", "EnterGame", "m1023_1", "g1023")
GMSetting:addItem("^7803FFTeleport", "^7803FFGem Knight", "EnterGame", "m1024_1", "g1024")
GMSetting:addItem("^7803FFTeleport", "^7803FFHero Tycoon 2", "EnterGame", "m1025_1", "g1025")
GMSetting:addItem("^7803FFTeleport", "^7803FFTnt Tag Map1", "EnterGame", "m1026_1", "g1026")
GMSetting:addItem("^7803FFTeleport", "^7803FFTnt Tag Map2", "EnterGame", "m1026_2", "g1026")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Royale", "EnterGame", "m1027_1", "g1027")
GMSetting:addItem("^7803FFTeleport", "^7803FFUltimate Fighting", "EnterGame", "m1028_2", "g1028")
GMSetting:addItem("^7803FFTeleport", "^7803FFMega Walls Map1", "EnterGame", "m1029_1", "g1029")
GMSetting:addItem("^7803FFTeleport", "^7803FFMega Walls Map2", "EnterGame", "m1029_2", "g1029")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowman Defender Map1", "EnterGame", "m1030_1", "g1030")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowman Defender Map2", "EnterGame", "m1030_2", "g1030")
GMSetting:addItem("^7803FFTeleport", "^7803FFSnowman Defender Map3", "EnterGame", "m1030_3", "g1030")
GMSetting:addItem("^7803FFTeleport", "^7803FFRanchers", "EnterGame", "m1031_1", "g1031")
GMSetting:addItem("^7803FFTeleport", "^7803FFBlockman Strike Lobby", "EnterGame", "m1032_1", "g1032")
GMSetting:addItem("^7803FFTeleport", "^7803FFBlockman Strike Map1", "EnterGame", "m1033_2", "g1033")
GMSetting:addItem("^7803FFTeleport", "^7803FFBlockman Strike Map2", "EnterGame", "m1033_3", "g1033")
GMSetting:addItem("^7803FFTeleport", "^7803FFBlockman Strike Map3", "EnterGame", "m1033_4", "g1033")
GMSetting:addItem("^7803FFTeleport", "^7803FFEnder Vs Slender Map1", "EnterGame", "m1036_1", "g1036")
GMSetting:addItem("^7803FFTeleport", "^7803FFEnder Vs Slender Map2", "EnterGame", "m1036_2", "g1036")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide And Seek2", "EnterGame", "m1037_1", "g1037")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide And Seek2 Map1", "EnterGame", "m1038_1", "g1038")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide And Seek2 Map2", "EnterGame", "m1038_2", "g1038")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide And Seek2 Map3", "EnterGame", "m1039_1", "g1039")
GMSetting:addItem("^7803FFTeleport", "^7803FFHide And Seek2 Map4", "EnterGame", "m1039_2", "g1039")
GMSetting:addItem("^7803FFTeleport", "^7803FFBird Simulator", "EnterGame", "m1041_2", "g1041")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1042_1", "g1042")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1043_1", "g1043")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1043_2", "g1043")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1043_3", "g1043")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1043_4", "g1043")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1044_1", "g1044")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1044_2", "g1044")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1044_3", "g1044")
GMSetting:addItem("^7803FFTeleport", "^7803FFBuild And Shoot", "EnterGame", "m1044_4", "g1044")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed War Lobby", "EnterGame", "m1046_2", "g1046")
GMSetting:addItem("^7803FFTeleport", "^7803FFRealm City", "EnterGame", "m1047_1", "g1047")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Block", "EnterGame", "m1048_1", "g1048")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Block Mining", "EnterGame", "m1049_2", "g1049")
GMSetting:addItem("^7803FFTeleport", "^7803FFSky Block Product", "EnterGame", "m1050_1", "g1050")
GMSetting:addItem("^7803FFTeleport", "^7803FFWalking Dead", "EnterGame", "m1051_1", "g1051")
GMSetting:addItem("^7803FFTeleport", "^7803FFBlock Fort", "EnterGame", "m1052", "g1052")
GMSetting:addItem("^7803FFTeleport", "^7803FFBattle Royale", "EnterGame", "m1053_1", "g1053")
GMSetting:addItem("^7803FFTeleport", "^7803FFLucky Block Sky war", "EnterGame", "m1054_1", "g1054")
GMSetting:addItem("^7803FFTeleport", "^7803FFLucky Block Sky war", "EnterGame", "m1054_2", "g1054")
GMSetting:addItem("^7803FFTeleport", "^7803FFWWE", "EnterGame", "m1055_1", "g1055")
GMSetting:addItem("^7803FFTeleport", "^7803FFAngry Pets", "EnterGame", "m1056_1", "g1056")
GMSetting:addItem("^7803FFTeleport", "^7803FFAngry Pets", "EnterGame", "m1057_1", "g1057")
GMSetting:addItem("^7803FFTeleport", "^7803FFLucky Blocks", "EnterGame", "m1058_1", "g1058")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed wars", "EnterGame", "m1061_1", "g1061")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed wars", "EnterGame", "m1062_1", "g1062")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed wars", "EnterGame", "m1063_1", "g1063")
GMSetting:addItem("^7803FFTeleport", "^7803FFBullets fly", "EnterGame", "m1064_1", "g1064")
GMSetting:addItem("^7803FFTeleport", "^7803FFBed wars 10vs10", "EnterGame", "m1065_1", "g1065")
GMSetting:addTab("^FF0378Camera", 9)
GMSetting:addItem("^FF0378Camera", "^D45959PersonView", "PersonView")
GMSetting:addItem("^FF0378Camera", "^D45959Camera", "CameraFunct")
GMSetting:addItem("^FF0378Camera", "^D45959FlipCamera", "CameraFlipModeON")
GMSetting:addItem("^FF0378Camera", "^D45959FlipCameraRESET", "CameraFlipModeRESET")
GMSetting:addItem("^FF0378Camera", "^D45959Bobbing", "SetBobbing")
GMSetting:addItem("^FF0378Camera", "^D45959FOV", "SetFOV")
GMSetting:addTab("^59D471ActionXD", 10)
GMSetting:addItem("^59D471ActionXD", "^13F03FResetXD", "ResetXD")
GMSetting:addItem("^59D471ActionXD", "^13F03FActionSet", "ActionSet")
GMSetting:addItem("^59D471ActionXD", "^13F03FSneak", "SneakXD")
GMSetting:addItem("^59D471ActionXD", "^13F03Fgun", "WalkSMG")
GMSetting:addItem("^59D471ActionXD", "^13F03FSit1", "SitXD")
GMSetting:addItem("^59D471ActionXD", "^13F03FSit2", "SitXD2")
GMSetting:addItem("^59D471ActionXD", "^13F03FSit3", "SitXD3")
GMSetting:addItem("^59D471ActionXD", "^13F03Fride_dragon", "rideDragonXD")
GMSetting:addItem("^59D471ActionXD", "^13F03Fswim", "SwimXD")
GMSetting:addTab("^13AEF0RenderWorld", 11)
GMSetting:addItem("^13AEF0RenderWorld", "^7ED7FCSetRenderWorld", "RenderWorld")
GMSetting:addItem("^13AEF0RenderWorld", "^7ED7FCCloudsStop", "CloudsOFF", true)
GMSetting:addItem("^13AEF0RenderWorld", "^7ED7FCBreakParticles", "BreakParticles")
GMSetting:addItem("^13AEF0RenderWorld", "^7ED7FCOFFDARK", "OFFDARK")
GMSetting:addTab("^FFAA00Special", 12)
GMSetting:addItem("^FFAA00Special", "^FFDD00SetTime", "SetTime")
GMSetting:addItem("^FFAA00Special", "^FFDD00Day", "ChangeTime", false)
GMSetting:addItem("^FFAA00Special", "^FFDD00Night", "ChangeTime", true)
GMSetting:addItem("^FFAA00Special", "^FFDD00Start/Stop cycle", "StartTime")
GMSetting:addItem("^FFAA00Special", "^FFDD00SetYaw", "setYaw")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpawnNPC", "SpawnNPC")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpawnItem", "SpawnItem")
GMSetting:addItem("^FFAA00Special", "^FFDD00SetBlockToAir", "SetBlockToAir")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpawnBlock", "SpawnBlock")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpawnCar", "spawnCar")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpYaw", "SpYaw")
GMSetting:addItem("^FFAA00Special", "^FFDD00SpYawSet", "SpYawSet")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeHair", "ChangeHair")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeFace", "ChangeFace")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeTops", "ChangeTops")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangePants", "ChangePants")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeWing", "ChangeWing")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeScarf", "ChangeScarf")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeGlasses", "ChangeGlasses")
GMSetting:addItem("^FFAA00Special", "^FFDD00ChangeShoes", "ChangeShoes")
GMSetting:addTab("^00AAFFINFO", 13)
GMSetting:addItem("^00AAFFINFO", "^00AAFFShowRegion", "ShowRegion")
GMSetting:addItem("^00AAFFINFO", "^00AAFFShowGameID", "GameID")
GMSetting:addItem("^00AAFFINFO", "^00AAFFAllInfoPlayer", "GetAllInfoT")
GMSetting:addItem("^00AAFFINFO", "^00AAFFCopyLogInfo", "LogInfo")
GMSetting:addTab("Misc")
GMSetting:addItem("Misc", "GMTransparent", "makeGmButtonTran")
GMHelper.enableGM = function(v603)
    if GUIGMControlPanel then
        return
    end
    GUIGMControlPanel = UIHelper.newEngineGUILayout("GUIGMControlPanel", "GMControlPanel.json")
    GUIGMControlPanel:hide()
    GUIGMMain = UIHelper.newEngineGUILayout("GUIGMMain", "GMMain.json")
    GUIGMMain:show()
    local v604 = ClientHelper.getBoolForKey("g1008_isOpenEventDialog", false)
    GUIGMMain:changeOpenEventDialog(v604)
    if GMSetting.addItemGMItems then
        GMSetting:addItemGMItems()
        GMSetting.addItemGMItems = nil
    end
end
GMHelper.openInput = function(v605, v606, v607)
    if (type(v606) ~= "table") then
        return
    end
    for v2125, v2126 in pairs(v606) do
        if (type(v2126) ~= "string") then
            if isClient then
                assert(true, "param need string type")
            end
            return
        end
    end
    GUIGMControlPanel:openInput(v606, v607)
end
GMHelper.callCommand = function(v608, v609, ...)
    local v610 = v608[v609]
    if (type(v610) == "function") then
        v610(v608, ...)
    end
    local v611 = {name = v609, params = {...}}
    table.remove(v611.params)
    PacketSender:sendLuaCommonData("GMCommand", json.encode(v611))
end
GMHelper.openDebug = function(v612)
    CGame.Instance():toggleDebugMessageShown(true)
    GMHelper:moveDebugInfo(0, 0)
end
GMHelper.closeDebug = function(v613)
    CGame.Instance():toggleDebugMessageShown(false)
end
GMHelper.moveDebugInfo = function(v614, v615, v616)
    local v617 = tonumber(ClientHelper.getStringForKey("DebugInfoRenderOffsetX", "0")) or 0
    local v618 = tonumber(ClientHelper.getStringForKey("DebugInfoRenderOffsetY", "0")) or 0
    local v619 = v617 + v615
    local v620 = v618 + v616
    ClientHelper.putStringForKey("DebugInfoRenderOffsetX", tostring(v619))
    ClientHelper.putStringForKey("DebugInfoRenderOffsetY", tostring(v620))
    ClientHelper.putFloatPrefs("DebugInfoRenderOffsetX", v619)
    ClientHelper.putFloatPrefs("DebugInfoRenderOffsetY", v620)
end
GMHelper.setCPUTimerEnabled = function(v621, v622)
    GUIGMControlPanel:hide()
    PerformanceStatistics.SetCPUTimerEnabled(v622)
end
GMHelper.setGPUTimerEnabled = function(v623, v624)
    GUIGMControlPanel:hide()
    PerformanceStatistics.SetGPUTimerEnabled(v624)
end
GMHelper.printCPUTimerResult = function(v625)
    GUIGMControlPanel:hide()
    PerformanceStatistics.PrintResults(20)
end
GMHelper.test2001 = function(v626)
    Chat:sendTextMsg(
        "089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test "
    )
end
GMHelper.openChatWin = function(v627)
    UIHelper.showGameGUILayout("GUILuaChat", Define.ChatTabType.SameServer)
end
GMHelper.showChatRecord = function(v628, v629)
    ChatClient:getPrivateMsgCache(
        v629,
        nil,
        function(v2127)
            LogUtil.pv(v2127)
        end
    )
end
GMHelper.autoPrintResults = function(v630)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            PerformanceStatistics.PrintResults(20)
        end,
        5000
    )
end
GMHelper.autoProfilePerformance = function(v631)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            PerformanceStatistics.ProfilePerformance(20)
        end,
        100
    )
    GMHelper:showInput(
        {"exp", "exp2"},
        function(v2128, v2129)
        end
    )
end
GMHelper.EnterGame = function(v632, v633, v634)
    Game:resetGame(v634, PlayerManager:getClientPlayer().userId, v633)
end
GMHelper.openDebug = function(v635)
    CGame.Instance():toggleDebugMessageShown(true)
    GMHelper:moveDebugInfo(0, 0)
end
GMHelper.closeDebug = function(v636)
    CGame.Instance():toggleDebugMessageShown(false)
end
GMHelper.EnterGameTest = function(v637, v638, v639, v640)
    Game:resetGame(v639, PlayerManager:getClientPlayer().userId)
end
GMHelper.SetPlayerScale2 = function(v641)
    PlayerManager:getClientPlayer().Player.SetPlayerScale = 5
end
GMHelper.setYaw = function(v643, v644, v645)
    if v645 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v644
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v644
end
GMHelper.SetNameColor = function(v647, v648)
    ModsConfig.PLAYER_NAME_COLOR = v648
end
GMHelper.setYaw = function(v650)
    GMHelper:openInput(
        {""},
        function(v2130)
            PlayerManager:getClientPlayer().Player.rotationYaw = v2130
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.ChangeTime = function(v651, v652)
    local v653 = EngineWorld:getWorld()
    if v652 then
        v653:setWorldTime(15000)
        UIHelper.showToast("^00FF00Now Night!")
        return
    end
    v653:setWorldTime(6000)
    UIHelper.showToast("^00FF00Now Day!")
end
GMHelper.SetTime = function(v654)
    GMHelper:openInput(
        {""},
        function(v2132)
            local v2133 = EngineWorld:getWorld()
            v2133:setWorldTime(v2132)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.StartTime = function(v655)
    isTimeStopped = not isTimeStopped
    local v656 = EngineWorld:getWorld()
    v656:setTimeStopped(isTimeStopped)
    if isTimeStopped then
        UIHelper.showToast("^FF0000Start/Stop Time: disabled!")
        return
    end
    UIHelper.showToast("^00FF00Start/Stop Time: enabled!")
end
GMHelper.getConfig = function(v657)
    MsgSender.sendMsg("Time:" .. tostring(ModsConfig.time))
    MsgSender.sendMsg("Show pos:" .. tostring(ModsConfig.showPos))
    MsgSender.sendMsg("Hp warn:" .. tostring(ModsConfig.lhwarn))
    MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
    MsgSender.sendMsg("Hide player names:" .. tostring(ModsConfig.hpn))
end
GMHelper.HidePlayerName = function(v658)
    isHideNames = not isHideNames
    if isHideNames then
        ModsConfig.hpn = 1
        MsgSender.sendMsg("Hide players name: enabled!")
        return
    end
    if not isHideNames then
        ModsConfig.hpn = 0
        MsgSender.sendMsg("Hide players name: disabled!")
    end
end
GMHelper.ShowPos = function(v659)
    isShowPos = not isShowPos
    if isShowPos then
        ModsConfig.showPos = 1
        MsgSender.sendMsg("Show player position: enabled!")
        return
    end
    ModsConfig.showPos = 0
    MsgSender.sendMsg("Show player position: disabled!")
end
GMHelper.EnableHPWarn = function(v661)
    useHPWarn = not useHPWarn
    if useHPWarn then
        ModsConfig.lhwarn = 1
        MsgSender.sendMsg("HP Warning: enabled!")
        return
    end
    ModsConfig.lhwarn = 0
    MsgSender.sendMsg("HP Warning: disabled!")
end
GMHelper.addHpLvl = function(v663, v664, v665)
    if v665 then
        if (ModsConfig.hpwarn == 0) then
            return
        end
        ModsConfig.hpwarn = ModsConfig.hpwarn - 1
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
        return
    end
    if (ModsConfig.hpwarn == PlayerManager:getClientPlayer().Player:getHealth()) then
        return
    end
    ModsConfig.hpwarn = ModsConfig.hpwarn + 1
    MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
end
GMHelper.addGMPlayer = function(v667, v668, v669)
    if not isClient then
        return
    end
    if v669 then
        for v4508, v4509 in pairs(PlayerManager:getPlayers()) do
            v4509:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v4509.userId)
        end
    else
        local v3733 = PlayerManager:getPlayers()
        local v3734 = 99999999
        local v3735
        for v4510, v4511 in pairs(v3733) do
            local v4512 = MathUtil:distanceSquare3d(v4511:getPosition(), v668:getPosition())
            if ((v3734 > v4512) and (v4511 ~= v668)) then
                v3734 = v4512
                v3735 = v4511
            end
        end
        if (v3735 and not PlayerManager:isAIPlayer(v3735)) then
            v3735:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v3735.userId)
        end
    end
    GUIGMControlPanel:hide()
end
GMHelper.openCommonPacketDebug = function(v670)
    CommonDataEvents.isDebug = true
end
GMHelper.closeCommonPacketDebug = function(v672)
    CommonDataEvents.isDebug = false
end
GMHelper.openConnectorLog = function(v674)
    local v675 = T(Global, "ConnectorCenter")
    v675.isDebug = true
    local v677 = T(Global, "ConnectorDispatch")
    v677.isDebug = true
end
GMHelper.closeConnectorLog = function(v679)
    local v680 = T(Global, "ConnectorCenter")
    v680.isDebug = false
    local v682 = T(Global, "ConnectorDispatch")
    v682.isDebug = false
end
GMHelper.sendTestConnectorMsg = function(v684, v685)
    local v686 = {}
    v686.a = 1
    v686.b = 2
    local v689 = T(Global, "ConnectorCenter")
    v689:sendMsg(v685, v686)
end
GMHelper.SetEnabledRenderFrameTimer = function(v690, v691)
    PerformanceStatistics.SetEnabledRenderFrameTimer(v691)
    GUIGMControlPanel:hide()
end
GMHelper.updateAllShaders = function(v692)
    Blockman.Instance().m_gameSettings:updateAllShaders()
    GUIGMControlPanel:hide()
end
GMHelper.setNeedMonitorShader = function(v693)
    Blockman.Instance().m_gameSettings:setNeedMonitorShader(true)
    GUIGMControlPanel:hide()
end
GMHelper.setDrawCallDisabled = function(v694)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setDrawCallDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setMinimumGeometry = function(v695)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setMinimumGeometry(true)
    GUIGMControlPanel:hide()
end
GMHelper.setColorBlendDisabled = function(v696)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setColorBlendDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setZTestDisabled = function(v697)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setZTestDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setZWriteDisabled = function(v698)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setZWriteDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setUseSmallTexture = function(v699)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallTexture(true)
    GUIGMControlPanel:hide()
end
GMHelper.setUseSmallViewport = function(v700)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallViewport(true)
    GUIGMControlPanel:hide()
end
GMHelper.JetPack = function(v701)
    A = not A
    PlayerManager:getClientPlayer().Player.m_keepJumping = false
    UIHelper.showToast("^FF00EEВключено")
    if A then
        PlayerManager:getClientPlayer().Player.m_keepJumping = true
        UIHelper.showToast("^FF00EEВыключено")
    end
end
GMHelper.Rvanka = function(v703)
    toggle = not toggle
    key = nil
    gay = nil
    if toggle then
        UIHelper.showToast("^FF00EE[ON]")
        key =
            LuaTimer:scheduleTimer(
            function()
                local v4513 = _G["PlayerManager"]:getClientPlayer().Player
                local v4514 = _G["PlayerManager"]:getPlayers()
                for v4838, v4839 in pairs(v4514) do
                    local v4840 = MathUtil:distanceSquare2d(v4839:getPosition(), v4513:getPosition())
                    if (v4839 ~= v4513) then
                        gay =
                            _G["LuaTimer"]:scheduleTimer(
                            function()
                                local v5224 =
                                    VectorUtil.newVector3(
                                    v4839:getPosition().x,
                                    v4839:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2)),
                                    v4839:getPosition().z
                                )
                                v4513:setPosition(v5224)
                            end,
                            (tonumber(tostring(1787 - _G["dumb"]), 2)),
                            (tonumber(tostring(1111101777 - _G["dumb"]), 2))
                        )
                    end
                end
            end,
            (tonumber(tostring(1111101778 - _G["dumb"]), 2)),
            -(tonumber(tostring(778 - _G["dumb"]), 2))
        )
    else
        UIHelper.showToast("^FF00EE[OFF] by clad_men")
        LuaTimer:cancel(key)
        LuaTimer:cancel(gay)
    end
end
GMHelper.setUseSmallVBO = function(v704)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallVBO(true)
    GUIGMControlPanel:hide()
end
GMHelper.ChangeBlockTextures = function(v705, v706)
    local v707 = GMHelper.blockTextures or false
    if not v707 then
        Blockman.Instance():changeBlockTextures("./package_02_32.zip")
        GMHelper.blockTextures = true
    else
        Blockman.Instance():changeBlockTextures("")
        GMHelper.blockTextures = false
    end
    if (#v706 > 0) then
        Blockman.Instance():changeBlockTextures("Media/Textures/package/" .. v706)
    else
        Blockman.Instance():changeBlockTextures("")
    end
    GUIGMControlPanel:hide()
end
GMHelper.GetMaterialBagList = function(v708)
    WebService:GetMaterialBagList()
end
GMHelper.setClearColorDisabled = function(v709)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setClearColorDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.DisableGraphicAPI = function(v710)
    Blockman.disableGraphicAPI()
end
GMHelper.DisableGraphicAPIAndTestCPU = function(v711)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetCPUTimerEnabled(true)
            PerformanceStatistics.SetGPUTimerEnabled(false)
            LuaTimer:schedule(
                function()
                    PerformanceStatistics.PrintResults(30)
                end,
                5100
            )
        end,
        200
    )
end
GMHelper.DisableGraphicAPIAndTestGPU = function(v712)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetCPUTimerEnabled(false)
            PerformanceStatistics.SetGPUTimerEnabled(true)
            LuaTimer:schedule(
                function()
                    PerformanceStatistics.PrintResults(30)
                end,
                5100
            )
        end,
        200
    )
end
GMHelper.DisableGraphicAPIAndDrawCallTest = function(v713)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        end,
        200
    )
end
GMHelper.openScreenRecord = function(v714)
    local v715 = {"Main-PoleControl-Move", "Main-PoleControl", "Main-FlyingControls", "Main-Fly"}
    local v716 = GUISystem.Instance():GetRootWindow()
    v716:SetXPosition({0, 10000})
    local v717 = GUIManager:getWindowByName("Main")
    local v718 = v717:GetChildCount()
    for v2134 = 1, v718 do
        local v2135 = v717:GetChildByIndex(v2134 - 1)
        local v2136 = v2135:GetName()
        if not TableUtil.tableContain(v715, v2136) then
            v2135:SetXPosition({0, 10000})
            v2135:SetYPosition({0, 10000})
        end
    end
    ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
    ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)
    GUIManager:getWindowByName("Main-Fly"):SetProperty("NormalImage", "")
    GUIManager:getWindowByName("Main-Fly"):SetProperty("PushedImage", "")
    GUIManager:getWindowByName("Main-PoleControl-BG"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-PoleControl-Center"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Up"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Drop"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Down"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Break-Block-Progress-Nor"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Break-Block-Progress-Pre"):SetProperty("ImageName", "")
    v717:SetXPosition({0, -10000})
    ClientHelper.putBoolPrefs("RenderHeadText", false)
    PlayerManager:getClientPlayer().Player:setActorInvisible(true)
end
GMHelper.changeLuaHotUpdate = function(v719, v720)
    startLuaHotUpdate()
    HU.CanUpdate = v720
end
GMHelper.changeOpenEventDialog = function(v722, v723)
    GUIGMMain:changeOpenEventDialog(v723)
end
GMHelper.showUserRegion = function(v724)
    UIHelper.showToast("游戏大区=" .. Game:getRegionId() .. "   玩家区域=" .. Game:getUserRegion())
end
GMHelper.setOutputUIName = function(v725, v726)
    GUISystem.Instance():SetOutputUIName(not GUISystem.Instance():IsOutputUIName())
    v726:SetText("打印UI(" .. ((GUISystem.Instance():IsOutputUIName() and "开)") or "关)"))
end
GMHelper.telnetClient = function(v727)
    if not Platform.isWindow() then
        return
    end
    local v728 = require("misc")
    local v729 = require("engine_base.debug.DebugPort")
    v728.win_exec("telnet.exe", "127.0.0.1 " .. v729.port, nil, nil, true)
end
GMHelper.telnetServer = function(v730)
    if not Platform.isWindow() then
        return
    end
    local v731 = require("misc")
    local v732 = require("engine_base.debug.DebugPort")
    v731.win_exec("telnet.exe", "127.0.0.1 " .. v732.port, 1, 1, true)
end
GMHelper.setGlobalShowText = function(v733)
    Root.Instance():setShowText(not Root.Instance():isShowText())
end
GMHelper.copyClientLog = function(v734)
    if Platform.isWindow() then
        return
    end
    local v735 = Root.Instance():getWriteablePath() .. "client.log"
    local v736 = io.open(v735, "r")
    if not v736 then
        return
    end
    local v737 = v736:read("*a")
    v736:close()
    ClientHelper.onSetClipboard(v737)
    UIHelper.showToast("拷贝成功，请粘贴到钉钉上自动生成文件发送到群里")
end
GMHelper.sendConnectorChatMsg = function(v738, v739)
    if (isClient or isStaging) then
        local v3739 = T(Global, "ChatService")
        for v4515 = 1, v739 do
            v3739:sendMsgToLangGroup(Define.ChatMsgType.TextMsg, {content = "Test:" .. v4515})
        end
    end
end
GMHelper.queryBoolKey = function(v740)
    GMHelper:openInput(
        {""},
        function(v2137)
            CustomDialog.builder().setContentText(v2137 .. "=" .. tostring(ClientHelper.getBoolForKey(v2137))).setHideLeftButton(

            ).show()
            GUIGMControlPanel:hide()
        end
    )
end
GMHelper.queryStringKey = function(v741)
    GMHelper:openInput(
        {""},
        function(v2138)
            CustomDialog.builder().setContentText(v2138 .. "=" .. ClientHelper.getStringForKey(v2138)).setHideLeftButton(

            ).setRightText("复制到粘贴板").setRightClickListener(
                function()
                    ClientHelper.onSetClipboard(ClientHelper.getStringForKey(v2138))
                    UIHelper.showToast("复制成功")
                end
            ).show()
            GUIGMControlPanel:hide()
        end
    )
end
GMHelper.makeGmButtonTran = function(v742)
    GUIGMMain:setTransparent()
end
GMHelper.setRenderMainScreenSeparate = function(v743, v744)
    Root.Instance():setRenderMainScreenSeparate(v744)
end
GMHelper.setEnableMergeBlock = function(v745, v746)
    Root.Instance():setEnableMergeBlock(true)
    UIHelper.showToast("1")
end
GMHelper.AnvilToObj = function(v747)
    local v748 = VectorUtil.newVector3()
    local v749 = 32
    AnvilToObj.doTranslate(v748, v749)
end
GMHelper.inTheAirCheat = function(v750)
    LuaTimer:scheduleTimer(
        function()
            local v2139 = VectorUtil.newVector3(0, 3, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2139)
        end,
        5,
        20
    )
end
GMHelper.CustomPid = function(v751)
    GMHelper:openInput(
        {""},
        function(v2140)
            PlayerManager:getClientPlayer():sendPacket({pid = v2140})
        end
    )
end
GMHelper.GoTO10BlocksDown = function(v752)
    LuaTimer:scheduleTimer(
        function()
            local v2141 = VectorUtil.newVector3(0, 0, 1)
            PlayerManager:getClientPlayer().Player:moveEntity(v2141)
        end,
        5,
        20
    )
end
GMHelper.PermaFly = function(v753)
    local v754 = PlayerManager:getClientPlayer()
    v754.sendPacket({pid = "onClickVipRespawn"})
end
GMHelper.GoTO10Blocks = function(v755)
    LuaTimer:scheduleTimer(
        function()
            local v2142 = VectorUtil.newVector3(1, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2142)
        end,
        5,
        20
    )
end
GMHelper.Scaffold3 = function(v756)
    A = not A
    LuaTimer:cancel(v756.timer)
    UIHelper.showToast("^00FF00Scaffold TurnOFF")
    if A then
        GMHelper:openInput(
            {"BlockID"},
            function(v4516)
                v756.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4841 = PlayerManager:getClientPlayer():getPosition()
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x, v4841.y - 2, v4841.z), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x - 1, v4841.y - 2, v4841.z - 1), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x + 1, v4841.y - 2, v4841.z + 1), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x, v4841.y - 2, v4841.z + 1), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x, v4841.y - 2, v4841.z - 1), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x + 1, v4841.y - 2, v4841.z), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x - 1, v4841.y - 2, v4841.z), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x - 1, v4841.y - 2, v4841.z + 1), v4516)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4841.x + 1, v4841.y - 2, v4841.z - 1), v4516)
                    end,
                    0.15,
                    -1
                )
                UIHelper.showToast("^00FF00Scaffold TurnON")
            end
        )
    end
end
GMHelper.Scaffold5 = function(v757)
    A = not A
    LuaTimer:cancel(v757.timer)
    UIHelper.showToast("^00FF00Scaffold (5 blocks) TurnOFF")
    if A then
        GMHelper:openInput(
            {"BlockID"},
            function(v4518)
                v757.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4842 = PlayerManager:getClientPlayer():getPosition()
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x, v4842.y - 2, v4842.z), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 1, v4842.y - 2, v4842.z - 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 1, v4842.y - 2, v4842.z + 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x, v4842.y - 2, v4842.z + 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x, v4842.y - 2, v4842.z - 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 1, v4842.y - 2, v4842.z), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 1, v4842.y - 2, v4842.z), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 1, v4842.y - 2, v4842.z + 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 1, v4842.y - 2, v4842.z - 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 2, v4842.y - 2, v4842.z - 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 2, v4842.y - 2, v4842.z + 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x, v4842.y - 2, v4842.z + 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x, v4842.y - 2, v4842.z - 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 2, v4842.y - 2, v4842.z), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 2, v4842.y - 2, v4842.z), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 2, v4842.y - 2, v4842.z + 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 2, v4842.y - 2, v4842.z - 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 2, v4842.y - 2, v4842.z + 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 2, v4842.y - 2, v4842.z - 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 1, v4842.y - 2, v4842.z + 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 1, v4842.y - 2, v4842.z - 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 2, v4842.y - 2, v4842.z - 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x - 1, v4842.y - 2, v4842.z - 2), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 2, v4842.y - 2, v4842.z + 1), v4518)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4842.x + 1, v4842.y - 2, v4842.z + 2), v4518)
                    end,
                    0.15,
                    -1
                )
                UIHelper.showToast("^00FF00Scaffold (5 blocks) TurnON")
            end
        )
    end
end
GMHelper.Scaffold7 = function(v758)
    A = not A
    LuaTimer:cancel(v758.timer)
    UIHelper.showToast("^00FF00Scaffold (7 blocks) TurnOFF")
    if A then
        GMHelper:openInput(
            {"BlockID"},
            function(v4520)
                v758.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4843 = PlayerManager:getClientPlayer():getPosition()
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z - 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 2, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z + 2), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 2, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z + 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 1, v4843.y - 2, v4843.z - 3), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 3, v4843.y - 2, v4843.z + 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x + 3, v4843.y - 2, v4843.z - 1), v4520)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4843.x - 1, v4843.y - 2, v4843.z + 3), v4520)
                    end,
                    5.15,
                    -1
                )
                UIHelper.showToast("^00FF00Scaffold (7 blocks) TurnON")
            end
        )
    end
end
GMHelper.testModiyScript = function(v759)
    ClientHttpRequest.reportScriptModifyCheat()
end
GMHelper.setShowGunFlameCoordinate = function(v760, v761)
    Blockman.Instance():setShowGunFlameCoordinate(v761)
    if v761 then
        GUIGMControlPanel:setBackgroundColor(Color.TRANS)
    else
        GUIGMControlPanel:setBackgroundColor({0, 0, 0, 0.784314})
    end
end
GMHelper.changeGunFlameParam = function(v762, v763, v764)
    ClientHelper.putFloatPrefs(v763, ClientHelper.getFloatPrefs(v763) + v764)
end
GMHelper.copyShowGunFlameParam = function(v765, v766)
    local v767 = ClientHelper.getFloatPrefs("GunFlameFrontOff" .. v766)
    local v768 = ClientHelper.getFloatPrefs("GunFlameRightOff" .. v766)
    local v769 = ClientHelper.getFloatPrefs("GunFlameDownOff" .. v766)
    local v770 = ClientHelper.getFloatPrefs("GunFlameScale" .. v766)
    v767 = math.floor(v767 * 100) / 100
    v768 = math.floor(v768 * 100) / 100
    v769 = math.floor(v769 * 100) / 100
    v770 = math.floor(v770 * 100) / 100
    local v771 = v767 .. "#" .. v768 .. "#" .. v769 .. "#" .. v770
    ClientHelper.onSetClipboard(v771)
    UIHelper.showToast("拷贝成功")
end
GMHelper.testinValidEffect = function(v772)
    local v773 = "01_face_boy.mesh"
    local v774 = VectorUtil.newVector3(100, 10, 100)
    WorldEffectManager.Instance():addSimpleEffect(v773, v774, 1, 1, 1, 1, 1)
    UIHelper.showToast("测试 非法 特效 完成")
end
GMHelper.outputItemLangFile = function(v775)
    if not isClient then
        return
    end
    local v776 = {}
    for v2143 = 1, 6000 do
        local v2144 = Item.getItemById(v2143)
        if v2144 then
            local v4522 = Lang:getItemName(v2143, 0)
            if (v4522 == "") then
                v4522 = v2144:getUnlocalizedName()
            end
            v776[tostring(v2143)] = v4522
        end
    end
    local v777 = io.open(GameType .. "_item_name.json", "w")
    v777:write(json.encode(v776))
    v777:close()
end
GMHelper.MyLoveFly = function(v778, v779)
    A = not A
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    PlayerManager:getClientPlayer().doubleJumpCount = 10000
    if A then
        UIHelper.showToast("^00FF00FLy ON")
        return
    end
    ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
    UIHelper.showToast("^FF0000FLy OFF")
end
GMHelper.GUISkyblockTest1 = function(v781)
    UIHelper.showGameGUILayout("GUIChristmas", 1)
    GUIGMControlPanel:hide()
end
GMHelper.GUISkyblockTest2 = function(v782)
    UIHelper.showGameGUILayout("GUIGameTool")
    GUIGMControlPanel:hide()
end
GMHelper.GUISkyblockTest3 = function(v783)
    UIHelper.showGameGUILayout("GUIRewardDetail", v783.rewardId)
    GUIGMControlPanel:hide()
end
GMHelper.Reach = function(v784)
    A = not A
    ClientHelper.putFloatPrefs("BlockReachDistance", 999)
    ClientHelper.putFloatPrefs("EntityReachDistance", 7)
    if A then
        UIHelper.showToast("^00FF00REACH ON")
        return
    end
    ClientHelper.putFloatPrefs("BlockReachDistance", 6.5)
    ClientHelper.putFloatPrefs("EntityReachDistance", 5)
    UIHelper.showToast("^00FF00REACH OFF")
end
GMHelper.LagServer2 = function(v785)
    LuaTimer:scheduleTimer(
        function()
            for v3740 = 1, 3 do
                PlayerManager:getClientPlayer():sendPacket({pid = "pid"})
            end
        end,
        0.1,
        1e+28
    )
end
GMHelper.ViewBobbing = function(v786)
    A = not A
    ClientHelper.putBoolPrefs("IsViewBobbing", false)
    if A then
        UIHelper.showToast("^FF0000ViewBobbing: OFF")
        return
    end
    ClientHelper.putBoolPrefs("IsViewBobbing", true)
    UIHelper.showToast("^00FF00ViewBobbing: ON")
end
GMHelper.putBoolPrefs = function(v787)
    GMHelper:openInput(
        {"", ""},
        function(v2145, v2146)
            if (v2146 == "true") then
                ClientHelper.putBoolPrefs(v2145, true)
            elseif (v2146 == "false") then
                ClientHelper.putBoolPrefs(v2145, false)
            end
        end
    )
end
GMHelper.putFloatPrefs = function(v788)
    GMHelper:openInput(
        {"", ""},
        function(v2147, v2148)
            ClientHelper.putFloatPrefs(v2147, v2148)
        end
    )
end
GMHelper.putIntPrefs = function(v789)
    GMHelper:openInput(
        {"", ""},
        function(v2149, v2150)
            ClientHelper.putIntPrefs(v2149, v2150)
        end
    )
end
GMHelper.putStringPrefs = function(v790)
    GMHelper:openInput(
        {"", ""},
        function(v2151, v2152)
            ClientHelper.putStringPrefs(v2151, v2152)
        end
    )
end
GMHelper.BlockmanCollision = function(v791)
    A = not A
    ClientHelper.putBoolPrefs("IsCreatureCollision", true)
    ClientHelper.putBoolPrefs("IsBlockmanCollision", true)
    if A then
        UIHelper.showToast("^00FF00BlockmanCollision: ON")
        return
    end
    ClientHelper.putBoolPrefs("IsBlockmanCollision", false)
    UIHelper.showToast("^FF0000BlockmanCollision: OFF")
    ClientHelper.putBoolPrefs("IsCreatureCollision", false)
end
GMHelper.RenderWorld = function(v792)
    GMHelper:openInput(
        {""},
        function(v2153)
            ClientHelper.putIntPrefs("BlockRenderDistance", v2153)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.Fog = function(v793)
    A = not A
    ClientHelper.putBoolPrefs("DisableFog", true)
    if A then
        UIHelper.showToast("^FF0000Fog Disabled!")
        return
    end
    ClientHelper.putBoolPrefs("DisableFog", false)
    UIHelper.showToast("^00FF00Fog Enabled!")
end
local v198 = false
GMHelper.AlwaysParachute = function(v794)
    v198 = not v198
    if v198 then
        UIHelper.showToast("AlwaysParachute = true")
    else
        UIHelper.showToast("AlwaysParachute = false")
    end
end
GMHelper.WWE_Camera = function(v795)
    A = not A
    ClientHelper.putBoolPrefs("IsSeparateCamera", true)
    if A then
        UIHelper.showToast("^00FF00SeparateCamera: Enabled")
        return
    end
    ClientHelper.putBoolPrefs("IsSeparateCamera", false)
    UIHelper.showToast("^FF0000SeparateCamera: Disabled")
end
GMHelper.FreezeUI = function(v796)
    A = not A
    ClientHelper.putBoolPrefs("LockUIShowAndHide", true)
    UIHelper.showToast("LockUIShowAndHide = true")
    if A then
        ClientHelper.putBoolPrefs("LockUIShowAndHide", false)
        UIHelper.showToast("LockUIShowAndHide = false")
    end
end
GMHelper.ResetXD = function(v797)
    ClientHelper.putStringPrefs("RunSkillName", "run")
    GUIGMControlPanel:hide()
end
GMHelper.ayesh = function(v798)
    local v799 = PlayerManager:getPlayers()
    for v2154, v2155 in pairs(v799) do
        MsgSender.sendMsg(
            "^FF0000INFO: " ..
                string.format(
                    "^FF0000UserName: %s {} ID: %s {} Gender: %s",
                    v2155:getName(),
                    v2155.userId,
                    v2155.Player:getSex()
                )
        )
    end
end
GMHelper.AutoClickzxc = function(v800)
    A = not A
    LuaTimer:cancel(v800.timer)
    UIHelper.showToast("^00FF00AutoClick OFF")
    if A then
        v800.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(800, 360)
                UIHelper.showToast("^00FF00AutoClick ON")
            end,
            0.15,
            -1
        )
    end
end
GMHelper.ActionSet = function(v801)
    GMHelper:openInput(
        {""},
        function(v2156)
            ClientHelper.putStringPrefs("RunSkillName", v2156)
        end
    )
end
GMHelper.InstantRespawn = function(v802)
    A = not A
    LuaTimer:cancel(ArdenPro)
    UIHelper.showToast("OFF!")
    if A then
        ArdenPro =
            LuaTimer:scheduleTimer(
            function()
                PacketSender:getSender():sendRebirth()
            end,
            0.15,
            -1
        )
        UIHelper.showToast("ON!")
    end
end
GMHelper.WalkSMG = function(v803)
    ClientHelper.putStringPrefs("RunSkillName", "smg_walk")
    GUIGMControlPanel:hide()
end
GMHelper.SendMSGTOSERVER = function(v804)
    PlayerManager:getClientPlayer():sendRebirth()
end
GMHelper.testHui = function(v805)
    LuaTimer:scheduleTimer(
        function()
            local v2157 = PlayerManager:getClientPlayer()
            if v2157 then
                local v4524 = v2157.Player:getPosition()
                local v4525 = PlayerManager:getPlayers()
                local v4526 = math.huge
                local v4527 = nil
                for v4844, v4845 in pairs(v4525) do
                    if (v4845 ~= v2157) then
                        local v5173 = v4845:getPosition()
                        local v5174 = MathUtil:distanceSquare2d(v5173, v4524)
                        if (v5174 < v4526) then
                            v4526 = v5174
                            v4527 = v4845
                        end
                    end
                end
                if ((v4527 ~= nil) and (v4526 < 10)) then
                    local v5039 = math.min(v4527:getHealth(), 50)
                    local v5040 = ((v4527:getSex() == 1) and "▢FF00FFFF██▢FFFFFFFF") or "▢FFFF1B89██▢FFFFFFFF"
                    local v5041 =
                        string.format(
                        "%s ¦ %.1f megaRICHHmade️▢FFFFFFFF ¦ %s ¦ X: ▢FFFF0000%.2f▢FFFFFFFF / Y: ▢FFFF0000%.2f▢FFFFFFFF / Z: ▢FFFF0000%.2f▢FFFFFFFF",
                        v4527.name,
                        v5039,
                        v5040,
                        v4527:getPosition().x,
                        v4527:getPosition().y,
                        v4527:getPosition().z
                    )
                    UIHelper.showToast(v5041)
                    MsgSender.sendCenterTips(1, string.format(" \n \n \n\n%s", v4527.userId))
                end
            end
        end,
        10,
        -1
    )
end
GMHelper.TeleportAura = function(v806)
    local v807 = 3
    local function v808(v2158)
        local v2159 = v2158:getPosition()
        local v2160 = MathUtil:getRandomPointInCircle(v2159, v807)
        PlayerManager:getClientPlayer().Player:setPosition(v2160)
    end
    local function v809()
        local v2161 = PlayerManager:getClientPlayer().Player
        local v2162 = PlayerManager:getPlayers()
        local v2163 = math.huge
        local v2164 = nil
        for v3742, v3743 in pairs(v2162) do
            if (v3743 ~= v2161) then
                local v4846 = MathUtil:distanceSquare2d(v3743:getPosition(), v2161:getPosition())
                if (v4846 < v2163) then
                    v2163 = v4846
                    v2164 = v3743
                end
            end
        end
        return v2164
    end
end
GMHelper.AimBo = function(v810)
    local v811 = PlayerManager:getPlayers()
    for v2165, v2166 in pairs(v811) do
        targetPos = v2166:getPosition()
        local function v2167(v3744)
            local v3745 = SceneManager.Instance():getMainCamera()
            local v3746 = v3745:getPosition()
            local v3747 = math.atan2(v3744.x - v3746.x, v3744.z - v3746.z)
            local v3748 = (v3747 / math.pi) * -180
            local v3749 = VectorUtil.sub3(v3744, v3746)
            local v3750 = MathUtil.GetVector3Angle(VectorUtil.newVector3(v3749.x, 0, v3749.z), v3749)
            return v3748, v3750
        end
        PlayerManager:getClientPlayer().targetPos = targetPos
        local v2169 = 50
        LuaTimer:cancel(v810.cameraKey)
        PlayerManager:getClientPlayer().cameraKey =
            LuaTimer:scheduleTimer(
            function()
                local v3751, v3752 = v2167(targetPos)
                local v3753 = PlayerManager:getClientPlayer().Player.rotationYaw
                local v3754 = PlayerManager:getClientPlayer().Player.rotationPitch
                while math.abs(v3753 - v3751) > 180 do
                    if (v3753 > v3751) then
                        v3751 = v3751 + 360
                    else
                        v3751 = v3751 - 360
                    end
                end
                if (v2169 > 1) then
                    PlayerManager:getClientPlayer().Player.rotationYaw = v3753 + ((v3751 - v3753) / v2169)
                    PlayerManager:getClientPlayer().Player.rotationPitch = v3754 + ((v3752 - v3754) / v2169)
                else
                    PlayerManager:getClientPlayer().Player.rotationYaw = v3751
                    PlayerManager:getClientPlayer().Player.rotationPitch = v3752
                end
                v2169 = v2169 - 1
            end,
            200,
            -1
        )
    end
end
GMHelper.StartAimBotTimer = function(v812)
    v812.aimBotTimer =
        LuaTimer:scheduleTimer(
        function()
            v812:AimBot()
        end,
        1000,
        -1
    )
end
GMHelper.StopAimBotTimer = function(v814)
    if v814.aimBotTimer then
        LuaTimer:cancel(v814.aimBotTimer)
        v814.aimBotTimer = nil
    end
end
GMHelper.testZalupa = function(v815)
    local v816 = PlayerManager:getPlayers()
    local v817 = PlayerManager:getClientPlayer().Player
    local v818 = v817:getPosition()
    local v819 = nil
    local v820 = math.huge
    for v2171, v2172 in pairs(v816) do
        local v2173 = v2172:getPosition()
        local v2174 = MathUtil.distance(v2173, v818)
        if ((v2174 <= 10) and (v2174 < v820)) then
            v819 = v2172
            v820 = v2174
        end
    end
    if v819 then
        targetPos = v819:getPosition()
        local function v3756(v4528)
            local v4529 = SceneManager.Instance():getMainCamera()
            local v4530 = v4529:getPosition()
            local v4531 = math.atan2(v4528.x - v4530.x, v4528.z - v4530.z)
            local v4532 = (v4531 / math.pi) * -180
            local v4533 = VectorUtil.sub3(v4528, v4530)
            local v4534 = MathUtil.GetVector3Angle(VectorUtil.newVector3(v4533.x, 0, v4533.z), v4533)
            return v4532, v4534
        end
        PlayerManager:getClientPlayer().targetPos = targetPos
        local v3758 = 50
        LuaTimer:cancel(v815.cameraKey)
        PlayerManager:getClientPlayer().cameraKey =
            LuaTimer:scheduleTimer(
            function()
                local v4535, v4536 = v3756(targetPos)
                local v4537 = PlayerManager:getClientPlayer().Player.rotationYaw
                local v4538 = PlayerManager:getClientPlayer().Player.rotationPitch
                while math.abs(v4537 - v4535) > 180 do
                    if (v4537 > v4535) then
                        v4535 = v4535 + 360
                    else
                        v4535 = v4535 - 360
                    end
                end
                if (v3758 > 1) then
                    PlayerManager:getClientPlayer().Player.rotationYaw = v4537 + ((v4535 - v4537) / v3758)
                    PlayerManager:getClientPlayer().Player.rotationPitch = v4538 + ((v4536 - v4538) / v3758)
                else
                    PlayerManager:getClientPlayer().Player.rotationYaw = v4535
                    PlayerManager:getClientPlayer().Player.rotationPitch = v4536
                end
                v3758 = v3758 - 1
            end,
            200,
            -1
        )
    else
        UIHelper:ShowError("Вы должны находиться рядом с другим игроком, чтобы использовать AimBot.")
    end
end
GMHelper.SetMaxFPS = function(v821)
    GMHelper:openInput(
        {""},
        function(v2175)
            CGame.Instance():SetMaxFps(v2175)
        end
    )
end
GMHelper.SneakXD = function(v822)
    ClientHelper.putStringPrefs("RunSkillName", "sneak")
    GUIGMControlPanel:hide()
end
GMHelper.BedwarNodelay = function(v823)
    PlayerManager:getClientPlayer().Player:setIntProperty("bedWarAttackCD", 0)
    ClientHelper.putIntPrefs("ClickSceneCD", 0)
end
GMHelper.SitXD = function(v824)
    ClientHelper.putStringPrefs("RunSkillName", "sit1")
    GUIGMControlPanel:hide()
end
GMHelper.SitXD2 = function(v825)
    ClientHelper.putStringPrefs("RunSkillName", "sit2")
    GUIGMControlPanel:hide()
end
GMHelper.updateBedWarArro = function(v826)
    GMHelper:openInput(
        {"speed"},
        function(v2176)
            local v2177 = tonumber(v2176) or 0
            PlayerManager:getClientPlayer().Player:setFloatProperty("ArrowSpeedScale", v2177)
            PlayerManager:getClientPlayer():sendPacket({pid = "updateBedWarArrowSpeed", scale = v2177})
        end
    )
end
GMHelper.ChatSend = function(v827)
    GMHelper:openInput(
        {""},
        function(v2178)
            HostApi.sendMsg(0, 0, v2178)
        end
    )
end
GMHelper.SitXD3 = function(v828)
    ClientHelper.putStringPrefs("RunSkillName", "sit3")
    GUIGMControlPanel:hide()
end
GMHelper.RotateHeadTowardsNearestPlayer = function(v829)
    LuaTimer:scheduleTimer(
        function()
            local v2179 = PlayerManager:getClientPlayer().Player
            local v2180 = PlayerManager:getPlayers()
            local v2181 = math.huge
            local v2182 = nil
            for v3760, v3761 in pairs(v2180) do
                local v3762 = MathUtil:distanceSquare2d(v3761:getPosition(), v2179:getPosition())
                if ((v3761 ~= v2179) and (v3762 < v2181)) then
                    v2181 = v3762
                    v2182 = v3761
                end
            end
            if v2182 then
                local v4539 = v2182:getPosition()
                local v4540 = VectorUtil.newVector3(v4539.x - v2179:getPosition().x, v4539.y - v2179:getPosition().y, 0)
                local v4541 = math.atan2(v4540.y, v4540.x) * (180 / math.pi)
                PlayerManager:getClientPlayer().Player.rotationYaw = v4541
            end
        end,
        500,
        -1
    )
end
GMHelper.SwitchPerson = function(v830, v831)
    Blockman.Instance():setPersonView(v831)
    GUIGMControlPanel:hide()
end
GMHelper.AllPlayerLocations = function(v832)
    LuaTimer:scheduleTimer(
        function()
            local v2183 = PlayerManager:getPlayers()
            for v3763, v3764 in pairs(v2183) do
                local v3765 = v3764:getPosition()
                local v3766 =
                    string.format(
                    "▢FFFFA500[▢FFFFFFFF %s / X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF ▢FFFFA500]▢FFFFFFFF",
                    v3764.name,
                    v3765.x,
                    v3765.y,
                    v3765.z
                )
                MsgSender.sendTopTips(100000, v3766)
            end
        end,
        500,
        -1
    )
end
GMHelper.MyLocation = function(v833)
    LuaTimer:scheduleTimer(
        function()
            local v2184 = PlayerManager:getClientPlayer()
            if v2184 then
                local v4543 = v2184.Player:getPosition()
                local v4544 =
                    string.format(
                    "X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF",
                    v4543.x,
                    v4543.y,
                    v4543.z
                )
                UIHelper.showToast(v4544)
            end
        end,
        500,
        -1
    )
end
GMHelper.AutoSpawnNPC = function(v834)
    GMHelper:openInput(
        {"TypeValue"},
        function(v2185)
            LuaTimer:scheduleTimer(
                function()
                    local v3767 = PlayerManager:getClientPlayer()
                    local v3768 = v3767.Player:getPosition()
                    local v3769 = PlayerManager:getPlayers()
                    for v4545, v4546 in pairs(v3769) do
                        if (v4546 ~= v3767) then
                            local v5046 = v4546:getPosition()
                            local v5047 = MathUtil:distanceSquare2d(v5046, v3768)
                            if (v5047 < 35) then
                                EngineWorld:addActorNpc(
                                    v5046,
                                    0,
                                    v2185,
                                    function(v5243)
                                    end
                                )
                            end
                        end
                    end
                end,
                100,
                -1
            )
        end
    )
end
GMHelper.AdjustSpeedBasedOnDistance = function(v835)
    LuaTimer:scheduleTimer(
        function()
            local v2186 = PlayerManager:getClientPlayer()
            local v2187 = v2186.Player:getPosition()
            local v2188 = PlayerManager:getPlayers()
            local v2189 = math.huge
            local v2190 = nil
            for v3770, v3771 in pairs(v2188) do
                if (v3771 ~= v2186) then
                    local v4851 = v3771:getPosition()
                    local v4852 = MathUtil:distanceSquare2d(v4851, v2187)
                    if (v4852 < v2189) then
                        v2189 = v4852
                        v2190 = v3771
                    end
                end
            end
            if (v2190 ~= nil) then
                if (v2189 < 10) then
                    v2186.Player:setSpeedAdditionLevel(1)
                else
                    v2186.Player:setSpeedAdditionLevel(100000)
                end
            end
        end,
        500,
        -1
    )
end
GMHelper.SpawnCube = function(v836)
    LuaTimer:scheduleTimer(
        function()
            local v2191 = PlayerManager:getClientPlayer():getPosition()
            local v2192 = v2191.x - 1
            local v2193 = v2191.y - 1
            local v2194 = v2191.z - 1
            for v3772 = 0, 2 do
                for v4547 = 0, 2 do
                    for v4853 = 0, 2 do
                        local v4854 = VectorUtil.newVector3(v2192 - v3772, v2193 + v4547, v2194 + v4853)
                        EngineWorld:setBlock(v4854, 3)
                    end
                end
            end
        end,
        100,
        -1
    )
end
GMHelper.SpawnSphere = function(v837)
    LuaTimer:scheduleTimer(
        function()
            local v2195 = PlayerManager:getClientPlayer():getPosition()
            local v2196 = 2
            for v3773 = -v2196, v2196 do
                for v4548 = -v2196, v2196 do
                    for v4855 = -v2196, v2196 do
                        local v4856 = math.sqrt((v3773 * v3773) + (v4548 * v4548) + (v4855 * v4855))
                        if (v4856 <= v2196) then
                            local v5175 = VectorUtil.newVector3(v2195.x - v3773, v2195.y - v4548, v2195.z - v4855)
                            EngineWorld:setBlock(v5175, 3)
                        end
                    end
                end
            end
        end,
        100,
        -1
    )
end
GMHelper.SpawnPyramid = function(v838)
    LuaTimer:scheduleTimer(
        function()
            local v2197 = PlayerManager:getClientPlayer():getPosition()
            local v2198 = 3
            for v3774 = 0, v2198 - 1 do
                for v4549 = -v3774, v3774 do
                    for v4857 = -v3774, v3774 do
                        local v4858 =
                            VectorUtil.newVector3(v2197.x + v4549, (v2197.y + (v2198 - 1)) - v3774, v2197.z + v4857)
                        EngineWorld:setBlock(v4858, 3)
                    end
                end
            end
        end,
        100,
        -1
    )
end
GMHelper.SpawnRhombus = function(v839)
    LuaTimer:scheduleTimer(
        function()
            local v2199 = PlayerManager:getClientPlayer():getPosition()
            local v2200 = 3
            for v3775 = 0, v2200 - 1 do
                for v4550 = -v3775, v3775 do
                    for v4859 = -v3775, v3775 do
                        local v4860 =
                            VectorUtil.newVector3(v2199.x + v4550, (v2199.y + (v2200 - 1)) - v3775, v2199.z + v4859)
                        EngineWorld:setBlock(v4860, 3)
                    end
                end
            end
            for v3776 = 1, v2200 - 1 do
                for v4551 = -v3776 + 1, v3776 - 1 do
                    for v4861 = -v3776 + 1, v3776 - 1 do
                        local v4862 =
                            VectorUtil.newVector3(v2199.x + v4551, v2199.y + (v2200 - 1) + v3776, v2199.z + v4861)
                        EngineWorld:setBlock(v4862, 3)
                    end
                end
            end
        end,
        100,
        -1
    )
end
GMHelper.ShowST = function(v840)
    local v841 = 3
    local v842 = BlockManager.getBlockById(v841)
    v842:setBlockBounds(0, 0, 0, 1, 1, 1)
end
GMHelper.HideST = function(v843)
    local v844 = 3
    local v845 = BlockManager.getBlockById(v844)
    v845:setBlockBounds(0, 0, 0, 0, 0, 0)
end
GMHelper.Tracer = function(v846)
    UIHelper.showToast("^FF00EE[ON]")
    local v847 = PlayerManager:getClientPlayer()
    LuaTimer:scheduleTimer(
        function()
            PlayerManager.getClientPlayer().Player:deleteAllGuideArrow()
            local v2201 = PlayerManager:getPlayers()
            for v3777, v3778 in pairs(v2201) do
                if (v3778 ~= v847) then
                    v847.Player:addGuideArrow(v3778:getPosition())
                end
            end
        end,
        500,
        -1
    )
end
GMHelper.rideDragonXD = function(v848)
    ClientHelper.putStringPrefs("RunSkillName", "ride_dragon")
    GUIGMControlPanel:hide()
end
GMHelper.SwimXD = function(v849)
    ClientHelper.putStringPrefs("RunSkillName", "swim")
    GUIGMControlPanel:hide()
end
GMHelper.quickblock = function(v850)
    GMHelper:openInput(
        {""},
        function(v2202)
            ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v2202)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.AutoClickNearest = function(v851)
    toggle = not toggle
    key = nil
    gay = nil
    if toggle then
        key =
            LuaTimer:scheduleTimer(
            function()
                local v4552 = _G["PlayerManager"]:getClientPlayer().Player
                local v4553 = _G["PlayerManager"]:getPlayers()
                local v4554 = math.huge
                local v4555 = nil
                for v4863, v4864 in pairs(v4553) do
                    local v4865 = MathUtil:distanceSquare2d(v4864:getPosition(), v4552:getPosition())
                    if ((v4864 ~= v4552) and (v4865 < v4554)) then
                        v4554 = v4865
                        v4555 = v4864
                    end
                end
                if v4555 then
                    gay =
                        _G["LuaTimer"]:scheduleTimer(
                        function()
                            local v5176 =
                                VectorUtil.newVector3(
                                v4555:getPosition().x,
                                v4555:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2)),
                                v4555:getPosition().z
                            )
                            CGame.Instance():handleTouchClick(
                                VectorUtil.newVector3(
                                    v4555:getPosition().x,
                                    v4555:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2))
                                )
                            )
                        end,
                        (tonumber(tostring(1787 - _G["dumb"]), 2)),
                        (tonumber(tostring(1111101777 - _G["dumb"]), 2))
                    )
                end
            end,
            (tonumber(tostring(1111101778 - _G["dumb"]), 2)),
            -(tonumber(tostring(778 - _G["dumb"]), 2))
        )
    else
        LuaTimer:cancel(key)
        LuaTimer:cancel(gay)
    end
end
GMHelper.ArmSpeed = function(v852)
    GMHelper:openInput(
        {""},
        function(v2203)
            ClientHelper.putIntPrefs("ArmSwingAnimationEnd", v2203)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.AutoMoveToNearestPlayer = function(v853)
    LuaTimer:scheduleTimer(
        function()
            toggle = not toggle
            if toggle then
                local v4556 = _G["PlayerManager"]:getClientPlayer().Player
                local v4557 = _G["PlayerManager"]:getPlayers()
                local v4558 = math.huge
                local v4559 = nil
                for v4866, v4867 in pairs(v4557) do
                    local v4868 = MathUtil:distanceSquare2d(v4867:getPosition(), v4556:getPosition())
                    if ((v4867 ~= v4556) and (v4868 < v4558)) then
                        v4558 = v4868
                        v4559 = v4867
                    end
                end
                if v4559 then
                    local v5048 =
                        VectorUtil.newVector3(v4559:getPosition().x, v4559:getPosition().y, v4559:getPosition().z)
                    v4556:setPosition(v5048)
                end
            end
        end,
        0.15,
        -1
    )
end
GMHelper.lagServer = function(v854)
    LuaTimer:scheduleTimer(
        function()
            for v3779 = 1, 3 do
                PacketSender:sendPidPacket()
            end
        end,
        0.1,
        1e+28
    )
end
GMHelper.CameraFunct = function(v855)
    GMHelper:openInput(
        {""},
        function(v2204)
            ClientHelper.putFloatPrefs("ThirdPersonDistance", v2204)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.Parachuteg = function(v856)
    GUIManager:getWindowByName("Main-Parachute"):SetVisible(true)
end
GMHelper.CloudsOFF = function(v857)
    ClientHelper.putBoolPrefs("DisableRenderClouds", true)
    UIHelper.showToast("^FF0000Clouds Stop")
    GUIGMControlPanel:hide()
end
GMHelper.TeleportToRandomPlayer = function(v858)
    local v859 = PlayerManager:getClientPlayer().Player
    local v860 = PlayerManager:getPlayers()
    if (#v860 > 1) then
        local v3780 = math.random(1, #v860)
        local v3781 = v860[v3780]
        v859:setPosition(v3781:getPosition())
        UIHelper.showToast("^00FF00Teleported to Random Player")
    else
        UIHelper.showToast("^FF0000No other players found")
    end
end
GMHelper.TntTag = function(v861)
    GUIManager:showWindowByName("Main-throwpot-Controls")
    GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
    GUIGMControlPanel:hide()
end
GMHelper.AutoParachute = function(v862)
    A = not A
    LuaTimer:cancel(v862.timer)
    UIHelper.showToast("^00FF00AutoParachute OFF")
    if A then
        v862.timer =
            LuaTimer:scheduleTimer(
            function()
                PlayerManager:getClientPlayer().Player:startParachute()
                UIHelper.showToast("^00FF00AutoParachute ON")
            end,
            0.15,
            -1
        )
    end
end
GMHelper.AFKmode1 = function(v863)
    A = not A
    PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1
    UIHelper.showToast("^FF00EEStart")
    if A then
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
        UIHelper.showToast("^FF00EEStop")
    end
end
GMHelper.BowSpeed = function(v865)
    ClientHelper.putFloatPrefs("BowPullingSpeedMultiplier", 1000)
    ClientHelper.putFloatPrefs("BowPullingFOVMultiplier", 0)
    UIHelper.showToast("^00FF00BowSpeed:ON")
    GUIGMControlPanel:hide()
end
GMHelper.startParachute = function(v866)
    PlayerManager:getClientPlayer().Player:startParachute()
end
GMHelper.SendMessage = function(v867)
    sendMsg(0, 5, msg)
end
GMHelper.HeadText = function(v868)
    A = not A
    ClientHelper.putBoolPrefs("RenderHeadText", true)
    if A then
        UIHelper.showToast("^00FF00Head text render now ON")
        return
    end
    ClientHelper.putBoolPrefs("RenderHeadText", false)
    UIHelper.showToast("^FF0000Head text render now OFF")
end
GMHelper.changePlayerActor = function(v869, v870)
    if isGameStart then
        if (v870 == 1) then
            ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
            ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
        else
            ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
            ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
        end
    elseif (v870 == 1) then
        ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
        ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
    else
        ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
        ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
    end
    local v871 = PlayerManager:getPlayers()
    for v2205, v2206 in pairs(v871) do
        if v2206.Player then
            v2206.Player.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v2206)
        end
    end
    UIHelper.showToast("^00FF00Success!")
    GUIGMControlPanel:hide()
end
GMHelper.BanClickCD = function(v872)
    A = not A
    ClientHelper.putBoolPrefs("banClickCD", true)
    PlayerManager:getClientPlayer().Player:setIntProperty("bedWarAttackCD", 0)
    UIHelper.showToast("^00FF00Nodelay ON!")
    if A then
        ClientHelper.putBoolPrefs("banClickCD", false)
        PlayerManager:getClientPlayer().Player:setIntProperty("bedWarAttackCD", 5)
        UIHelper.showToast("^FF0000Nodelay OFF!")
    end
end
GMHelper.ShowAllCobtrolXD = function(v873)
    RootGuiLayout.Instance():showMainControl()
end
GMHelper.CreateGUIDEArrow = function(v874)
    local v875 = PlayerManager:getPlayers()
    for v2207, v2208 in pairs(v875) do
        PlayerManager:getPlayers().Players:addGuideArrow(v2208)
        UIHelper.showToast("^FF00EEOk")
    end
end
GMHelper.PersonView = function(v876)
    GMHelper:openInput(
        {""},
        function(v2209)
            Blockman.Instance():setPersonView(v2209)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.BreakParticles = function(v877)
    GMHelper:openInput(
        {""},
        function(v2210)
            ClientHelper.putIntPrefs("BlockDestroyEffectSize", v2210)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.JailBreakBypass = function(v878)
    RootGuiLayout.Instance():showMainControl()
    GUIGMControlPanel:hide()
end
GMHelper.SpeedLineMode = function(v879)
    local v880 = 1
    local v881 = 0.01
    Blockman.Instance().m_gameSettings:setPatternSpeedLine(v880, v881)
    UIHelper.showToast("^00FF00Speed Line = Enable!")
    GUIGMControlPanel:hide()
end
GMHelper.SpeedLineModeDisable = function(v882)
    local v883 = 0
    local v884 = 0
    Blockman.Instance().m_gameSettings:setPatternSpeedLine(v883, v884)
    UIHelper.showToast("^FF0000Speed Line = Disabled!")
    GUIGMControlPanel:hide()
end
GMHelper.PatternTorchMode = function(v885)
    local v886 = 1
    Blockman.Instance().m_gameSettings:setPatternTorchStrength(v886)
    UIHelper.showToast("^00FF00PatternTorch = Enabled!")
    GUIGMControlPanel:hide()
end
GMHelper.PatternTorchModeOFF = function(v887)
    local v888 = 0
    Blockman.Instance().m_gameSettings:setPatternTorchStrength(v888)
    UIHelper.showToast("^FF0000PatternTorch = Disabled!")
    GUIGMControlPanel:hide()
end
GMHelper.CameraFlipModeRESET = function(v889)
    Blockman.Instance().m_gameSettings:setFovSetting(1)
    GUIGMControlPanel:hide()
end
GMHelper.BW = function(v890)
    GMHelper:openInput(
        {""},
        function(v2211)
            ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", v2211)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.BWV2 = function(v891)
    GMHelper:openInput(
        {""},
        function(v2212)
            ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", v2212)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.BlinkOP = function(v892)
    A = not A
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
    if A then
        UIHelper.showToast("^00FF00Blink Enabled!")
        return
    end
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
    UIHelper.showToast("^FF0000Blink Disabled!")
end
GMHelper.FollowPlayer = function(v893)
    GMHelper:openInput(
        {"id"},
        function(v2213)
            LuaTimer:scheduleTimer(
                function()
                    local v3784 = PlayerManager:getClientPlayer().Player
                    local v3785 = PlayerManager:getPlayerByUserId(v2213)
                    if v3785 then
                        v3784:setPosition(v3785:getPosition())
                    end
                end,
                0.1,
                1e+38
            )
        end
    )
end
GMHelper.CopyAllPlayer = function(v894)
    local v895 = PlayerManager:getPlayers()
    for v2214, v2215 in pairs(players) do
        MsgSender.sendMsg(string.format("%s", v2215.userId))
        ClientHelper.onSetClipboard(v895)
    end
end
GMHelper.FollowPlayer2 = function(v896)
    GMHelper:openInput(
        {"id"},
        function(v2216)
            local v2217 = PlayerManager:getClientPlayer().Player
            local v2218 = PlayerManager:getPlayerByUserId(v2216)
            if v2218 then
                v2217:setPosition(v2218:getPosition())
            end
        end
    )
end
GMHelper.CameraFlipModeON = function(v897)
    Blockman.Instance().m_gameSettings:setFovSetting(90)
    GUIGMControlPanel:hide()
end
GMHelper.Iikj = function(v898, v899)
    local v900 = v899:getPosition()
    v900.y = v900.y + 0.5
    local v902 = v899:getYaw()
    v899:teleportPosWithYaw(v900, v902)
    GUIGMControlPanel:hide()
end
GMHelper.TestAim = function(v903)
    targetPos = VectorUtil.newVector3(999, 1, 999)
    local v904 = 50
    LuaTimer:cancel(PlayerManager:getClientPlayer().cameraKey)
    PlayerManager:getClientPlayer().cameraKey =
        LuaTimer:scheduleTimer(
        function()
            local v2219, v2220 = getPitchAndYaw(targetPos)
            local v2221 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2222 = PlayerManager:getClientPlayer().Player.rotationPitch
            while math.abs(v2221 - v2219) > 180 do
                if (v2221 > v2219) then
                    v2219 = v2219 + 360
                else
                    v2219 = v2219 - 360
                end
            end
            if (v904 > 1) then
                PlayerManager:getClientPlayer().Player.rotationYaw = v2221 + ((v2219 - v2221) / v904)
                PlayerManager:getClientPlayer().Player.rotationPitch = v2222 + ((v2220 - v2222) / v904)
            else
                PlayerManager:getClientPlayer().Player.rotationYaw = v2219
                PlayerManager:getClientPlayer().Player.rotationPitch = v2220
            end
            v904 = v904 - 1
        end,
        20,
        50
    )
end
GMHelper.GUItest1 = function(v906)
    MsgSender.sendMsg(10007, "Lol Ok")
    MsgSender.sendMsg(10006, "a")
    MsgSender.sendMsg(10005, "a")
    MsgSender.sendMsg(10004, "a")
    MsgSender.sendMsg(10003, "a")
    MsgSender.sendMsg(10002, "a")
    MsgSender.sendMsg(10001, "a")
    MsgSender.sendMsg(10000, "a")
    MsgSender.sendMsg(1, "a")
end
GMHelper.FustBreakBlockMode = function(v907)
    cBlockManager.cGetBlockById(66):setNeedRender(false)
    cBlockManager.cGetBlockById(253):setNeedRender(false)
    for v2223 = 1, 40000 do
        local v2224 = BlockManager.getBlockById(v2223)
        if v2224 then
            v2224:setHardness(0)
            UIHelper.showToast("^00FF00Turned ON")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.FlyDev = function(v908)
    GUIManager:hideWindowByName("Main.binary")
    GUIManager:hideWindowByName("Main.json")
    GUIGMControlPanel:hide()
end
GMHelper.HideHP = function(v909)
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(false)
end
GMHelper.ShowHP = function(v910)
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
end
GMHelper.FlyDev2 = function(v911)
    for v2225 = 1, 40000 do
        local v2226 = BlockManager.getBlockById(v2225)
        if v2226 then
            Blockman.Instance():setBloomEnable(true)
            Blockman.Instance():enableFullscreenBloom(true)
            Blockman.Instance():setBlockBloomOption(100)
            Blockman.Instance():setBloomIntensity(100)
            Blockman.Instance():setBloomSaturation(100)
            Blockman.Instance():setBloomThreshold(100)
            UIHelper.showToast("^00FF00Speed Break Block = 0")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.FlyDev3 = function(v912)
    GUIManager:showWindowByName("PlayerInventory-DesignationTab")
    GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetVisible(true)
    GUIManager:showWindowByName("PlayerInventory-MainInventoryTab")
    GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetVisible(true)
    GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetArea({1, 1}, {1, 0}, {0, 1}, {0, 1})
    GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetArea({0, 0}, {0, 0}, {0.3, 0}, {0.3, 0})
    GUIManager:getWindowByName("PlayerInventory-ToggleInventoryButton"):SetVisible(true)
    GUIManager:showWindowByName("PlayerInventory-ToggleInventoryButton")
    GUIGMControlPanel:hide()
end
GMHelper.Freecam = function(v913)
    GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible(true)
    GUIGMControlPanel:hide()
end
GMHelper.TntTag = function(v914)
    GUIManager:showWindowByName("Main-throwpot-Controls")
    GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
    GUIGMControlPanel:hide()
end
GMHelper.SetBobbing = function(v915)
    GMHelper:openInput(
        {""},
        function(v2227)
            ClientHelper.putFloatPrefs("PlayerBobbingScale", v2227)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.test200 = function(v916)
    MsgSender.sendMsg(Messages:gameResetTimeHint())
    GUIGMControlPanel:hide()
end
GMHelper.test600 = function(v917)
    local v918 = PlayerManager:getPlayers()
    for v2228, v2229 in pairs(v918) do
        if v2229.Player then
            v2229.Player.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v2229)
        end
    end
    UIHelper.showToast("^00FF00yes")
    GUIGMControlPanel:hide()
end
GMHelper.JustClick = function(v919)
    LuaTimer:scheduleTimer(
        function()
            local v2230 = VectorUtil.newVector3(0, 30, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2230)
        end,
        5,
        2e+35
    )
end
GMHelper.JustClick2 = function(v920)
    LuaTimer:scheduleTimer(
        function()
            local v2231 = VectorUtil.newVector3(0, 300, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2231)
        end,
        5,
        2e+35
    )
end
GMHelper.OffChat = function(v921)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
end
GMHelper.OnChat = function(v922)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
end
GMHelper.Noclip = function(v923)
    A = not A
    for v2232 = 1, 40000 do
        local v2233 = BlockManager.getBlockById(v2232)
        if v2233 then
            v2233:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Noclip = true")
        return
    end
    for v2234 = 1, 40000 do
        local v2235 = BlockManager.getBlockById(v2234)
        if v2235 then
            v2235:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Noclip = false")
end
GMHelper.NoclipOP = function(v924)
    A = not A
    for v2236 = 3, 133 do
        local v2237 = BlockManager.getBlockById(v2236)
        if v2237 then
            v2237:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00TreasureHunterNoClip = Enabled")
        return
    end
    for v2238 = 3, 133 do
        local v2239 = BlockManager.getBlockById(v2238)
        if v2239 then
            v2239:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000TreasureHunterNoClip = Disabled")
end
GMHelper.NoObsidian1 = function(v925)
    A = not A
    for v2240 = 49, 50 do
        local v2241 = BlockManager.getBlockById(v2240)
        if v2241 then
            v2241:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2242 = 49, 50 do
        local v2243 = BlockManager.getBlockById(v2242)
        if v2243 then
            v2243:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoOakPlanks1 = function(v926)
    A = not A
    for v2244 = 5, 6 do
        local v2245 = BlockManager.getBlockById(v2244)
        if v2245 then
            v2245:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2246 = 5, 6 do
        local v2247 = BlockManager.getBlockById(v2246)
        if v2247 then
            v2247:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoGlass1 = function(v927)
    A = not A
    for v2248 = 94, 95 do
        local v2249 = BlockManager.getBlockById(v2248)
        if v2249 then
            v2249:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2250 = 94, 95 do
        local v2251 = BlockManager.getBlockById(v2250)
        if v2251 then
            v2251:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoEndStone1 = function(v928)
    A = not A
    for v2252 = 120, 121 do
        local v2253 = BlockManager.getBlockById(v2252)
        if v2253 then
            v2253:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2254 = 120, 121 do
        local v2255 = BlockManager.getBlockById(v2254)
        if v2255 then
            v2255:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoWool1 = function(v929)
    A = not A
    for v2256 = 34, 35 do
        local v2257 = BlockManager.getBlockById(v2256)
        if v2257 then
            v2257:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2258 = 34, 35 do
        local v2259 = BlockManager.getBlockById(v2258)
        if v2259 then
            v2259:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.openDebug = function(v930)
    CGame.Instance():toggleDebugMessageShown(true)
    GMHelper:moveDebugInfo(0, 0)
end
GMHelper.FunctionOFF = function(v931)
    Off = 10000
    UIHelper.showToast("^00FF00本栏持续运行功能中断")
end
GMHelper.FunctionON = function(v932)
    Off = 0
    UIHelper.showToast("^FF0000需要持续运行的功能可重新开启")
end
GMHelper.closeDebug = function(v933)
    CGame.Instance():toggleDebugMessageShown(false)
end
GMHelper.moveDebugInfo = function(v934, v935, v936)
    local v937 = tonumber(ClientHelper.getStringForKey("DebugInfoRenderOffsetX", "0")) or 0
    local v938 = tonumber(ClientHelper.getStringForKey("DebugInfoRenderOffsetY", "0")) or 0
    local v939 = v937 + v935
    local v940 = v938 + v936
    ClientHelper.putStringForKey("DebugInfoRenderOffsetX", tostring(v939))
    ClientHelper.putStringForKey("DebugInfoRenderOffsetY", tostring(v940))
    ClientHelper.putFloatPrefs("DebugInfoRenderOffsetX", v939)
    ClientHelper.putFloatPrefs("DebugInfoRenderOffsetY", v940)
end
GMHelper.setCPUTimerEnabled = function(v941, v942)
    GUIGMControlPanel:hide()
    PerformanceStatistics.SetCPUTimerEnabled(v942)
end
GMHelper.setGPUTimerEnabled = function(v943, v944)
    GUIGMControlPanel:hide()
    PerformanceStatistics.SetGPUTimerEnabled(v944)
end
GMHelper.printCPUTimerResult = function(v945)
    GUIGMControlPanel:hide()
    PerformanceStatistics.PrintResults(20)
end
GMHelper.quickblock = function(v946)
    GMHelper:openInput(
        {""},
        function(v2260)
            ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v2260)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.BlinkOP = function(v947)
    A = not A
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
    if A then
        UIHelper.showToast("^00FF00分身已开启,你的行踪将不会被发现")
        return
    end
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
    UIHelper.showToast("^FF0000分身已关闭,即将传送回本体")
end
GMHelper.bttest = function(v948)
    local v949 = io.popen("/data/user/0/com.sandboxol.blockymods/app_resources/airjump")
    local v950 = v949:read("*a")
    v949:close()
    UIHelper.showToast("^FF00EE白糖和茶" .. v950)
end
GMHelper.test2001 = function(v951)
    Chat:sendTextMsg(
        "089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test 089 Test "
    )
end
GMHelper.openChatWin = function(v952)
    UIHelper.showGameGUILayout("GUILuaChat", Define.ChatTabType.SameServer)
end
GMHelper.showChatRecord = function(v953, v954)
    ChatClient:getPrivateMsgCache(
        v954,
        nil,
        function(v2261)
            LogUtil.pv(v2261)
        end
    )
end
GMHelper.autoPrintResults = function(v955)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            PerformanceStatistics.PrintResults(20)
        end,
        5000
    )
end
GMHelper.autoProfilePerformance = function(v956)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            PerformanceStatistics.ProfilePerformance(20)
        end,
        100
    )
    GMHelper:showInput(
        {"exp", "exp2"},
        function(v2262, v2263)
        end
    )
end
GMHelper.EnterGame = function(v957, v958, v959)
    Game:resetGame(v959, PlayerManager:getClientPlayer().userId, v958)
end
GMHelper.EnterGameTest = function(v960, v961, v962, v963)
    Game:resetGame(v962, PlayerManager:getClientPlayer().userId)
end
GMHelper.SetPlayerScale2 = function(v964)
    PlayerManager:getClientPlayer().Player.SetPlayerScale = 5
end
GMHelper.setYaw = function(v966, v967, v968)
    if v968 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v967
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v967
end
GMHelper.setYaw = function(v970)
    GMHelper:openInput(
        {""},
        function(v2264)
            PlayerManager:getClientPlayer().Player.rotationYaw = v2264
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.East = function(v971, v972, v973)
    if v973 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v972
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v972
end
GMHelper.BypassOP = function(v975)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
                GMHelper:One()
            end,
            250
        )
    end
end
GMHelper.One = function(v976)
    LuaTimer:schedule(
        function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
            GMHelper:BypassOP()
        end,
        800
    )
end
GMHelper.East = function(v977)
    PlayerManager:getClientPlayer().Player.rotationYaw = 0
    UIHelper.showToast("^00FF00正东:Z正轴")
end
GMHelper.East5 = function(v979)
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + 5
    UIHelper.showToast("^00FF00朝向+5°")
end
GMHelper.West5 = function(v981)
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - 5
    UIHelper.showToast("^00FF00朝向-5°")
end
GMHelper.West = function(v983, v984, v985)
    if v985 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v984
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v984
end
GMHelper.West = function(v987)
    PlayerManager:getClientPlayer().Player.rotationYaw = 180
    UIHelper.showToast("^00FF00正西:Z负轴")
end
GMHelper.south = function(v989, v990, v991)
    if v991 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v990
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v990
end
GMHelper.south = function(v993)
    PlayerManager:getClientPlayer().Player.rotationYaw = 90
    UIHelper.showToast("^00FF00正南:X负轴")
end
GMHelper.north = function(v995, v996, v997)
    if v997 then
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw - v996
        return
    end
    PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v996
end
GMHelper.north = function(v999)
    PlayerManager:getClientPlayer().Player.rotationYaw = 270
    UIHelper.showToast("^00FF00正北:X正轴")
end
GMHelper.ChangeTime = function(v1001, v1002)
    local v1003 = EngineWorld:getWorld()
    if v1002 then
        v1003:setWorldTime(15000)
        UIHelper.showToast("^00FF00已更改")
        return
    end
    v1003:setWorldTime(6000)
    UIHelper.showToast("^FF0000已关闭")
end
GMHelper.SetTime = function(v1004)
    GMHelper:openInput(
        {""},
        function(v2266)
            local v2267 = EngineWorld:getWorld()
            v2267:setWorldTime(v2266)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.MineReset = function(v1005)
    local v1006 = VectorUtil.newVector3(536, 2.78, -136)
    local v1007 = VectorUtil.newVector3(0, 0, 0)
    PlayerManager:getClientPlayer().Player:setPosition(v1006)
    PlayerManager:getClientPlayer().Player:moveEntity(v1007)
end
GMHelper.StartTime = function(v1008)
    isTimeStopped = not isTimeStopped
    local v1009 = EngineWorld:getWorld()
    v1009:setTimeStopped(isTimeStopped)
    if isTimeStopped then
        UIHelper.showToast("^00FF00开启")
        return
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.TpPosition = function(v1010)
    local v1011 = VectorUtil.newVector3(0, 1.35, 0)
    local v1012 = PlayerManager:getClientPlayer()
    v1012.Player:setAllowFlying(true)
    v1012.Player:setFlying(true)
    v1012.Player:setPosition(ClientPos)
end
GMHelper.getPosition = function(v1013)
    ClientPos = PlayerManager:getClientPlayer():getPosition()
    local v1014 = VectorUtil.newVector3(ClientPos.x, ClientPos.y, ClientPos.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPos.x .. " " .. ClientPos.y .. " " .. ClientPos.z .. " ")
end
GMHelper.TpPositionv1 = function(v1015)
    local v1016 = VectorUtil.newVector3(0, 1.35, 0)
    local v1017 = PlayerManager:getClientPlayer()
    v1017.Player:setAllowFlying(true)
    v1017.Player:setFlying(true)
    v1017.Player:setPosition(ClientPosv1)
end
GMHelper.getPositionv1 = function(v1018)
    ClientPosv1 = PlayerManager:getClientPlayer():getPosition()
    local v1019 = VectorUtil.newVector3(ClientPosv1.x, ClientPosv1.y, ClientPosv1.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv1.x .. " " .. ClientPosv1.y .. " " .. ClientPosv1.z .. " ")
end
GMHelper.TpPositionv2 = function(v1020)
    local v1021 = VectorUtil.newVector3(0, 1.35, 0)
    local v1022 = PlayerManager:getClientPlayer()
    v1022.Player:setAllowFlying(true)
    v1022.Player:setFlying(true)
    v1022.Player:setPosition(ClientPosv2)
end
GMHelper.getPositionv2 = function(v1023)
    ClientPosv2 = PlayerManager:getClientPlayer():getPosition()
    local v1024 = VectorUtil.newVector3(ClientPosv2.x, ClientPosv2.y, ClientPosv2.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv2.x .. " " .. ClientPosv2.y .. " " .. ClientPosv2.z .. " ")
end
GMHelper.TpPositionv3 = function(v1025)
    local v1026 = VectorUtil.newVector3(0, 1.35, 0)
    local v1027 = PlayerManager:getClientPlayer()
    v1027.Player:setAllowFlying(true)
    v1027.Player:setFlying(true)
    v1027.Player:setPosition(ClientPosv3)
end
GMHelper.getPositionv3 = function(v1028)
    ClientPosv3 = PlayerManager:getClientPlayer():getPosition()
    local v1029 = VectorUtil.newVector3(ClientPosv3.x, ClientPosv3.y, ClientPosv3.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv3.x .. " " .. ClientPosv3.y .. " " .. ClientPosv3.z .. " ")
end
GMHelper.TpPositionv4 = function(v1030)
    local v1031 = VectorUtil.newVector3(0, 1.35, 0)
    local v1032 = PlayerManager:getClientPlayer()
    v1032.Player:setAllowFlying(true)
    v1032.Player:setFlying(true)
    v1032.Player:setPosition(ClientPosv4)
end
GMHelper.getPositionv4 = function(v1033)
    ClientPosv4 = PlayerManager:getClientPlayer():getPosition()
    local v1034 = VectorUtil.newVector3(ClientPosv4.x, ClientPosv4.y, ClientPosv4.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv4.x .. " " .. ClientPosv4.y .. " " .. ClientPosv4.z .. " ")
end
GMHelper.TpPositionv5 = function(v1035)
    local v1036 = VectorUtil.newVector3(0, 1.35, 0)
    local v1037 = PlayerManager:getClientPlayer()
    v1037.Player:setAllowFlying(true)
    v1037.Player:setFlying(true)
    v1037.Player:setPosition(ClientPosv5)
end
GMHelper.getPositionv5 = function(v1038)
    ClientPosv5 = PlayerManager:getClientPlayer():getPosition()
    local v1039 = VectorUtil.newVector3(ClientPosv5.x, ClientPosv5.y, ClientPosv5.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv5.x .. " " .. ClientPosv5.y .. " " .. ClientPosv5.z .. " ")
end
GMHelper.TpPositionv6 = function(v1040)
    local v1041 = VectorUtil.newVector3(0, 1.35, 0)
    local v1042 = PlayerManager:getClientPlayer()
    v1042.Player:setAllowFlying(true)
    v1042.Player:setFlying(true)
    v1042.Player:setPosition(ClientPosv6)
end
GMHelper.getPositionv6 = function(v1043)
    ClientPosv6 = PlayerManager:getClientPlayer():getPosition()
    local v1044 = VectorUtil.newVector3(ClientPosv6.x, ClientPosv6.y, ClientPosv6.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv6.x .. " " .. ClientPosv6.y .. " " .. ClientPosv6.z .. " ")
end
GMHelper.TpPositionv7 = function(v1045)
    local v1046 = VectorUtil.newVector3(0, 1.35, 0)
    local v1047 = PlayerManager:getClientPlayer()
    v1047.Player:setAllowFlying(true)
    v1047.Player:setFlying(true)
    v1047.Player:setPosition(ClientPosv7)
end
GMHelper.getPositionv7 = function(v1048)
    ClientPosv7 = PlayerManager:getClientPlayer():getPosition()
    local v1049 = VectorUtil.newVector3(ClientPosv7.x, ClientPosv7.y, ClientPosv7.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv7.x .. " " .. ClientPosv7.y .. " " .. ClientPosv7.z .. " ")
end
GMHelper.TpPositionv8 = function(v1050)
    local v1051 = VectorUtil.newVector3(0, 1.35, 0)
    local v1052 = PlayerManager:getClientPlayer()
    v1052.Player:setAllowFlying(true)
    v1052.Player:setFlying(true)
    v1052.Player:setPosition(ClientPosv8)
end
GMHelper.getPositionv8 = function(v1053)
    ClientPosv8 = PlayerManager:getClientPlayer():getPosition()
    local v1054 = VectorUtil.newVector3(ClientPosv8.x, ClientPosv8.y, ClientPosv8.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv8.x .. " " .. ClientPosv8.y .. " " .. ClientPosv8.z .. " ")
end
GMHelper.TpPositionv9 = function(v1055)
    local v1056 = VectorUtil.newVector3(0, 1.35, 0)
    local v1057 = PlayerManager:getClientPlayer()
    v1057.Player:setAllowFlying(true)
    v1057.Player:setFlying(true)
    v1057.Player:setPosition(ClientPosv9)
end
GMHelper.getPositionv9 = function(v1058)
    ClientPosv9 = PlayerManager:getClientPlayer():getPosition()
    local v1059 = VectorUtil.newVector3(ClientPosv9.x, ClientPosv9.y, ClientPosv9.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv9.x .. " " .. ClientPosv9.y .. " " .. ClientPosv9.z .. " ")
end
GMHelper.ToPosition = function(v1060)
    local v1061 = 50
    local v1060 = PlayerManager:getClientPlayer():getPosition()
    local v1062 = (ClientPos.x - v1060.x) / v1061
    local v1063 = math.floor(v1062)
    if (v1062 <= 0.1) then
        r = -1
    end
    if (v1062 >= 0.1) then
        r = 1
    end
    for v2268 = 0, v1063 - r, r do
        LuaTimer:schedule(
            function()
                local v3791 = VectorUtil.newVector3(r * v1061, 20, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3791)
            end,
            3000
        )
    end
    local v1064 = PlayerManager:getClientPlayer():getPosition()
    check = ClientPos.x - v1064.x
    if (check >= 0) then
        d = 1
    end
    if (check <= 0) then
        d = -1
    end
    checkNum = math.abs(check)
    if ((checkNum >= 1.01) and (d == 1)) then
        local v3792 = VectorUtil.newVector3(d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3792)
    end
    if ((checkNum >= 1.01) and (d == -1)) then
        local v3793 = VectorUtil.newVector3(-1 * d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3793)
    end
    local v1065 = (ClientPos.z - v1060.z) / v1061
    local v1066 = math.floor(v1065)
    if (v1065 <= 0.1) then
        r = -1
    end
    if (v1065 >= 0.1) then
        r = 1
    end
    for v2269 = 0, v1063 - r, r do
        LuaTimer:schedule(
            function()
                local v3794 = VectorUtil.newVector3(r * v1061, 20, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3794)
            end,
            3000
        )
    end
    local v1064 = PlayerManager:getClientPlayer():getPosition()
    check = ClientPos.z - v1064.z
    if (check >= 0) then
        d = 1
    end
    if (check <= 0) then
        d = -1
    end
    checkNum = math.abs(check)
    if ((checkNum >= 1.01) and (d == 1)) then
        local v3795 = VectorUtil.newVector3(d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3795)
    end
    if ((checkNum >= 1.01) and (d == -1)) then
        local v3796 = VectorUtil.newVector3(-1 * d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3796)
    end
end
GMHelper.ToPositionv1 = function(v1067)
    local v1068 = 50
    local v1067 = PlayerManager:getClientPlayer():getPosition()
    local v1069 = (ClientPosv1.x - v1067.x) / v1068
    local v1070 = math.floor(v1069)
    if (v1069 <= 0.1) then
        r = -1
    end
    if (v1069 >= 0.1) then
        r = 1
    end
    for v2270 = 0, v1070 - r, r do
        LuaTimer:schedule(
            function()
                local v3797 = VectorUtil.newVector3(r * v1068, 20, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3797)
            end,
            3000
        )
    end
    local v1071 = PlayerManager:getClientPlayer():getPosition()
    check = ClientPosv1.x - v1071.x
    if (check >= 0) then
        d = 1
    end
    if (check <= 0) then
        d = -1
    end
    checkNum = math.abs(check)
    if ((checkNum >= 1.01) and (d == 1)) then
        local v3798 = VectorUtil.newVector3(d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3798)
    end
    if ((checkNum >= 1.01) and (d == -1)) then
        local v3799 = VectorUtil.newVector3(-1 * d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3799)
    end
    local v1072 = (ClientPosv1.z - v1067.z) / v1068
    local v1073 = math.floor(v1072)
    if (v1072 <= 0.1) then
        r = -1
    end
    if (v1072 >= 0.1) then
        r = 1
    end
    for v2271 = 0, v1070 - r, r do
        LuaTimer:schedule(
            function()
                local v3800 = VectorUtil.newVector3(r * v1068, 20, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3800)
            end,
            3000
        )
    end
    local v1071 = PlayerManager:getClientPlayer():getPosition()
    check = ClientPosv1.z - v1071.z
    if (check >= 0) then
        d = 1
    end
    if (check <= 0) then
        d = -1
    end
    checkNum = math.abs(check)
    if ((checkNum >= 1.01) and (d == 1)) then
        local v3801 = VectorUtil.newVector3(d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3801)
    end
    if ((checkNum >= 1.01) and (d == -1)) then
        local v3802 = VectorUtil.newVector3(-1 * d * check, 3, 0)
        PlayerManager:getClientPlayer().Player:moveEntity(v3802)
    end
end
GMHelper.getconfig = function(v1074)
    MsgSender.sendMsg("Time:" .. tostring(ModsConfig.time))
    MsgSender.sendMsg("Show pos:" .. tostring(ModsConfig.showPos))
    MsgSender.sendMsg("Hp warn:" .. tostring(ModsConfig.lhwarn))
    MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
    MsgSender.sendMsg("Hide player names:" .. tostring(ModsConfig.hpn))
end
GMHelper.getConfig = function(v1075)
    UIHelper.showToast("剩余次数:" .. ModsConfig.lhwarn)
end
GMHelper.HidePlayerName = function(v1076)
    isHideNames = not isHideNames
    if isHideNames then
        ModsConfig.hpn = 1
        MsgSender.sendMsg("Hide players name: enabled!")
        return
    end
    if not isHideNames then
        ModsConfig.hpn = 0
        MsgSender.sendMsg("Hide players name: disabled!")
    end
end
GMHelper.ShowPos = function(v1077)
    isShowPos = not isShowPos
    if isShowPos then
        ModsConfig.showPos = 1
        MsgSender.sendMsg("Show player position: enabled!")
        return
    end
    ModsConfig.showPos = 0
    MsgSender.sendMsg("Show player position: disabled!")
end
GMHelper.EnableHPWarn = function(v1079)
    useHPWarn = not useHPWarn
    if useHPWarn then
        ModsConfig.lhwarn = 1
        MsgSender.sendMsg("HP Warning: enabled!")
        return
    end
    ModsConfig.lhwarn = 0
    MsgSender.sendMsg("HP Warning: disabled!")
end
GMHelper.addHpLvl = function(v1081, v1082, v1083)
    if v1083 then
        if (ModsConfig.hpwarn == 0) then
            return
        end
        ModsConfig.hpwarn = ModsConfig.hpwarn - 1
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
        return
    end
    if (ModsConfig.hpwarn == PlayerManager:getClientPlayer().Player:getHealth()) then
        return
    end
    ModsConfig.hpwarn = ModsConfig.hpwarn + 1
    MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
end
GMHelper.addGMPlayer = function(v1085, v1086, v1087)
    if not isClient then
        return
    end
    if v1087 then
        for v4566, v4567 in pairs(PlayerManager:getPlayers()) do
            v4567:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v4567.userId)
        end
    else
        local v3808 = PlayerManager:getPlayers()
        local v3809 = 99999999
        local v3810
        for v4568, v4569 in pairs(v3808) do
            local v4570 = MathUtil:distanceSquare3d(v4569:getPosition(), v1086:getPosition())
            if ((v3809 > v4570) and (v4569 ~= v1086)) then
                v3809 = v4570
                v3810 = v4569
            end
        end
        if (v3810 and not PlayerManager:isAIPlayer(v3810)) then
            v3810:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v3810.userId)
        end
    end
    GUIGMControlPanel:hide()
end
GMHelper.callCommand = function(v1088, v1089, ...)
    local v1090 = v1088[v1089]
    if (type(v1090) == "function") then
        v1090(v1088, ...)
    end
    local v1091 = {name = v1089, params = {...}}
    table.remove(v1091.params)
    PacketSender:sendLuaCommonData("GMCommand", json.encode(v1091))
end
GMHelper.openCommonPacketDebug = function(v1092)
    CommonDataEvents.isDebug = true
end
GMHelper.closeCommonPacketDebug = function(v1094)
    CommonDataEvents.isDebug = false
end
GMHelper.openConnectorLog = function(v1096)
    local v1097 = T(Global, "ConnectorCenter")
    v1097.isDebug = true
    local v1099 = T(Global, "ConnectorDispatch")
    v1099.isDebug = true
end
GMHelper.closeConnectorLog = function(v1101)
    local v1102 = T(Global, "ConnectorCenter")
    v1102.isDebug = false
    local v1104 = T(Global, "ConnectorDispatch")
    v1104.isDebug = false
end
GMHelper.SetEnabledRenderFrameTimer = function(v1106, v1107)
    PerformanceStatistics.SetEnabledRenderFrameTimer(v1107)
    GUIGMControlPanel:hide()
end
GMHelper.updateAllShaders = function(v1108)
    Blockman.Instance().m_gameSettings:updateAllShaders()
    GUIGMControlPanel:hide()
end
GMHelper.setNeedMonitorShader = function(v1109)
    Blockman.Instance().m_gameSettings:setNeedMonitorShader(true)
    GUIGMControlPanel:hide()
end
GMHelper.setDrawCallDisabled = function(v1110)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setDrawCallDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setMinimumGeometry = function(v1111)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setMinimumGeometry(true)
    GUIGMControlPanel:hide()
end
GMHelper.setColorBlendDisabled = function(v1112)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setColorBlendDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setZTestDisabled = function(v1113)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setZTestDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setZWriteDisabled = function(v1114)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setZWriteDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.setUseSmallTexture = function(v1115)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallTexture(true)
    GUIGMControlPanel:hide()
end
GMHelper.setUseSmallViewport = function(v1116)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallViewport(true)
    GUIGMControlPanel:hide()
end
GMHelper.setUseSmallVBO = function(v1117)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setUseSmallVBO(true)
    GUIGMControlPanel:hide()
end
GMHelper.setClearColorDisabled = function(v1118)
    PerformanceStatistics.SetEnabledRenderFrameTimer(true)
    RenderExperimentSwitch.Instance():setClearColorDisabled(true)
    GUIGMControlPanel:hide()
end
GMHelper.DisableGraphicAPI = function(v1119)
    Blockman.disableGraphicAPI()
end
GMHelper.DisableGraphicAPIAndTestCPU = function(v1120)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetCPUTimerEnabled(true)
            PerformanceStatistics.SetGPUTimerEnabled(false)
            LuaTimer:schedule(
                function()
                    PerformanceStatistics.PrintResults(30)
                end,
                5100
            )
        end,
        200
    )
end
GMHelper.DisableGraphicAPIAndTestGPU = function(v1121)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetCPUTimerEnabled(false)
            PerformanceStatistics.SetGPUTimerEnabled(true)
            LuaTimer:schedule(
                function()
                    PerformanceStatistics.PrintResults(30)
                end,
                5100
            )
        end,
        200
    )
end
GMHelper.DisableGraphicAPIAndDrawCallTest = function(v1122)
    GUIGMControlPanel:hide()
    LuaTimer:schedule(
        function()
            Blockman.disableGraphicAPI()
            PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        end,
        200
    )
end
GMHelper.AddWarnLimit = function(v1123)
    WarnHP = WarnHP + 1
    UIHelper.showToast("^FF0000当前血量警示临界值: " .. WarnHP)
end
GMHelper.SubWarnLimit = function(v1124)
    WarnHP = WarnHP - 1
    UIHelper.showToast("^FF0000当前血量警示临界值: " .. WarnHP)
end
GMHelper.WarnTP = function(v1125)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                local v4571 = PlayerManager:getClientPlayer()
                local v4572 = v4571.Player:getHealth()
                if (v4572 <= WarnHP) then
                    local v5049 = VectorUtil.newVector3(0, 1.35, 0)
                    local v5050 = PlayerManager:getClientPlayer()
                    v5050.Player:setPosition(ClientPos)
                end
                GMHelper:WarnTP()
            end,
            10
        )
    end
end
GMHelper.WarnJL = function(v1126)
    ClientPos = PlayerManager:getClientPlayer():getPosition()
    local v1127 = VectorUtil.newVector3(ClientPos.x, ClientPos.y, ClientPos.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPos.x .. " " .. ClientPos.y .. " " .. ClientPos.z .. " ")
end
GMHelper.getDistance = function(v1128)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2272)
            Zimiao(v2272)
        end
    )
end
function Zimiao(v1129)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                player = PlayerManager:getClientPlayer()
                Dplayer = PlayerManager:getPlayerByUserId(v1129)
                if Dplayer then
                    for v5177 = 1, 999 do
                        play = player:getPosition()
                        UIDpos = Dplayer:getPosition()
                        local v5178 = ((UIDpos.x - play.x) ^ 2) + (play.z - UIDpos.z)
                        local v5179 = UIDpos.y - play.y
                        local v5180 = math.sqrt(v5178)
                        UIHelper.showToast("你与目标距离: " .. v5180 .. " 高度相差: " .. v5179)
                    end
                end
                Zimiao(v1129)
            end,
            10
        )
    end
end
GMHelper.openScreenRecord = function(v1130)
    local v1131 = {"Main-PoleControl-Move", "Main-PoleControl", "Main-FlyingControls", "Main-Fly"}
    local v1132 = GUISystem.Instance():GetRootWindow()
    v1132:SetXPosition({0, 10000})
    local v1133 = GUIManager:getWindowByName("Main")
    local v1134 = v1133:GetChildCount()
    for v2273 = 1, v1134 do
        local v2274 = v1133:GetChildByIndex(v2273 - 1)
        local v2275 = v2274:GetName()
        if not TableUtil.tableContain(v1131, v2275) then
            v2274:SetXPosition({0, 10000})
            v2274:SetYPosition({0, 10000})
        end
    end
    ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
    ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)
    GUIManager:getWindowByName("Main-Fly"):SetProperty("NormalImage", "")
    GUIManager:getWindowByName("Main-Fly"):SetProperty("PushedImage", "")
    GUIManager:getWindowByName("Main-PoleControl-BG"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-PoleControl-Center"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Up"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Drop"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Down"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Break-Block-Progress-Nor"):SetProperty("ImageName", "")
    GUIManager:getWindowByName("Main-Break-Block-Progress-Pre"):SetProperty("ImageName", "")
    v1133:SetXPosition({0, -10000})
    ClientHelper.putBoolPrefs("RenderHeadText", false)
    PlayerManager:getClientPlayer().Player:setActorInvisible(true)
end
GMHelper.changeLuaHotUpdate = function(v1135, v1136)
    startLuaHotUpdate()
    HU.CanUpdate = v1136
end
GMHelper.changeOpenEventDialog = function(v1138, v1139)
    GUIGMMain:changeOpenEventDialog(v1139)
end
GMHelper.showUserRegion = function(v1140)
    UIHelper.showToast("游戏大区=" .. Game:getRegionId() .. "   玩家区域=" .. Game:getUserRegion())
end
GMHelper.setOutputUIName = function(v1141, v1142)
    GUISystem.Instance():SetOutputUIName(not GUISystem.Instance():IsOutputUIName())
    v1142:SetText("打印UI(" .. ((GUISystem.Instance():IsOutputUIName() and "开)") or "关)"))
end
GMHelper.telnetClient = function(v1143)
    if not Platform.isWindow() then
        return
    end
    local v1144 = require("misc")
    local v1145 = require("engine_base.debug.DebugPort")
    v1144.win_exec("telnet.exe", "127.0.0.1 " .. v1145.port, nil, nil, true)
end
GMHelper.telnetServer = function(v1146)
    if not Platform.isWindow() then
        return
    end
    local v1147 = require("misc")
    local v1148 = require("engine_base.debug.DebugPort")
    v1147.win_exec("telnet.exe", "127.0.0.1 " .. v1148.port, 1, 1, true)
end
GMHelper.setGlobalShowText = function(v1149)
    Root.Instance():setShowText(not Root.Instance():isShowText())
end
GMHelper.copyClientLog = function(v1150)
    if Platform.isWindow() then
        return
    end
    local v1151 = Root.Instance():getWriteablePath() .. "client.log"
    local v1152 = io.open(v1151, "r")
    if not v1152 then
        return
    end
    local v1153 = v1152:read("*a")
    v1152:close()
    ClientHelper.onSetClipboard(v1153)
    UIHelper.showToast("拷贝成功，请粘贴到钉钉上自动生成文件发送到群里")
end
GMHelper.sendConnectorChatMsg = function(v1154, v1155)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4573 = T(Global, "ChatService")
                for v4869 = 1, v1155 do
                    v4573:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {content = "［此信息为自动刷］\n早点睡觉\n别看了\n傻逼CRIEX菜鸡\n次数：" .. v4869}
                    )
                end
            end
            GMHelper:sendConnectorChatMsg(v1155)
        end,
        1000
    )
end
GMHelper.sendConnectorChatMsg1 = function(v1156, v1157)
    if (isClient or isStaging) then
        local v3811 = T(Global, "ChatService")
        for v4574 = 1, v1157 do
            v3811:sendMsgToLangGroup(Define.ChatMsgType.TextMsg, {content = "早点睡觉\n别看了\n傻逼CRIEX菜鸡" .. v4574})
        end
    end
end
GMHelper.sendConnectorChatMsg2 = function(v1158, v1159)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4575 = T(Global, "ChatService")
                for v4870 = 1, v1159 do
                    v4575:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {content = "[此信息为自动发]\n我又回来了\n今早7点就停了\n次数：" .. v4870}
                    )
                end
            end
            GMHelper:sendConnectorChatMsg2(v1159)
        end,
        1000
    )
end
GMHelper.sendConnectorChatMsg3 = function(v1160, v1161)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4576 = T(Global, "ChatService")
                for v4871 = 1, v1161 do
                    v4576:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {
                            content = "[AUTO SEND]\nThis Message Is From SkyBlock DEV\n New Updates- GiveAway All SkyBlock Player Vip Game Pass \nFrom: BlockmanGo SkyBlock Dev" ..
                                v4871
                        }
                    )
                end
            end
            GMHelper:sendConnectorChatMsg3(v1161)
        end,
        1000
    )
end
GMHelper.sendConnectorChatMsg4 = function(v1162, v1163)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4577 = T(Global, "ChatService")
                for v4872 = 1, v1163 do
                    v4577:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {
                            content = "哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\n哈\nF\nu\nc\nk\nY\no\nu\nG\na\ny\n此数：" ..
                                v4872
                        }
                    )
                end
            end
            GMHelper:sendConnectorChatMsg4(v1163)
        end,
        1000
    )
end
GMHelper.sendConnectorChatMsg5 = function(v1164, v1165)
    if (isClient or isStaging) then
        local v3812 = T(Global, "ChatService")
        for v4578 = 1, v1165 do
            v3812:sendMsgToLangGroup(Define.ChatMsgType.TextMsg, {content = "我回来了各位\n想我了吗？\n我要刷到早上了哦" .. v4578})
        end
    end
end
GMHelper.sendConnectorChatMsg6 = function(v1166, v1167)
    LuaTimer:schedule(
        function()
            if (isClient or isStaging) then
                local v4579 = T(Global, "ChatService")
                for v4873 = 1, v1167 do
                    v4579:sendMsgToLangGroup(
                        Define.ChatMsgType.TextMsg,
                        {
                            content = "[自动发]\n测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试.测试." ..
                                v4873
                        }
                    )
                end
            end
            GMHelper:sendConnectorChatMsg6(v1167)
        end,
        1000
    )
end
GMHelper.sendTestConnectorMsg = function(v1168, v1169)
    local v1170 = {}
    v1170.a = 1
    v1170.b = 2
    local v1173 = T(Global, "ConnectorCenter")
    v1173:sendMsg(v1169, v1170)
end
GMHelper.queryBoolKey = function(v1174)
    GMHelper:openInput(
        {""},
        function(v2276)
            CustomDialog.builder().setContentText(v2276 .. "=" .. tostring(ClientHelper.getBoolForKey(v2276))).setHideLeftButton(

            ).show()
            GUIGMControlPanel:hide()
        end
    )
end
GMHelper.queryStringKey = function(v1175)
    GMHelper:openInput(
        {""},
        function(v2277)
            CustomDialog.builder().setContentText(v2277 .. "=" .. ClientHelper.getStringForKey(v2277)).setHideLeftButton(

            ).setRightText("复制到粘贴板").setRightClickListener(
                function()
                    ClientHelper.onSetClipboard(ClientHelper.getStringForKey(v2277))
                    UIHelper.showToast("复制成功")
                end
            ).show()
            GUIGMControlPanel:hide()
        end
    )
end
GMHelper.makeGmButtonTran = function(v1176)
    GUIGMMain:setTransparent()
end
GMHelper.setRenderMainScreenSeparate = function(v1177, v1178)
    Root.Instance():setRenderMainScreenSeparate(v1178)
end
GMHelper.setEnableMergeBlock = function(v1179, v1180)
    Root.Instance():setEnableMergeBlock(true)
    UIHelper.showToast("1")
end
GMHelper.AnvilToObj = function(v1181)
    local v1182 = VectorUtil.newVector3()
    local v1183 = 32
    AnvilToObj.doTranslate(v1182, v1183)
end
GMHelper.SetUpBuild = function(v1184)
    GMHelper:openInput(
        {""},
        function(v2278)
            ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v2278)
            UIHelper.showToast("^FF00EE连叠" .. v2278 .. "格")
        end
    )
end
GMHelper.NoFall = function(v1185)
    A = not A
    ClientHelper.putIntPrefs("SprintLimitCheck", 7)
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    ClientHelper.putIntPrefs("SprintLimitCheck", 0)
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoFallSet = function(v1186)
    GMHelper:openInput(
        {""},
        function(v2279)
            ClientHelper.putIntPrefs("SprintLimitCheck", v2279)
            UIHelper.showToast("设置成功")
        end
    )
end
GMHelper.inTheAirCheat = function(v1187)
    LuaTimer:scheduleTimer(
        function()
            local v2280 = VectorUtil.newVector3(0, 3, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2280)
        end,
        5,
        20
    )
end
GMHelper.GoTO10BlocksDown = function(v1188)
    LuaTimer:scheduleTimer(
        function()
            local v2281 = VectorUtil.newVector3(0, 0, 1)
            PlayerManager:getClientPlayer().Player:moveEntity(v2281)
        end,
        5,
        20
    )
end
GMHelper.GoTO20BlocksDown = function(v1189)
    LuaTimer:scheduleTimer(
        function()
            local v2282 = VectorUtil.newVector3(0, 0, -1)
            PlayerManager:getClientPlayer().Player:moveEntity(v2282)
        end,
        5,
        20
    )
end
GMHelper.GoTO10Blocks = function(v1190)
    LuaTimer:scheduleTimer(
        function()
            local v2283 = VectorUtil.newVector3(1, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2283)
        end,
        5,
        20
    )
end
GMHelper.GoTO20Blocks = function(v1191)
    LuaTimer:scheduleTimer(
        function()
            local v2284 = VectorUtil.newVector3(-1, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2284)
        end,
        5,
        20
    )
end
GMHelper.XTP50 = function(v1192)
    LuaTimer:scheduleTimer(
        function()
            local v2285 = VectorUtil.newVector3(2.5, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2285)
        end,
        5,
        20
    )
end
GMHelper.XRTP50 = function(v1193)
    LuaTimer:scheduleTimer(
        function()
            local v2286 = VectorUtil.newVector3(-2.5, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2286)
        end,
        5,
        20
    )
end
GMHelper.ZTP50 = function(v1194)
    LuaTimer:scheduleTimer(
        function()
            local v2287 = VectorUtil.newVector3(0, 0, 2.5)
            PlayerManager:getClientPlayer().Player:moveEntity(v2287)
        end,
        5,
        20
    )
end
GMHelper.ZRTP50 = function(v1195)
    LuaTimer:scheduleTimer(
        function()
            local v2288 = VectorUtil.newVector3(0, 0, -2.5)
            PlayerManager:getClientPlayer().Player:moveEntity(v2288)
        end,
        5,
        20
    )
end
GMHelper.linetp = function(v1196)
    local v1197 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1198 = math.rad(v1197)
    local v1199 = math.sin(v1198)
    local v1200 = math.cos(v1198)
    local v1201 = VectorUtil.newVector3(-50 * v1199, 0, 50 * v1200)
    PlayerManager:getClientPlayer().Player:moveEntity(v1201)
end
GMHelper.linetpr = function(v1202)
    local v1203 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1204 = math.rad(v1203)
    local v1205 = math.sin(v1204)
    local v1206 = math.cos(v1204)
    LuaTimer:scheduleTimer(
        function()
            local v2289 = VectorUtil.newVector3(2.5 * v1205, 0, -2.5 * v1206)
            PlayerManager:getClientPlayer().Player:moveEntity(v2289)
        end,
        5,
        20
    )
end
GMHelper.linetp5 = function(v1207)
    local v1208 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1209 = math.rad(v1208)
    local v1210 = math.sin(v1209)
    local v1211 = math.cos(v1209)
    local v1212 = VectorUtil.newVector3(-5 * v1210, 0, 5 * v1211)
    PlayerManager:getClientPlayer().Player:moveEntity(v1212)
end
GMHelper.linetpr5 = function(v1213)
    local v1214 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1215 = math.rad(v1214)
    local v1216 = math.sin(v1215)
    local v1217 = math.cos(v1215)
    local v1218 = VectorUtil.newVector3(-5 * v1216, 0, 5 * v1217)
    PlayerManager:getClientPlayer().Player:moveEntity(v1218)
end
GMHelper.linetp25 = function(v1219)
    local v1220 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1221 = math.rad(v1220)
    local v1222 = math.sin(v1221)
    local v1223 = math.cos(v1221)
    LuaTimer:scheduleTimer(
        function()
            local v2290 = VectorUtil.newVector3(-1.25 * v1222, 0, 1.25 * v1223)
            PlayerManager:getClientPlayer().Player:moveEntity(v2290)
        end,
        5,
        20
    )
end
GMHelper.linetpr25 = function(v1224)
    local v1225 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1226 = math.rad(v1225)
    local v1227 = math.sin(v1226)
    local v1228 = math.cos(v1226)
    LuaTimer:scheduleTimer(
        function()
            local v2291 = VectorUtil.newVector3(1.25 * v1227, 0, -1.25 * v1228)
            PlayerManager:getClientPlayer().Player:moveEntity(v2291)
        end,
        5,
        20
    )
end
GMHelper.tptest = function(v1229)
    LuaTimer:schedule(
        function()
            local v2292 = PlayerManager:getClientPlayer():getPosition()
            local v2293 = math.modf(v2292.y * 100)
            local v2294 = math.modf(v2292.x * 100)
            local v2295 = math.modf(v2292.z * 100)
            local v2296 = v2293 / 100
            local v2297 = v2294 / 100
            local v2298 = v2295 / 100
            local v2299 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2300 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
            v2299 = v2299 % 360
            if (v2299 < 0) then
                v2299 = v2299 + 360
            end
            local v2301 = (math.floor((v2299 + 22.5) / 45) % 8) + 1
            local v2302 = v2300[v2301]
            MsgSender.sendTopTips(
                10,
                "▢FFFFFF00[CryIsHere] ▢FFFFFFFF作者ID：569448335 \n 朝向:" ..
                    v2302 .. "\n X:" .. v2297 .. " Y:" .. v2296 .. " Z:" .. v2298
            )
            GMHelper:tptest()
        end,
        10
    )
end
GMHelper.testModiyScript = function(v1230)
    ClientHttpRequest.reportScriptModifyCheat()
end
GMHelper.setShowGunFlameCoordinate = function(v1231, v1232)
    Blockman.Instance():setShowGunFlameCoordinate(v1232)
    if v1232 then
        GUIGMControlPanel:setBackgroundColor(Color.TRANS)
    else
        GUIGMControlPanel:setBackgroundColor({0, 0, 0, 0.784314})
    end
end
GMHelper.changeGunFlameParam = function(v1233, v1234, v1235)
    ClientHelper.putFloatPrefs(v1234, ClientHelper.getFloatPrefs(v1234) + v1235)
end
GMHelper.copyShowGunFlameParam = function(v1236, v1237)
    local v1238 = ClientHelper.getFloatPrefs("GunFlameFrontOff" .. v1237)
    local v1239 = ClientHelper.getFloatPrefs("GunFlameRightOff" .. v1237)
    local v1240 = ClientHelper.getFloatPrefs("GunFlameDownOff" .. v1237)
    local v1241 = ClientHelper.getFloatPrefs("GunFlameScale" .. v1237)
    v1238 = math.floor(v1238 * 100) / 100
    v1239 = math.floor(v1239 * 100) / 100
    v1240 = math.floor(v1240 * 100) / 100
    v1241 = math.floor(v1241 * 100) / 100
    local v1242 = v1238 .. "#" .. v1239 .. "#" .. v1240 .. "#" .. v1241
    ClientHelper.onSetClipboard(v1242)
    UIHelper.showToast("拷贝成功")
end
GMHelper.testinValidEffect = function(v1243)
    local v1244 = "01_face_boy.mesh"
    local v1245 = VectorUtil.newVector3(100, 10, 100)
    WorldEffectManager.Instance():addSimpleEffect(v1244, v1245, 1, 1, 1, 1, 1)
    UIHelper.showToast("测试 非法 特效 完成")
end
GMHelper.outputItemLangFile = function(v1246)
    if not isClient then
        return
    end
    local v1247 = {}
    for v2303 = 1, 6000 do
        local v2304 = Item.getItemById(v2303)
        if v2304 then
            local v4580 = Lang:getItemName(v2303, 0)
            if (v4580 == "") then
                v4580 = v2304:getUnlocalizedName()
            end
            v1247[tostring(v2303)] = v4580
        end
    end
    local v1248 = io.open(GameType .. "_item_name.json", "w")
    v1248:write(json.encode(v1247))
    v1248:close()
end
GMHelper.MyLoveFly = function(v1249, v1250)
    A = not A
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.GUISkyblockTest1 = function(v1251)
    UIHelper.showGameGUILayout("GUIChristmas", 1)
    GUIGMControlPanel:hide()
end
GMHelper.GUISkyblockTest2 = function(v1252)
    UIHelper.showGameGUILayout("GUIGameTool")
    GUIGMControlPanel:hide()
end
GMHelper.GUISkyblockTest3 = function(v1253)
    UIHelper.showGameGUILayout("GUIRewardDetail", v1253.rewardId)
    GUIGMControlPanel:hide()
end
GMHelper.ViewBobbing = function(v1254)
    A = not A
    ClientHelper.putBoolPrefs("IsViewBobbing", false)
    if A then
        UIHelper.showToast("^FF0000ViewBobbing: OFF")
        return
    end
    ClientHelper.putBoolPrefs("IsViewBobbing", true)
    UIHelper.showToast("^00FF00ViewBobbing: ON")
end
GMHelper.BlockmanCollision = function(v1255)
    A = not A
    ClientHelper.putBoolPrefs("IsCreatureCollision", true)
    ClientHelper.putBoolPrefs("IsBlockmanCollision", true)
    if A then
        UIHelper.showToast("^00FF00BlockmanCollision: ON")
        return
    end
    ClientHelper.putBoolPrefs("IsBlockmanCollision", false)
    UIHelper.showToast("^FF0000BlockmanCollision: OFF")
    ClientHelper.putBoolPrefs("IsCreatureCollision", false)
end
GMHelper.RenderWorld = function(v1256)
    GMHelper:openInput(
        {""},
        function(v2305)
            ClientHelper.putIntPrefs("BlockRenderDistance", v2305)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.Fog = function(v1257)
    A = not A
    ClientHelper.putBoolPrefs("DisableFog", true)
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    ClientHelper.putBoolPrefs("DisableFog", false)
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.WWE_Camera = function(v1258)
    A = not A
    ClientHelper.putBoolPrefs("IsSeparateCamera", true)
    if A then
        UIHelper.showToast("^00FF00SeparateCamera: Enabled")
        return
    end
    ClientHelper.putBoolPrefs("IsSeparateCamera", false)
    UIHelper.showToast("^FF0000SeparateCamera: Disabled")
end
GMHelper.ResetXD = function(v1259)
    ClientHelper.putStringPrefs("RunSkillName", "run")
    GUIGMControlPanel:hide()
end
GMHelper.ActionSet = function(v1260)
    GMHelper:openInput(
        {""},
        function(v2306)
            ClientHelper.putStringPrefs("RunSkillName", v2306)
        end
    )
end
GMHelper.WalkSMG = function(v1261)
    ClientHelper.putStringPrefs("RunSkillName", "smg_walk")
    GUIGMControlPanel:hide()
end
GMHelper.SneakXD = function(v1262)
    ClientHelper.putStringPrefs("RunSkillName", "sneak")
    GUIGMControlPanel:hide()
end
GMHelper.SitXD = function(v1263)
    ClientHelper.putStringPrefs("RunSkillName", "sit1")
    GUIGMControlPanel:hide()
end
GMHelper.SitXD2 = function(v1264)
    ClientHelper.putStringPrefs("RunSkillName", "sit2")
    GUIGMControlPanel:hide()
end
GMHelper.SitXD3 = function(v1265)
    ClientHelper.putStringPrefs("RunSkillName", "sit3")
    GUIGMControlPanel:hide()
end
GMHelper.rideDragonXD = function(v1266)
    ClientHelper.putStringPrefs("RunSkillName", "ride_dragon")
    GUIGMControlPanel:hide()
end
GMHelper.SwimXD = function(v1267)
    ClientHelper.putStringPrefs("RunSkillName", "swim")
    GUIGMControlPanel:hide()
end
GMHelper.ArmSpeed = function(v1268)
    GMHelper:openInput(
        {""},
        function(v2307)
            ClientHelper.putIntPrefs("ArmSwingAnimationEnd", v2307)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.CameraFunct = function(v1269)
    GMHelper:openInput(
        {""},
        function(v2308)
            ClientHelper.putFloatPrefs("ThirdPersonDistance", v2308)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.CloudsOFF = function(v1270)
    ClientHelper.putBoolPrefs("DisableRenderClouds", true)
    UIHelper.showToast("^FF0000关闭")
    GUIGMControlPanel:hide()
end
GMHelper.BowSpeed = function(v1271)
    ClientHelper.putFloatPrefs("BowPullingSpeedMultiplier", 1000)
    ClientHelper.putFloatPrefs("BowPullingFOVMultiplier", 0)
    UIHelper.showToast("^00FF00开启")
    GUIGMControlPanel:hide()
end
GMHelper.HeadText = function(v1272)
    A = not A
    ClientHelper.putBoolPrefs("RenderHeadText", true)
    if A then
        UIHelper.showToast("^00FF00Head text render now ON")
        return
    end
    ClientHelper.putBoolPrefs("RenderHeadText", false)
    UIHelper.showToast("^FF0000Head text render now OFF")
end
GMHelper.changePlayerActor = function(v1273, v1274)
    if isGameStart then
        if (v1274 == 1) then
            ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
            ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
        else
            ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
            ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
        end
    elseif (v1274 == 1) then
        ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
        ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
    else
        ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
        ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
    end
    local v1275 = PlayerManager:getPlayers()
    for v2309, v2310 in pairs(v1275) do
        if v2310.Player then
            v2310.Player.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v2310)
        end
    end
    UIHelper.showToast("^00FF00成功")
    GUIGMControlPanel:hide()
end
GMHelper.BanClickCD = function(v1276, v1277)
    A = not A
    ClientHelper.putBoolPrefs("banClickCD", true)
    ClientHelper.putBoolPrefs("RemoveClickCD", true)
    ClientHelper.putIntPrefs("HurtProtectTime", 0)
    ClientHelper.putBoolPrefs("BanEntityHitCD", true)
    ClientHelper.putIntPrefs("ClickSceneCD", 0)
    PlayerManager:getClientPlayer().Player:setIntProperty("bedWarAttackCD", 0)
    if A then
        UIHelper.showToast("^00FF00CD 已开启")
        return
    end
    ClientHelper.putBoolPrefs("banClickCD", false)
    ClientHelper.putBoolPrefs("RemoveClickCD", false)
    ClientHelper.putIntPrefs("HurtProtectTime", 4)
    ClientHelper.putBoolPrefs("BanEntityHitCD", false)
    ClientHelper.putIntPrefs("ClickSceneCD", 4)
    PlayerManager:getClientPlayer().Player:setIntProperty("bedWarAttackCD", 4)
    UIHelper.showToast("^FF00000CD 已关闭")
end
GMHelper.Fly = function(v1278, v1279)
    A = not A
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    ClientHelper.putBoolPrefs("EnableFly", true)
    if A then
        UIHelper.showToast("^00FF0已开启")
        return
    end
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    ClientHelper.putBoolPrefs("EnableFly", true)
    UIHelper.showToast("^FF0000 已关闭")
end
GMHelper.ShowAllCobtrolXD = function(v1280)
    RootGuiLayout.Instance():showMainControl()
end
GMHelper.PersonView = function(v1281)
    GMHelper:openInput(
        {""},
        function(v2311)
            Blockman.Instance():setPersonView(v2311)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.BreakParticles = function(v1282)
    GMHelper:openInput(
        {""},
        function(v2312)
            ClientHelper.putIntPrefs("BlockDestroyEffectSize", v2312)
            UIHelper.showToast("^00FF00成功")
        end
    )
end
GMHelper.JailBreakBypass = function(v1283)
    RootGuiLayout.Instance():showMainControl()
    GUIGMControlPanel:hide()
end
GMHelper.SpeedLineMode = function(v1284)
    local v1285 = 1
    local v1286 = 0.01
    Blockman.Instance().m_gameSettings:setPatternSpeedLine(v1285, v1286)
    UIHelper.showToast("^00FF00Speed Line = Enable!")
    GUIGMControlPanel:hide()
end
GMHelper.SpeedLineModeDisable = function(v1287)
    local v1288 = 0
    local v1289 = 0
    Blockman.Instance().m_gameSettings:setPatternSpeedLine(v1288, v1289)
    UIHelper.showToast("^FF0000Speed Line = Disabled!")
    GUIGMControlPanel:hide()
end
GMHelper.PatternTorchMode = function(v1290)
    local v1291 = 1
    Blockman.Instance().m_gameSettings:setPatternTorchStrength(v1291)
    UIHelper.showToast("^00FF00PatternTorch = Enabled!")
    GUIGMControlPanel:hide()
end
GMHelper.PatternTorchModeOFF = function(v1292)
    local v1293 = 0
    Blockman.Instance().m_gameSettings:setPatternTorchStrength(v1293)
    UIHelper.showToast("^FF0000PatternTorch = Disabled!")
    GUIGMControlPanel:hide()
end
GMHelper.CameraFlipModeRESET = function(v1294)
    Blockman.Instance().m_gameSettings:setFovSetting(1)
    GUIGMControlPanel:hide()
end
GMHelper.CameraFlipModeON = function(v1295)
    Blockman.Instance().m_gameSettings:setFovSetting(90)
    GUIGMControlPanel:hide()
end
GMHelper.Iikj = function(v1296, v1297)
    local v1298 = v1297:getPosition()
    v1298.y = v1298.y + 0.5
    local v1300 = v1297:getYaw()
    v1297:teleportPosWithYaw(v1298, v1300)
    GUIGMControlPanel:hide()
end
GMHelper.GUItest1 = function(v1301)
    MsgSender.sendMsg("IikjLol")
    MsgSender.sendMsg("IikjLol")
    MsgSender.sendMsg("IikjLol")
    MsgSender.sendMsg(10004, "IikjLol")
    MsgSender.sendMsg(10003, "IikjLol")
    MsgSender.sendMsg(10002, "IikjLol")
    MsgSender.sendMsg(10001, "IikjLol")
    MsgSender.sendMsg(10000, "IikjLol")
    MsgSender.sendMsg(1, "IikjLol")
end
GMHelper.FlyDev = function(v1302)
    GUIManager:hideWindowByName("Main.binary")
    GUIManager:hideWindowByName("Main.json")
    GUIGMControlPanel:hide()
end
GMHelper.HideHP = function(v1303)
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(false)
end
GMHelper.ShowHP = function(v1304)
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
end
GMHelper.FlyDev2 = function(v1305)
    for v2313 = 1, 40000 do
        local v2314 = BlockManager.getBlockById(v2313)
        if v2314 then
            Blockman.Instance():setBloomEnable(true)
            Blockman.Instance():enableFullscreenBloom(true)
            Blockman.Instance():setBlockBloomOption(100)
            Blockman.Instance():setBloomIntensity(100)
            Blockman.Instance():setBloomSaturation(100)
            Blockman.Instance():setBloomThreshold(100)
            UIHelper.showToast("^00FF00Speed Break Block = 0")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.SetBobbing = function(v1306)
    GMHelper:openInput(
        {""},
        function(v2315)
            ClientHelper.putFloatPrefs("PlayerBobbingScale", v2315)
            UIHelper.showToast("^00FF00Changed")
        end
    )
end
GMHelper.test200 = function(v1307)
    MsgSender.sendMsg(Messages:gameResetTimeHint())
    GUIGMControlPanel:hide()
end
GMHelper.test600 = function(v1308)
    local v1309 = PlayerManager:getPlayers()
    for v2316, v2317 in pairs(v1309) do
        if v2317.Player then
            v2317.Player.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v2317)
        end
    end
    UIHelper.showToast("^00FF00yes")
    GUIGMControlPanel:hide()
end
GMHelper.JustClick = function(v1310)
    LuaTimer:scheduleTimer(
        function()
            local v2318 = VectorUtil.newVector3(0, 30, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2318)
        end,
        5,
        2e+35
    )
end
GMHelper.JustClick2 = function(v1311)
    LuaTimer:scheduleTimer(
        function()
            local v2319 = VectorUtil.newVector3(0, 300, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2319)
        end,
        5,
        2e+35
    )
end
GMHelper.OffChat = function(v1312)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
end
GMHelper.OnChat = function(v1313)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
    GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
end
GMHelper.Noclip = function(v1314)
    A = not A
    for v2320 = 1, 40000 do
        local v2321 = BlockManager.getBlockById(v2320)
        if v2321 then
            v2321:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2322 = 1, 40000 do
        local v2323 = BlockManager.getBlockById(v2322)
        if v2323 then
            v2323:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoclipOP = function(v1315)
    A = not A
    for v2324 = 3, 133 do
        local v2325 = BlockManager.getBlockById(v2324)
        if v2325 then
            v2325:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2326 = 3, 133 do
        local v2327 = BlockManager.getBlockById(v2326)
        if v2327 then
            v2327:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoObsidian1 = function(v1316)
    A = not A
    for v2328 = 49, 50 do
        local v2329 = BlockManager.getBlockById(v2328)
        if v2329 then
            v2329:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2330 = 49, 50 do
        local v2331 = BlockManager.getBlockById(v2330)
        if v2331 then
            v2331:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoOakPlanks1 = function(v1317)
    A = not A
    for v2332 = 5, 6 do
        local v2333 = BlockManager.getBlockById(v2332)
        if v2333 then
            v2333:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2334 = 5, 6 do
        local v2335 = BlockManager.getBlockById(v2334)
        if v2335 then
            v2335:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoGlass1 = function(v1318)
    A = not A
    for v2336 = 94, 95 do
        local v2337 = BlockManager.getBlockById(v2336)
        if v2337 then
            v2337:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2338 = 94, 95 do
        local v2339 = BlockManager.getBlockById(v2338)
        if v2339 then
            v2339:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoEndStone1 = function(v1319)
    A = not A
    for v2340 = 120, 121 do
        local v2341 = BlockManager.getBlockById(v2340)
        if v2341 then
            v2341:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2342 = 120, 121 do
        local v2343 = BlockManager.getBlockById(v2342)
        if v2343 then
            v2343:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoWool1 = function(v1320)
    A = not A
    for v2344 = 1441, 1444 do
        local v2345 = BlockManager.getBlockById(v2344)
        if v2345 then
            v2345:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2346 = 1441, 1444 do
        local v2347 = BlockManager.getBlockById(v2346)
        if v2347 then
            v2347:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoBomb1 = function(v1321)
    A = not A
    for v2348 = 593, 594 do
        local v2349 = BlockManager.getBlockById(v2348)
        if v2349 then
            v2349:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2350 = 593, 594 do
        local v2351 = BlockManager.getBlockById(v2350)
        if v2351 then
            v2351:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoIDoor1 = function(v1322)
    A = not A
    for v2352 = 241, 242 do
        local v2353 = BlockManager.getBlockById(v2352)
        if v2353 then
            v2353:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2354 = 241, 242 do
        local v2355 = BlockManager.getBlockById(v2354)
        if v2355 then
            v2355:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.NoQuartz1 = function(v1323)
    A = not A
    for v2356 = 155, 156 do
        local v2357 = BlockManager.getBlockById(v2356)
        if v2357 then
            v2357:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00开启")
        return
    end
    for v2358 = 155, 156 do
        local v2359 = BlockManager.getBlockById(v2358)
        if v2359 then
            v2359:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000关闭")
end
GMHelper.JumpHeight = function(v1324)
    GMHelper:openInput(
        {""},
        function(v2360)
            local v2361 = PlayerManager:getClientPlayer()
            if (v2361 and v2361.Player) then
                v2361.Player:setFloatProperty("JumpHeight", v2360)
                UIHelper.showToast("^00FF00成功")
            end
        end
    )
end
GMHelper.addCurrencyCustom = function(v1325, v1326)
    GMHelper:openInput(
        v1326,
        {"100"},
        function(v2362)
            v2362 = tonumber(v2362) or 0
            v1326:addCurrency(v2362, "GM")
        end
    )
end
GMHelper.GUIOpener = function(v1327)
    GMHelper:openInput(
        {".json"},
        function(v2363)
            GUIManager:showWindowByName(v2363)
        end
    )
end
GMHelper.GUIViewOFF = function(v1328)
    GMHelper:openInput(
        {".json"},
        function(v2364)
            GUIManager:hideWindowByName(v2364)
        end
    )
end
GMHelper.InsideGUI = function(v1329)
    GMHelper:openInput(
        {"", ""},
        function(v2365, v2366)
            GUIManager:getWindowByName(v2365):SetVisible(v2366)
        end
    )
end
GMHelper.ChangeNick = function(v1330)
    GMHelper:openInput(
        {""},
        function(v2367)
            PlayerManager:getClientPlayer().Player:setShowName(v2367)
            UIHelper.showToast("^FF00EE已更改")
        end
    )
end
GMHelper.LongJump = function(v1331)
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:setGlide(true)
        end,
        0.2,
        9e+23
    )
end
GMHelper.AdvancedUp = function(v1332)
    GMHelper:openInput(
        {""},
        function(v2368)
            local v2369 = VectorUtil.newVector3(0, v2368, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2369)
        end
    )
end
GMHelper.AdvancedIn = function(v1333)
    GMHelper:openInput(
        {""},
        function(v2370)
            local v2371 = VectorUtil.newVector3(v2370, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2371)
        end
    )
end
GMHelper.AdvancedOn = function(v1334)
    GMHelper:openInput(
        {""},
        function(v2372)
            local v2373 = VectorUtil.newVector3(0, 0, v2372)
            PlayerManager:getClientPlayer().Player:moveEntity(v2373)
        end
    )
end
GMHelper.AdvancedDirect = function(v1335)
    GMHelper:openInput(
        {"", "", ""},
        function(v2374, v2375, v2376)
            local v2377 = VectorUtil.newVector3(v2374, v2375, v2376)
            PlayerManager:getClientPlayer().Player:moveEntity(v2377)
        end
    )
end
GMHelper.tpPos = function(v1336)
    GMHelper:openInput(
        {"", "", ""},
        function(v2378, v2379, v2380)
            local v2381 = VectorUtil.newVector3(v2378, v2379, v2380)
            local v2382 = VectorUtil.newVector3(1, 10, 1)
            PlayerManager:getClientPlayer().Player:setPosition(v2381)
            PlayerManager:getClientPlayer().Player:moveEntity(v2382)
        end
    )
end
GMHelper.HideHoldItem = function(v1337)
    A = not A
    PlayerManager:getClientPlayer():setHideHoldItem(true)
    UIHelper.showToast("^FF00EETrue")
    if A then
        PlayerManager:getClientPlayer():setHideHoldItem(false)
        UIHelper.showToast("^FF00EEFalse")
    end
end
GMHelper.DevFlyI = function(v1338)
    local v1339 = VectorUtil.newVector3(0, 1.35, 0)
    local v1340 = PlayerManager:getClientPlayer()
    v1340.Player:setAllowFlying(true)
    v1340.Player:setFlying(true)
    v1340.Player:moveEntity(v1339)
    UIHelper.showToast("^FF00EE成功")
end
GMHelper.AntiFlyDetect = function(v1341)
    local v1342 = 1
    if (v1342 <= 99900) then
        LuaTimer:schedule(
            function()
                local v4584 = PlayerManager:getClientPlayer()
                local v4585 = VectorUtil.newVector3(0, -2, 0)
                local v4586 = PlayerManager:getClientPlayer():getPosition()
                local v4587 = VectorUtil.newVector3(v4586.x, v4586.y - 2, v4586.z)
                EngineWorld:setBlock(v4587, 159)
                v4584.Player:moveEntity(v4585)
                local v4588 = VectorUtil.newVector3(0, 1.35, 0)
                v4584.Player:setAllowFlying(true)
                v4584.Player:setFlying(true)
                v4584.Player:moveEntity(v4588)
                v1342 = v1342 + 1
                GMHelper:AntiFlyDetect()
            end,
            5000
        )
    end
end
GMHelper.OFFFLY = function(v1343)
    local v1344 = PlayerManager:getClientPlayer()
    local v1345 = VectorUtil.newVector3(0, -2, 0)
    v1344.Player:moveEntity(v1345)
end
GMHelper.SharpFly = function(v1346)
    A = not A
    ClientHelper.putBoolPrefs("DisableInertialFly", true)
    UIHelper.showToast("^00FF00开启")
    if A then
        ClientHelper.putBoolPrefs("DisableInertialFly", false)
        UIHelper.showToast("^FF0000关闭")
    end
end
GMHelper.WatchMode = function(v1347)
    A = not A
    local v1348 = VectorUtil.newVector3(0, 1.35, 0)
    PlayerManager:getClientPlayer().Player:setAllowFlying(true)
    PlayerManager:getClientPlayer().Player:setFlying(true)
    PlayerManager:getClientPlayer().Player:setWatchMode(true)
    PlayerManager:getClientPlayer().Player:moveEntity(v1348)
    UIHelper.showToast("^FF00EE开")
    if A then
        PlayerManager:getClientPlayer().Player:setAllowFlying(false)
        PlayerManager:getClientPlayer().Player:setFlying(false)
        PlayerManager:getClientPlayer().Player:setWatchMode(false)
        UIHelper.showToast("^FF00EE关")
    end
end
GMHelper.WaterPush = function(v1349)
    A = not A
    local v1350 = PlayerManager:getClientPlayer().Player
    v1350:setBoolProperty("ignoreWaterPush", true)
    UIHelper.showToast("^FF00EEON")
    if A then
        v1350:setBoolProperty("ignoreWaterPush", false)
        UIHelper.showToast("^FF00EEOFF")
    end
end
GMHelper.changeScale = function(v1351)
    GMHelper:openInput(
        {""},
        function(v2383)
            local v2384 = PlayerManager:getClientPlayer().Player
            v2384:setScale(v2383)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.BlockOFF = function(v1352)
    GMHelper:openInput(
        {""},
        function(v2385)
            local v2386 = v2385
            local v2387 = BlockManager.getBlockById(v2386)
            v2387:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    )
end
GMHelper.BlockON = function(v1353)
    GMHelper:openInput(
        {""},
        function(v2388)
            local v2389 = v2388
            local v2390 = BlockManager.getBlockById(v2389)
            v2390:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    )
end
GMHelper.SpeedManager = function(v1354)
    GMHelper:openInput(
        {""},
        function(v2391)
            PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(v2391)
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.SpeedUp = function(v1355)
    ClientHelper.putIntPrefs("SpeedAddMax", 20000000)
    UIHelper.showToast("^FF0000开启")
end
GMHelper.XRayManagerON = function(v1356)
    GMHelper:openInput(
        {"erase this text and write block id"},
        function(v2392)
            cBlockManager.cGetBlockById(v2392):setNeedRender(false)
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.XRayManagerOFF = function(v1357)
    GMHelper:openInput(
        {"erase this text and write block id"},
        function(v2393)
            cBlockManager.cGetBlockById(v2393):setNeedRender(true)
            UIHelper.showToast("^FF00EE关闭")
        end
    )
end
GMHelper.OFFDARK = function(v1358)
    cBlockManager.cGetBlockById(66):setNeedRender(false)
    cBlockManager.cGetBlockById(253):setNeedRender(false)
    for v2394 = 1, 40000 do
        local v2395 = BlockManager.getBlockById(v2394)
        if v2395 then
            v2395:setLightValue(150, 150, 150)
            UIHelper.showToast("^00FF00成功")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.SpawnNPC = function(v1359)
    GMHelper:openInput(
        {".actor"},
        function(v2396)
            local v2397 = PlayerManager:getClientPlayer():getPosition()
            local v2398 = PlayerManager:getClientPlayer():getYaw()
            EngineWorld:addActorNpc(
                v2397,
                v2398,
                v2396,
                function(v3813)
                end
            )
        end
    )
end
GMHelper.spawnCar = function(v1360)
    GMHelper:openInput(
        {"Car ID (erase this text and write carID)"},
        function(v2399)
            local v2400 = PlayerManager:getClientPlayer():getPosition()
            Blockman.Instance():getWorld():addVehicle(v2400, v2399, 5)
            UIHelper.showToast("^00FFEECar Spawn Success")
        end
    )
end
function TPplayerv1(v1361)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                player = PlayerManager:getClientPlayer().Player
                Dplayer = PlayerManager:getPlayerByUserId(v1361)
                if Dplayer then
                    for v5181 = 1, 999 do
                        UIDpos = Dplayer:getPosition()
                        PlayerPos = VectorUtil.newVector3(UIDpos.x, UIDpos.y + 3, UIDpos.z)
                        player:setPosition(PlayerPos)
                    end
                end
                TPplayerv1(v1361)
            end,
            10
        )
    end
end
GMHelper.SpawnBlockSwim = function(v1362)
    local v1363 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1364 = {"东", "南", "西", "北"}
    v1363 = v1363 % 360
    if (v1363 < 0) then
        v1363 = v1363 + 360
    end
    local v1365 = (math.floor((v1363 + 45) / 90) % 4) + 1
    local v1366 = PlayerManager:getClientPlayer():getPosition()
    GMHelper:openInput(
        {"填20,42,43,80都可以", "填8,9,10,11", "距离自己多远生成,推荐5", "距离自己多高生成,推荐0或者4"},
        function(v2401, v2402, v2403, v2404)
            local v2405 = PlayerManager:getClientPlayer():getPosition()
            if (v1365 == 1) then
                for v4874 = -12, 12, 1 do
                    for v5051 = 0, 56, 1 do
                        for v5182 = -4, 0, 1 do
                            local v5183 =
                                VectorUtil.newVector3(v2405.x + v4874, v2405.y + v5182 + v2404, v2405.z + v5051 + v2403)
                            EngineWorld:setBlock(v5183, v2401)
                        end
                    end
                end
                for v4875 = -9, 9, 1 do
                    for v5052 = 3, 53, 1 do
                        for v5184 = -3, 0, 1 do
                            local v5185 =
                                VectorUtil.newVector3(v2405.x + v4875, v2405.y + v5184 + v2404, v2405.z + v5052 + v2403)
                            EngineWorld:setBlock(v5185, v2402)
                        end
                    end
                end
            end
            if (v1365 == 2) then
                for v4876 = -12, 12, 1 do
                    for v5053 = -56, 0, 1 do
                        for v5186 = -4, 0, 1 do
                            local v5187 =
                                VectorUtil.newVector3(
                                (v2405.x + v5053) - v2403,
                                v2405.y + v5186 + v2404,
                                v2405.z + v4876
                            )
                            EngineWorld:setBlock(v5187, v2401)
                        end
                    end
                end
                for v4877 = -9, 9, 1 do
                    for v5054 = -53, -3, 1 do
                        for v5188 = -3, 0, 1 do
                            local v5189 =
                                VectorUtil.newVector3(
                                (v2405.x + v5054) - v2403,
                                v2405.y + v5188 + v2404,
                                v2405.z + v4877
                            )
                            EngineWorld:setBlock(v5189, v2402)
                        end
                    end
                end
            end
            if (v1365 == 3) then
                for v4878 = -12, 12, 1 do
                    for v5055 = -56, 0, 1 do
                        for v5190 = -4, 0, 1 do
                            local v5191 =
                                VectorUtil.newVector3(
                                v2405.x + v4878,
                                v2405.y + v5190 + v2404,
                                (v2405.z + v5055) - v2403
                            )
                            EngineWorld:setBlock(v5191, v2401)
                        end
                    end
                end
                for v4879 = -9, 9, 1 do
                    for v5056 = -53, -3, 1 do
                        for v5192 = -3, 0, 1 do
                            local v5193 =
                                VectorUtil.newVector3(
                                v2405.x + v4879,
                                v2405.y + v5192 + v2404,
                                (v2405.z + v5056) - v2403
                            )
                            EngineWorld:setBlock(v5193, v2402)
                        end
                    end
                end
            end
            if (v1365 == 4) then
                for v4880 = -12, 12, 1 do
                    for v5057 = 0, 56, 1 do
                        for v5194 = -4, 0, 1 do
                            local v5195 =
                                VectorUtil.newVector3(v2405.x + v5057 + v2403, v2405.y + v5194 + v2404, v2405.z + v4880)
                            EngineWorld:setBlock(v5195, v2401)
                        end
                    end
                end
                for v4881 = -9, 9, 1 do
                    for v5058 = 3, 53, 1 do
                        for v5196 = -3, 0, 1 do
                            local v5197 =
                                VectorUtil.newVector3(v2405.x + v5058 + v2403, v2405.y + v5196 + v2404, v2405.z + v4881)
                            EngineWorld:setBlock(v5197, v2402)
                        end
                    end
                end
            end
        end
    )
end
GMHelper.SpawnBlockTowordv2 = function(v1367)
    local v1368 = PlayerManager:getClientPlayer()
    if (v1368 == nil) then
        return
    end
    local v1369 = v1368.Player.rotationYaw
    local v1370 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
    v1369 = v1369 % 360
    if (v1369 < 0) then
        v1369 = v1369 + 360
    end
    local v1371 = (math.floor((v1369 + 22.5) / 45) % 8) + 1
    local v1372 = PlayerManager:getClientPlayer():getPosition()
    if (v1371 == 1) then
        for v4590 = -2, 2, 1 do
            for v4882 = 1, 100, 1 do
                local v4883 = VectorUtil.newVector3(v1372.x + v4590, v1372.y - 2, v1372.z + v4882)
                EngineWorld:setBlock(v4883, 159)
            end
        end
    elseif (v1371 == 2) then
        for v5059 = -2, 2, 1 do
            for v5198 = 1, 100, 1 do
                local v5199 = VectorUtil.newVector3((v1372.x + v5059) - v5198, v1372.y - 2, v1372.z + v5059 + v5198)
                EngineWorld:setBlock(v5199, 159)
            end
        end
    elseif (v1371 == 3) then
        for v5225 = -2, 2, 1 do
            for v5244 = 1, 100, 1 do
                local v5245 = VectorUtil.newVector3(v1372.x - v5244, v1372.y - 2, v1372.z + v5225)
                EngineWorld:setBlock(v5245, 159)
            end
        end
    elseif (v1371 == 4) then
        for v5250 = -2, 2, 1 do
            for v5257 = 1, 100, 1 do
                local v5258 = VectorUtil.newVector3(v1372.x - v5257, v1372.y - 2, (v1372.z + v5250) - v5257)
                EngineWorld:setBlock(v5258, 159)
            end
        end
    elseif (v1371 == 5) then
        for v5260 = -2, 2, 1 do
            for v5263 = 1, 100, 1 do
                local v5264 = VectorUtil.newVector3(v1372.x + v5260, v1372.y - 2, v1372.z - v5263)
                EngineWorld:setBlock(v5264, 159)
            end
        end
    elseif (v1371 == 6) then
        for v5266 = -2, 2, 1 do
            for v5269 = 1, 100, 1 do
                local v5270 = VectorUtil.newVector3(v1372.x + v5266 + v5269, v1372.y - 2, (v1372.z + v5266) - v5269)
                EngineWorld:setBlock(v5270, 159)
            end
        end
    elseif (v1371 == 7) then
        for v5272 = -2, 2, 1 do
            for v5275 = 1, 100, 1 do
                local v5276 = VectorUtil.newVector3(v1372.x + v5275, v1372.y - 2, v1372.z + v5272)
                EngineWorld:setBlock(v5276, 159)
            end
        end
    elseif (v1371 == 8) then
        for v5278 = -2, 2, 1 do
            for v5281 = 1, 100, 1 do
                local v5282 = VectorUtil.newVector3(v1372.x + v5281, v1372.y - 2, v1372.z + v5278 + v5281)
                EngineWorld:setBlock(v5282, 159)
            end
        end
    end
end
GMHelper.TPplayer = function(v1373)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2406)
            TPplayerv1(v2406)
        end
    )
end
GMHelper.TeleportByUID = function(v1374)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2407)
            local v2408 = PlayerManager:getClientPlayer().Player
            local v2409 = PlayerManager:getPlayerByUserId(v2407)
            local v2410 = v2409:getPosition()
            local v2411 = VectorUtil.newVector3(v2410.x, v2410.y + 3, v2410.z)
            if v2409 then
                v2408:setPosition(v2411)
            end
        end
    )
end
GMHelper.ChangeActorForMe = function(v1375)
    local v1376 = PlayerManager:getClientPlayer().Player
    GMHelper:openInput(
        {".actor"},
        function(v2412)
            Blockman.Instance():getWorld():changePlayerActor(v1376, v2412)
            Blockman.Instance():getWorld():changePlayerActor(v1376, v2412)
            v1376.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v1376)
            UIHelper.showToast("^00FFEE成功")
        end
    )
end
GMHelper.AFKmode = function(v1377)
    A = not A
    PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1
    UIHelper.showToast("^FF00EEStart")
    if A then
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
        UIHelper.showToast("^FF00EEStop")
    end
end
GMHelper.DevnoClip = function(v1379)
    A = not A
    PlayerManager:getClientPlayer().Player.noClip = true
    UIHelper.showToast("^FF00EE成功")
    if A then
        PlayerManager:getClientPlayer().Player.noClip = false
        UIHelper.showToast("^FF00EE关闭")
    end
end
GMHelper.StepHeight = function(v1381)
    GMHelper:openInput(
        {"StepHeight Value"},
        function(v2414)
            PlayerManager:getClientPlayer().Player.stepHeight = v2414
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.TL = function(v1382)
    if (Off == 0) then
        LuaTimer:schedule(
            function()
                PlayerManager:getClientPlayer().Player.spYaw = true
                PlayerManager:getClientPlayer().Player.spYawRadian = 45
                TL1()
            end,
            50
        )
    end
end
function TL1()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 90
            TL2()
        end,
        50
    )
end
function TL2()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 135
            TL3()
        end,
        50
    )
end
function TL3()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 180
            TL4()
        end,
        50
    )
end
function TL4()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 225
            TL5()
        end,
        50
    )
end
function TL5()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 270
            TL6()
        end,
        50
    )
end
function TL6()
    LuaTimer:schedule(
        function()
            PlayerManager:getClientPlayer().Player.spYawRadian = 315
            GMHelper:TL()
        end,
        50
    )
end
GMHelper.SpYaw = function(v1383)
    A = not A
    PlayerManager:getClientPlayer().Player.spYaw = true
    UIHelper.showToast("^FF00EE开启")
    if A then
        PlayerManager:getClientPlayer().Player.spYaw = false
        UIHelper.showToast("^FF00EE关闭")
    end
end
GMHelper.SpYawSet = function(v1385)
    GMHelper:openInput(
        {""},
        function(v2422)
            PlayerManager:getClientPlayer().Player.spYawRadian = v2422
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.HairSet = function(v1386)
    GMHelper:openInput(
        {""},
        function(v2424)
            PlayerManager:getClientPlayer().Player.m_isEquipWing = true
            PlayerManager:getClientPlayer().Player.m_isClothesChange = true
            PlayerManager:getClientPlayer().Player.m_isClothesChanged = true
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.SetHideAndShowArmor = function(v1387)
    A = not A
    LogicSetting.Instance():setHideArmor(true)
    UIHelper.showToast("^FF00EE开启")
    if A then
        LogicSetting.Instance():setHideArmor(false)
        UIHelper.showToast("^FF00EE关闭")
    end
end
GMHelper.SettingLongjump = function(v1388)
    GMHelper:openInput(
        {"speedglide", "drop resistance"},
        function(v2428, v2429)
            local v2430 = PlayerManager:getClientPlayer().Player
            v2430.m_isGlide = true
            v2430.m_glideMoveAddition = v2428
            v2430.m_glideDropResistance = v2429
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.SetAlpha = function(v1389)
    GMHelper:openInput(
        {"Gui name", "alpha"},
        function(v2434, v2435)
            GUIManager:getWindowByName(v2434):SetAlpha(v2435)
            UIHelper.showToast("^FF00EE开启")
        end
    )
end
GMHelper.ChangeHair = function(v1390)
    GMHelper:openInput(
        {"number"},
        function(v2436)
            local v2437 = PlayerManager:getClientPlayer().Player
            v2437.m_outLooksChanged = true
            v2437.m_hairID = v2436
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeFace = function(v1391)
    GMHelper:openInput(
        {"number"},
        function(v2440)
            local v2441 = PlayerManager:getClientPlayer().Player
            v2441.m_outLooksChanged = true
            v2441.m_faceID = v2440
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeTops = function(v1392)
    GMHelper:openInput(
        {"number"},
        function(v2444)
            local v2445 = PlayerManager:getClientPlayer().Player
            v2445.m_outLooksChanged = true
            v2445.m_topsID = v2444
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangePants = function(v1393)
    GMHelper:openInput(
        {"number"},
        function(v2448)
            local v2449 = PlayerManager:getClientPlayer().Player
            v2449.m_outLooksChanged = true
            v2449.m_pantsID = v2448
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeShoes = function(v1394)
    GMHelper:openInput(
        {"number"},
        function(v2452)
            local v2453 = PlayerManager:getClientPlayer().Player
            v2453.m_outLooksChanged = true
            v2453.m_shoesID = v2452
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeGlasses = function(v1395)
    GMHelper:openInput(
        {"number"},
        function(v2456)
            local v2457 = PlayerManager:getClientPlayer().Player
            v2457.m_outLooksChanged = true
            v2457.m_glassesId = v2456
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeScarf = function(v1396)
    GMHelper:openInput(
        {"number"},
        function(v2460)
            local v2461 = PlayerManager:getClientPlayer().Player
            v2461.m_outLooksChanged = true
            v2461.m_scarfId = v2460
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeWing = function(v1397)
    GMHelper:openInput(
        {"number"},
        function(v2464)
            local v2465 = PlayerManager:getClientPlayer().Player
            v2465.m_outLooksChanged = true
            v2465.m_wingId = v2464
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ShowRegion = function(v1398)
    UIHelper.showToast("RegionID=" .. Game:getRegionId())
end
GMHelper.GameID = function(v1399)
    UIHelper.showToast("GameID=" .. CGame.Instance():getGameType())
end
GMHelper.LogInfo = function(v1400)
    local v1401 = HostApi.getClientInfo()
    ClientHelper.onSetClipboard(v1401)
    UIHelper.showToast("^FF00EESuccess")
end
GMHelper.GetID = function(v1402)
    local v1403 = PlayerManager:getPlayers()
    for v2468, v2469 in pairs(v1403) do
        MsgSender.sendMsg(
            "^FF0000玩家信息: " ..
                string.format(
                    "^FF0000玩家名字: %s {} ID: %s {} 性别: %s",
                    v2469:getName(),
                    v2469.userId,
                    v2469.Player:getSex()
                )
        )
    end
end
GMHelper.GetAllInfoT = function(v1404)
    local v1405 = PlayerManager:getPlayers()
    for v2470, v2471 in pairs(v1405) do
        MsgSender.sendMsg(
            "^FF0000INFO: " ..
                string.format(
                    "^00FF00UserName: %s {} ID: %s {} Gender: %s",
                    v2471:getName(),
                    v2471.userId,
                    v2471.Player:getSex()
                )
        )
    end
end
GMHelper.test2300 = function(v1406)
    GMHelper:openInput(
        {""},
        function(v2472)
            local v2473 = PlayerManager:getClientPlayer().Player
            v2473.length = v2472
            v2473.isCollidedHorizontally = true
            v2473.isCollidedVertically = true
            v2473.isCollided = true
        end
    )
end
GMHelper.test1222 = function(v1407)
    local v1408 = PlayerManager:getClientPlayer().Player
    v1408.m_canBuildBlockQuickly = true
    v1408.m_quicklyBuildBlock = true
    UIHelper.showToast("2:")
end
GMHelper.test2222 = function(v1411)
    local v1412 = PlayerManager:getClientPlayer().Player
    v1412.m_opacity = 0.2
    UIHelper.showToast("1:")
end
GMHelper.spawnCar = function(v1414)
    GMHelper:openInput(
        {"Car ID (erase this text and write carID)"},
        function(v2478)
            local v2479 = PlayerManager:getClientPlayer():getPosition()
            local v2480 = PlayerManager:getClientPlayer():getYaw()
            Blockman.Instance():getWorld():addVehicle(v2479, v2478, v2480)
            UIHelper.showToast("^FF00EECar Spawn Success")
        end
    )
end
GMHelper.SpawnItem = function(v1415)
    GMHelper:openInput(
        {"ID", "Count"},
        function(v2481, v2482)
            local v2483 = PlayerManager:getClientPlayer():getPosition()
            EngineWorld:addEntityItem(v2481, v2482, 0, 600, v2483, VectorUtil.ZERO)
        end
    )
end
GMHelper.SetBlockToAir = function(v1416)
    GMHelper:openInput(
        {"block Position X", "block Position Y", "block Position Z"},
        function(v2484, v2485, v2486)
            local v2487 = VectorUtil.newVector3(v2484, v2485, v2486)
            EngineWorld:setBlockToAir(v2487)
        end
    )
end
GMHelper.SpawnBlock = function(v1417)
    GMHelper:openInput(
        {""},
        function(v2488)
            local v2489 = PlayerManager:getClientPlayer():getPosition()
            EngineWorld:setBlock(v2489, v2488)
        end
    )
end
GMHelper.btSpawnBlock = function(v1418)
    GMHelper:openInput(
        {""},
        function(v2490)
            local v2491 = PlayerManager:getClientPlayer():getPosition()
            count = 1
            ceshi(v2491, v2490, count)
        end
    )
end
GMHelper.btSpawnBlockv2 = function(v1419)
    GMHelper:openInput(
        {"", ""},
        function(v2492, v2493)
            local v2494 = PlayerManager:getClientPlayer():getPosition()
            count = 1
            ceshiv2(v2494, v2492, v2493, count)
        end
    )
end
GMHelper.SpawnBlockLong = function(v1420)
    GMHelper:openInput(
        {"", ""},
        function(v2495, v2496)
            local v2497 = PlayerManager:getClientPlayer():getPosition()
            for v3817 = -1 * v2496, v2496, 1 do
                local v3818 = VectorUtil.newVector3(v2497.x + v3817, v2497.y - 2, v2497.z)
                EngineWorld:setBlock(v3818, v2495)
            end
            for v3819 = -1 * v2496, v2496, 1 do
                local v3820 = VectorUtil.newVector3(v2497.x, v2497.y - 2, v2497.z + v3819)
                EngineWorld:setBlock(v3820, v2495)
            end
        end
    )
end
GMHelper.SpawnBlockToword = function(v1421)
    GMHelper:openInput(
        {"", "", ""},
        function(v2498, v2499, v2500)
            local v2501 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2502 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
            v2501 = v2501 % 360
            if (v2501 < 0) then
                v2501 = v2501 + 360
            end
            local v2503 = (math.floor((v2501 + 22.5) / 45) % 8) + 1
            local v2504 = PlayerManager:getClientPlayer():getPosition()
            if (v2503 == 1) then
                for v4884 = -1 * v4884, v4884, 1 do
                    for v5060 = 1, v2499, 1 do
                        local v5061 = VectorUtil.newVector3(v2504.x + v4884, v2504.y - 2, v2504.z + v5060)
                        EngineWorld:setBlock(v5061, v2498)
                    end
                end
            end
            if (v2503 == 2) then
                for v4885 = -1 * v4885, v4885, 1 do
                    for v5062 = 1, v2499, 1 do
                        local v5063 =
                            VectorUtil.newVector3((v2504.x + v4885) - v5062, v2504.y - 2, v2504.z + v4885 + v5062)
                        EngineWorld:setBlock(v5063, v2498)
                    end
                end
            end
            if (v2503 == 3) then
                for v4886 = -1 * v4886, v4886, 1 do
                    for v5064 = 1, v2499, 1 do
                        local v5065 = VectorUtil.newVector3(v2504.x - v5064, v2504.y - 2, v2504.z + v4886)
                        EngineWorld:setBlock(v5065, v2498)
                    end
                end
            end
            if (v2503 == 4) then
                for v4887 = -1 * v4887, v4887, 1 do
                    for v5066 = 1, v2499, 1 do
                        local v5067 = VectorUtil.newVector3(v2504.x - v5066, v2504.y - 2, (v2504.z + v4887) - v5066)
                        EngineWorld:setBlock(v5067, v2498)
                    end
                end
            end
            if (v2503 == 5) then
                for v4888 = -1 * v4888, v4888, 1 do
                    for v5068 = 1, v2499, 1 do
                        local v5069 = VectorUtil.newVector3(v2504.x + v4888, v2504.y - 2, v2504.z - v5068)
                        EngineWorld:setBlock(v5069, v2498)
                    end
                end
            end
            if (v2503 == 6) then
                for v4889 = -1 * v4889, v4889, 1 do
                    for v5070 = 1, v2499, 1 do
                        local v5071 =
                            VectorUtil.newVector3(v2504.x + v4889 + v5070, v2504.y - 2, (v2504.z + v4889) - v5070)
                        EngineWorld:setBlock(v5071, v2498)
                    end
                end
            end
            if (v2503 == 7) then
                for v4890 = -1 * v4890, v4890, 1 do
                    for v5072 = 1, v2499, 1 do
                        local v5073 = VectorUtil.newVector3(v2504.x + v5072, v2504.y - 2, v2504.z + v4890)
                        EngineWorld:setBlock(v5073, v2498)
                    end
                end
            end
            if (v2503 == 8) then
                for v4891 = -1 * v4891, v4891, 1 do
                    for v5074 = 1, v2499, 1 do
                        local v5075 = VectorUtil.newVector3(v2504.x + v5074, v2504.y - 2, v2504.z + v4891 + v5074)
                        EngineWorld:setBlock(v5075, v2498)
                    end
                end
            end
        end
    )
end
GMHelper.SpawnBlockTowordv1 = function(v1422)
    local v1423 = PlayerManager:getClientPlayer().Player.rotationYaw
    local v1424 = {"东", "东南", "南", "西南", "西", "西北", "北", "东北"}
    v1423 = v1423 % 360
    if (v1423 < 0) then
        v1423 = v1423 + 360
    end
    local v1425 = (math.floor((v1423 + 22.5) / 45) % 8) + 1
    local v1426 = PlayerManager:getClientPlayer():getPosition()
    if (v1425 == 1) then
        for v4593 = 1, 100, 1 do
            local v4594 = VectorUtil.newVector3(v1426.x, v1426.y - 2, v1426.z + v4593)
            EngineWorld:setBlock(v4594, 159)
        end
    end
    if (v1425 == 2) then
        for v4595 = 1, 100, 1 do
            local v4596 = VectorUtil.newVector3(v1426.x - v4595, v1426.y - 2, v1426.z + v4595)
            EngineWorld:setBlock(v4596, 159)
        end
    end
    if (v1425 == 3) then
        for v4597 = 1, 100, 1 do
            local v4598 = VectorUtil.newVector3(v1426.x - v4597, v1426.y - 2, v1426.z)
            EngineWorld:setBlock(v4598, 159)
        end
    end
    if (v1425 == 4) then
        for v4599 = 1, 100, 1 do
            local v4600 = VectorUtil.newVector3(v1426.x - v4599, v1426.y - 2, v1426.z - v4599)
            EngineWorld:setBlock(v4600, 159)
        end
    end
    if (v1425 == 5) then
        for v4601 = 1, 100, 1 do
            local v4602 = VectorUtil.newVector3(v1426.x, v1426.y - 2, v1426.z - v4601)
            EngineWorld:setBlock(v4602, 159)
        end
    end
    if (v1425 == 6) then
        for v4603 = 1, 100, 1 do
            local v4604 = VectorUtil.newVector3(v1426.x + v4603, v1426.y - 2, v1426.z - v4603)
            EngineWorld:setBlock(v4604, 159)
        end
    end
    if (v1425 == 7) then
        for v4605 = 1, 100, 1 do
            local v4606 = VectorUtil.newVector3(v1426.x + v4605, v1426.y - 2, v1426.z)
            EngineWorld:setBlock(v4606, 159)
        end
    end
    if (v1425 == 8) then
        for v4607 = 1, 100, 1 do
            local v4608 = VectorUtil.newVector3(v1426.x + v4607, v1426.y - 2, v1426.z + v4607)
            EngineWorld:setBlock(v4608, 159)
        end
    end
end
GMHelper.SpawnBlockSize = function(v1427)
    GMHelper:openInput(
        {"", ""},
        function(v2505, v2506)
            local v2507 = PlayerManager:getClientPlayer():getPosition()
            for v3821 = -1 * v2506, v2506, 1 do
                for v4609 = -1 * v2506, v2506, 1 do
                    local v4610 = VectorUtil.newVector3(v2507.x + v3821, v2507.y - 2, v2507.z + v4609)
                    EngineWorld:setBlock(v4610, v2505)
                end
            end
        end
    )
end
GMHelper.pingtai = function(v1428)
    local v1429 = PlayerManager:getClientPlayer():getPosition()
    for v2508 = -1, 1, 1 do
        for v3822 = -1, 1, 1 do
            local v3823 = VectorUtil.newVector3(v1429.x + v2508, v1429.y - 5, v1429.z + v3822)
            EngineWorld:setBlock(v3823, 159)
        end
    end
end
GMHelper.SpawnBlockfillSize = function(v1430)
    GMHelper:openInput(
        {"", "", "", "", "", "", ""},
        function(v2509, v2510, v2511, v2512, v2513, v2514, v2515)
            local v2516 = PlayerManager:getClientPlayer():getPosition()
            for v3824 = v2509, v2512, 1 do
                for v4611 = v2511, v2514, 1 do
                    for v4892 = v2510, v2513, 1 do
                        local v4893 = VectorUtil.newVector3(v2516.x + v3824, v2516.y + v4892, v2516.z + v4611)
                        EngineWorld:setBlock(v4893, v2515)
                    end
                end
            end
        end
    )
end
GMHelper.CloneBlocksMove = function(v1431)
    GMHelper:openInput(
        {"", "", "", "", "", "", "", "", ""},
        function(v2517, v2518, v2519, v2520, v2521, v2522, v2523, v2524, v2525)
            local v2526, v2527, v2528
            if (v2520 >= v2517) then
                v2526 = 1
            else
                v2526 = -1
            end
            if (v2521 >= v2518) then
                v2527 = 1
            else
                v2527 = -1
            end
            if (v2522 >= v2519) then
                v2528 = 1
            else
                v2528 = -1
            end
            local v2529 = PlayerManager:getClientPlayer():getPosition()
            LX = v2517
            LZ = v2519
            for v3825 = v2517, v2520, v2526 do
                for v4612 = v2519, v2522, v2528 do
                    for v4894 = v2518, v2521, v2527 do
                        local v4895 = VectorUtil.newVector3(v2529.x + v3825, v2529.y + v4894, v2529.z + v4612)
                        blockId = EngineWorld:getBlockId(v4895)
                        blockMeta = EngineWorld:getBlockMeta(v4895)
                        BlockPos =
                            VectorUtil.newVector3(
                            v2529.x + v3825 + v2523,
                            v2529.y + v4894 + v2524,
                            v2529.z + v4612 + v2525
                        )
                        table.insert(
                            blocksM,
                            {bx = BlockPos.x, by = BlockPos.y, bz = BlockPos.z, bid = blockId, bmeta = blockMeta}
                        )
                    end
                end
            end
        end
    )
end
GMHelper.CloneBlocks = function(v1432)
    GMHelper:openInput(
        {"", "", "", "", "", "", "", "", ""},
        function(v2530, v2531, v2532, v2533, v2534, v2535, v2536, v2537, v2538)
            local v2539, v2540, v2541
            if (v2533 >= v2530) then
                v2539 = 1
            else
                v2539 = -1
            end
            if (v2534 >= v2531) then
                v2540 = 1
            else
                v2540 = -1
            end
            if (v2535 >= v2532) then
                v2541 = 1
            else
                v2541 = -1
            end
            local v2542 = PlayerManager:getClientPlayer():getPosition()
            for v3826 = v2530, v2533, v2539 do
                for v4613 = v2532, v2535, v2541 do
                    for v4896 = v2531, v2534, v2540 do
                        local v4897 = VectorUtil.newVector3(v2542.x + v3826, v2542.y + v4896, v2542.z + v4613)
                        blockId = EngineWorld:getBlockId(v4897)
                        blockMeta = EngineWorld:getBlockMeta(v4897)
                        BlockPos =
                            VectorUtil.newVector3(
                            v2542.x + v3826 + v2536,
                            v2542.y + v4896 + v2537,
                            v2542.z + v4613 + v2538
                        )
                        table.insert(
                            blocks,
                            {bx = BlockPos.x, by = BlockPos.y, bz = BlockPos.z, bid = blockId, bmeta = blockMeta}
                        )
                    end
                end
            end
        end
    )
end
GMHelper.AddBlocks = function(v1433)
    for v2543, v2544 in ipairs(blocks) do
        local v2545 = VectorUtil.newVector3(v2544.bx, v2544.by, v2544.bz)
        EngineWorld:setBlock(v2545, v2544.bid, v2544.bmeta)
    end
end
GMHelper.AddBlocksMove = function(v1434)
    for v2546, v2547 in ipairs(blocksM) do
        v1434 = PlayerManager:getClientPlayer():getPosition()
        LXL = LX + v2546
        LZL = LZ + v2546
        BX = v1434.x - v2547.bx
        BY = v1434.y - v2547.by
        BZ = v1434.z - v2547.bz
        fbx = BX + v2547.bx + LXL
        fbz = BZ + v2547.bz + LZL
        MsgSender.sendMsg("放置坐标x: " .. fbx .. "放置z  " .. fbz .. "计数: " .. v2546)
        BLOCKPos = VectorUtil.newVector3(fbx, v2547.by, fbz)
        EngineWorld:setBlock(BLOCKPos, v2547.bid, v2547.bmeta)
    end
end
GMHelper.SpawnBlockClone = function(v1435)
    GMHelper:openInput(
        {"", "", "", "", "", "", "", "", ""},
        function(v2548, v2549, v2550, v2551, v2552, v2553, v2554, v2555, v2556)
            local v2557, v2558, v2559
            if (v2551 >= v2548) then
                v2557 = 1
            else
                v2557 = -1
            end
            if (v2552 >= v2549) then
                v2558 = 1
            else
                v2558 = -1
            end
            if (v2553 >= v2550) then
                v2559 = 1
            else
                v2559 = -1
            end
            local v2560 = PlayerManager:getClientPlayer():getPosition()
            for v3827 = v2548, v2551, v2557 do
                for v4614 = v2550, v2553, v2559 do
                    for v4898 = v2549, v2552, v2558 do
                        local v4899 = VectorUtil.newVector3(v2560.x + v3827, v2560.y + v4898, v2560.z + v4614)
                        local v4900 = EngineWorld:getBlockId(v4899)
                        local v4901 = EngineWorld:getBlockMeta(v4899)
                        local v4902 =
                            VectorUtil.newVector3(
                            v2560.x + v3827 + v2554,
                            v2560.y + v4898 + v2555,
                            v2560.z + v4614 + v2556
                        )
                        EngineWorld:setBlock(v4902, v4900, v4901)
                    end
                end
            end
        end
    )
end
GMHelper.SpawnBlockNoclip = function(v1436)
    local v1437 = PlayerManager:getClientPlayer():getPosition()
    for v2561 = -1, 1, 1 do
        for v3828 = -1, 1, 1 do
            local v3829 = VectorUtil.newVector3(v1437.x + v2561, v1437.y - 2, v1437.z + v3828)
            EngineWorld:setBlock(v3829, 0)
        end
    end
    ceshiv4()
end
function ceshiv4()
    local v1438 = PlayerManager:getClientPlayer():getPosition()
    if (OFF <= 9999) then
        LuaTimer:schedule(
            function()
                for v4903 = -2, 2, 1 do
                    for v5076 = -2, 2, 1 do
                        for v5200 = -1, 0, 1 do
                            local v5201 = VectorUtil.newVector3(v1438.x + v4903, v1438.y + v5200, v1438.z + v5076)
                            EngineWorld:setBlock(v5201, 0)
                        end
                    end
                end
                ceshiv4()
            end,
            10
        )
    end
end
GMHelper.SpawnBlockOFF = function(v1439)
    OFF = 10000
    UIHelper.showToast("^00FF00连锁搭路已被禁用")
end
GMHelper.SpawnBlockON = function(v1440)
    OFF = 0
    UIHelper.showToast("^FF0000连锁搭路已启用")
end
GMHelper.SpawnBlocktimeSize = function(v1441)
    local v1442 = PlayerManager:getClientPlayer():getPosition()
    if (OFF <= 9999) then
        LuaTimer:schedule(
            function()
                for v4904 = -2, 2, 1 do
                    for v5077 = -2, 2, 1 do
                        local v5078 = VectorUtil.newVector3(v1442.x + v4904, v1442.y - 2, v1442.z + v5077)
                        EngineWorld:setBlock(v5078, 0)
                    end
                end
                for v4905 = -1, 1, 1 do
                    for v5079 = -1, 1, 1 do
                        local v5080 = VectorUtil.newVector3(v1442.x + v4905, v1442.y - 2, v1442.z + v5079)
                        EngineWorld:setBlock(v5080, 159)
                    end
                end
                GMHelper:SpawnBlocktimeSize()
            end,
            10
        )
    end
end
GMHelper.SpawnBlocktimeSize1 = function(v1443)
    GMHelper:openInput(
        {"", ""},
        function(v2562, v2563)
            local v2564 = PlayerManager:getClientPlayer():getPosition()
            count = 1
            ceshiv3(v2564, v2562, v2563, count)
        end
    )
end
function ceshiv3()
    if (count <= 99900) then
        LuaTimer:schedule(
            function()
                local v4615 = PlayerManager:getClientPlayer():getPosition()
                for v4906 = -1 * Size, Size, 1 do
                    for v5081 = -1 * Size, Size, 1 do
                        local v5082 = VectorUtil.newVector3(v4615.x + v4906, v4615.y - 2, v4615.z + v5081)
                        EngineWorld:setBlock(v5082, martin)
                    end
                end
                count = count + 1
                ceshiv3(v4615, martin, Size, count)
            end,
            10
        )
    end
end
function ceshi(v1444, v1445, v1446)
    if ((v1446 <= 9999) and (OFF == 0)) then
        LuaTimer:schedule(
            function()
                local v4616 = PlayerManager:getClientPlayer():getPosition()
                local v4617 = VectorUtil.newVector3(v4616.x + 1, v4616.y - 2, v4616.z)
                local v4618 = VectorUtil.newVector3(v4616.x - 1, v4616.y - 2, v4616.z)
                local v4619 = VectorUtil.newVector3(v4616.x, v4616.y - 2, v4616.z + 1)
                local v4620 = VectorUtil.newVector3(v4616.x, v4616.y - 2, v4616.z - 1)
                local v4621 = VectorUtil.newVector3(v4616.x, v4616.y - 2, v4616.z)
                EngineWorld:setBlock(v4621, v1445)
                EngineWorld:setBlock(v4617, v1445)
                EngineWorld:setBlock(v4618, v1445)
                EngineWorld:setBlock(v4619, v1445)
                EngineWorld:setBlock(v4620, v1445)
                v1446 = v1446 + 1
                Count = 9999 - v1446
                UIHelper.showToast("剩余次数:" .. Count)
                ceshi(v4616, v1445, v1446)
            end,
            10
        )
    end
end
function ceshiv2(v1447, v1448, v1449, v1450)
    if ((v1450 <= 99900) and (OFF == 0)) then
        LuaTimer:schedule(
            function()
                local v4622 = PlayerManager:getClientPlayer():getPosition()
                for v4907 = -1 * v1449, v1449, 1 do
                    for v5083 = -1 * v1449, v1449, 1 do
                        local v5084 = VectorUtil.newVector3(v4622.x + v4907, v4622.y - 2, v4622.z + v5083)
                        EngineWorld:setBlock(v5084, v1448)
                    end
                end
                v1450 = v1450 + 1
                Count = 99900 - v1450
                UIHelper.showToast("剩余次数:" .. Count)
                ceshiv2(v4622, v1448, v1449, v1450)
            end,
            10
        )
    end
end
GMHelper.NaiJiu = function(v1451)
    A = not A
    ClientHelper.putBoolPrefs("IsShowItemDurability", true)
    if A then
        UIHelper.showToast("^00FF00已开启")
        return
    end
    ClientHelper.putBoolPrefs("IsShowItemDurability", true)
    UIHelper.showToast("^FF0000已关闭")
end
GMHelper.BlockLimit = function(v1452)
    A = not A
    ClientHelper.putIntPrefs("InventoryStackLimit", 99999)
    if A then
        UIHelper.showToast("^00FF00已开启")
        return
    end
    ClientHelper.putIntPrefs("InventoryStackLimit", 64)
    UIHelper.showToast("^FF0000已关闭")
end
GMHelper.bwbtn = function(v1453)
    A = not A
    ClientHelper.putBoolPrefs("showBedWarAttackBtn", true)
    if A then
        UIHelper.showToast("^00FF00已开启")
        return
    end
    ClientHelper.putBoolPrefs("showBedWarAttackBtn", false)
    UIHelper.showToast("^FF0000已关闭")
end
GMHelper.checkLuaMemoryBegin = function(v1454)
    local v1455 = require("engine_base.debug.MemoryReferenceInfo")
    v1455.m_cConfig.m_bAllMemoryRefFileAddTime = false
    local v1457 = "mem_check_begin"
    collectgarbage("collect")
    v1455.m_cMethods.DumpMemorySnapshot("./", v1457, -1)
end
GMHelper.checkLuaMemoryEnd = function(v1458)
    local v1459 = require("engine_base.debug.MemoryReferenceInfo")
    v1459.m_cConfig.m_bAllMemoryRefFileAddTime = false
    local v1461 = "mem_check_end"
    v1459.m_cMethods.DumpMemorySnapshot("./", v1461, -1)
    v1459.m_cMethods.DumpMemorySnapshotComparedFile(
        "./",
        "Compared",
        -1,
        string.format("./LuaMemRefInfo-All-[%s].txt", "mem_check_begin"),
        string.format("./LuaMemRefInfo-All-[%s].txt", "mem_check_end")
    )
end
GMHelper.outputAppDress = function(v1462)
    GMHelper:openInput(
        {"uid"},
        function(v2565)
            print(v2565)
            WebService.GetPlayerDecoration(
                tonumber(v2565) or 0,
                function(v3830)
                    LogUtil.logInfo("---------------------------------------userId:" .. v2565)
                    LogUtil.pv(v3830)
                end
            )
        end
    )
end
GMHelper.CSv1 = function(v1463)
    local v1464 = VectorUtil.newVector3(0, 1.35, 0)
    local v1465 = PlayerManager:getClientPlayer()
    v1465.Player:setPosition(ClientPosv1)
end
GMHelper.JLv1 = function(v1466)
    ClientPosv1 = PlayerManager:getClientPlayer():getPosition()
    local v1467 = VectorUtil.newVector3(ClientPosv1.x, ClientPosv1.y, ClientPosv1.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv1.x .. " " .. ClientPosv1.y .. " " .. ClientPosv1.z .. " ")
end
GMHelper.CSv2 = function(v1468)
    local v1469 = VectorUtil.newVector3(0, 1.35, 0)
    local v1470 = PlayerManager:getClientPlayer()
    v1470.Player:setPosition(ClientPosv2)
end
GMHelper.JLv2 = function(v1471)
    ClientPosv2 = PlayerManager:getClientPlayer():getPosition()
    local v1472 = VectorUtil.newVector3(ClientPosv2.x, ClientPosv2.y, ClientPosv2.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv2.x .. " " .. ClientPosv2.y .. " " .. ClientPosv2.z .. " ")
end
GMHelper.CSv3 = function(v1473)
    local v1474 = VectorUtil.newVector3(0, 1.35, 0)
    local v1475 = PlayerManager:getClientPlayer()
    v1475.Player:setPosition(ClientPosv3)
end
GMHelper.JLv3 = function(v1476)
    ClientPosv3 = PlayerManager:getClientPlayer():getPosition()
    local v1477 = VectorUtil.newVector3(ClientPosv3.x, ClientPosv3.y, ClientPosv3.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv3.x .. " " .. ClientPosv3.y .. " " .. ClientPosv3.z .. " ")
end
GMHelper.CSv4 = function(v1478)
    local v1479 = VectorUtil.newVector3(0, 1.35, 0)
    local v1480 = PlayerManager:getClientPlayer()
    v1480.Player:setPosition(ClientPosv4)
end
GMHelper.JLv4 = function(v1481)
    ClientPosv4 = PlayerManager:getClientPlayer():getPosition()
    local v1482 = VectorUtil.newVector3(ClientPosv4.x, ClientPosv4.y, ClientPosv4.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv4.x .. " " .. ClientPosv4.y .. " " .. ClientPosv4.z .. " ")
end
GMHelper.CSv5 = function(v1483)
    local v1484 = VectorUtil.newVector3(0, 1.35, 0)
    local v1485 = PlayerManager:getClientPlayer()
    v1485.Player:setPosition(ClientPosv5)
end
GMHelper.JLv5 = function(v1486)
    ClientPosv5 = PlayerManager:getClientPlayer():getPosition()
    local v1487 = VectorUtil.newVector3(ClientPosv5.x, ClientPosv5.y, ClientPosv5.z)
    UIHelper.showToast("^00FF00存档位置: " .. ClientPosv5.x .. " " .. ClientPosv5.y .. " " .. ClientPosv5.z .. " ")
end
GMHelper.Rvanka = function(v1488)
    LuaTimer:scheduleTimer(
        function()
            local v2566 = PlayerManager:getClientPlayer().Player
            local v2567 = PlayerManager:getPlayers()
            for v3831, v3832 in pairs(v3832) do
                MathUtil:distanceSquare2d(v3832:getPosition(), v2566:getPosition())
                if (v3832 ~= v2566) then
                    LuaTimer:scheduleTimer(
                        function()
                            local v5085 =
                                VectorUtil.newVector3(
                                v3832:getPosition().x,
                                v3832:getPosition().y + (tonumber(tostring(787 - 777), 2)),
                                v3832:getPosition().z
                            )
                            v2566:setPosition(v5085)
                        end,
                        (tonumber(tostring(1787 - 777), 2)),
                        (tonumber(tostring(1111101777 - 777), 2))
                    )
                end
            end
        end,
        (tonumber(tostring(1111101778 - 777), 2)),
        -(tonumber(tostring(778 - 777), 2))
    )
end
GMHelper.Tracer = function(v1489)
    local v1490 = PlayerManager:getClientPlayer()
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
            local v2568 = PlayerManager:getPlayers()
            for v3833, v3834 in pairs(v2568) do
                if (v3834 ~= v1490) then
                    PlayerManager:getClientPlayer().Player:addGuideArrow(v3834:getPosition())
                end
            end
        end,
        (tonumber(tostring(111110877 - 777), 2)),
        -(tonumber(tostring(778 - 777), 2))
    )
end
GMHelper.Tracer2 = function(v1491)
    local v1492 = PlayerManager:getClientPlayer()
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
            local v2569 = PlayerManager:getClientPlayer().Player.rotationYaw
            local v2570 = math.rad(v2569)
            local v2571 = math.sin(v2570)
            local v2572 = math.cos(v2570)
            local v2573 = PlayerManager:getPlayers()
            local v2574 = v1492:getPosition()
            Quay = VectorUtil.newVector3((-50 * v2571) + v2574.x, v2574.y, (50 * v2572) + v2574.z)
            Que = VectorUtil.newVector3((-50 * v2571) + v2574.x, v2574.y - 2, (50 * v2572) + v2574.z)
            blockId = EngineWorld:getBlockId(Que)
            for v3835, v3836 in pairs(v2573) do
                if (v3836 ~= v1492) then
                    PlayerManager:getClientPlayer().Player:addGuideArrow(v3836:getPosition())
                end
            end
        end,
        50,
        99999999
    )
end
GMHelper.Scaffold = function(v1493)
    A = not A
    LuaTimer:cancel(v1493.timer)
    UIHelper.showToast("^00FF00Scaffold TurnOFF")
    if A then
        GMHelper:openInput(
            {"BlockID"},
            function(v4623)
                v1493.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4908 = PlayerManager:getClientPlayer():getPosition()
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x, v4908.y - 2, v4908.z), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x - 1, v4908.y - 2, v4908.z - 1), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x + 1, v4908.y - 2, v4908.z + 1), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x, v4908.y - 2, v4908.z + 1), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x, v4908.y - 2, v4908.z - 1), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x + 1, v4908.y - 2, v4908.z), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x - 1, v4908.y - 2, v4908.z), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x - 1, v4908.y - 2, v4908.z + 1), v4623)
                        EngineWorld:setBlock(VectorUtil.newVector3(v4908.x + 1, v4908.y - 2, v4908.z - 1), v4623)
                    end,
                    0.15,
                    -1
                )
                UIHelper.showToast("^00FF00Scaffold TurnON")
            end
        )
    end
end
GMHelper.ReachSet = function(v1494)
    GMHelper:openInput(
        {"默认5"},
        function(v2575)
            ClientHelper.putFloatPrefs("EntityReachDistance", v2575)
            UIHelper.showToast("修改成功")
        end
    )
end
GMHelper.Reach = function(v1495)
    A = not A
    ClientHelper.putFloatPrefs("BlockReachDistance", 1000000)
    ClientHelper.putFloatPrefs("EntityReachDistance", 1000)
    if A then
        UIHelper.showToast("^00FF00长臂猿 开启")
        return
    end
    ClientHelper.putFloatPrefs("BlockReachDistance", 10)
    ClientHelper.putFloatPrefs("EntityReachDistance", 10)
    UIHelper.showToast("^FF0000长臂猿 关闭")
end
GMHelper.FustBreakBlockMode = function(v1496)
    cBlockManager.cGetBlockById(66):setNeedRender(false)
    cBlockManager.cGetBlockById(253):setNeedRender(false)
    for v2576 = 1, 40000 do
        local v2577 = BlockManager.getBlockById(v2576)
        if v2577 then
            v2577:setHardness(0)
            UIHelper.showToast("^00FF00开启")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.SpamRespawn = function(v1497)
    GMHelper:openInput(
        {""},
        function(v2578)
            for v3837 = 1, v2578 do
                PacketSender:getSender():sendRebirth()
            end
        end
    )
end
GMHelper.Fuhuo = function(v1498)
    LuaTimer:schedule(
        function()
            PacketSender:getSender():sendRebirth()
            GMHelper:Fuhuo()
        end,
        10
    )
end
GMHelper.BlockReachSet = function(v1499)
    GMHelper:openInput(
        {"默认6.5"},
        function(v2579)
            ClientHelper.putFloatPrefs("BlockReachDistance", v2579)
            UIHelper.showToast("修改成功")
        end
    )
end
GMHelper.TestHack = function(v1500)
    GUIManager:showWindowByName("PlayerInventory-MainInventoryTab")
    GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetVisible(true)
    GUIGMControlPanel:hide()
end
GMHelper.SetMaxFPS = function(v1501)
    GMHelper:openInput(
        {""},
        function(v2580)
            CGame.Instance():SetMaxFps(v2580)
        end
    )
end
GMHelper.FlyDev2 = function(v1502)
    GUIManager:showWindowByName("PlayerInventory-DesignationTab")
    GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetVisible(true)
    GUIManager:showWindowByName("PlayerInventory-MainInventoryTab")
    GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetVisible(true)
    GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetArea({1, 1}, {1, 0}, {0, 1}, {0, 1})
    GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetArea({0, 0}, {0, 0}, {0.3, 0}, {0.3, 0})
    GUIManager:getWindowByName("PlayerInventory-ToggleInventoryButton"):SetVisible(true)
    GUIManager:showWindowByName("PlayerInventory-ToggleInventoryButton")
    GUIGMControlPanel:hide()
end
GMHelper.Freecam = function(v1503)
    GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible(true)
    GUIGMControlPanel:hide()
end
GMHelper.Cry01 = function(v1504)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2581)
            local v2582 = T(Global, "PidPacketSender")
            v2582:tryRequestTrade(tonumber(v2581))
        end
    )
end
GMHelper.Cry02 = function(v1505)
    GMHelper:openInput(
        {"玩家ID"},
        function(v2583)
            LuaTimer:schedule(
                function()
                    local v3838 = T(Global, "PidPacketSender")
                    v3838:tryRequestTrade(tonumber(v2583))
                end
            )
            GMHelper:Cry02()
        end,
        1000
    )
end
GMHelper.InfBD = function(v1506)
    ModuleBlockConfig.init = function(v2584)
        local v2585 = FileUtil.getGameConfigFromYml("module_block/ModuleBlock", true) or {}
        v2584.placeBlockMaxDepth = v2585.placeBlockMaxDepth or 2
        v2584.placeBlockMaxBuildDistance = 6
        v2584.buildRoadModeMaxDistance = 6
        if isClient then
            ClientHelper.putIntPrefs("RunLimitCheck", v2585.limitBlockCheckRun or 10)
            ClientHelper.putIntPrefs("SprintLimitCheck", v2585.limitBlockCheckSprint or 10)
        end
        v2585 = FileUtil.getGameConfigFromCsv("module_block/ModuleBlock.csv", 2, true, true) or {}
        for v3839, v3840 in pairs(v2585) do
            local v3841 = {
                id = tonumber(v3840.id),
                itemId = tonumber(v3840.itemId),
                teamId = tonumber(v3840.teamId) or 0,
                consumeNum = tonumber(v3840.consumeNum) or 1,
                schematic = v3840.schematic,
                offsetX = tonumber(v3840.offsetX) or 0,
                offsetZ = tonumber(v3840.offsetZ) or 0,
                image = v3840.image,
                extraParam = tonumber(v3840.extraParam) or 0
            }
            v8[v3841.itemId] = v8[v3841.itemId] or {}
            table.insert(v8[v3841.itemId], v3841)
        end
        for v3843, v3844 in pairs(v8) do
            table.sort(
                v3844,
                function(v4625, v4626)
                    return v4625.id < v4626.id
                end
            )
        end
    end
    ModuleBlockConfig.getModuleBlock = function(v2589, v2590, v2591, v2592)
        local v2593 = v8[v2590]
        if not v2593 then
            return nil
        end
        if (v2591 and (v2591 ~= 0)) then
            for v4909, v4910 in pairs(v2593) do
                if (v4910.id == v2591) then
                    return v4910
                end
            end
        end
        for v3845, v3846 in pairs(v2593) do
            if (v3846.teamId == v2592) then
                return v3846
            end
        end
        if (v2592 == 0) then
            return nil
        else
            return v2589:getModuleBlock(v2590, v2591, 0)
        end
    end
    ModuleBlockConfig.getModuleBlocks = function(v2594, v2595)
        return v8[v2595]
    end
    ModuleBlockConfig.getDefaultModuleId = function(v2596, v2597)
        local v2598 = v8[v2597]
        if TableUtil.isEmpty(v2598) then
            return 0
        end
        return v2598[1].id
    end
    ModuleBlockConfig.hasConfig = function(v2599)
        return not TableUtil.isEmpty(v8)
    end
    ModuleBlockConfig:init()
    UIHelper.showToast("^00FF00ON")
    GUIGMControlPanel:hide()
end
GMHelper.findLifePlayer = function(v1512, v1513)
    local v1514 = findLifeOtherPlayer(v1513)
    if v1514 then
        v1513:teleportPos(v1514:getPosition())
    end
end
GMHelper.addGMPlayer = function(v1515, v1516, v1517)
    if (not isTest and not isStaging) then
        return
    end
    if v1517 then
        for v4627, v4628 in pairs(PlayerManager:getPlayers()) do
            v4628:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v4628.userId)
        end
    else
        local v3847 = PlayerManager:getPlayers()
        local v3848 = 99999999
        local v3849
        for v4629, v4630 in pairs(v3847) do
            local v4631 = MathUtil:distanceSquare3d(v4630:getPosition(), v1516:getPosition())
            if ((v3848 > v4631) and (v4630 ~= v1516)) then
                v3848 = v4631
                v3849 = v4630
            end
        end
        if (v3849 and not PlayerManager:isAIPlayer(v3849)) then
            v3849:sendPacket({pid = "openGMHelper"})
            table.insert(GmIds, v3849.userId)
        end
    end
end
GMHelper.SpamChat = function(v1518)
    GMHelper:openInput(
        {""},
        function(v2600)
            LuaTimer:scheduleTimer(
                function()
                    GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v2600)
                end,
                5,
                1000000
            )
        end
    )
end
GMHelper.Autoclick = function(v1519)
    A = not A
    LuaTimer:cancel(v1519.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1519.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(816, 316)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.Autoclickew = function(v1520)
    A = not A
    LuaTimer:cancel(v1520.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1520.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4632 = PlayerManager:getClientPlayer().Player:getHeldItemId()
                if ((v4632 >= 267) and (v4632 <= 279)) then
                    CGame.Instance():handleTouchClick(816, 316)
                end
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.getName = function(v1521)
    local v1522 = PlayerManager:getPlayers()
    for v2601, v2602 in pairs(v1522) do
        MsgSender.sendMsg(
            "^FFFF00玩家名字: " ..
                v2602:getName() ..
                    "^00FF00对应id:  " ..
                        v2602.userId .. "^FFFF00队伍: " .. v2602:getTeamId() .. "^00FF00生命: " .. v2602:getHealth()
        )
    end
end
GMHelper.Autoclick1 = function(v1523)
    A = not A
    LuaTimer:cancel(v1523.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1523.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(75, 25)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.Autoclick2 = function(v1524)
    A = not A
    LuaTimer:cancel(v1524.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1524.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4633 = PlayerManager:getClientPlayer().Player:getHeldItemId()
                if ((v4633 >= 2441) and (v4633 <= 2444)) then
                    CGame.Instance():handleTouchClick(1315, 416)
                end
            end,
            10,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.Autoclick3 = function(v1525)
    A = not A
    LuaTimer:cancel(v1525.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1525.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(1500, 317)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.Autoclick4 = function(v1526)
    A = not A
    LuaTimer:cancel(v1526.timer)
    UIHelper.showToast("^FF0000关闭")
    if A then
        v1526.timer =
            LuaTimer:scheduleTimer(
            function()
                CGame.Instance():handleTouchClick(1600, 400)
            end,
            0.2,
            9e+23
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.AutoJump = function(v1527)
    E = not E
    LuaTimer:cancel(v1527.timer)
    UIHelper.showToast("^FF0000关闭")
    if E then
        v1527.timer =
            LuaTimer:scheduleTimer(
            function()
                local v4634 = PlayerManager:getClientPlayer().Player:getBaseAction()
                if ((v4634 >= 0) and (v4634 <= 1) and (Ins == 0)) then
                    local v5086 = VectorUtil.newVector3(0, 1.2, 0)
                    PlayerManager:getClientPlayer().Player:moveEntity(v5086)
                    Ins = 1
                elseif ((v4634 >= 18) and (v4634 <= 19)) then
                    Ins = 0
                end
            end,
            100,
            9000000
        )
        UIHelper.showToast("^00FF00开启")
        GUIGMControlPanel:hide()
    end
end
GMHelper.NoBomb1 = function(v1528)
    A = not A
    for v2603 = 593, 594 do
        local v2604 = BlockManager.getBlockById(v2603)
        if v2604 then
            v2604:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2605 = 593, 594 do
        local v2606 = BlockManager.getBlockById(v2605)
        if v2606 then
            v2606:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoIDoor1 = function(v1529)
    A = not A
    for v2607 = 241, 242 do
        local v2608 = BlockManager.getBlockById(v2607)
        if v2608 then
            v2608:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2609 = 241, 242 do
        local v2610 = BlockManager.getBlockById(v2609)
        if v2610 then
            v2610:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.NoQuartz1 = function(v1530)
    A = not A
    for v2611 = 155, 156 do
        local v2612 = BlockManager.getBlockById(v2611)
        if v2612 then
            v2612:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    end
    if A then
        UIHelper.showToast("^00FF00Enabled")
        return
    end
    for v2613 = 155, 156 do
        local v2614 = BlockManager.getBlockById(v2613)
        if v2614 then
            v2614:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    end
    UIHelper.showToast("^FF0000Disabled")
end
GMHelper.JumpHeight = function(v1531)
    GMHelper:openInput(
        {""},
        function(v2615)
            local v2616 = PlayerManager:getClientPlayer()
            if (v2616 and v2616.Player) then
                v2616.Player:setFloatProperty("JumpHeight", v2615)
                UIHelper.showToast("^00FF00Success")
            end
        end
    )
end
GMHelper.Scaffold = function(v1532)
    A = not A
    LuaTimer:cancel(v1532.timer)
    UIHelper.showToast("^00FF00Scaffold ON")
    if A then
        GMHelper:openInput(
            {"BlockID"},
            function(v4635)
                v1532.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        local v4911 = PlayerManager:getClientPlayer():getPosition()
                        EngineWorld:setBlock(VectorUtil.newVector3(v4911.x, v4911.y - 2, v4911.z), v4635)
                    end,
                    0.15,
                    -1
                )
                UIHelper.showToast("^00FF00Scaffold OFF")
            end
        )
    end
end
GMHelper.StopScaffold = function(v1533)
    LuaTimer:cancel(v1533.timer)
end
GMHelper.addCurrencyCustom = function(v1534, v1535)
    GMHelper:openInput(
        v1535,
        {"100"},
        function(v2617)
            v2617 = tonumber(v2617) or 0
            v1535:addCurrency(v2617, "GM")
        end
    )
end
GMHelper.GUIOpener = function(v1536)
    GMHelper:openInput(
        {".json"},
        function(v2618)
            GUIManager:showWindowByName(v2618)
        end
    )
end
GMHelper.GUIViewOFF = function(v1537)
    GMHelper:openInput(
        {".json"},
        function(v2619)
            GUIManager:hideWindowByName(v2619)
        end
    )
end
GMHelper.InsideGUI = function(v1538)
    GMHelper:openInput(
        {"", ""},
        function(v2620, v2621)
            GUIManager:getWindowByName(v2620):SetVisible(v2621)
        end
    )
end
GMHelper.ChangeNick = function(v1539)
    GMHelper:openInput(
        {""},
        function(v2622)
            PlayerManager:getClientPlayer().Player:setShowName(v2622)
            UIHelper.showToast("^FF00EENickNameChanged")
        end
    )
end
GMHelper.FlyParachute = function(v1540)
    local v1541 = VectorUtil.newVector3(0, 1.35, 0)
    local v1542 = PlayerManager:getClientPlayer()
    v1542.Player:setAllowFlying(true)
    v1542.Player:setFlying(true)
    v1542.Player:moveEntity(v1541)
    PlayerManager:getClientPlayer().Player:startParachute()
    UIHelper.showToast("^FF00EESuccess")
end
GMHelper.SpamRespawn = function(v1543)
    GMHelper:openInput(
        {""},
        function(v2623)
            for v3857 = 1, v2623 do
                PacketSender:getSender():sendRebirth()
            end
        end
    )
end
GMHelper.RespawnTool = function(v1544)
    PacketSender:getSender():sendRebirth()
end
GMHelper.ShowPlayersInfo = function(v1545)
    local v1546 = PlayerManager:getPlayers()
    for v2624, v2625 in pairs(v1546) do
        MsgSender.sendMsgs(
            "[Player Info] " ..
                string.format(
                    "Username: %s | User ID: %s | Gender: %s",
                    v2625:getName(),
                    v2625.userId,
                    v2625.Player:getSex()
                )
        )
    end
end
GMHelper.CopyPlayersInfo = function(v1547)
    local v1548 = ""
    local v1549 = PlayerManager:getPlayers()
    for v2626, v2627 in pairs(v1549) do
        v1548 =
            v1548 ..
            "\n[Player Info] " ..
                string.format(
                    "Username: %s | User ID: %s | Gender: %s",
                    v2627:getName(),
                    v2627.userId,
                    v2627.Player:getSex()
                )
    end
    ClientHelper.onSetClipboard(v1548)
end
GMHelper.LongJump = function(v1550)
    LuaTimer:scheduleTimer(
        function()
            PlayerManager:getClientPlayer().Player:setGlide(true)
        end,
        0.2,
        9e+23
    )
end
GMHelper.AdvancedUp = function(v1551)
    GMHelper:openInput(
        {""},
        function(v2628)
            local v2629 = VectorUtil.newVector3(0, v2628, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2629)
        end
    )
end
GMHelper.AdvancedIn = function(v1552)
    GMHelper:openInput(
        {""},
        function(v2630)
            local v2631 = VectorUtil.newVector3(v2630, 0, 0)
            PlayerManager:getClientPlayer().Player:moveEntity(v2631)
        end
    )
end
GMHelper.AdvancedOn = function(v1553)
    GMHelper:openInput(
        {""},
        function(v2632)
            local v2633 = VectorUtil.newVector3(0, 0, v2632)
            PlayerManager:getClientPlayer().Player:moveEntity(v2633)
        end
    )
end
GMHelper.AdvancedDirect = function(v1554)
    GMHelper:openInput(
        {"", "", ""},
        function(v2634, v2635, v2636)
            local v2637 = VectorUtil.newVector3(v2634, v2635, v2636)
            PlayerManager:getClientPlayer().Player:moveEntity(v2637)
        end
    )
end
GMHelper.tpPos = function(v1555)
    GMHelper:openInput(
        {"", "", ""},
        function(v2638, v2639, v2640)
            local v2641 = VectorUtil.newVector3(v2638, v2639, v2640)
            local v2642 = VectorUtil.newVector3(1, 10, 1)
            PlayerManager:getClientPlayer().Player:setPosition(v2641)
            PlayerManager:getClientPlayer().Player:moveEntity(v2642)
        end
    )
end
GMHelper.HideHoldItem = function(v1556)
    A = not A
    PlayerManager:getClientPlayer():setHideHoldItem(true)
    UIHelper.showToast("^FF00EETrue")
    if A then
        PlayerManager:getClientPlayer():setHideHoldItem(false)
        UIHelper.showToast("^FF00EEFalse")
    end
end
GMHelper.MineReset = function(v1557)
    local v1558 = VectorUtil.newVector3(536, 2.78, -136)
    local v1559 = VectorUtil.newVector3(0, 0, 0)
    PlayerManager:getClientPlayer().Player:setPosition(v1558)
    PlayerManager:getClientPlayer().Player:moveEntity(v1559)
end
GMHelper.DevFlyI = function(v1560)
    local v1561 = VectorUtil.newVector3(0, 1.35, 0)
    local v1562 = PlayerManager:getClientPlayer()
    v1562.Player:setAllowFlying(true)
    v1562.Player:setFlying(true)
    v1562.Player:moveEntity(v1561)
    UIHelper.showToast("^FF00EESuccess")
end
GMHelper.SetFOV = function(v1563)
    GMHelper:openInput(
        {""},
        function(v2643)
            Blockman.Instance().m_gameSettings:setFovSetting(v2643)
            UIHelper.showToast("success")
        end
    )
end
GMHelper.SharpFly = function(v1564)
    A = not A
    ClientHelper.putBoolPrefs("DisableInertialFly", true)
    UIHelper.showToast("^FF00EE[ON] works when you have dev flight enabled")
    if A then
        ClientHelper.putBoolPrefs("DisableInertialFly", false)
        UIHelper.showToast("^FF00EE[OFF] works when you have dev flight enabled")
    end
end
GMHelper.WaterPush = function(v1565)
    A = not A
    local v1566 = PlayerManager:getClientPlayer().Player
    v1566:setBoolProperty("ignoreWaterPush", true)
    UIHelper.showToast("^FF00EEON")
    if A then
        v1566:setBoolProperty("ignoreWaterPush", false)
        UIHelper.showToast("^FF00EEOFF")
    end
end
GMHelper.ReachSet = function(v1567)
    GMHelper:openInput(
        {"Delete this sentence and type your reach. Default: 5"},
        function(v2644)
            ClientHelper.putFloatPrefs("EntityReachDistance", v2644)
            UIHelper.showToast("sukses")
        end
    )
end
GMHelper.changeScale = function(v1568)
    GMHelper:openInput(
        {""},
        function(v2645)
            local v2646 = PlayerManager:getClientPlayer().Player
            v2646:setScale(v2645)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.BlockOFF = function(v1569)
    GMHelper:openInput(
        {""},
        function(v2647)
            local v2648 = v2647
            local v2649 = BlockManager.getBlockById(v2648)
            v2649:setBlockBounds(0, 0, 0, 0, 0, 0)
        end
    )
end
GMHelper.BlockON = function(v1570)
    GMHelper:openInput(
        {""},
        function(v2650)
            local v2651 = v2650
            local v2652 = BlockManager.getBlockById(v2651)
            v2652:setBlockBounds(0, 0, 0, 1, 1, 1)
        end
    )
end
GMHelper.SpeedManager = function(v1571)
    GMHelper:openInput(
        {""},
        function(v2653)
            PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(v2653)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.SpeedUp = function(v1572)
    ClientHelper.putIntPrefs("SpeedAddMax", 20000000)
    UIHelper.showToast("^FF0000[DANGER]")
end
GMHelper.XRayManagerON = function(v1573)
    GMHelper:openInput(
        {"erase this text and write block id"},
        function(v2654)
            cBlockManager.cGetBlockById(v2654):setNeedRender(false)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.XRayManagerOFF = function(v1574)
    GMHelper:openInput(
        {"erase this text and write block id"},
        function(v2655)
            cBlockManager.cGetBlockById(v2655):setNeedRender(true)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.OFFDARK = function(v1575)
    cBlockManager.cGetBlockById(66):setNeedRender(false)
    cBlockManager.cGetBlockById(253):setNeedRender(false)
    for v2656 = 1, 40000 do
        local v2657 = BlockManager.getBlockById(v2656)
        if v2657 then
            v2657:setLightValue(150, 150, 150)
            UIHelper.showToast("^00FF00Success")
            GUIGMControlPanel:hide()
        end
    end
end
GMHelper.SpawnNPC = function(v1576)
    GMHelper:openInput(
        {".actor"},
        function(v2658)
            local v2659 = PlayerManager:getClientPlayer():getPosition()
            local v2660 = PlayerManager:getClientPlayer():getYaw()
            EngineWorld:addActorNpc(
                v2659,
                v2660,
                v2658,
                function(v3858)
                end
            )
        end
    )
end
GMHelper.spawnCar = function(v1577)
    GMHelper:openInput(
        {"Car ID (erase this text and write carID)"},
        function(v2661)
            local v2662 = PlayerManager:getClientPlayer():getPosition()
            Blockman.Instance():getWorld():addVehicle(v2662, v2661, 5)
            UIHelper.showToast("^00FFEECar Spawn Success")
        end
    )
end
GMHelper.TeleportByUID = function(v1578)
    GMHelper:openInput(
        {"id player"},
        function(v2663)
            local v2664 = PlayerManager:getClientPlayer().Player
            local v2665 = PlayerManager:getPlayerByUserId(v2663)
            if v2665 then
                v2664:setPosition(v2665:getPosition())
            end
        end
    )
end
GMHelper.NoFall = function(v1579)
    A = not A
    ClientHelper.putIntPrefs("SprintLimitCheck", 7)
    if A then
        UIHelper.showToast("Enabled")
        return
    end
    ClientHelper.putIntPrefs("SprintLimitCheck", 0)
    UIHelper.showToast("Disabled")
end
GMHelper.ChangeActorForMe = function(v1580)
    local v1581 = PlayerManager:getClientPlayer().Player
    GMHelper:openInput(
        {".actor"},
        function(v2666)
            Blockman.Instance():getWorld():changePlayerActor(v1581, v2666)
            Blockman.Instance():getWorld():changePlayerActor(v1581, v2666)
            v1581.m_isPeopleActor = false
            EngineWorld:restorePlayerActor(v1581)
            UIHelper.showToast("^00FFEESuccess")
        end
    )
end
GMHelper.AFKmode = function(v1582)
    A = not A
    PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1
    UIHelper.showToast("^FF00EEStart")
    if A then
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
        UIHelper.showToast("^FF00EEStop")
    end
end
GMHelper.DevnoClip = function(v1584)
    A = not A
    PlayerManager:getClientPlayer().Player.noClip = true
    UIHelper.showToast("^FF00EETurned on")
    if A then
        PlayerManager:getClientPlayer().Player.noClip = false
        UIHelper.showToast("^FF00EETurned off")
    end
end
GMHelper.StepHeight = function(v1586)
    GMHelper:openInput(
        {"StepHeight Value"},
        function(v2668)
            PlayerManager:getClientPlayer().Player.stepHeight = v2668
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.SpYaw = function(v1587)
    A = not A
    PlayerManager:getClientPlayer().Player.spYaw = true
    UIHelper.showToast("^FF00EEON")
    if A then
        PlayerManager:getClientPlayer().Player.spYaw = false
        UIHelper.showToast("^FF00EEOFF")
    end
end
GMHelper.SpYawSet = function(v1589)
    GMHelper:openInput(
        {""},
        function(v2670)
            PlayerManager:getClientPlayer().Player.spYawRadian = v2670
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.HairSet = function(v1590)
    GMHelper:openInput(
        {""},
        function(v2672)
            PlayerManager:getClientPlayer().Player.m_isEquipWing = true
            PlayerManager:getClientPlayer().Player.m_isClothesChange = true
            PlayerManager:getClientPlayer().Player.m_isClothesChanged = true
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.SetHideAndShowArmor = function(v1591)
    A = not A
    LogicSetting.Instance():setHideArmor(true)
    UIHelper.showToast("^FF00EEON")
    if A then
        LogicSetting.Instance():setHideArmor(false)
        UIHelper.showToast("^FF00EEOFF")
    end
end
GMHelper.SettingLongjump = function(v1592)
    GMHelper:openInput(
        {"speedglide", "drop resistance"},
        function(v2676, v2677)
            local v2678 = PlayerManager:getClientPlayer().Player
            v2678.m_isGlide = true
            v2678.m_glideMoveAddition = v2676
            v2678.m_glideDropResistance = v2677
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.SetAlpha = function(v1593)
    GMHelper:openInput(
        {"Gui name", "alpha"},
        function(v2682, v2683)
            GUIManager:getWindowByName(v2682):SetAlpha(v2683)
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeHair = function(v1594)
    GMHelper:openInput(
        {"number"},
        function(v2684)
            local v2685 = PlayerManager:getClientPlayer().Player
            v2685.m_outLooksChanged = true
            v2685.m_hairID = v2684
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeFace = function(v1595)
    GMHelper:openInput(
        {"number"},
        function(v2688)
            local v2689 = PlayerManager:getClientPlayer().Player
            v2689.m_outLooksChanged = true
            v2689.m_faceID = v2688
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeTops = function(v1596)
    GMHelper:openInput(
        {"number"},
        function(v2692)
            local v2693 = PlayerManager:getClientPlayer().Player
            v2693.m_outLooksChanged = true
            v2693.m_topsID = v2692
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangePants = function(v1597)
    GMHelper:openInput(
        {"number"},
        function(v2696)
            local v2697 = PlayerManager:getClientPlayer().Player
            v2697.m_outLooksChanged = true
            v2697.m_pantsID = v2696
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeShoes = function(v1598)
    GMHelper:openInput(
        {"number"},
        function(v2700)
            local v2701 = PlayerManager:getClientPlayer().Player
            v2701.m_outLooksChanged = true
            v2701.m_shoesID = v2700
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeGlasses = function(v1599)
    GMHelper:openInput(
        {"number"},
        function(v2704)
            local v2705 = PlayerManager:getClientPlayer().Player
            v2705.m_outLooksChanged = true
            v2705.m_glassesId = v2704
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeScarf = function(v1600)
    GMHelper:openInput(
        {"number"},
        function(v2708)
            local v2709 = PlayerManager:getClientPlayer().Player
            v2709.m_outLooksChanged = true
            v2709.m_scarfId = v2708
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ChangeWing = function(v1601)
    GMHelper:openInput(
        {"number"},
        function(v2712)
            local v2713 = PlayerManager:getClientPlayer().Player
            v2713.m_outLooksChanged = true
            v2713.m_wingId = v2712
            UIHelper.showToast("^FF00EESuccess")
        end
    )
end
GMHelper.ShowRegion = function(v1602)
    UIHelper.showToast("RegionID=" .. Game:getRegionId())
end
GMHelper.GameID = function(v1603)
    UIHelper.showToast("GameID=" .. CGame.Instance():getGameType())
end
GMHelper.LogInfo = function(v1604)
    local v1605 = HostApi.getClientInfo()
    ClientHelper.onSetClipboard(v1605)
    UIHelper.showToast("^FF00EESuccess")
end
GMHelper.GetAllInfoT = function(v1606)
    local v1607 = PlayerManager:getPlayers()
    for v2716, v2717 in pairs(v1607) do
        MsgSender.sendMsg(
            "^FF0000INFO: " ..
                string.format(
                    "^FF0000UserName: %s {} ID: %s {} Gender: %s",
                    v2717:getName(),
                    v2717.userId,
                    v2717.Player:getSex()
                )
        )
    end
end
GMHelper.test2300 = function(v1608)
    GMHelper:openInput(
        {""},
        function(v2718)
            local v2719 = PlayerManager:getClientPlayer().Player
            v2719.length = v2718
            v2719.isCollidedHorizontally = true
            v2719.isCollidedVertically = true
            v2719.isCollided = true
        end
    )
end
GMHelper.test1222 = function(v1609)
    local v1610 = PlayerManager:getClientPlayer().Player
    v1610.m_canBuildBlockQuickly = true
    v1610.m_quicklyBuildBlock = true
    UIHelper.showToast("2:")
end
GMHelper.test2222 = function(v1613)
    local v1614 = PlayerManager:getClientPlayer().Player
    v1614.m_opacity = 0.2
    UIHelper.showToast("1:")
end
GMHelper.spawnCar = function(v1616)
    GMHelper:openInput(
        {"Car ID (erase this text and write carID)"},
        function(v2724)
            local v2725 = PlayerManager:getClientPlayer():getPosition()
            local v2726 = PlayerManager:getClientPlayer():getYaw()
            Blockman.Instance():getWorld():addVehicle(v2725, v2724, v2726)
            UIHelper.showToast("^FF00EECar Spawn Success")
        end
    )
end
GMHelper.SpawnItem = function(v1617)
    GMHelper:openInput(
        {"ID", "Count"},
        function(v2727, v2728)
            local v2729 = PlayerManager:getClientPlayer():getPosition()
            EngineWorld:addEntityItem(v2727, v2728, 0, 600, v2729, VectorUtil.ZERO)
        end
    )
end
GMHelper.SetBlockToAir = function(v1618)
    GMHelper:openInput(
        {"block Position X", "block Position Y", "block Position Z"},
        function(v2730, v2731, v2732)
            local v2733 = VectorUtil.newVector3(v2730, v2731, v2732)
            EngineWorld:setBlockToAir(v2733)
        end
    )
end
GMHelper.NoFallSet = function(v1619)
    GMHelper:openInput(
        {"TypeValue"},
        function(v2734)
            ClientHelper.putIntPrefs("SprintLimitCheck", v2734)
            UIHelper.showToast("Done, now it will have like a protection")
        end
    )
end
GMHelper.SpawnBlock = function(v1620)
    GMHelper:openInput(
        {""},
        function(v2735)
            local v2736 = PlayerManager:getClientPlayer():getPosition()
            EngineWorld:setBlock(v2736, v2735)
        end
    )
end
GMHelper.BlockReachSet = function(v1621)
    GMHelper:openInput(
        {"Input Float. Default: 6.5"},
        function(v2737)
            ClientHelper.putFloatPrefs("BlockReachDistance", v2737)
            UIHelper.showToast("done")
        end
    )
end
local function v441(v1622)
    local v1623 = SceneManager.Instance():getMainCamera():getPosition()
    local v1624 = VectorUtil.newVector3(v1622.x - v1623.x, v1622.y - v1623.y, v1622.z - v1623.z)
    local v1625 = (math.atan2(v1624.x, v1624.z) * 180) / math.pi
    local v1626 = (math.atan2(v1624.y, math.sqrt((v1624.x * v1624.x) + (v1624.z * v1624.z))) * 180) / math.pi
    PlayerManager:getClientPlayer().Player.rotationYaw = v1625
    PlayerManager:getClientPlayer().Player.rotationPitch = v1626
end
local function v442(v1629)
    local v1630 = SceneManager.Instance():getMainCamera()
    local v1631 = v1630:getPosition()
    local v1632 = VectorUtil.sub3(v1629, v1631)
    local v1633 = (math.atan2(v1629.x - v1631.x, v1629.z - v1631.z) * -180) / math.pi
    local v1634 = math.sqrt((v1632.x * v1632.x) + (v1632.z * v1632.z))
    local v1635 = (-math.atan2(v1629.y - v1631.y, v1634) * 180) / math.pi
    PlayerManager:getClientPlayer().Player.rotationYaw = v1633
    PlayerManager:getClientPlayer().Player.rotationPitch = v1635
end
EntityCache.onTick = function(v1638)
    if v29 then
        local v3862 = PlayerManager:getClientPlayer()
        if (v3862 == nil) then
            return
        end
        local v3863 = v3862.Player:getPosition()
        MsgSender.sendTopTips(
            1,
            string.format(
                "X : %s  Y : %s  Z : %s",
                tostring(math.floor(v3863.x)),
                tostring(math.floor(v3863.y)),
                tostring(math.floor(v3863.z))
            )
        )
    end
    if v22 then
        yaw = PlayerManager:getClientPlayer().Player:getYaw()
        pitch = PlayerManager:getClientPlayer().Player:getPitch()
        MsgSender.sendTopTips(1, "yaw = " .. yaw .. " pitch = " .. pitch)
    end
    if scaffold then
        local v3864 = PlayerManager:getClientPlayer():getPosition()
        EngineWorld:setBlock(VectorUtil.newVector3(v3864.x, v3864.y - 2, v3864.z), 2)
    end
    if ShowHealth then
        allPlayer = PlayerManager:getPlayers()
        for v4637, v4638 in pairs(allPlayer) do
            allPlayer.Player:setShowName(allPlayer.Player:getShowName() .. "" .. allPlayer.Player:getHealth() .. "\n ")
        end
    end
    if v44 then
        local v3865 = PlayerManager:getClientPlayer().Player:getYaw()
        local v3866 = PlayerManager:getClientPlayer().Player:getPitch()
        local v3867 = math.rad(v3865)
        local v3868 = math.rad(v3866)
        local v3869 = v43
        local v3870 = -v3869 * math.cos(v3868) * math.sin(v3867)
        local v3871 = -v3869 * math.sin(v3868)
        local v3872 = v3869 * math.cos(v3868) * math.cos(v3867)
        local v3873 = VectorUtil.newVector3(v3870, v3871, v3872)
        PlayerManager:getClientPlayer().Player:setVelocity(v3873)
    end
    if LongJump then
        PlayerManager:getClientPlayer().Player:setGlide(true)
    end
    GMHelper.EnterGame = function(v2738, v2739, v2740)
        Game:resetGame(v2740, PlayerManager:getClientPlayer().userId, v2739)
    end
    GMHelper.EnterGameTest = function(v2741, v2742, v2743, v2744)
        Game:resetGame(v2743, PlayerManager:getClientPlayer().userId)
    end
    GMHelper.SetPlayerScale2 = function(v2745)
        PlayerManager:getClientPlayer().Player.SetPlayerScale = 5
    end
    GMHelper.setYaw = function(v2747, v2748, v2749)
        if v2749 then
            PlayerManager:getClientPlayer().Player.rotationYaw =
                PlayerManager:getClientPlayer().Player.rotationYaw - v2748
            return
        end
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v2748
    end
    GMHelper.setYaw = function(v2751)
        GMHelper:openInput(
            {""},
            function(v3874)
                PlayerManager:getClientPlayer().Player.rotationYaw = v3874
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.ChangeTime = function(v2752, v2753)
        local v2754 = EngineWorld:getWorld()
        if v2753 then
            v2754:setWorldTime(15000)
            UIHelper.showToast("^00FF00Now Night!")
            return
        end
        v2754:setWorldTime(6000)
        UIHelper.showToast("^00FF00Now Day!")
    end
    GMHelper.SetTime = function(v2755)
        GMHelper:openInput(
            {""},
            function(v3876)
                local v3877 = EngineWorld:getWorld()
                v3877:setWorldTime(v3876)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.StartTime = function(v2756)
        isTimeStopped = not isTimeStopped
        local v2757 = EngineWorld:getWorld()
        v2757:setTimeStopped(isTimeStopped)
        if isTimeStopped then
            UIHelper.showToast("^00FF00Start/Stop Time: disabled!")
            return
        end
        UIHelper.showToast("^00FF00Start/Stop Time: enabled!")
    end
    GMHelper.getConfig = function(v2758)
        MsgSender.sendMsg("Time:" .. tostring(ModsConfig.time))
        MsgSender.sendMsg("Show pos:" .. tostring(ModsConfig.showPos))
        MsgSender.sendMsg("Hp warn:" .. tostring(ModsConfig.lhwarn))
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
        MsgSender.sendMsg("Hide player names:" .. tostring(ModsConfig.hpn))
    end
    GMHelper.HidePlayerName = function(v2759)
        isHideNames = not isHideNames
        if isHideNames then
            ModsConfig.hpn = 1
            MsgSender.sendMsg("Hide players name: enabled!")
            return
        end
        if not isHideNames then
            ModsConfig.hpn = 0
            MsgSender.sendMsg("Hide players name: disabled!")
        end
    end
    GMHelper.ShowPos = function(v2760)
        isShowPos = not isShowPos
        if isShowPos then
            ModsConfig.showPos = 1
            MsgSender.sendMsg("Show player position: enabled!")
            return
        end
        ModsConfig.showPos = 0
        MsgSender.sendMsg("Show player position: disabled!")
    end
    GMHelper.EnableHPWarn = function(v2762)
        useHPWarn = not useHPWarn
        if useHPWarn then
            ModsConfig.lhwarn = 1
            MsgSender.sendMsg("HP Warning: enabled!")
            return
        end
        ModsConfig.lhwarn = 0
        MsgSender.sendMsg("HP Warning: disabled!")
    end
    GMHelper.addHpLvl = function(v2764, v2765, v2766)
        if v2766 then
            if (ModsConfig.hpwarn == 0) then
                return
            end
            ModsConfig.hpwarn = ModsConfig.hpwarn - 1
            MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
            return
        end
        if (ModsConfig.hpwarn == PlayerManager:getClientPlayer().Player:getHealth()) then
            return
        end
        ModsConfig.hpwarn = ModsConfig.hpwarn + 1
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
    end
    GMHelper.addGMPlayer = function(v2768, v2769, v2770)
        if not isClient then
            return
        end
        if v2770 then
            for v4912, v4913 in pairs(PlayerManager:getPlayers()) do
                v4913:sendPacket({pid = "openGMHelper"})
                table.insert(GmIds, v4913.userId)
            end
        else
            local v4645 = PlayerManager:getPlayers()
            local v4646 = 99999999
            local v4647
            for v4914, v4915 in pairs(v4645) do
                local v4916 = MathUtil:distanceSquare3d(v4915:getPosition(), v2769:getPosition())
                if ((v4646 > v4916) and (v4915 ~= v2769)) then
                    v4646 = v4916
                    v4647 = v4915
                end
            end
            if (v4647 and not PlayerManager:isAIPlayer(v4647)) then
                v4647:sendPacket({pid = "openGMHelper"})
                table.insert(GmIds, v4647.userId)
            end
        end
        GUIGMControlPanel:hide()
    end
    GMHelper.openCommonPacketDebug = function(v2771)
        CommonDataEvents.isDebug = true
    end
    GMHelper.closeCommonPacketDebug = function(v2773)
        CommonDataEvents.isDebug = false
    end
    GMHelper.openConnectorLog = function(v2775)
        local v2776 = T(Global, "ConnectorCenter")
        v2776.isDebug = true
        local v2778 = T(Global, "ConnectorDispatch")
        v2778.isDebug = true
    end
    GMHelper.closeConnectorLog = function(v2780)
        local v2781 = T(Global, "ConnectorCenter")
        v2781.isDebug = false
        local v2783 = T(Global, "ConnectorDispatch")
        v2783.isDebug = false
    end
    GMHelper.sendTestConnectorMsg = function(v2785, v2786)
        local v2787 = {}
        v2787.a = 1
        v2787.b = 2
        local v2790 = T(Global, "ConnectorCenter")
        v2790:sendMsg(v2786, v2787)
    end
    GMHelper.SetEnabledRenderFrameTimer = function(v2791, v2792)
        PerformanceStatistics.SetEnabledRenderFrameTimer(v2792)
        GUIGMControlPanel:hide()
    end
    GMHelper.updateAllShaders = function(v2793)
        Blockman.Instance().m_gameSettings:updateAllShaders()
        GUIGMControlPanel:hide()
    end
    GMHelper.setNeedMonitorShader = function(v2794)
        Blockman.Instance().m_gameSettings:setNeedMonitorShader(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setDrawCallDisabled = function(v2795)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setDrawCallDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setMinimumGeometry = function(v2796)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setMinimumGeometry(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setColorBlendDisabled = function(v2797)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setColorBlendDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setZTestDisabled = function(v2798)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setZTestDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setZWriteDisabled = function(v2799)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setZWriteDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setUseSmallTexture = function(v2800)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallTexture(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setUseSmallViewport = function(v2801)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallViewport(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setUseSmallVBO = function(v2802)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallVBO(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setClearColorDisabled = function(v2803)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setClearColorDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.DisableGraphicAPI = function(v2804)
        Blockman.disableGraphicAPI()
    end
    GMHelper.DisableGraphicAPIAndTestCPU = function(v2805)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetCPUTimerEnabled(true)
                PerformanceStatistics.SetGPUTimerEnabled(false)
                LuaTimer:schedule(
                    function()
                        PerformanceStatistics.PrintResults(30)
                    end,
                    5100
                )
            end,
            200
        )
    end
    GMHelper.DisableGraphicAPIAndTestGPU = function(v2806)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetCPUTimerEnabled(false)
                PerformanceStatistics.SetGPUTimerEnabled(true)
                LuaTimer:schedule(
                    function()
                        PerformanceStatistics.PrintResults(30)
                    end,
                    5100
                )
            end,
            200
        )
    end
    GMHelper.DisableGraphicAPIAndDrawCallTest = function(v2807)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetEnabledRenderFrameTimer(true)
            end,
            200
        )
    end
    GMHelper.openScreenRecord = function(v2808)
        local v2809 = {"Main-PoleControl-Move", "Main-PoleControl", "Main-FlyingControls", "Main-Fly"}
        local v2810 = GUISystem.Instance():GetRootWindow()
        v2810:SetXPosition({0, 10000})
        local v2811 = GUIManager:getWindowByName("Main")
        local v2812 = v2811:GetChildCount()
        for v3878 = 1, v2812 do
            local v3879 = v2811:GetChildByIndex(v3878 - 1)
            local v3880 = v3879:GetName()
            if not TableUtil.tableContain(v2809, v3880) then
                v3879:SetXPosition({0, 10000})
                v3879:SetYPosition({0, 10000})
            end
        end
        ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
        ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)
        GUIManager:getWindowByName("Main-Fly"):SetProperty("NormalImage", "")
        GUIManager:getWindowByName("Main-Fly"):SetProperty("PushedImage", "")
        GUIManager:getWindowByName("Main-PoleControl-BG"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-PoleControl-Center"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Up"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Drop"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Down"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Break-Block-Progress-Nor"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Break-Block-Progress-Pre"):SetProperty("ImageName", "")
        v2811:SetXPosition({0, -10000})
        ClientHelper.putBoolPrefs("RenderHeadText", false)
        PlayerManager:getClientPlayer().Player:setActorInvisible(true)
    end
    GMHelper.changeLuaHotUpdate = function(v2813, v2814)
        startLuaHotUpdate()
        HU.CanUpdate = v2814
    end
    GMHelper.changeOpenEventDialog = function(v2816, v2817)
        GUIGMMain:changeOpenEventDialog(v2817)
    end
    GMHelper.showUserRegion = function(v2818)
        UIHelper.showToast("游戏大区=" .. Game:getRegionId() .. "   玩家区域=" .. Game:getUserRegion())
    end
    GMHelper.setOutputUIName = function(v2819, v2820)
        GUISystem.Instance():SetOutputUIName(not GUISystem.Instance():IsOutputUIName())
        v2820:SetText("打印UI(" .. ((GUISystem.Instance():IsOutputUIName() and "开)") or "关)"))
    end
    GMHelper.telnetClient = function(v2821)
        if not Platform.isWindow() then
            return
        end
        local v2822 = require("misc")
        local v2823 = require("engine_base.debug.DebugPort")
        v2822.win_exec("telnet.exe", "127.0.0.1 " .. v2823.port, nil, nil, true)
    end
    GMHelper.telnetServer = function(v2824)
        if not Platform.isWindow() then
            return
        end
        local v2825 = require("misc")
        local v2826 = require("engine_base.debug.DebugPort")
        v2825.win_exec("telnet.exe", "127.0.0.1 " .. v2826.port, 1, 1, true)
    end
    GMHelper.setGlobalShowText = function(v2827)
        Root.Instance():setShowText(not Root.Instance():isShowText())
    end
    GMHelper.copyClientLog = function(v2828)
        if Platform.isWindow() then
            return
        end
        local v2829 = Root.Instance():getWriteablePath() .. "client.log"
        local v2830 = io.open(v2829, "r")
        if not v2830 then
            return
        end
        local v2831 = v2830:read("*a")
        v2830:close()
        ClientHelper.onSetClipboard(v2831)
        UIHelper.showToast("拷贝成功，请粘贴到钉钉上自动生成文件发送到群里")
    end
    GMHelper.sendConnectorChatMsg = function(v2832, v2833)
        if (isClient or isStaging) then
            local v4648 = T(Global, "ChatService")
            for v4917 = 1, v2833 do
                v4648:sendMsgToLangGroup(Define.ChatMsgType.TextMsg, {content = "Test:" .. v4917})
            end
        end
    end
    GMHelper.queryBoolKey = function(v2834)
        GMHelper:openInput(
            {""},
            function(v3881)
                CustomDialog.builder().setContentText(v3881 .. "=" .. tostring(ClientHelper.getBoolForKey(v3881))).setHideLeftButton(

                ).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.queryStringKey = function(v2835)
        GMHelper:openInput(
            {""},
            function(v3882)
                CustomDialog.builder().setContentText(v3882 .. "=" .. ClientHelper.getStringForKey(v3882)).setHideLeftButton(

                ).setRightText("复制到粘贴板").setRightClickListener(
                    function()
                        ClientHelper.onSetClipboard(ClientHelper.getStringForKey(v3882))
                        UIHelper.showToast("复制成功")
                    end
                ).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.makeGmButtonTran = function(v2836)
        GUIGMMain:setTransparent()
    end
    GMHelper.setRenderMainScreenSeparate = function(v2837, v2838)
        Root.Instance():setRenderMainScreenSeparate(v2838)
    end
    GMHelper.setEnableMergeBlock = function(v2839, v2840)
        Root.Instance():setEnableMergeBlock(true)
        UIHelper.showToast("1")
    end
    GMHelper.AnvilToObj = function(v2841)
        local v2842 = VectorUtil.newVector3()
        local v2843 = 32
        AnvilToObj.doTranslate(v2842, v2843)
    end
    GMHelper.inTheAirCheat = function(v2844)
        LuaTimer:scheduleTimer(
            function()
                local v3883 = VectorUtil.newVector3(0, 3, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3883)
            end,
            5,
            20
        )
    end
    GMHelper.GoTO10BlocksDown = function(v2845)
        LuaTimer:scheduleTimer(
            function()
                local v3884 = VectorUtil.newVector3(0, 0, 1)
                PlayerManager:getClientPlayer().Player:moveEntity(v3884)
            end,
            5,
            20
        )
    end
    GMHelper.GoTO10Blocks = function(v2846)
        LuaTimer:scheduleTimer(
            function()
                local v3885 = VectorUtil.newVector3(1, 0, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3885)
            end,
            5,
            20
        )
    end
    GMHelper.testModiyScript = function(v2847)
        ClientHttpRequest.reportScriptModifyCheat()
    end
    GMHelper.setShowGunFlameCoordinate = function(v2848, v2849)
        Blockman.Instance():setShowGunFlameCoordinate(v2849)
        if v2849 then
            GUIGMControlPanel:setBackgroundColor(Color.TRANS)
        else
            GUIGMControlPanel:setBackgroundColor({0, 0, 0, 0.784314})
        end
    end
    GMHelper.changeGunFlameParam = function(v2850, v2851, v2852)
        ClientHelper.putFloatPrefs(v2851, ClientHelper.getFloatPrefs(v2851) + v2852)
    end
    GMHelper.copyShowGunFlameParam = function(v2853, v2854)
        local v2855 = ClientHelper.getFloatPrefs("GunFlameFrontOff" .. v2854)
        local v2856 = ClientHelper.getFloatPrefs("GunFlameRightOff" .. v2854)
        local v2857 = ClientHelper.getFloatPrefs("GunFlameDownOff" .. v2854)
        local v2858 = ClientHelper.getFloatPrefs("GunFlameScale" .. v2854)
        v2855 = math.floor(v2855 * 100) / 100
        v2856 = math.floor(v2856 * 100) / 100
        v2857 = math.floor(v2857 * 100) / 100
        v2858 = math.floor(v2858 * 100) / 100
        local v2859 = v2855 .. "#" .. v2856 .. "#" .. v2857 .. "#" .. v2858
        ClientHelper.onSetClipboard(v2859)
        UIHelper.showToast("拷贝成功")
    end
    GMHelper.testinValidEffect = function(v2860)
        local v2861 = "01_face_boy.mesh"
        local v2862 = VectorUtil.newVector3(100, 10, 100)
        WorldEffectManager.Instance():addSimpleEffect(v2861, v2862, 1, 1, 1, 1, 1)
        UIHelper.showToast("测试 非法 特效 完成")
    end
    GMHelper.outputItemLangFile = function(v2863)
        if not isClient then
            return
        end
        local v2864 = {}
        for v3886 = 1, 6000 do
            local v3887 = Item.getItemById(v3886)
            if v3887 then
                local v4918 = Lang:getItemName(v3886, 0)
                if (v4918 == "") then
                    v4918 = v3887:getUnlocalizedName()
                end
                v2864[tostring(v3886)] = v4918
            end
        end
        local v2865 = io.open(GameType .. "_item_name.json", "w")
        v2865:write(json.encode(v2864))
        v2865:close()
    end
    GMHelper.MyLoveFly = function(v2866, v2867)
        A = not A
        ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
        if A then
            UIHelper.showToast("^00FF00FLy ON")
            return
        end
        ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
        UIHelper.showToast("^00FF00FLy OFF")
    end
    GMHelper.GUISkyblockTest1 = function(v2868)
        UIHelper.showGameGUILayout("GUIChristmas", 1)
        GUIGMControlPanel:hide()
    end
    GMHelper.showChatRecord = function(v2869, v2870)
        ChatClient:getPrivateMsgCache(
            v2870,
            nil,
            function(v3888)
                LogUtil.pv(v3888)
            end
        )
    end
    GMHelper.autoPrintResults = function(v2871)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                PerformanceStatistics.PrintResults(20)
            end,
            5000
        )
    end
    GMHelper.autoProfilePerformance = function(v2872)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                PerformanceStatistics.ProfilePerformance(20)
            end,
            100
        )
        GMHelper:showInput(
            {"exp", "exp2"},
            function(v3889, v3890)
            end
        )
    end
    GMHelper.EnterGame = function(v2873, v2874, v2875)
        Game:resetGame(v2875, PlayerManager:getClientPlayer().userId, v2874)
    end
    GMHelper.EnterGameTest = function(v2876, v2877, v2878, v2879)
        Game:resetGame(v2878, PlayerManager:getClientPlayer().userId)
    end
    GMHelper.SetPlayerScale2 = function(v2880)
        PlayerManager:getClientPlayer().Player.SetPlayerScale = 5
    end
    GMHelper.noway = function(v2882)
        MsgSender.sendMsg("^000000UNIVERSAL ADMIN PANEL")
        MsgSender.sendTopTips(99999999, "^FF0000UNIVERSAL PANEL BY ETERNALHACKER")
        MsgSender.sendOtherTips(99999999, "^00FF11Version: 1.1")
        MsgSender.sendCenterTips(4, "^2196F3Welcome")
        LuaTimer:schedule(
            function()
                MsgSender.sendMsg("^FF0000LOADED")
                MsgSender.sendMsg("^FF0000VERSION 1.1")
            end,
            5000
        )
        LuaTimer:schedule(
            function()
                MsgSender.sendMsg("^006633")
                MsgSender.sendMsg("^FF0000")
            end,
            5002
        )
    end
    GMHelper.setYaw = function(v2883, v2884, v2885)
        if v2885 then
            PlayerManager:getClientPlayer().Player.rotationYaw =
                PlayerManager:getClientPlayer().Player.rotationYaw - v2884
            return
        end
        PlayerManager:getClientPlayer().Player.rotationYaw = PlayerManager:getClientPlayer().Player.rotationYaw + v2884
    end
    GMHelper.setYaw = function(v2887)
        GMHelper:openInput(
            {""},
            function(v3891)
                PlayerManager:getClientPlayer().Player.rotationYaw = v3891
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.ChangeTime = function(v2888, v2889)
        local v2890 = EngineWorld:getWorld()
        if v2889 then
            v2890:setWorldTime(15000)
            UIHelper.showToast("^00FF00Now Night!")
            return
        end
        v2890:setWorldTime(6000)
        UIHelper.showToast("^00FF00Now Day!")
    end
    GMHelper.SetTime = function(v2891)
        GMHelper:openInput(
            {""},
            function(v3893)
                local v3894 = EngineWorld:getWorld()
                v3894:setWorldTime(v3893)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.StartTime = function(v2892)
        isTimeStopped = not isTimeStopped
        local v2893 = EngineWorld:getWorld()
        v2893:setTimeStopped(isTimeStopped)
        if isTimeStopped then
            UIHelper.showToast("^FF0000Start/Stop Time: disabled!")
            return
        end
        UIHelper.showToast("^00FF00Start/Stop Time: enabled!")
    end
    GMHelper.getConfig = function(v2894)
        MsgSender.sendMsg("Time:" .. tostring(ModsConfig.time))
        MsgSender.sendMsg("Show pos:" .. tostring(ModsConfig.showPos))
        MsgSender.sendMsg("Hp warn:" .. tostring(ModsConfig.lhwarn))
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
        MsgSender.sendMsg("Hide player names:" .. tostring(ModsConfig.hpn))
    end
    GMHelper.HidePlayerName = function(v2895)
        isHideNames = not isHideNames
        if isHideNames then
            ModsConfig.hpn = 1
            MsgSender.sendMsg("Hide players name: enabled!")
            return
        end
        if not isHideNames then
            ModsConfig.hpn = 0
            MsgSender.sendMsg("Hide players name: disabled!")
        end
    end
    GMHelper.ShowPos = function(v2896)
        isShowPos = not isShowPos
        if isShowPos then
            ModsConfig.showPos = 1
            MsgSender.sendMsg("Show player position: enabled!")
            return
        end
        ModsConfig.showPos = 0
        MsgSender.sendMsg("Show player position: disabled!")
    end
    GMHelper.EnableHPWarn = function(v2898)
        useHPWarn = not useHPWarn
        if useHPWarn then
            ModsConfig.lhwarn = 1
            MsgSender.sendMsg("HP Warning: enabled!")
            return
        end
        ModsConfig.lhwarn = 0
        MsgSender.sendMsg("HP Warning: disabled!")
    end
    GMHelper.addHpLvl = function(v2900, v2901, v2902)
        if v2902 then
            if (ModsConfig.hpwarn == 0) then
                return
            end
            ModsConfig.hpwarn = ModsConfig.hpwarn - 1
            MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
            return
        end
        if (ModsConfig.hpwarn == PlayerManager:getClientPlayer().Player:getHealth()) then
            return
        end
        ModsConfig.hpwarn = ModsConfig.hpwarn + 1
        MsgSender.sendMsg("Hp warn level:" .. tostring(ModsConfig.hpwarn))
    end
    GMHelper.addGMPlayer = function(v2904, v2905, v2906)
        if not isClient then
            return
        end
        if v2906 then
            for v4920, v4921 in pairs(PlayerManager:getPlayers()) do
                v4921:sendPacket({pid = "openGMHelper"})
                table.insert(GmIds, v4921.userId)
            end
        else
            local v4655 = PlayerManager:getPlayers()
            local v4656 = 99999999
            local v4657
            for v4922, v4923 in pairs(v4655) do
                local v4924 = MathUtil:distanceSquare3d(v4923:getPosition(), v2905:getPosition())
                if ((v4656 > v4924) and (v4923 ~= v2905)) then
                    v4656 = v4924
                    v4657 = v4923
                end
            end
            if (v4657 and not PlayerManager:isAIPlayer(v4657)) then
                v4657:sendPacket({pid = "openGMHelper"})
                table.insert(GmIds, v4657.userId)
            end
        end
        GUIGMControlPanel:hide()
    end
    GMHelper.openCommonPacketDebug = function(v2907)
        CommonDataEvents.isDebug = true
    end
    GMHelper.closeCommonPacketDebug = function(v2909)
        CommonDataEvents.isDebug = false
    end
    GMHelper.openConnectorLog = function(v2911)
        local v2912 = T(Global, "ConnectorCenter")
        v2912.isDebug = true
        local v2914 = T(Global, "ConnectorDispatch")
        v2914.isDebug = true
    end
    GMHelper.closeConnectorLog = function(v2916)
        local v2917 = T(Global, "ConnectorCenter")
        v2917.isDebug = false
        local v2919 = T(Global, "ConnectorDispatch")
        v2919.isDebug = false
    end
    GMHelper.sendTestConnectorMsg = function(v2921, v2922)
        local v2923 = {}
        v2923.a = 1
        v2923.b = 2
        local v2926 = T(Global, "ConnectorCenter")
        v2926:sendMsg(v2922, v2923)
    end
    GMHelper.SetEnabledRenderFrameTimer = function(v2927, v2928)
        PerformanceStatistics.SetEnabledRenderFrameTimer(v2928)
        GUIGMControlPanel:hide()
    end
    GMHelper.updateAllShaders = function(v2929)
        Blockman.Instance().m_gameSettings:updateAllShaders()
        GUIGMControlPanel:hide()
    end
    GMHelper.setNeedMonitorShader = function(v2930)
        Blockman.Instance().m_gameSettings:setNeedMonitorShader(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setDrawCallDisabled = function(v2931)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setDrawCallDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setMinimumGeometry = function(v2932)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setMinimumGeometry(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setColorBlendDisabled = function(v2933)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setColorBlendDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setZTestDisabled = function(v2934)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setZTestDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setZWriteDisabled = function(v2935)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setZWriteDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.jeba = function(v2936)
        local v2937 = {4294901760, 4294934528, 4294967040, 4278255360, 4278255615, 4278190335, 4286578943}
        local v2938 = 1
        local v2939 = "Credits: EternalHacker - ImNotKooper"
        local v2940 = string.len(v2939)
        local v2941 = {}
        for v3895 = 0, v2940 do
            v2941[v3895] = v2937[v2938]
            v2938 = ((v2938 < #v2937) and (v2938 + 1)) or 1
        end
        LuaTimer:scheduleTimer(
            function()
                local v3898 = ""
                for v4658 = 0, #v2941 do
                    v3898 = v3898 .. "▢" .. string.format("%X", v2941[v4658]) .. string.sub(v2939, v4658, v4658)
                end
                MsgSender.sendBottomTips(1000000, v3898, "Test")
                local v3899 = table.remove(v2941, #v2941)
                table.insert(v2941, 1, v3899)
            end,
            100,
            -1
        )
    end
    GMHelper.setUseSmallTexture = function(v2942)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallTexture(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setUseSmallViewport = function(v2943)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallViewport(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setUseSmallVBO = function(v2944)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setUseSmallVBO(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.setClearColorDisabled = function(v2945)
        PerformanceStatistics.SetEnabledRenderFrameTimer(true)
        RenderExperimentSwitch.Instance():setClearColorDisabled(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.DisableGraphicAPI = function(v2946)
        Blockman.disableGraphicAPI()
    end
    GMHelper.DisableGraphicAPIAndTestCPU = function(v2947)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetCPUTimerEnabled(true)
                PerformanceStatistics.SetGPUTimerEnabled(false)
                LuaTimer:schedule(
                    function()
                        PerformanceStatistics.PrintResults(30)
                    end,
                    5100
                )
            end,
            200
        )
    end
    GMHelper.DisableGraphicAPIAndTestGPU = function(v2948)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetCPUTimerEnabled(false)
                PerformanceStatistics.SetGPUTimerEnabled(true)
                LuaTimer:schedule(
                    function()
                        PerformanceStatistics.PrintResults(30)
                    end,
                    5100
                )
            end,
            200
        )
    end
    GMHelper.DisableGraphicAPIAndDrawCallTest = function(v2949)
        GUIGMControlPanel:hide()
        LuaTimer:schedule(
            function()
                Blockman.disableGraphicAPI()
                PerformanceStatistics.SetEnabledRenderFrameTimer(true)
            end,
            200
        )
    end
    GMHelper.openScreenRecord = function(v2950)
        local v2951 = {"Main-PoleControl-Move", "Main-PoleControl", "Main-FlyingControls", "Main-Fly"}
        local v2952 = GUISystem.Instance():GetRootWindow()
        v2952:SetXPosition({0, 10000})
        local v2953 = GUIManager:getWindowByName("Main")
        local v2954 = v2953:GetChildCount()
        for v3900 = 1, v2954 do
            local v3901 = v2953:GetChildByIndex(v3900 - 1)
            local v3902 = v3901:GetName()
            if not TableUtil.tableContain(v2951, v3902) then
                v3901:SetXPosition({0, 10000})
                v3901:SetYPosition({0, 10000})
            end
        end
        ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
        ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)
        GUIManager:getWindowByName("Main-Fly"):SetProperty("NormalImage", "")
        GUIManager:getWindowByName("Main-Fly"):SetProperty("PushedImage", "")
        GUIManager:getWindowByName("Main-PoleControl-BG"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-PoleControl-Center"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Up"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Drop"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Down"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Break-Block-Progress-Nor"):SetProperty("ImageName", "")
        GUIManager:getWindowByName("Main-Break-Block-Progress-Pre"):SetProperty("ImageName", "")
        v2953:SetXPosition({0, -10000})
        ClientHelper.putBoolPrefs("RenderHeadText", false)
        PlayerManager:getClientPlayer().Player:setActorInvisible(true)
    end
    GMHelper.changeLuaHotUpdate = function(v2955, v2956)
        startLuaHotUpdate()
        HU.CanUpdate = v2956
    end
    GMHelper.changeOpenEventDialog = function(v2958, v2959)
        GUIGMMain:changeOpenEventDialog(v2959)
    end
    GMHelper.showUserRegion = function(v2960)
        UIHelper.showToast("游戏大区=" .. Game:getRegionId() .. "   玩家区域=" .. Game:getUserRegion())
    end
    GMHelper.setOutputUIName = function(v2961, v2962)
        GUISystem.Instance():SetOutputUIName(not GUISystem.Instance():IsOutputUIName())
        v2962:SetText("打印UI(" .. ((GUISystem.Instance():IsOutputUIName() and "开)") or "关)"))
    end
    GMHelper.telnetClient = function(v2963)
        if not Platform.isWindow() then
            return
        end
        local v2964 = require("misc")
        local v2965 = require("engine_base.debug.DebugPort")
        v2964.win_exec("telnet.exe", "127.0.0.1 " .. v2965.port, nil, nil, true)
    end
    GMHelper.telnetServer = function(v2966)
        if not Platform.isWindow() then
            return
        end
        local v2967 = require("misc")
        local v2968 = require("engine_base.debug.DebugPort")
        v2967.win_exec("telnet.exe", "127.0.0.1 " .. v2968.port, 1, 1, true)
    end
    GMHelper.setGlobalShowText = function(v2969)
        Root.Instance():setShowText(not Root.Instance():isShowText())
    end
    GMHelper.copyClientLog = function(v2970)
        if Platform.isWindow() then
            return
        end
        local v2971 = Root.Instance():getWriteablePath() .. "client.log"
        local v2972 = io.open(v2971, "r")
        if not v2972 then
            return
        end
        local v2973 = v2972:read("*a")
        v2972:close()
        ClientHelper.onSetClipboard(v2973)
        UIHelper.showToast("拷贝成功，请粘贴到钉钉上自动生成文件发送到群里")
    end
    GMHelper.sendConnectorChatMsg = function(v2974, v2975)
        if (isClient or isStaging) then
            local v4659 = T(Global, "ChatService")
            for v4925 = 1, v2975 do
                v4659:sendMsgToLangGroup(Define.ChatMsgType.TextMsg, {content = "Test:" .. v4925})
            end
        end
    end
    GMHelper.queryBoolKey = function(v2976)
        GMHelper:openInput(
            {""},
            function(v3903)
                CustomDialog.builder().setContentText(v3903 .. "=" .. tostring(ClientHelper.getBoolForKey(v3903))).setHideLeftButton(

                ).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.queryStringKey = function(v2977)
        GMHelper:openInput(
            {""},
            function(v3904)
                CustomDialog.builder().setContentText(v3904 .. "=" .. ClientHelper.getStringForKey(v3904)).setHideLeftButton(

                ).setRightText("复制到粘贴板").setRightClickListener(
                    function()
                        ClientHelper.onSetClipboard(ClientHelper.getStringForKey(v3904))
                        UIHelper.showToast("复制成功")
                    end
                ).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.makeGmButtonTran = function(v2978)
        GUIGMMain:setTransparent()
    end
    GMHelper.setRenderMainScreenSeparate = function(v2979, v2980)
        Root.Instance():setRenderMainScreenSeparate(v2980)
    end
    GMHelper.setEnableMergeBlock = function(v2981, v2982)
        Root.Instance():setEnableMergeBlock(true)
        UIHelper.showToast("1")
    end
    GMHelper.AnvilToObj = function(v2983)
        local v2984 = VectorUtil.newVector3()
        local v2985 = 32
        AnvilToObj.doTranslate(v2984, v2985)
    end
    GMHelper.inTheAirCheat = function(v2986)
        LuaTimer:scheduleTimer(
            function()
                local v3905 = VectorUtil.newVector3(0, 3, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3905)
            end,
            5,
            20
        )
    end
    GMHelper.inTheAirCheatMinus = function(v2987)
        LuaTimer:scheduleTimer(
            function()
                local v3906 = VectorUtil.newVector3(0, -3, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3906)
            end,
            5,
            20
        )
    end
    GMHelper.GoTO10BlocksDown = function(v2988)
        LuaTimer:scheduleTimer(
            function()
                local v3907 = VectorUtil.newVector3(0, 0, 1)
                PlayerManager:getClientPlayer().Player:moveEntity(v3907)
            end,
            5,
            20
        )
    end
    GMHelper.GoTO10Blocks = function(v2989)
        LuaTimer:scheduleTimer(
            function()
                local v3908 = VectorUtil.newVector3(1, 0, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3908)
            end,
            5,
            20
        )
    end
    GMHelper.testModiyScript = function(v2990)
        ClientHttpRequest.reportScriptModifyCheat()
    end
    GMHelper.setShowGunFlameCoordinate = function(v2991, v2992)
        Blockman.Instance():setShowGunFlameCoordinate(v2992)
        if v2992 then
            GUIGMControlPanel:setBackgroundColor(Color.TRANS)
        else
            GUIGMControlPanel:setBackgroundColor({0, 0, 0, 0.784314})
        end
    end
    GMHelper.changeGunFlameParam = function(v2993, v2994, v2995)
        ClientHelper.putFloatPrefs(v2994, ClientHelper.getFloatPrefs(v2994) + v2995)
    end
    GMHelper.copyShowGunFlameParam = function(v2996, v2997)
        local v2998 = ClientHelper.getFloatPrefs("GunFlameFrontOff" .. v2997)
        local v2999 = ClientHelper.getFloatPrefs("GunFlameRightOff" .. v2997)
        local v3000 = ClientHelper.getFloatPrefs("GunFlameDownOff" .. v2997)
        local v3001 = ClientHelper.getFloatPrefs("GunFlameScale" .. v2997)
        v2998 = math.floor(v2998 * 100) / 100
        v2999 = math.floor(v2999 * 100) / 100
        v3000 = math.floor(v3000 * 100) / 100
        v3001 = math.floor(v3001 * 100) / 100
        local v3002 = v2998 .. "#" .. v2999 .. "#" .. v3000 .. "#" .. v3001
        ClientHelper.onSetClipboard(v3002)
        UIHelper.showToast("拷贝成功")
    end
    GMHelper.testinValidEffect = function(v3003)
        local v3004 = "01_face_boy.mesh"
        local v3005 = VectorUtil.newVector3(100, 10, 100)
        WorldEffectManager.Instance():addSimpleEffect(v3004, v3005, 1, 1, 1, 1, 1)
        UIHelper.showToast("测试 非法 特效 完成")
    end
    GMHelper.outputItemLangFile = function(v3006)
        if not isClient then
            return
        end
        local v3007 = {}
        for v3909 = 1, 6000 do
            local v3910 = Item.getItemById(v3909)
            if v3910 then
                local v4926 = Lang:getItemName(v3909, 0)
                if (v4926 == "") then
                    v4926 = v3910:getUnlocalizedName()
                end
                v3007[tostring(v3909)] = v4926
            end
        end
        local v3008 = io.open(GameType .. "_item_name.json", "w")
        v3008:write(json.encode(v3007))
        v3008:close()
    end
    GMHelper.MyLoveFly = function(v3009, v3010)
        A = not A
        ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
        if A then
            UIHelper.showToast("^00FF00FLy ON")
            return
        end
        ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
        UIHelper.showToast("^FF0000FLy OFF")
    end
    GMHelper.GUISkyblockTest1 = function(v3011)
        UIHelper.showGameGUILayout("GUIChristmas", 1)
        GUIGMControlPanel:hide()
    end
    GMHelper.GUISkyblockTest2 = function(v3012)
        UIHelper.showGameGUILayout("GUIGameTool")
        GUIGMControlPanel:hide()
    end
    GMHelper.GUISkyblockTest3 = function(v3013)
        UIHelper.showGameGUILayout("GUIRewardDetail", v3013.rewardId)
        GUIGMControlPanel:hide()
    end
    GMHelper.Reach = function(v3014)
        A = not A
        ClientHelper.putFloatPrefs("BlockReachDistance", 1000000)
        ClientHelper.putFloatPrefs("EntityReachDistance", 1000)
        if A then
            UIHelper.showToast("^00FF00REACH ON")
            return
        end
        ClientHelper.putFloatPrefs("BlockReachDistance", 10)
        ClientHelper.putFloatPrefs("EntityReachDistance", 10)
        UIHelper.showToast("^00FF00REACH OFF")
    end
    GMHelper.ViewBobbing = function(v3015)
        A = not A
        ClientHelper.putBoolPrefs("IsViewBobbing", false)
        if A then
            UIHelper.showToast("^FF0000ViewBobbing: OFF")
            return
        end
        ClientHelper.putBoolPrefs("IsViewBobbing", true)
        UIHelper.showToast("^00FF00ViewBobbing: ON")
    end
    GMHelper.BlockmanCollision = function(v3016)
        A = not A
        ClientHelper.putBoolPrefs("IsCreatureCollision", true)
        ClientHelper.putBoolPrefs("IsBlockmanCollision", true)
        if A then
            UIHelper.showToast("^00FF00BlockmanCollision: ON")
            return
        end
        ClientHelper.putBoolPrefs("IsBlockmanCollision", false)
        UIHelper.showToast("^FF0000BlockmanCollision: OFF")
        ClientHelper.putBoolPrefs("IsCreatureCollision", false)
    end
    GMHelper.RenderWorld = function(v3017)
        GMHelper:openInput(
            {""},
            function(v3911)
                ClientHelper.putIntPrefs("BlockRenderDistance", v3911)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.Fog = function(v3018)
        A = not A
        ClientHelper.putBoolPrefs("DisableFog", true)
        if A then
            UIHelper.showToast("^FF0000Fog Disabled!")
            return
        end
        ClientHelper.putBoolPrefs("DisableFog", false)
        UIHelper.showToast("^00FF00Fog Enabled!")
    end
    GMHelper.WWE_Camera = function(v3019)
        A = not A
        ClientHelper.putBoolPrefs("IsSeparateCamera", true)
        if A then
            UIHelper.showToast("^00FF00SeparateCamera: Enabled")
            return
        end
        ClientHelper.putBoolPrefs("IsSeparateCamera", false)
        UIHelper.showToast("^FF0000SeparateCamera: Disabled")
    end
    GMHelper.ResetXD = function(v3020)
        ClientHelper.putStringPrefs("RunSkillName", "run")
        GUIGMControlPanel:hide()
    end
    GMHelper.ActionSet = function(v3021)
        GMHelper:openInput(
            {""},
            function(v3912)
                ClientHelper.putStringPrefs("RunSkillName", v3912)
            end
        )
    end
    GMHelper.WalkSMG = function(v3022)
        ClientHelper.putStringPrefs("RunSkillName", "smg_walk")
        GUIGMControlPanel:hide()
    end
    GMHelper.SneakXD = function(v3023)
        ClientHelper.putStringPrefs("RunSkillName", "sneak")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD = function(v3024)
        ClientHelper.putStringPrefs("RunSkillName", "sit1")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD2 = function(v3025)
        ClientHelper.putStringPrefs("RunSkillName", "sit2")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD3 = function(v3026)
        ClientHelper.putStringPrefs("RunSkillName", "sit3")
        GUIGMControlPanel:hide()
    end
    GMHelper.rideDragonXD = function(v3027)
        ClientHelper.putStringPrefs("RunSkillName", "ride_dragon")
        GUIGMControlPanel:hide()
    end
    GMHelper.SwimXD = function(v3028)
        ClientHelper.putStringPrefs("RunSkillName", "swim")
        GUIGMControlPanel:hide()
    end
    GMHelper.ArmSpeed = function(v3029)
        GMHelper:openInput(
            {""},
            function(v3913)
                ClientHelper.putIntPrefs("ArmSwingAnimationEnd", v3913)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.CameraFunct = function(v3030)
        GMHelper:openInput(
            {""},
            function(v3914)
                ClientHelper.putFloatPrefs("ThirdPersonDistance", v3914)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.CloudsOFF = function(v3031)
        ClientHelper.putBoolPrefs("DisableRenderClouds", true)
        UIHelper.showToast("^FF0000Clouds Stop")
        GUIGMControlPanel:hide()
    end
    GMHelper.BowSpeed = function(v3032)
        ClientHelper.putFloatPrefs("BowPullingSpeedMultiplier", 1000)
        ClientHelper.putFloatPrefs("BowPullingFOVMultiplier", 0)
        UIHelper.showToast("^00FF00BowSpeed:ON")
        GUIGMControlPanel:hide()
    end
    GMHelper.HeadText = function(v3033)
        A = not A
        ClientHelper.putBoolPrefs("RenderHeadText", true)
        if A then
            UIHelper.showToast("^00FF00Head text render now ON")
            return
        end
        ClientHelper.putBoolPrefs("RenderHeadText", false)
        UIHelper.showToast("^FF0000Head text render now OFF")
    end
    GMHelper.changePlayerActor = function(v3034, v3035)
        if isGameStart then
            if (v3035 == 1) then
                ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
                ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
            else
                ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
                ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
            end
        elseif (v3035 == 1) then
            ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
            ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
        else
            ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
            ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
        end
        local v3036 = PlayerManager:getPlayers()
        for v3915, v3916 in pairs(v3036) do
            if v3916.Player then
                v3916.Player.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v3916)
            end
        end
        UIHelper.showToast("^00FF00Success!")
        GUIGMControlPanel:hide()
    end
    GMHelper.BanClickCD = function(v3037, v3038)
        A = not A
        ClientHelper.putBoolPrefs("banClickCD", true)
        if A then
            UIHelper.showToast("^FF0000done, bedwars click: 0FF")
            return
        end
        ClientHelper.putBoolPrefs("banClickCD", false)
        UIHelper.showToast("^00FF00done, bedwars click: 0N")
    end
    GMHelper.ShowAllCobtrolXD = function(v3039)
        RootGuiLayout.Instance():showMainControl()
    end
    GMHelper.PersonView = function(v3040)
        GMHelper:openInput(
            {""},
            function(v3917)
                Blockman.Instance():setPersonView(v3917)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.BreakParticles = function(v3041)
        GMHelper:openInput(
            {""},
            function(v3918)
                ClientHelper.putIntPrefs("BlockDestroyEffectSize", v3918)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.JailBreakBypass = function(v3042)
        RootGuiLayout.Instance():showMainControl()
        GUIGMControlPanel:hide()
    end
    GMHelper.infbrid1 = function(v3043)
        ModuleBlockConfig.init = function(v3919)
            local v3920 = FileUtil.getGameConfigFromYml("module_block/ModuleBlock", true) or {}
            v3919.placeBlockMaxDepth = v3920.placeBlockMaxDepth or 2
            v3919.placeBlockMaxBuildDistance = 99999999999
            v3919.buildRoadModeMaxDistance = 9999999999999
            if isClient then
                ClientHelper.putIntPrefs("RunLimitCheck", v3920.limitBlockCheckRun or 10)
                ClientHelper.putIntPrefs("SprintLimitCheck", v3920.limitBlockCheckSprint or 10)
            end
            v3920 = FileUtil.getGameConfigFromCsv("module_block/ModuleBlock.csv", 2, true, true) or {}
            for v4660, v4661 in pairs(v3920) do
                local v4662 = {
                    id = tonumber(v4661.id),
                    itemId = tonumber(v4661.itemId),
                    teamId = tonumber(v4661.teamId) or 0,
                    consumeNum = tonumber(v4661.consumeNum) or 1,
                    schematic = v4661.schematic,
                    offsetX = tonumber(v4661.offsetX) or 0,
                    offsetZ = tonumber(v4661.offsetZ) or 0,
                    image = v4661.image,
                    extraParam = tonumber(v4661.extraParam) or 0
                }
                v8[v4662.itemId] = v8[v4662.itemId] or {}
                table.insert(v8[v4662.itemId], v4662)
            end
            for v4664, v4665 in pairs(v8) do
                table.sort(
                    v4665,
                    function(v4929, v4930)
                        return v4929.id < v4930.id
                    end
                )
            end
        end
        ModuleBlockConfig.getModuleBlock = function(v3924, v3925, v3926, v3927)
            local v3928 = v8[v3925]
            if not v3928 then
                return nil
            end
            if (v3926 and (v3926 ~= 0)) then
                for v5087, v5088 in pairs(v3928) do
                    if (v5088.id == v3926) then
                        return v5088
                    end
                end
            end
            for v4666, v4667 in pairs(v3928) do
                if (v4667.teamId == v3927) then
                    return v4667
                end
            end
            if (v3927 == 0) then
                return nil
            else
                return v3924:getModuleBlock(v3925, v3926, 0)
            end
        end
        ModuleBlockConfig.getModuleBlocks = function(v3929, v3930)
            return v8[v3930]
        end
        ModuleBlockConfig.getDefaultModuleId = function(v3931, v3932)
            local v3933 = v8[v3932]
            if TableUtil.isEmpty(v3933) then
                return 0
            end
            return v3933[1].id
        end
        ModuleBlockConfig.hasConfig = function(v3934)
            return not TableUtil.isEmpty(v8)
        end
        ModuleBlockConfig:init()
        UIHelper.showToast("^00FF00ON")
        GUIGMControlPanel:hide()
    end
    GMHelper.SpeedLineMode = function(v3049)
        local v3050 = 1
        local v3051 = 0.01
        Blockman.Instance().m_gameSettings:setPatternSpeedLine(v3050, v3051)
        UIHelper.showToast("^00FF00Speed Line = Enable!")
        GUIGMControlPanel:hide()
    end
    GMHelper.SpeedLineModeDisable = function(v3052)
        local v3053 = 0
        local v3054 = 0
        Blockman.Instance().m_gameSettings:setPatternSpeedLine(v3053, v3054)
        UIHelper.showToast("^FF0000Speed Line = Disabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.PatternTorchMode = function(v3055)
        local v3056 = 1
        Blockman.Instance().m_gameSettings:setPatternTorchStrength(v3056)
        UIHelper.showToast("^00FF00PatternTorch = Enabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.PatternTorchModeOFF = function(v3057)
        local v3058 = 0
        Blockman.Instance().m_gameSettings:setPatternTorchStrength(v3058)
        UIHelper.showToast("^FF0000PatternTorch = Disabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.CameraFlipModeRESET = function(v3059)
        Blockman.Instance().m_gameSettings:setFovSetting(1)
        GUIGMControlPanel:hide()
    end
    GMHelper.CameraFlipModeON = function(v3060)
        Blockman.Instance().m_gameSettings:setFovSetting(90)
        GUIGMControlPanel:hide()
    end
    GMHelper.Iikj = function(v3061, v3062)
        local v3063 = v3062:getPosition()
        v3063.y = v3063.y + 0.5
        local v3065 = v3062:getYaw()
        v3062:teleportPosWithYaw(v3063, v3065)
        GUIGMControlPanel:hide()
    end
    GMHelper.GUItest1 = function(v3066)
        MsgSender.sendMsg(10007, "IikjLol")
        MsgSender.sendMsg(10006, "IikjLol")
        MsgSender.sendMsg(10005, "IikjLol")
        MsgSender.sendMsg(10004, "IikjLol")
        MsgSender.sendMsg(10003, "IikjLol")
        MsgSender.sendMsg(10002, "IikjLol")
        MsgSender.sendMsg(10001, "IikjLol")
        MsgSender.sendMsg(10000, "IikjLol")
        MsgSender.sendMsg(1, "IikjLol")
    end
    GMHelper.FustBreakBlockMode = function(v3067)
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for v3935 = 1, 40000 do
            local v3936 = BlockManager.getBlockById(v3935)
            if v3936 then
                v3936:setHardness(0)
                UIHelper.showToast("^00FF00Turned ON")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.FlyDev = function(v3068)
        GUIManager:hideWindowByName("Main.binary")
        GUIManager:hideWindowByName("Main.json")
        GUIGMControlPanel:hide()
    end
    GMHelper.HideHP = function(v3069)
        GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(false)
    end
    GMHelper.ShowHP = function(v3070)
        GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
    end
    GMHelper.FlyDev2 = function(v3071)
        for v3937 = 1, 40000 do
            local v3938 = BlockManager.getBlockById(v3937)
            if v3938 then
                Blockman.Instance():setBloomEnable(true)
                Blockman.Instance():enableFullscreenBloom(true)
                Blockman.Instance():setBlockBloomOption(100)
                Blockman.Instance():setBloomIntensity(100)
                Blockman.Instance():setBloomSaturation(100)
                Blockman.Instance():setBloomThreshold(100)
                UIHelper.showToast("^00FF00Speed Break Block = 0")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.FlyDev3 = function(v3072)
        GUIManager:showWindowByName("PlayerInventory-DesignationTab")
        GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetVisible(true)
        GUIManager:showWindowByName("PlayerInventory-MainInventoryTab")
        GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetVisible(true)
        GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetArea({1, 1}, {1, 0}, {0, 1}, {0, 1})
        GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetArea({0, 0}, {0, 0}, {0.3, 0}, {0.3, 0})
        GUIManager:getWindowByName("PlayerInventory-ToggleInventoryButton"):SetVisible(true)
        GUIManager:showWindowByName("PlayerInventory-ToggleInventoryButton")
        GUIGMControlPanel:hide()
    end
    GMHelper.Freecam = function(v3073)
        GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.TntTag = function(v3074)
        GUIManager:showWindowByName("Main-throwpot-Controls")
        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.SetBobbing = function(v3075)
        GMHelper:openInput(
            {""},
            function(v3939)
                ClientHelper.putFloatPrefs("PlayerBobbingScale", v3939)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.test200 = function(v3076)
        MsgSender.sendMsg(Messages:gameResetTimeHint())
        GUIGMControlPanel:hide()
    end
    GMHelper.test600 = function(v3077)
        local v3078 = PlayerManager:getPlayers()
        for v3940, v3941 in pairs(v3078) do
            if v3941.Player then
                v3941.Player.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v3941)
            end
        end
        UIHelper.showToast("^00FF00yes")
        GUIGMControlPanel:hide()
    end
    GMHelper.JustClick = function(v3079)
        LuaTimer:scheduleTimer(
            function()
                local v3942 = VectorUtil.newVector3(0, 30, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3942)
            end,
            5,
            2e+35
        )
    end
    GMHelper.JustClick2 = function(v3080)
        LuaTimer:scheduleTimer(
            function()
                local v3943 = VectorUtil.newVector3(0, 300, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3943)
            end,
            5,
            2e+35
        )
    end
    GMHelper.OffChat = function(v3081)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
    end
    GMHelper.OnChat = function(v3082)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
    end
    GMHelper.Noclip = function(v3083)
        A = not A
        for v3944 = 1, 40000 do
            local v3945 = BlockManager.getBlockById(v3944)
            if v3945 then
                v3945:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Noclip = true")
            return
        end
        for v3946 = 1, 40000 do
            local v3947 = BlockManager.getBlockById(v3946)
            if v3947 then
                v3947:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Noclip = false")
    end
    GMHelper.NoclipOP = function(v3084)
        A = not A
        for v3948 = 3, 133 do
            local v3949 = BlockManager.getBlockById(v3948)
            if v3949 then
                v3949:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00TreasureHunterNoClip = Enabled")
            return
        end
        for v3950 = 3, 133 do
            local v3951 = BlockManager.getBlockById(v3950)
            if v3951 then
                v3951:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000TreasureHunterNoClip = Disabled")
    end
    GMHelper.NoObsidian1 = function(v3085)
        A = not A
        for v3952 = 49, 50 do
            local v3953 = BlockManager.getBlockById(v3952)
            if v3953 then
                v3953:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3954 = 49, 50 do
            local v3955 = BlockManager.getBlockById(v3954)
            if v3955 then
                v3955:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoOakPlanks1 = function(v3086)
        A = not A
        for v3956 = 5, 6 do
            local v3957 = BlockManager.getBlockById(v3956)
            if v3957 then
                v3957:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3958 = 5, 6 do
            local v3959 = BlockManager.getBlockById(v3958)
            if v3959 then
                v3959:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoGlass1 = function(v3087)
        A = not A
        for v3960 = 94, 95 do
            local v3961 = BlockManager.getBlockById(v3960)
            if v3961 then
                v3961:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3962 = 94, 95 do
            local v3963 = BlockManager.getBlockById(v3962)
            if v3963 then
                v3963:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoEndStone1 = function(v3088)
        A = not A
        for v3964 = 120, 121 do
            local v3965 = BlockManager.getBlockById(v3964)
            if v3965 then
                v3965:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3966 = 120, 121 do
            local v3967 = BlockManager.getBlockById(v3966)
            if v3967 then
                v3967:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoWool1 = function(v3089)
        A = not A
        for v3968 = 1441, 1444 do
            local v3969 = BlockManager.getBlockById(v3968)
            if v3969 then
                v3969:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3970 = 1441, 1444 do
            local v3971 = BlockManager.getBlockById(v3970)
            if v3971 then
                v3971:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoBomb1 = function(v3090)
        A = not A
        for v3972 = 593, 594 do
            local v3973 = BlockManager.getBlockById(v3972)
            if v3973 then
                v3973:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3974 = 593, 594 do
            local v3975 = BlockManager.getBlockById(v3974)
            if v3975 then
                v3975:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoIDoor1 = function(v3091)
        A = not A
        for v3976 = 241, 242 do
            local v3977 = BlockManager.getBlockById(v3976)
            if v3977 then
                v3977:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3978 = 241, 242 do
            local v3979 = BlockManager.getBlockById(v3978)
            if v3979 then
                v3979:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.NoQuartz1 = function(v3092)
        A = not A
        for v3980 = 155, 156 do
            local v3981 = BlockManager.getBlockById(v3980)
            if v3981 then
                v3981:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v3982 = 155, 156 do
            local v3983 = BlockManager.getBlockById(v3982)
            if v3983 then
                v3983:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^FF0000Disabled")
    end
    GMHelper.JumpHeight = function(v3093)
        GMHelper:openInput(
            {""},
            function(v3984)
                local v3985 = PlayerManager:getClientPlayer()
                if (v3985 and v3985.Player) then
                    v3985.Player:setFloatProperty("JumpHeight", v3984)
                    UIHelper.showToast("^00FF00Success")
                end
            end
        )
    end
    GMHelper.addCurrencyCustom = function(v3094, v3095)
        GMHelper:openInput(
            v3095,
            {"100"},
            function(v3986)
                v3986 = tonumber(v3986) or 0
                v3095:addCurrency(v3986, "GM")
            end
        )
    end
    GMHelper.GUIOpener = function(v3096)
        GMHelper:openInput(
            {".json"},
            function(v3987)
                GUIManager:showWindowByName(v3987)
            end
        )
    end
    GMHelper.GUIViewOFF = function(v3097)
        GMHelper:openInput(
            {".json"},
            function(v3988)
                GUIManager:hideWindowByName(v3988)
            end
        )
    end
    GMHelper.InsideGUI = function(v3098)
        GMHelper:openInput(
            {"", ""},
            function(v3989, v3990)
                GUIManager:getWindowByName(v3989):SetVisible(v3990)
            end
        )
    end
    GMHelper.ChangeNick = function(v3099)
        GMHelper:openInput(
            {""},
            function(v3991)
                PlayerManager:getClientPlayer().Player:setShowName(v3991)
                UIHelper.showToast("^FF00EENickNameChanged")
            end
        )
    end
    GMHelper.LongJump = function(v3100)
        LuaTimer:scheduleTimer(
            function()
                PlayerManager:getClientPlayer().Player:setGlide(true)
            end,
            0.2,
            9e+23
        )
    end
    GMHelper.AdvancedUp = function(v3101)
        GMHelper:openInput(
            {""},
            function(v3992)
                local v3993 = VectorUtil.newVector3(0, v3992, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3993)
            end
        )
    end
    GMHelper.AdvancedIn = function(v3102)
        GMHelper:openInput(
            {""},
            function(v3994)
                local v3995 = VectorUtil.newVector3(v3994, 0, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v3995)
            end
        )
    end
    GMHelper.AdvancedOn = function(v3103)
        GMHelper:openInput(
            {""},
            function(v3996)
                local v3997 = VectorUtil.newVector3(0, 0, v3996)
                PlayerManager:getClientPlayer().Player:moveEntity(v3997)
            end
        )
    end
    GMHelper.AdvancedDirect = function(v3104)
        GMHelper:openInput(
            {"", "", ""},
            function(v3998, v3999, v4000)
                local v4001 = VectorUtil.newVector3(v3998, v3999, v4000)
                PlayerManager:getClientPlayer().Player:moveEntity(v4001)
            end
        )
    end
    GMHelper.tpPos = function(v3105)
        GMHelper:openInput(
            {"", "", ""},
            function(v4002, v4003, v4004)
                local v4005 = VectorUtil.newVector3(v4002, v4003, v4004)
                local v4006 = VectorUtil.newVector3(1, 10, 1)
                PlayerManager:getClientPlayer().Player:setPosition(v4005)
                PlayerManager:getClientPlayer().Player:moveEntity(v4006)
            end
        )
    end
    GMHelper.HideHoldItem = function(v3106)
        A = not A
        PlayerManager:getClientPlayer():setHideHoldItem(true)
        UIHelper.showToast("^FF00EETrue")
        if A then
            PlayerManager:getClientPlayer():setHideHoldItem(false)
            UIHelper.showToast("^FF00EEFalse")
        end
    end
    GMHelper.DevFlyI = function(v3107)
        local v3108 = VectorUtil.newVector3(0, 1.35, 0)
        local v3109 = PlayerManager:getClientPlayer()
        v3109.Player:setAllowFlying(true)
        v3109.Player:setFlying(true)
        v3109.Player:moveEntity(v3108)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.SharpFly = function(v3110)
        A = not A
        ClientHelper.putBoolPrefs("DisableInertialFly", true)
        UIHelper.showToast("^FF00EE[ON] works when you have dev flight enabled")
        if A then
            ClientHelper.putBoolPrefs("DisableInertialFly", false)
            UIHelper.showToast("^FF00EE[OFF] works when you have dev flight enabled")
        end
    end
    GMHelper.WaterPush = function(v3111)
        A = not A
        local v3112 = PlayerManager:getClientPlayer().Player
        v3112:setBoolProperty("ignoreWaterPush", true)
        UIHelper.showToast("^FF00EEON")
        if A then
            v3112:setBoolProperty("ignoreWaterPush", false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.changeScale = function(v3113)
        GMHelper:openInput(
            {""},
            function(v4007)
                local v4008 = PlayerManager:getClientPlayer().Player
                v4008:setScale(v4007)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.BlockOFF = function(v3114)
        GMHelper:openInput(
            {""},
            function(v4009)
                local v4010 = v4009
                local v4011 = BlockManager.getBlockById(v4010)
                v4011:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        )
    end
    GMHelper.BlockON = function(v3115)
        GMHelper:openInput(
            {""},
            function(v4012)
                local v4013 = v4012
                local v4014 = BlockManager.getBlockById(v4013)
                v4014:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        )
    end
    GMHelper.SpeedManager = function(v3116)
        GMHelper:openInput(
            {""},
            function(v4015)
                PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(v4015)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SpeedUp = function(v3117)
        ClientHelper.putIntPrefs("SpeedAddMax", 20000000)
        UIHelper.showToast("^FF0000[DANGER]")
    end
    GMHelper.XRayManagerON = function(v3118)
        GMHelper:openInput(
            {"erase this text and write block id"},
            function(v4016)
                cBlockManager.cGetBlockById(v4016):setNeedRender(false)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.XRayManagerOFF = function(v3119)
        GMHelper:openInput(
            {"erase this text and write block id"},
            function(v4017)
                cBlockManager.cGetBlockById(v4017):setNeedRender(true)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.OFFDARK = function(v3120)
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for v4018 = 1, 40000 do
            local v4019 = BlockManager.getBlockById(v4018)
            if v4019 then
                v4019:setLightValue(150, 150, 150)
                UIHelper.showToast("^00FF00Success")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.SpawnNPC = function(v3121)
        GMHelper:openInput(
            {".actor"},
            function(v4020)
                local v4021 = PlayerManager:getClientPlayer():getPosition()
                local v4022 = PlayerManager:getClientPlayer():getYaw()
                EngineWorld:addActorNpc(
                    v4021,
                    v4022,
                    v4020,
                    function(v4668)
                    end
                )
            end
        )
    end
    GMHelper.spawnCar = function(v3122)
        GMHelper:openInput(
            {"Car ID (erase this text and write carID)"},
            function(v4023)
                local v4024 = PlayerManager:getClientPlayer():getPosition()
                Blockman.Instance():getWorld():addVehicle(v4024, v4023, 5)
                UIHelper.showToast("^00FFEECar Spawn Success")
            end
        )
    end
    GMHelper.TeleportByUID = function(v3123)
        GMHelper:openInput(
            {"id player"},
            function(v4025)
                local v4026 = PlayerManager:getClientPlayer().Player
                local v4027 = PlayerManager:getPlayerByUserId(v4025)
                if v4027 then
                    v4026:setPosition(v4027:getPosition())
                end
            end
        )
    end
    GMHelper.ChangeActorForMe = function(v3124)
        local v3125 = PlayerManager:getClientPlayer().Player
        GMHelper:openInput(
            {".actor"},
            function(v4028)
                Blockman.Instance():getWorld():changePlayerActor(v3125, v4028)
                Blockman.Instance():getWorld():changePlayerActor(v3125, v4028)
                v3125.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v3125)
                UIHelper.showToast("^00FFEESuccess")
            end
        )
    end
    GMHelper.AFKmode = function(v3126)
        A = not A
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1
        UIHelper.showToast("^FF00EEStart")
        if A then
            PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
            UIHelper.showToast("^FF00EEStop")
        end
    end
    GMHelper.DevnoClip = function(v3128)
        A = not A
        PlayerManager:getClientPlayer().Player.noClip = true
        UIHelper.showToast("^FF00EETurned on")
        if A then
            PlayerManager:getClientPlayer().Player.noClip = false
            UIHelper.showToast("^FF00EETurned off")
        end
    end
    GMHelper.StepHeight = function(v3130)
        GMHelper:openInput(
            {"StepHeight Value"},
            function(v4030)
                PlayerManager:getClientPlayer().Player.stepHeight = v4030
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SpYaw = function(v3131)
        A = not A
        PlayerManager:getClientPlayer().Player.spYaw = true
        UIHelper.showToast("^FF00EEON")
        if A then
            PlayerManager:getClientPlayer().Player.spYaw = false
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.SpYawSet = function(v3133)
        GMHelper:openInput(
            {""},
            function(v4032)
                PlayerManager:getClientPlayer().Player.spYawRadian = v4032
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.HairSet = function(v3134)
        GMHelper:openInput(
            {""},
            function(v4034)
                PlayerManager:getClientPlayer().Player.m_isEquipWing = true
                PlayerManager:getClientPlayer().Player.m_isClothesChange = true
                PlayerManager:getClientPlayer().Player.m_isClothesChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SetHideAndShowArmor = function(v3135)
        A = not A
        LogicSetting.Instance():setHideArmor(true)
        UIHelper.showToast("^FF00EEON")
        if A then
            LogicSetting.Instance():setHideArmor(false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.SettingLongjump = function(v3136)
        GMHelper:openInput(
            {"speedglide", "drop resistance"},
            function(v4038, v4039)
                local v4040 = PlayerManager:getClientPlayer().Player
                v4040.m_isGlide = true
                v4040.m_glideMoveAddition = v4038
                v4040.m_glideDropResistance = v4039
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SetAlpha = function(v3137)
        GMHelper:openInput(
            {"Gui name", "alpha"},
            function(v4044, v4045)
                GUIManager:getWindowByName(v4044):SetAlpha(v4045)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeHair = function(v3138)
        GMHelper:openInput(
            {"number"},
            function(v4046)
                local v4047 = PlayerManager:getClientPlayer().Player
                v4047.m_outLooksChanged = true
                v4047.m_hairID = v4046
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeFace = function(v3139)
        GMHelper:openInput(
            {"number"},
            function(v4050)
                local v4051 = PlayerManager:getClientPlayer().Player
                v4051.m_outLooksChanged = true
                v4051.m_faceID = v4050
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeTops = function(v3140)
        GMHelper:openInput(
            {"number"},
            function(v4054)
                local v4055 = PlayerManager:getClientPlayer().Player
                v4055.m_outLooksChanged = true
                v4055.m_topsID = v4054
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangePants = function(v3141)
        GMHelper:openInput(
            {"number"},
            function(v4058)
                local v4059 = PlayerManager:getClientPlayer().Player
                v4059.m_outLooksChanged = true
                v4059.m_pantsID = v4058
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeShoes = function(v3142)
        GMHelper:openInput(
            {"number"},
            function(v4062)
                local v4063 = PlayerManager:getClientPlayer().Player
                v4063.m_outLooksChanged = true
                v4063.m_shoesID = v4062
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeGlasses = function(v3143)
        GMHelper:openInput(
            {"number"},
            function(v4066)
                local v4067 = PlayerManager:getClientPlayer().Player
                v4067.m_outLooksChanged = true
                v4067.m_glassesId = v4066
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeScarf = function(v3144)
        GMHelper:openInput(
            {"number"},
            function(v4070)
                local v4071 = PlayerManager:getClientPlayer().Player
                v4071.m_outLooksChanged = true
                v4071.m_scarfId = v4070
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeWing = function(v3145)
        GMHelper:openInput(
            {"number"},
            function(v4074)
                local v4075 = PlayerManager:getClientPlayer().Player
                v4075.m_outLooksChanged = true
                v4075.m_wingId = v4074
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeHat = function(v3146)
        GMHelper:openInput(
            {"number"},
            function(v4078)
                PlayerManager:getClientPlayer().Player.m_hatId = v4078
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeDecHat = function(v3147)
        GMHelper:openInput(
            {"number"},
            function(v4081)
                PlayerManager:getClientPlayer().Player.m_decorate_hatId = v4081
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeTail = function(v3148)
        GMHelper:openInput(
            {"number"},
            function(v4084)
                PlayerManager:getClientPlayer().Player.m_tailId = v4084
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeBagI = function(v3149)
        GMHelper:openInput(
            {"number"},
            function(v4087)
                PlayerManager:getClientPlayer().Player.m_bagId = v4087
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeCrown = function(v3150)
        GMHelper:openInput(
            {""},
            function(v4090)
                PlayerManager:getClientPlayer().Player.m_crownId = v4090
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.CreateGUIDEArrow = function(v3151)
        local v3152 = PlayerManager:getClientPlayer():getPosition()
        PlayerManager:getClientPlayer().Player:addGuideArrow(v3152)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.DelAllGUIDEArrow = function(v3153)
        PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.JetPack = function(v3154)
        A = not A
        PlayerManager:getClientPlayer().Player.m_keepJumping = false
        UIHelper.showToast("^FF00EEВключено")
        if A then
            PlayerManager:getClientPlayer().Player.m_keepJumping = true
            UIHelper.showToast("^FF00EEВыключено")
        end
    end
    GMHelper.SetUpBuild = function(v3156)
        GMHelper:openInput(
            {""},
            function(v4093)
                ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v4093)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.EasyWay = function(v3157)
        local v3158 = PlayerManager:getClientPlayer():getInventory()
        v3158:removeAllItemFromHotBar()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.WatchMode = function(v3159)
        A = not A
        local v3160 = VectorUtil.newVector3(0, 1.35, 0)
        PlayerManager:getClientPlayer().Player:setAllowFlying(true)
        PlayerManager:getClientPlayer().Player:setFlying(true)
        PlayerManager:getClientPlayer().Player:setWatchMode(true)
        PlayerManager:getClientPlayer().Player:moveEntity(v3160)
        UIHelper.showToast("^FF00EEON")
        if A then
            PlayerManager:getClientPlayer().Player:setAllowFlying(false)
            PlayerManager:getClientPlayer().Player:setFlying(false)
            PlayerManager:getClientPlayer().Player:setWatchMode(false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.ShowRegion = function(v3161)
        UIHelper.showToast("RegionID=" .. Game:getRegionId())
    end
    GMHelper.GameID = function(v3162)
        UIHelper.showToast("GameID=" .. CGame.Instance():getGameType())
    end
    GMHelper.LogInfo = function(v3163)
        local v3164 = HostApi.getClientInfo()
        ClientHelper.onSetClipboard(v3164)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.GetAllInfoT = function(v3165)
        local v3166 = PlayerManager:getPlayers()
        for v4094, v4095 in pairs(v3166) do
            MsgSender.sendMsg(
                "^FF0000INFO: " ..
                    string.format(
                        "^FF0000UserName: %s {} ID: %s {} Gender: %s",
                        v4095:getName(),
                        v4095.userId,
                        v4095.Player:getSex()
                    )
            )
        end
    end
    GMHelper.test2300 = function(v3167)
        GMHelper:openInput(
            {""},
            function(v4096)
                local v4097 = PlayerManager:getClientPlayer().Player
                v4097.length = v4096
                v4097.isCollidedHorizontally = true
                v4097.isCollidedVertically = true
                v4097.isCollided = true
            end
        )
    end
    GMHelper.test1222 = function(v3168)
        local v3169 = PlayerManager:getClientPlayer().Player
        v3169.m_canBuildBlockQuickly = true
        v3169.m_quicklyBuildBlock = true
        UIHelper.showToast("2:")
    end
    GMHelper.test2222 = function(v3172)
        local v3173 = PlayerManager:getClientPlayer().Player
        v3173.m_opacity = 0.2
        UIHelper.showToast("1:")
    end
    GMHelper.spawnCar = function(v3175)
        GMHelper:openInput(
            {"Car ID (erase this text and write carID)"},
            function(v4102)
                local v4103 = PlayerManager:getClientPlayer():getPosition()
                local v4104 = PlayerManager:getClientPlayer():getYaw()
                Blockman.Instance():getWorld():addVehicle(v4103, v4102, v4104)
                UIHelper.showToast("^FF00EECar Spawn Success")
            end
        )
    end
    GMHelper.SpawnItem = function(v3176)
        GMHelper:openInput(
            {"ID", "Count"},
            function(v4105, v4106)
                local v4107 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:addEntityItem(v4105, v4106, 0, 600, v4107, VectorUtil.ZERO)
            end
        )
    end
    GMHelper.CheckUpdates = function(v3177)
        SoundUtil.playSound(1)
        local v3178 =
            "To find out if a new panel update has been released, follow the link below. \nhttps://pastebin.com/raw/k3PUuEqp\nThe link will change with each update!"
        local v3179 = "OK"
        local v3180 = "https://pastebin.com/raw/k3PUuEqp"
        local v3181 = "The link has been copied to the clipboard!"
        CustomDialog.builder().setContentText(v3178).setRightText(v3179).setHideLeftButton().setRightClickListener(
            function()
                ClientHelper.onSetClipboard(v3180)
                UIHelper.showCenterToast(v3181, 5000)
            end
        ).setLeftClickListener(
            function()
                UIHelper.showToast(scrm)
            end
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.CrashFix = function(v3182)
        local v3183 =
            "If you don't understand how to run 'bypass.lua' correctly, then read this short guide.(\n1)Launch the GameGuardian, then enter the Bedwars.\n2)As soon as you enter, select the Bedwars process and run the 'bypass.lua' script, then select the Bedwars(BlockmanGo) process and run the script again.\n3)If the gameguard writes that the game or process has been completed, i.e. closed, then you select two processes again and run the script.\n4)After exiting the mode, immediately select these two processes again and run the script(GameGuardian will tell you that they have been closed)."
        local v3184 = "OK"
        local v3185 = "How to fix crashes."
        CustomDialog.builder().setContentText(v3183).setRightText(v3184).setTitleText(v3185).setHideLeftButton().setPanelSize(
            1200,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.EnteringValues = function(v3186)
        local v3187 =
            "If you're having trouble typing a value in a function and clicking the send button, and you're just wrapping it to another line, then use a different keyboard, such as from Microsoft\n(For example, you have selected the function to change wings, written a number, but you do not send a command)"
        local v3188 = "OK"
        local v3189 = "Fix Entering Values"
        CustomDialog.builder().setContentText(v3187).setRightText(v3188).setTitleText(v3189).setHideLeftButton().setPanelSize(
            600,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.updates1_1 = function(v3190)
        local v3191 =
            "Version 1.1 added:\nSetUpBuild, ChangeHat, ChangeTail, ChangeBagI, ChangeCrown, CreateGUIDEArrow, DelAllGUIDEArrow, EasyWay, WatchMode, Blink, NoFall, TreasureReset, QuickPlaceBlock, Parachute, FlyParachute and the 'README' category.\nI'll explain some of the functions (the rest are already clear)\nSetUpBuild - function lets you put down multiple blocks at once in a certain direction. You can choose how many blocks to place and the direction they'll go.\nCreateGUIDEArrow - creates an arrow underneath you, can be used as a marker.\nWatchMode - puts you in spectator mode.\nBlink - When you activate this feature, the character will remain where you activated the function, after which you can run anywhere and deal damage to everyone (you will not be visible).\nTreasureRest - Restore the mine in the TreasureHunter.\nFlyParachute - Gives you a fly and a parachute that is visible to all players (i.e. not visual)"
        local v3192 = "OK"
        local v3193 = "What's New? (1.1)"
        CustomDialog.builder().setContentText(v3191).setRightText(v3192).setTitleText(v3193).setHideLeftButton().setPanelSize(
            1200,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.updates1_2 = function(v3194)
        local v3195 =
            "Version 1.2 added:\nRvanka, Tracer, ChangeBlockTextures, ArrowSpeedBow, Scaffold.\nI'll explain some of the functions (the rest are already clear)\nRvanka - teleports you to the nearest players, thereby you can kill them very quickly (use together with blink)\nTracer - When turned on, arrows will be attached to all players, thereby you will know where the players are(ESP)\nScaffold - visual blocks will be automatically placed under you."
        local v3196 = "OK"
        local v3197 = "What's New? (1.2)"
        CustomDialog.builder().setContentText(v3195).setRightText(v3196).setTitleText(v3197).setHideLeftButton().setPanelSize(
            1200,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.BlinkOP = function(v3198)
        A = not A
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        if A then
            UIHelper.showToast("^00FF00Blink Enabled!")
            return
        end
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        UIHelper.showToast("^FF0000Blink Disabled!")
    end
    GMHelper.NoFall = function(v3199)
        A = not A
        ClientHelper.putIntPrefs("SprintLimitCheck", 7)
        if A then
            UIHelper.showToast("Enabled")
            return
        end
        ClientHelper.putIntPrefs("SprintLimitCheck", 0)
        UIHelper.showToast("Disabled")
    end
    GMHelper.NoFallSet = function(v3200)
        GMHelper:openInput(
            {"TypeValue"},
            function(v4108)
                ClientHelper.putIntPrefs("SprintLimitCheck", v4108)
                UIHelper.showToast("Done, now it will have like a protection")
            end
        )
    end
    GMHelper.MineReset = function(v3201)
        local v3202 = VectorUtil.newVector3(536, 2.78, -136)
        local v3203 = VectorUtil.newVector3(0, 0, 0)
        PlayerManager:getClientPlayer().Player:setPosition(v3202)
        PlayerManager:getClientPlayer().Player:moveEntity(v3203)
    end
    GMHelper.quickblock = function(v3204)
        GMHelper:openInput(
            {""},
            function(v4109)
                ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v4109)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.startParachute = function(v3205)
        PlayerManager:getClientPlayer().Player:startParachute()
    end
    GMHelper.FlyParachute = function(v3206)
        local v3207 = VectorUtil.newVector3(0, 1.35, 0)
        local v3208 = PlayerManager:getClientPlayer()
        v3208.Player:setAllowFlying(true)
        v3208.Player:setFlying(true)
        v3208.Player:moveEntity(v3207)
        PlayerManager:getClientPlayer().Player:startParachute()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.SetBlockToAir = function(v3209)
        GMHelper:openInput(
            {"block Position X", "block Position Y", "block Position Z"},
            function(v4110, v4111, v4112)
                local v4113 = VectorUtil.newVector3(v4110, v4111, v4112)
                EngineWorld:setBlockToAir(v4113)
            end
        )
    end
    GMHelper.SpawnBlock = function(v3210)
        GMHelper:openInput(
            {""},
            function(v4114)
                local v4115 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:setBlock(v4115, v4114)
            end
        )
    end
    GMHelper.ChangeBlockTextures = function(v3211, v3212)
        local v3213 = GMHelper.blockTextures or false
        if not v3213 then
            Blockman.Instance():changeBlockTextures("./package_02_32.zip")
            GMHelper.blockTextures = true
        else
            Blockman.Instance():changeBlockTextures("")
            GMHelper.blockTextures = false
        end
        if (#v3212 > 0) then
            Blockman.Instance():changeBlockTextures("Media/Textures/package/" .. v3212)
        else
            Blockman.Instance():changeBlockTextures("")
        end
        GUIGMControlPanel:hide()
    end
    GMHelper.updateBedWarArrowSpeed = function(v3214)
        GMHelper:openInput(
            {"speed"},
            function(v4116)
                local v4117 = tonumber(v4116) or 0
                PlayerManager:getClientPlayer().Player:setFloatProperty("ArrowSpeedScale", v4117)
                PlayerManager:getClientPlayer():sendPacket({pid = "updateBedWarArrowSpeed", scale = v4117})
            end
        )
    end
    GMHelper.Rvanka = function(v3215)
        toggle = not toggle
        key = nil
        gay = nil
        if toggle then
            UIHelper.showToast("^FF00EE[ON] by clad_men")
            key =
                LuaTimer:scheduleTimer(
                function()
                    local v4932 = _G["PlayerManager"]:getClientPlayer().Player
                    local v4933 = _G["PlayerManager"]:getPlayers()
                    for v5089, v5090 in pairs(v4933) do
                        local v5091 = MathUtil:distanceSquare2d(v5090:getPosition(), v4932:getPosition())
                        if (v5090 ~= v4932) then
                            gay =
                                _G["LuaTimer"]:scheduleTimer(
                                function()
                                    local v5246 =
                                        VectorUtil.newVector3(
                                        v5090:getPosition().x,
                                        v5090:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2)),
                                        v5090:getPosition().z
                                    )
                                    v4932:setPosition(v5246)
                                end,
                                (tonumber(tostring(1787 - _G["dumb"]), 2)),
                                (tonumber(tostring(1111101777 - _G["dumb"]), 2))
                            )
                        end
                    end
                end,
                (tonumber(tostring(1111101778 - _G["dumb"]), 2)),
                -(tonumber(tostring(778 - _G["dumb"]), 2))
            )
        else
            UIHelper.showToast("^FF00EE[OFF] by clad_men")
            LuaTimer:cancel(key)
            LuaTimer:cancel(gay)
        end
    end
    GMHelper.Tracer = function(v3216)
        UIHelper.showToast("^FF00EE [ON]")
        local v3217 = PlayerManager:getClientPlayer()
        LuaTimer:scheduleTimer(
            function()
                PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
                local v4118 = PlayerManager:getPlayers()
                for v4675, v4676 in pairs(v4118) do
                    if (v4676 ~= v3217) then
                        PlayerManager:getClientPlayer().Player:addGuideArrow(v4676:getPosition())
                    end
                end
            end,
            500,
            -1
        )
    end
    GMHelper.Scaffold = function(v3218)
        A = not A
        LuaTimer:cancel(v3218.timer)
        UIHelper.showToast("^00FF00Scaffold TurnOFF")
        if A then
            GMHelper:openInput(
                {"BlockID"},
                function(v4934)
                    v3218.timer =
                        LuaTimer:scheduleTimer(
                        function()
                            local v5092 = PlayerManager:getClientPlayer():getPosition()
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x, v5092.y - 2, v5092.z), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x - 1, v5092.y - 2, v5092.z - 1), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x + 1, v5092.y - 2, v5092.z + 1), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x, v5092.y - 2, v5092.z + 1), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x, v5092.y - 2, v5092.z - 1), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x + 1, v5092.y - 2, v5092.z), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x - 1, v5092.y - 2, v5092.z), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x - 1, v5092.y - 2, v5092.z + 1), v4934)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5092.x + 1, v5092.y - 2, v5092.z - 1), v4934)
                        end,
                        0.15,
                        -1
                    )
                    UIHelper.showToast("^00FF00Scaffold TurnON")
                end
            )
        end
    end
    GMHelper.AutoClick = function(v3219)
        A = not A
        LuaTimer:cancel(v3219.timer)
        UIHelper.showToast("^00FF00AutoClick OFF")
        if A then
            v3219.timer =
                LuaTimer:scheduleTimer(
                function()
                    CGame.Instance():handleTouchClick(800, 360)
                    UIHelper.showToast("^00FF00AutoClick ON")
                end,
                0.15,
                -1
            )
        end
    end
    GMHelper.AutoParachute = function(v3220)
        A = not A
        LuaTimer:cancel(v3220.timer)
        UIHelper.showToast("^00FF00AutoParachute OFF")
        if A then
            v3220.timer =
                LuaTimer:scheduleTimer(
                function()
                    PlayerManager:getClientPlayer().Player:startParachute()
                    UIHelper.showToast("^00FF00AutoParachute ON")
                end,
                0.15,
                -1
            )
        end
    end
    GMHelper.AFKmode = function(v3221)
        GMHelper:openInput(
            {"TypeValue"},
            function(v4119)
                PlayerManager:getClientPlayer().Player.m_rotateSpeed = v4119
                UIHelper.showToast("^FF00EEStart")
            end
        )
    end
    GMHelper.Parachute = function(v3222)
        GUIManager:getWindowByName("Main-Parachute"):SetVisible(true)
        GUIManager:getWindowByName("Main-Parachute", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                PlayerManager:getClientPlayer().Player:startParachute()
                UIHelper.showToast("Deploy a parachute successfully.")
            end
        )
    end
    GMHelper.TeleportToRandomPlayer = function(v3223)
        local v3224 = PlayerManager:getClientPlayer().Player
        local v3225 = PlayerManager:getPlayers()
        if (#v3225 > 1) then
            local v4679 = math.random(1, #v3225)
            local v4680 = v3225[v4679]
            v3224:setPosition(v4680:getPosition())
            UIHelper.showToast("^00FF00Teleported to Random Player")
        else
            UIHelper.showToast("^FF0000No other players found")
        end
    end
    GMHelper.AutoClickNearest = function(v3226)
        toggle = not toggle
        key = nil
        gay = nil
        if toggle then
            key =
                LuaTimer:scheduleTimer(
                function()
                    local v4936 = _G["PlayerManager"]:getClientPlayer().Player
                    local v4937 = _G["PlayerManager"]:getPlayers()
                    local v4938 = math.huge
                    local v4939 = nil
                    for v5093, v5094 in pairs(v4937) do
                        local v5095 = MathUtil:distanceSquare2d(v5094:getPosition(), v4936:getPosition())
                        if ((v5094 ~= v4936) and (v5095 < v4938)) then
                            v4938 = v5095
                            v4939 = v5094
                        end
                    end
                    if v4939 then
                        gay =
                            _G["LuaTimer"]:scheduleTimer(
                            function()
                                local v5226 =
                                    VectorUtil.newVector3(
                                    v4939:getPosition().x,
                                    v4939:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2)),
                                    v4939:getPosition().z
                                )
                                CGame.Instance():handleTouchClick(
                                    VectorUtil.newVector3(
                                        v4939:getPosition().x,
                                        v4939:getPosition().y + (tonumber(tostring(787 - _G["dumb"]), 2))
                                    )
                                )
                            end,
                            (tonumber(tostring(1787 - _G["dumb"]), 2)),
                            (tonumber(tostring(1111101777 - _G["dumb"]), 2))
                        )
                    end
                end,
                (tonumber(tostring(1111101778 - _G["dumb"]), 2)),
                -(tonumber(tostring(778 - _G["dumb"]), 2))
            )
        else
            LuaTimer:cancel(key)
            LuaTimer:cancel(gay)
        end
    end
    GMHelper.AutoMoveToNearestPlayer = function(v3227)
        LuaTimer:scheduleTimer(
            function()
                toggle = not toggle
                if toggle then
                    local v4940 = _G["PlayerManager"]:getClientPlayer().Player
                    local v4941 = _G["PlayerManager"]:getPlayers()
                    local v4942 = math.huge
                    local v4943 = nil
                    for v5096, v5097 in pairs(v4941) do
                        local v5098 = MathUtil:distanceSquare2d(v5097:getPosition(), v4940:getPosition())
                        if ((v5097 ~= v4940) and (v5098 < v4942)) then
                            v4942 = v5098
                            v4943 = v5097
                        end
                    end
                    if v4943 then
                        local v5202 =
                            VectorUtil.newVector3(v4943:getPosition().x, v4943:getPosition().y, v4943:getPosition().z)
                        v4940:setPosition(v5202)
                    end
                end
            end,
            50,
            -1
        )
    end
    GMHelper.RotateHeadTowardsNearestPlayer = function(v3228)
        LuaTimer:scheduleTimer(
            function()
                local v4121 = PlayerManager:getClientPlayer().Player
                local v4122 = PlayerManager:getPlayers()
                local v4123 = math.huge
                local v4124 = nil
                for v4681, v4682 in pairs(v4122) do
                    local v4683 = MathUtil:distanceSquare2d(v4682:getPosition(), v4121:getPosition())
                    if ((v4682 ~= v4121) and (v4683 < v4123)) then
                        v4123 = v4683
                        v4124 = v4682
                    end
                end
                if v4124 then
                    local v4944 = v4124:getPosition()
                    local v4945 =
                        VectorUtil.newVector3(v4944.x - v4121:getPosition().x, v4944.y - v4121:getPosition().y, 0)
                    local v4946 = math.atan2(v4945.y, v4945.x) * (180 / math.pi)
                    PlayerManager:getClientPlayer().Player.rotationYaw = v4946
                end
            end,
            500,
            -1
        )
    end
    GMHelper.SwitchPerson = function(v3229, v3230)
        Blockman.Instance():setPersonView(v3230)
        GUIGMControlPanel:hide()
    end
    GMHelper.AllPlayerLocations = function(v3231)
        LuaTimer:scheduleTimer(
            function()
                local v4125 = PlayerManager:getPlayers()
                for v4684, v4685 in pairs(v4125) do
                    local v4686 = v4685:getPosition()
                    local v4687 =
                        string.format(
                        "▢FFFFA500[▢FFFFFFFF %s / X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF ▢FFFFA500]▢FFFFFFFF",
                        v4685.name,
                        v4686.x,
                        v4686.y,
                        v4686.z
                    )
                    MsgSender.sendTopTips(100000, v4687)
                end
            end,
            500,
            -1
        )
    end
    GMHelper.MyLocation = function(v3232)
        LuaTimer:scheduleTimer(
            function()
                local v4126 = PlayerManager:getClientPlayer()
                if v4126 then
                    local v4948 = v4126.Player:getPosition()
                    local v4949 =
                        string.format(
                        "X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF",
                        v4948.x,
                        v4948.y,
                        v4948.z
                    )
                    UIHelper.showToast(v4949)
                end
            end,
            500,
            -1
        )
    end
    GMHelper.AutoSpawnNPC = function(v3233)
        GMHelper:openInput(
            {"TypeValue"},
            function(v4127)
                LuaTimer:scheduleTimer(
                    function()
                        local v4688 = PlayerManager:getClientPlayer()
                        local v4689 = v4688.Player:getPosition()
                        local v4690 = PlayerManager:getPlayers()
                        for v4950, v4951 in pairs(v4690) do
                            if (v4951 ~= v4688) then
                                local v5203 = v4951:getPosition()
                                local v5204 = MathUtil:distanceSquare2d(v5203, v4689)
                                if (v5204 < 35) then
                                    EngineWorld:addActorNpc(
                                        v5203,
                                        0,
                                        v4127,
                                        function(v5251)
                                        end
                                    )
                                end
                            end
                        end
                    end,
                    100,
                    -1
                )
            end
        )
    end
    GMHelper.AdjustSpeedBasedOnDistance = function(v3234)
        LuaTimer:scheduleTimer(
            function()
                local v4128 = PlayerManager:getClientPlayer()
                local v4129 = v4128.Player:getPosition()
                local v4130 = PlayerManager:getPlayers()
                local v4131 = math.huge
                local v4132 = nil
                for v4691, v4692 in pairs(v4130) do
                    if (v4692 ~= v4128) then
                        local v5099 = v4692:getPosition()
                        local v5100 = MathUtil:distanceSquare2d(v5099, v4129)
                        if (v5100 < v4131) then
                            v4131 = v5100
                            v4132 = v4692
                        end
                    end
                end
                if (v4132 ~= nil) then
                    if (v4131 < 10) then
                        v4128.Player:setSpeedAdditionLevel(1)
                    else
                        v4128.Player:setSpeedAdditionLevel(100000)
                    end
                end
            end,
            500,
            -1
        )
    end
    GMHelper.SpawnCube = function(v3235)
        LuaTimer:scheduleTimer(
            function()
                local v4133 = PlayerManager:getClientPlayer():getPosition()
                local v4134 = v4133.x - 1
                local v4135 = v4133.y - 1
                local v4136 = v4133.z - 1
                for v4693 = 0, 2 do
                    for v4952 = 0, 2 do
                        for v5101 = 0, 2 do
                            local v5102 = VectorUtil.newVector3(v4134 - v4693, v4135 + v4952, v4136 + v5101)
                            EngineWorld:setBlock(v5102, 3)
                        end
                    end
                end
            end,
            100,
            -1
        )
    end
    GMHelper.SpawnSphere = function(v3236)
        LuaTimer:scheduleTimer(
            function()
                local v4137 = PlayerManager:getClientPlayer():getPosition()
                local v4138 = 2
                for v4694 = -v4138, v4138 do
                    for v4953 = -v4138, v4138 do
                        for v5103 = -v4138, v4138 do
                            local v5104 = math.sqrt((v4694 * v4694) + (v4953 * v4953) + (v5103 * v5103))
                            if (v5104 <= v4138) then
                                local v5227 = VectorUtil.newVector3(v4137.x - v4694, v4137.y - v4953, v4137.z - v5103)
                                EngineWorld:setBlock(v5227, 3)
                            end
                        end
                    end
                end
            end,
            100,
            -1
        )
    end
    GMHelper.SpawnPyramid = function(v3237)
        LuaTimer:scheduleTimer(
            function()
                local v4139 = PlayerManager:getClientPlayer():getPosition()
                local v4140 = 3
                for v4695 = 0, v4140 - 1 do
                    for v4954 = -v4695, v4695 do
                        for v5105 = -v4695, v4695 do
                            local v5106 =
                                VectorUtil.newVector3(v4139.x + v4954, (v4139.y + (v4140 - 1)) - v4695, v4139.z + v5105)
                            EngineWorld:setBlock(v5106, 3)
                        end
                    end
                end
            end,
            100,
            -1
        )
    end
    GMHelper.SpawnRhombus = function(v3238)
        LuaTimer:scheduleTimer(
            function()
                local v4141 = PlayerManager:getClientPlayer():getPosition()
                local v4142 = 3
                for v4696 = 0, v4142 - 1 do
                    for v4955 = -v4696, v4696 do
                        for v5107 = -v4696, v4696 do
                            local v5108 =
                                VectorUtil.newVector3(v4141.x + v4955, (v4141.y + (v4142 - 1)) - v4696, v4141.z + v5107)
                            EngineWorld:setBlock(v5108, 3)
                        end
                    end
                end
                for v4697 = 1, v4142 - 1 do
                    for v4956 = -v4697 + 1, v4697 - 1 do
                        for v5109 = -v4697 + 1, v4697 - 1 do
                            local v5110 =
                                VectorUtil.newVector3(v4141.x + v4956, v4141.y + (v4142 - 1) + v4697, v4141.z + v5109)
                            EngineWorld:setBlock(v5110, 3)
                        end
                    end
                end
            end,
            100,
            -1
        )
    end
    GMHelper.ShowST = function(v3239)
        local v3240 = 3
        local v3241 = BlockManager.getBlockById(v3240)
        v3241:setBlockBounds(0, 0, 0, 1, 1, 1)
    end
    GMHelper.HideST = function(v3242)
        local v3243 = 3
        local v3244 = BlockManager.getBlockById(v3243)
        v3244:setBlockBounds(0, 0, 0, 0, 0, 0)
    end
    GMHelper.wafexTest = function(v3245)
        GUIManager:getWindowByName("Main-Cannon"):SetVisible(true)
        GUIManager:getWindowByName("Main-Cannon", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                local v4143 = 2
                local v4144 = 3
                local v4145 = 4
                local v4146 = VectorUtil.newVector3(v4143, v4144, v4145)
                PlayerManager:getClientPlayer().Player:setVelocity(v4146)
            end
        )
    end
    GMHelper.testHui = function(v3246)
        LuaTimer:scheduleTimer(
            function()
                local v4147 = PlayerManager:getClientPlayer()
                if v4147 then
                    local v4957 = v4147.Player:getPosition()
                    local v4958 = PlayerManager:getPlayers()
                    local v4959 = math.huge
                    local v4960 = nil
                    local v4961 = math.huge
                    local v4962 = nil
                    for v5111, v5112 in pairs(v4958) do
                        if (v5112 ~= v4147) then
                            local v5228 = v5112:getPosition()
                            local v5229 = MathUtil:distanceSquare2d(v5228, v4957)
                            if (v5229 < v4959) then
                                v4959 = v5229
                                v4960 = v5112
                            end
                            if (v5229 < v4961) then
                                v4961 = v5229
                                v4962 = v5112
                            end
                        end
                    end
                    if ((v4960 ~= nil) and (v4959 < 10)) then
                        local v5205 = math.min(v4960:getHealth(), 50)
                        local v5206 = ((v4960:getSex() == 1) and "▢FF00FFFF██▢FFFFFFFF") or "▢FFFF1B89██▢FFFFFFFF"
                        local v5207 =
                            string.format(
                            "%s ¦ %.1f ▢FFFF0000♥️▢FFFFFFFF ¦ %s ¦ X: ▢FFFF0000%.2f▢FFFFFFFF / Y: ▢FFFF0000%.2f▢FFFFFFFF / Z: ▢FFFF0000%.2f▢FFFFFFFF",
                            v4960.name,
                            v5205,
                            v5206,
                            v4960:getPosition().x,
                            v4960:getPosition().y,
                            v4960:getPosition().z
                        )
                        UIHelper.showToast(v5207)
                    end
                    if (v4962 ~= nil) then
                        local v5208 =
                            string.format("Ты находишься на расстоянии от ближайшего игрока на %.1f блоков", v4961)
                        MsgSender.sendCenterTips(
                            1,
                            string.format(" \nDistance: %.1f blocks\n \n\n%s", v4961, v4960.userId)
                        )
                    end
                end
            end,
            10,
            -1
        )
    end
    GMHelper.TeleportAura = function(v3247)
        local v3248 = 3
        local function v3249(v4148)
            local v4149 = v4148:getPosition()
            local v4150 = MathUtil:getRandomPointInCircle(v4149, v3248)
            PlayerManager:getClientPlayer().Player:setPosition(v4150)
        end
        local function v3250()
            local v4151 = PlayerManager:getClientPlayer().Player
            local v4152 = PlayerManager:getPlayers()
            local v4153 = math.huge
            local v4154 = nil
            for v4698, v4699 in pairs(v4152) do
                if (v4699 ~= v4151) then
                    local v5113 = MathUtil:distanceSquare2d(v4699:getPosition(), v4151:getPosition())
                    if (v5113 < v4153) then
                        v4153 = v5113
                        v4154 = v4699
                    end
                end
            end
            return v4154
        end
    end
    GMHelper.AimBotw = function(v3251)
        local v3252 = PlayerManager:getPlayers()
        for v4155, v4156 in pairs(v3252) do
            targetPos = v4156:getPosition()
            local function v4157(v4700)
                local v4701 = SceneManager.Instance():getMainCamera()
                local v4702 = v4701:getPosition()
                local v4703 = math.atan2(v4700.x - v4702.x, v4700.z - v4702.z)
                local v4704 = (v4703 / math.pi) * -180
                local v4705 = VectorUtil.sub3(v4700, v4702)
                local v4706 = MathUtil.GetVector3Angle(VectorUtil.newVector3(v4705.x, 0, v4705.z), v4705)
                return v4704, v4706
            end
            PlayerManager:getClientPlayer().targetPos = targetPos
            local v4159 = 50
            LuaTimer:cancel(v3251.cameraKey)
            PlayerManager:getClientPlayer().cameraKey =
                LuaTimer:scheduleTimer(
                function()
                    local v4707, v4708 = v4157(targetPos)
                    local v4709 = PlayerManager:getClientPlayer().Player.rotationYaw
                    local v4710 = PlayerManager:getClientPlayer().Player.rotationPitch
                    while math.abs(v4709 - v4707) > 180 do
                        if (v4709 > v4707) then
                            v4707 = v4707 + 360
                        else
                            v4707 = v4707 - 360
                        end
                    end
                    if (v4159 > 1) then
                        PlayerManager:getClientPlayer().Player.rotationYaw = v4709 + ((v4707 - v4709) / v4159)
                        PlayerManager:getClientPlayer().Player.rotationPitch = v4710 + ((v4708 - v4710) / v4159)
                    else
                        PlayerManager:getClientPlayer().Player.rotationYaw = v4707
                        PlayerManager:getClientPlayer().Player.rotationPitch = v4708
                    end
                    v4159 = v4159 - 1
                end,
                200,
                -1
            )
        end
    end
    GMHelper.StartAimBotTimer = function(v3253)
        v3253.aimBotTimer =
            LuaTimer:scheduleTimer(
            function()
                v3253:AimBot()
            end,
            1000,
            -1
        )
    end
    GMHelper.StopAimBotTimer = function(v3255)
        if v3255.aimBotTimer then
            LuaTimer:cancel(v3255.aimBotTimer)
            v3255.aimBotTimer = nil
        end
    end
    GMHelper.testZalupa = function(v3256)
    end
    GMHelper.ShowHealthBar = function(v3257)
        LuaTimer:scheduleTimer(
            function()
                local v4161 = PlayerManager:getPlayers()
                local v4162 = {
                    ["0"] = "▢FFFF0000",
                    ["5"] = "▢FFFF3300",
                    ["10"] = "▢FFFF6600",
                    ["15"] = "▢FF66FF00",
                    ["20"] = "▢FF00FF00"
                }
                local v4163 = 20
                local v4164 = ""
                for v4712 = 1, v4163 do
                    local v4713 = v4161[v4712]
                    local v4714 = v4162["0"]
                    if v4713 then
                        local v5118 = v4713:getHealth()
                        for v5209 = 20, 0, -5 do
                            if (v5118 >= v5209) then
                                v4714 = v4162[tostring(v5209)]
                                break
                            end
                        end
                    end
                    v4164 = v4164 .. (v4714 or v4162["0"]) .. "♥️"
                end
                MsgSender.sendTopTips(1, v4164)
            end,
            10,
            -1
        )
    end
    GMHelper.ChangeTargetAimBot = function(v3258)
        local v3259 = PlayerManager:getPlayers()
        local v3260 = 1
        local v3261 = nil
        local function v3262(v4165)
            local v4166 = SceneManager.Instance():getMainCamera()
            local v4167 = v4166:getPosition()
            local v4168 = math.atan2(v4165.x - v4167.x, v4165.z - v4167.z)
            local v4169 = (v4168 / math.pi) * -180
            local v4170 = VectorUtil.sub3(v4165, v4167)
            local v4171 = MathUtil.GetVector3Angle(VectorUtil.newVector3(v4170.x, 0, v4170.z), v4170)
            return v4169, v4171
        end
        local function v3263()
            v3260 = v3260 + 1
            if (v3260 > #v3259) then
                v3260 = 1
            end
            v3261 = v3259[v3260]:getPosition()
            PlayerManager:getClientPlayer().targetPos = v3261
        end
        local v3264 = 50
        LuaTimer:cancel(v3258.cameraKey)
        PlayerManager:getClientPlayer().cameraKey =
            LuaTimer:scheduleTimer(
            function()
                v3263()
                local v4173, v4174 = v3262(v3261)
                local v4175 = PlayerManager:getClientPlayer().Player.rotationYaw
                local v4176 = PlayerManager:getClientPlayer().Player.rotationPitch
                while math.abs(v4175 - v4173) > 180 do
                    if (v4175 > v4173) then
                        v4173 = v4173 + 360
                    else
                        v4173 = v4173 - 360
                    end
                end
                if (v3264 > 1) then
                    PlayerManager:getClientPlayer().Player.rotationYaw = v4175 + ((v4173 - v4175) / v3264)
                    PlayerManager:getClientPlayer().Player.rotationPitch = v4176 + ((v4174 - v4176) / v3264)
                else
                    PlayerManager:getClientPlayer().Player.rotationYaw = v4173
                    PlayerManager:getClientPlayer().Player.rotationPitch = v4174
                    v3263()
                end
                v3264 = v3264 - 1
            end,
            200,
            -1
        )
    end
    GMHelper.SetMaxFPS = function(v3266)
        GMHelper:openInput(
            {""},
            function(v4177)
                CGame.Instance():SetMaxFps(v4177)
            end
        )
    end
    GMHelper.ChangePlayerSize = function(v3267)
        local v3268 = PlayerManager:getClientPlayer()
        local v3269 = PlayerManager:getPlayers()
        for v4178, v4179 in pairs(v3269) do
            if (v4179 ~= v3268) then
                v4179:setScale(5)
            end
        end
    end
    GMHelper.wafexTest2 = function(v3270)
        LuaTimer:scheduleTimer(
            function()
                local v4180 = PlayerManager:getClientPlayer()
                local v4181 = PlayerManager:getPlayers()
                for v4715, v4716 in pairs(v4181) do
                    if (v4716 ~= v4180) then
                        v4716.Player.m_rotateSpeed = 999
                    end
                end
            end,
            100,
            -1
        )
    end
    GMHelper.RespawnTool = function(v3271)
        PacketSender:getSender():sendRebirth()
    end
    GMHelper.testwafexlol = function(v3272)
        LuaTimer:scheduleTimer(
            function()
                local v4182 = PlayerManager:getClientPlayer()
                if v4182 then
                    local v4967 = v4182.Player:getPosition()
                    local v4968 = PlayerManager:getPlayers()
                    local v4969 = math.huge
                    local v4970 = nil
                    local v4971 = math.huge
                    local v4972 = nil
                    for v5120, v5121 in pairs(v4968) do
                        if (v5121 ~= v4182) then
                            local v5230 = v5121:getPosition()
                            local v5231 = MathUtil:distanceSquare2d(v5230, v4967)
                            if (v5231 < v4969) then
                                v4969 = v5231
                                v4970 = v5121
                            end
                            if (v5231 < v4971) then
                                v4971 = v5231
                                v4972 = v5121
                            end
                        end
                    end
                    if ((v4970 ~= nil) and (v4969 < 50)) then
                        local v5210 = math.min(v4970:getHealth(), 50)
                        local v5211 = ((v4970:getSex() == 1) and "▢FF00FFFF██▢FFFFFFFF") or "▢FFFF1B89██▢FFFFFFFF"
                        local v5212 =
                            string.format(
                            "%s ¦ X: %.2f / Y: %.2f / Z: %.2f",
                            v4970.name,
                            v4970:getPosition().x,
                            v4970:getPosition().y,
                            v4970:getPosition().z
                        )
                        GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v5212)
                    end
                end
            end,
            10,
            -1
        )
    end
    GMHelper.FreezeUI = function(v3273)
        FreezeUIs = not FreezeUIs
        ClientHelper.putBoolPrefs("LockUIShowAndHide", true)
        UIHelper.showToast("LockUIShowAndHide = true")
        if FreezeUIs then
            ClientHelper.putBoolPrefs("LockUIShowAndHide", false)
            UIHelper.showToast("LockUIShowAndHide = false")
        end
    end
    GMHelper.setVelocity = function(v3274)
        local v3275 = 2
        local v3276 = 3
        local v3277 = 4
        local v3278 = VectorUtil.newVector3(v3275, v3276, v3277)
        PlayerManager:getClientPlayer().Player:setVelocity(v3278)
    end
    GMHelper.popkashlen = function(v3279)
        GMHelper:openInput(
            {""},
            function(v4183)
                LuaTimer:scheduleTimer(
                    function()
                        GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v4183)
                    end,
                    5,
                    1000000
                )
            end
        )
        UIHelper.showToast("SUCCESS")
    end
    GMHelper.infiniteCountdownToChat = function(v3280)
        local v3281 = 0
        local v3282 = 0
        LuaTimer:scheduleTimer(
            function()
                v3282 = v3282 + 1
                v3281 = v3281 - 1
                GUIManager:getWindowByName("Chat-Input-Box"):SetProperty(
                    "Text",
                    "  " .. v3282 .. "  " .. v3281 .. "  " .. v3282 .. "  " .. v3281 .. "  " .. v3282 .. "  " .. v3281
                )
            end,
            10,
            -1
        )
    end
    GMHelper.ChangeWeather = function(v3283)
        local v3284 = EngineWorld:getWorld()
        v3284:setWorldWeather("rain")
        UIHelper.showToast("^00FF00Now Rain!")
    end
    GMHelper.showRainbowText = function(v3285)
        local v3286 = {4294901760, 4294934528, 4294967040, 4278255360, 4278255615, 4278190335, 4286578943}
        local v3287 = 1
        local v3288 = "Modification by Wafex (Version: 1.0)"
        local v3289 = string.len(v3288)
        local v3290 = {}
        for v4184 = 1, v3289 do
            v3290[v4184] = v3286[v3287]
            v3287 = ((v3287 < #v3286) and (v3287 + 1)) or 1
        end
        LuaTimer:scheduleTimer(
            function()
                local v4187 = ""
                for v4717 = 1, #v3290 do
                    v4187 = v4187 .. "▢" .. string.format("%X", v3290[v4717]) .. string.sub(v3288, v4717, v4717)
                end
                MsgSender.sendTopTips(1000000, v4187, "Test")
                local v4188 = table.remove(v3290, #v3290)
                table.insert(v3290, 1, v4188)
            end,
            100,
            -1
        )
    end
    GMHelper.teleportAuraWafex = function(v3291)
        local v3292 = 2
        local v3293 = VectorUtil.newVector3(2, 0, 2)
        local function v3294()
            local v4189 = getAlivePlayers()
            local v4190 = PlayerManager:getClientPlayer().Player:getPosition()
            local v4191 = 1
            local v4192 = math.huge
            for v4718, v4719 in ipairs(v4189) do
                local v4720 = v4719.Player:getPosition()
                local v4721 = VectorUtil.newVector3(v4190, v4720)
                if (v4721 < v4192) then
                    v4192 = v4721
                    v4191 = v4718
                end
            end
            return v4189[v4191].Player:getPosition()
        end
        local function v3295()
            local v4193 = v3294()
            for v4722 = 0, math.pi * 2, 0.1 do
                local v4723 = math.cos(v4722) * v3292
                local v4724 = math.sin(v4722) * v3292
                local v4725 = VectorUtil.add3(v4193, VectorUtil.newVector3(v4723, 0, v4724))
                v4725 = VectorUtil.add3(v4725, v3293)
                PlayerManager:getClientPlayer().Player:setVelocity(v4725)
            end
        end
    end
    GMHelper.TeleportOnClick = function(v3296)
        LuaTimer:scheduleTimer(
            function()
                local function v4194()
                    local v4726 = CGame.Instance():getMousePos()
                    PlayerManager:getClientPlayer():setPosition(VectorUtil.newVector3(v4726))
                end
                CGame.Instance().onMouseClick = v4194
            end,
            20,
            -1
        )
    end
    GMHelper.showRainbowAnimation = function(v3297)
        local v3298 = {4294901760, 4294934528, 4294967040, 4278255360, 4278255615, 4278190335, 4286578943}
        local v3299 = 1
        local v3300 = "член хуй"
        local v3301 = string.len(v3300)
        local v3302 = ""
        for v4196 = 1, v3301 do
            v3302 =
                v3302 ..
                "\27[38;2;" ..
                    string.rshift(v3298[v3299], 16) ..
                        ";" ..
                            string.rshift(bit.band(v3298[v3299], 65280), 8) ..
                                ";" .. bit.band(v3298[v3299], 255) .. "m" .. string.sub(v3300, v4196, v4196)
            v3299 = ((v3299 < #v3298) and (v3299 + 1)) or 1
        end
        GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v3302)
        UIHelper.showToast("SUCCESS")
    end
    GMHelper.teleportToPlane = function(v3303)
        local v3304 = 1
        EngineWorld:getWorld():addAircraft(PlayerManager:getClientPlayer():getPosition(), 0)
    end
    GMHelper.AimBot2 = function(v3305, v3306)
        local v3307 = PlayerManager:getPlayers()
        for v4197, v4198 in pairs(v3307) do
            targetPos = VectorUtil.add3(v4198:getPosition(renderDt), VectorUtil.newVector3(0, 1.62, 0))
            local function v4199(v4727)
                local v4728 = SceneManager.Instance():getMainCamera()
                local v4729 = v4728:getPosition()
                local v4730 = math.atan2(v4727.x - v4729.x, v4727.z - v4729.z)
                local v4731 = (v4730 / math.pi) * -180
                local v4732 = VectorUtil.sub3(v4727, v4729)
                local v4733 = MathUtil.GetVector3Angle(VectorUtil.newVector3(v4732.x, 0, v4732.z), v4732)
                return v4731, v4733
            end
            PlayerManager:getClientPlayer().targetPos = targetPos
            local v4201 = 50
            LuaTimer:cancel(v3305.cameraKey)
            PlayerManager:getClientPlayer().cameraKey =
                LuaTimer:scheduleTimer(
                function()
                    local v4734, v4735 = v4199(targetPos)
                    local v4736 = PlayerManager:getClientPlayer().Player
                    local v4737 = v4736.rotationYaw
                    local v4738 = v4736.rotationPitch
                    local v4739 = 360
                    local v4740 = math.fmod(v4734 - v4737, 360)
                    if ((v4740 > 180) or (v4740 < -180)) then
                        v4740 = -v4740
                    end
                    local v4741 = v4735 - v4738
                    if (math.abs(v4740) < (((v3306 or 1000) / 1000) * v4739)) then
                        v4736.rotationYaw = v4734
                    else
                        v4736.rotationYaw = v4737 + ((v4740 / math.abs(v4740)) * v4739 * ((v3306 or 1000) / 1000))
                    end
                    if (math.abs(v4741) < (((v3306 or 1000) / 1000) * v4739)) then
                        v4736.rotationPitch = v4735
                    else
                        v4736.rotationPitch = v4738 + ((v4741 / math.abs(v4741)) * v4739 * ((v3306 or 1000) / 1000))
                    end
                end,
                200,
                -1
            )
        end
    end
    GMHelper.StartAimBotTimer2 = function(v3308)
        v3308.aimBotTimer =
            LuaTimer:scheduleTimer(
            function()
                v3308:AimBot2()
            end,
            500,
            -1
        )
    end
    GMHelper.texturecrash = function(v3310)
        local v3311 =
            "After changing textures, do not immediately change them to other textures, wait for a while. It is not possible to select other textures after you have changed the textures, first reset the textures by selecting the default of the texture, wait a while and select other textures. "
        local v3312 = "OK"
        local v3313 = "Fixing crashes when changing textures"
        CustomDialog.builder().setContentText(v3311).setRightText(v3312).setTitleText(v3313).setHideLeftButton().setPanelSize(
            600,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.GUISkyblockTest2 = function(v3314)
        UIHelper.showGameGUILayout("GUIGameTool")
        GUIGMControlPanel:hide()
    end
    GMHelper.GUISkyblockTest3 = function(v3315)
        UIHelper.showGameGUILayout("GUIRewardDetail", v3315.rewardId)
        GUIGMControlPanel:hide()
    end
    GMHelper.Reach = function(v3316)
        A = not A
        ClientHelper.putFloatPrefs("BlockReachDistance", 1000000)
        ClientHelper.putFloatPrefs("EntityReachDistance", 1000)
        if A then
            UIHelper.showToast("^00FF00REACH ON")
            return
        end
        ClientHelper.putFloatPrefs("BlockReachDistance", 10)
        ClientHelper.putFloatPrefs("EntityReachDistance", 10)
        UIHelper.showToast("^00FF00REACH OFF")
    end
    GMHelper.ViewBobbing = function(v3317)
        A = not A
        ClientHelper.putBoolPrefs("IsViewBobbing", false)
        if A then
            UIHelper.showToast("^00FF00ViewBobbing: OFF")
            return
        end
        ClientHelper.putBoolPrefs("IsViewBobbing", true)
        UIHelper.showToast("^00FF00ViewBobbing: ON")
    end
    GMHelper.BlockmanCollision = function(v3318)
        A = not A
        ClientHelper.putBoolPrefs("IsCreatureCollision", true)
        ClientHelper.putBoolPrefs("IsBlockmanCollision", true)
        if A then
            UIHelper.showToast("^00FF00BlockmanCollision: ON")
            return
        end
        ClientHelper.putBoolPrefs("IsBlockmanCollision", false)
        UIHelper.showToast("^00FF00BlockmanCollision: OFF")
        ClientHelper.putBoolPrefs("IsCreatureCollision", false)
    end
    GMHelper.RenderWorld = function(v3319)
        GMHelper:openInput(
            {""},
            function(v4203)
                ClientHelper.putIntPrefs("BlockRenderDistance", v4203)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.Fog = function(v3320)
        A = not A
        ClientHelper.putBoolPrefs("DisableFog", true)
        if A then
            UIHelper.showToast("^00FF00Fog Disabled!")
            return
        end
        ClientHelper.putBoolPrefs("DisableFog", false)
        UIHelper.showToast("^00FF00Fog Enabled!")
    end
    GMHelper.WWE_Camera = function(v3321)
        A = not A
        ClientHelper.putBoolPrefs("IsSeparateCamera", true)
        if A then
            UIHelper.showToast("^00FF00SeparateCamera: Enabled")
            return
        end
        ClientHelper.putBoolPrefs("IsSeparateCamera", false)
        UIHelper.showToast("^00FF00SeparateCamera: Disabled")
    end
    GMHelper.ResetXD = function(v3322)
        ClientHelper.putStringPrefs("RunSkillName", "run")
        GUIGMControlPanel:hide()
    end
    GMHelper.ActionSet = function(v3323)
        GMHelper:openInput(
            {""},
            function(v4204)
                ClientHelper.putStringPrefs("RunSkillName", v4204)
            end
        )
    end
    GMHelper.WalkSMG = function(v3324)
        ClientHelper.putStringPrefs("RunSkillName", "smg_walk")
        GUIGMControlPanel:hide()
    end
    GMHelper.SneakXD = function(v3325)
        ClientHelper.putStringPrefs("RunSkillName", "sneak")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD = function(v3326)
        ClientHelper.putStringPrefs("RunSkillName", "sit1")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD2 = function(v3327)
        ClientHelper.putStringPrefs("RunSkillName", "sit2")
        GUIGMControlPanel:hide()
    end
    GMHelper.SitXD3 = function(v3328)
        ClientHelper.putStringPrefs("RunSkillName", "sit3")
        GUIGMControlPanel:hide()
    end
    GMHelper.rideDragonXD = function(v3329)
        ClientHelper.putStringPrefs("RunSkillName", "ride_dragon")
        GUIGMControlPanel:hide()
    end
    GMHelper.SwimXD = function(v3330)
        ClientHelper.putStringPrefs("RunSkillName", "swim")
        GUIGMControlPanel:hide()
    end
    GMHelper.ArmSpeed = function(v3331)
        GMHelper:openInput(
            {""},
            function(v4205)
                ClientHelper.putIntPrefs("ArmSwingAnimationEnd", v4205)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.CameraFunct = function(v3332)
        GMHelper:openInput(
            {""},
            function(v4206)
                ClientHelper.putFloatPrefs("ThirdPersonDistance", v4206)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.CloudsOFF = function(v3333)
        ClientHelper.putBoolPrefs("DisableRenderClouds", true)
        UIHelper.showToast("^00FF00Clouds Stop")
        GUIGMControlPanel:hide()
    end
    GMHelper.BowSpeed = function(v3334)
        ClientHelper.putFloatPrefs("BowPullingSpeedMultiplier", 1000)
        ClientHelper.putFloatPrefs("BowPullingFOVMultiplier", 0)
        UIHelper.showToast("^00FF00BowSpeed:ON")
        GUIGMControlPanel:hide()
    end
    GMHelper.HeadText = function(v3335)
        A = not A
        ClientHelper.putBoolPrefs("RenderHeadText", true)
        if A then
            UIHelper.showToast("^00FF00Head text render now ON")
            return
        end
        ClientHelper.putBoolPrefs("RenderHeadText", false)
        UIHelper.showToast("^00FF00Head text render now OFF")
    end
    GMHelper.changePlayerActor = function(v3336, v3337)
        if isGameStart then
            if (v3337 == 1) then
                ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
                ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
            else
                ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
                ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
            end
        elseif (v3337 == 1) then
            ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
            ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
        else
            ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
            ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
        end
        local v3338 = PlayerManager:getPlayers()
        for v4207, v4208 in pairs(v3338) do
            if v4208.Player then
                v4208.Player.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v4208)
            end
        end
        UIHelper.showToast("^00FF00Success!")
        GUIGMControlPanel:hide()
    end
    GMHelper.BanClickCD = function(v3339, v3340)
        A = not A
        ClientHelper.putBoolPrefs("banClickCD", true)
        if A then
            UIHelper.showToast("^00FF00done, bedwars click: 0FF")
            return
        end
        ClientHelper.putBoolPrefs("banClickCD", false)
        UIHelper.showToast("^00FF00done, bedwars click: 0N")
    end
    GMHelper.ShowAllCobtrolXD = function(v3341)
        RootGuiLayout.Instance():showMainControl()
    end
    GMHelper.PersonView = function(v3342)
        GMHelper:openInput(
            {""},
            function(v4209)
                Blockman.Instance():setPersonView(v4209)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.BreakParticles = function(v3343)
        GMHelper:openInput(
            {""},
            function(v4210)
                ClientHelper.putIntPrefs("BlockDestroyEffectSize", v4210)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.JailBreakBypass = function(v3344)
        RootGuiLayout.Instance():showMainControl()
        GUIGMControlPanel:hide()
    end
    GMHelper.SpeedLineMode = function(v3345)
        local v3346 = 1
        local v3347 = 0.01
        Blockman.Instance().m_gameSettings:setPatternSpeedLine(v3346, v3347)
        UIHelper.showToast("^00FF00Speed Line = Enable!")
        GUIGMControlPanel:hide()
    end
    GMHelper.SpeedLineModeDisable = function(v3348)
        local v3349 = 0
        local v3350 = 0
        Blockman.Instance().m_gameSettings:setPatternSpeedLine(v3349, v3350)
        UIHelper.showToast("^00FF00Speed Line = Disabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.PatternTorchMode = function(v3351)
        local v3352 = 1
        Blockman.Instance().m_gameSettings:setPatternTorchStrength(v3352)
        UIHelper.showToast("^00FF00PatternTorch = Enabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.PatternTorchModeOFF = function(v3353)
        local v3354 = 0
        Blockman.Instance().m_gameSettings:setPatternTorchStrength(v3354)
        UIHelper.showToast("^00FF00PatternTorch = Disabled!")
        GUIGMControlPanel:hide()
    end
    GMHelper.CameraFlipModeRESET = function(v3355)
        Blockman.Instance().m_gameSettings:setFovSetting(1)
        GUIGMControlPanel:hide()
    end
    GMHelper.CameraFlipModeON = function(v3356)
        Blockman.Instance().m_gameSettings:setFovSetting(90)
        GUIGMControlPanel:hide()
    end
    GMHelper.Iikj = function(v3357, v3358)
        local v3359 = v3358:getPosition()
        v3359.y = v3359.y + 0.5
        local v3361 = v3358:getYaw()
        v3358:teleportPosWithYaw(v3359, v3361)
        GUIGMControlPanel:hide()
    end
    GMHelper.GUItest1 = function(v3362)
        MsgSender.sendMsg(10007, "IikjLol")
        MsgSender.sendMsg(10006, "IikjLol")
        MsgSender.sendMsg(10005, "IikjLol")
        MsgSender.sendMsg(10004, "IikjLol")
        MsgSender.sendMsg(10003, "IikjLol")
        MsgSender.sendMsg(10002, "IikjLol")
        MsgSender.sendMsg(10001, "IikjLol")
        MsgSender.sendMsg(10000, "IikjLol")
        MsgSender.sendMsg(1, "IikjLol")
    end
    GMHelper.FustBreakBlockMode = function(v3363)
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for v4211 = 1, 40000 do
            local v4212 = BlockManager.getBlockById(v4211)
            if v4212 then
                v4212:setHardness(0)
                UIHelper.showToast("^00FF00Turned ON")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.FlyDev = function(v3364)
        GUIManager:hideWindowByName("Main.binary")
        GUIManager:hideWindowByName("Main.json")
        GUIGMControlPanel:hide()
    end
    GMHelper.HideHP = function(v3365)
        GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(false)
    end
    GMHelper.ShowHP = function(v3366)
        GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
    end
    GMHelper.FlyDev2 = function(v3367)
        for v4213 = 1, 40000 do
            local v4214 = BlockManager.getBlockById(v4213)
            if v4214 then
                Blockman.Instance():setBloomEnable(true)
                Blockman.Instance():enableFullscreenBloom(true)
                Blockman.Instance():setBlockBloomOption(100)
                Blockman.Instance():setBloomIntensity(100)
                Blockman.Instance():setBloomSaturation(100)
                Blockman.Instance():setBloomThreshold(100)
                UIHelper.showToast("^00FF00Speed Break Block = 0")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.FlyDev3 = function(v3368)
        GUIManager:showWindowByName("PlayerInventory-DesignationTab")
        GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetVisible(true)
        GUIManager:showWindowByName("PlayerInventory-MainInventoryTab")
        GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetVisible(true)
        GUIManager:getWindowByName("PlayerInventory-MainInventoryTab"):SetArea({1, 1}, {1, 0}, {0, 1}, {0, 1})
        GUIManager:getWindowByName("PlayerInventory-DesignationTab"):SetArea({0, 0}, {0, 0}, {0.3, 0}, {0.3, 0})
        GUIManager:getWindowByName("PlayerInventory-ToggleInventoryButton"):SetVisible(true)
        GUIManager:showWindowByName("PlayerInventory-ToggleInventoryButton")
        GUIGMControlPanel:hide()
    end
    GMHelper.TNTButtonView = function(v3369)
        GUIManager:showWindowByName("Main-throwpot-Controls")
        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.SetBobbing = function(v3370)
        GMHelper:openInput(
            {""},
            function(v4215)
                ClientHelper.putFloatPrefs("PlayerBobbingScale", v4215)
                UIHelper.showToast("^00FF00Changed")
            end
        )
    end
    GMHelper.test200 = function(v3371)
        MsgSender.sendMsg(Messages:gameResetTimeHint())
        GUIGMControlPanel:hide()
    end
    GMHelper.test600 = function(v3372)
        local v3373 = PlayerManager:getPlayers()
        for v4216, v4217 in pairs(v3373) do
            if v4217.Player then
                v4217.Player.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v4217)
            end
        end
        UIHelper.showToast("^00FF00yes")
        GUIGMControlPanel:hide()
    end
    GMHelper.JustClick = function(v3374)
        LuaTimer:scheduleTimer(
            function()
                local v4218 = VectorUtil.newVector3(0, 30, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v4218)
            end,
            5,
            2e+35
        )
    end
    GMHelper.JustClick2 = function(v3375)
        LuaTimer:scheduleTimer(
            function()
                local v4219 = VectorUtil.newVector3(0, 300, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v4219)
            end,
            5,
            2e+35
        )
    end
    GMHelper.OffChat = function(v3376)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
    end
    GMHelper.OnChat = function(v3377)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
    end
    GMHelper.Noclip = function(v3378)
        A = not A
        for v4220 = 1, 40000 do
            local v4221 = BlockManager.getBlockById(v4220)
            if v4221 then
                v4221:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Noclip = true")
            return
        end
        for v4222 = 1, 40000 do
            local v4223 = BlockManager.getBlockById(v4222)
            if v4223 then
                v4223:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Noclip = false")
    end
    GMHelper.NoclipOP = function(v3379)
        A = not A
        for v4224 = 3, 133 do
            local v4225 = BlockManager.getBlockById(v4224)
            if v4225 then
                v4225:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00TreasureHunterNoClip = Enabled")
            return
        end
        for v4226 = 3, 133 do
            local v4227 = BlockManager.getBlockById(v4226)
            if v4227 then
                v4227:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00TreasureHunterNoClip = Disabled")
    end
    GMHelper.NoObsidian1 = function(v3380)
        A = not A
        for v4228 = 49, 50 do
            local v4229 = BlockManager.getBlockById(v4228)
            if v4229 then
                v4229:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4230 = 49, 50 do
            local v4231 = BlockManager.getBlockById(v4230)
            if v4231 then
                v4231:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoOakPlanks1 = function(v3381)
        A = not A
        for v4232 = 5, 6 do
            local v4233 = BlockManager.getBlockById(v4232)
            if v4233 then
                v4233:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4234 = 5, 6 do
            local v4235 = BlockManager.getBlockById(v4234)
            if v4235 then
                v4235:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoGlass1 = function(v3382)
        A = not A
        for v4236 = 94, 95 do
            local v4237 = BlockManager.getBlockById(v4236)
            if v4237 then
                v4237:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4238 = 94, 95 do
            local v4239 = BlockManager.getBlockById(v4238)
            if v4239 then
                v4239:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoEndStone1 = function(v3383)
        A = not A
        for v4240 = 120, 121 do
            local v4241 = BlockManager.getBlockById(v4240)
            if v4241 then
                v4241:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4242 = 120, 121 do
            local v4243 = BlockManager.getBlockById(v4242)
            if v4243 then
                v4243:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoWool1 = function(v3384)
        A = not A
        for v4244 = 1441, 1444 do
            local v4245 = BlockManager.getBlockById(v4244)
            if v4245 then
                v4245:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4246 = 1441, 1444 do
            local v4247 = BlockManager.getBlockById(v4246)
            if v4247 then
                v4247:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoBomb1 = function(v3385)
        A = not A
        for v4248 = 593, 594 do
            local v4249 = BlockManager.getBlockById(v4248)
            if v4249 then
                v4249:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4250 = 593, 594 do
            local v4251 = BlockManager.getBlockById(v4250)
            if v4251 then
                v4251:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoIDoor1 = function(v3386)
        A = not A
        for v4252 = 241, 242 do
            local v4253 = BlockManager.getBlockById(v4252)
            if v4253 then
                v4253:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4254 = 241, 242 do
            local v4255 = BlockManager.getBlockById(v4254)
            if v4255 then
                v4255:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.NoQuartz1 = function(v3387)
        A = not A
        for v4256 = 155, 156 do
            local v4257 = BlockManager.getBlockById(v4256)
            if v4257 then
                v4257:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        end
        if A then
            UIHelper.showToast("^00FF00Enabled")
            return
        end
        for v4258 = 155, 156 do
            local v4259 = BlockManager.getBlockById(v4258)
            if v4259 then
                v4259:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
        UIHelper.showToast("^00FF00Disabled")
    end
    GMHelper.test2222 = function(v3388)
        A = not A
        LuaTimer:scheduleTimerWithEnd(
            function()
                PlayerManager:getClientPlayer().Player:setGlide(true)
            end,
            0.2,
            9e+23
        )
        if A then
            LuaTimer:scheduleTimerWithEnd(
                function()
                    PlayerManager:getClientPlayer().Player:setGlide(false)
                end,
                0.2,
                1
            )
        end
    end
    GMHelper.JumpHeight = function(v3389)
        GMHelper:openInput(
            {""},
            function(v4260)
                local v4261 = PlayerManager:getClientPlayer()
                if (v4261 and v4261.Player) then
                    v4261.Player:setFloatProperty("JumpHeight", v4260)
                    UIHelper.showToast("^00FF00Success")
                end
            end
        )
    end
    GMHelper.addCurrencyCustom = function(v3390, v3391)
        GMHelper:openInput(
            v3391,
            {"100"},
            function(v4262)
                v4262 = tonumber(v4262) or 0
                v3391:addCurrency(v4262, "GM")
            end
        )
    end
    GMHelper.GUIOpener = function(v3392)
        GMHelper:openInput(
            {".json"},
            function(v4263)
                GUIManager:showWindowByName(v4263)
            end
        )
    end
    GMHelper.GUIViewOFF = function(v3393)
        GMHelper:openInput(
            {".json"},
            function(v4264)
                GUIManager:hideWindowByName(v4264)
            end
        )
    end
    GMHelper.InsideGUI = function(v3394)
        GMHelper:openInput(
            {"", ""},
            function(v4265, v4266)
                GUIManager:getWindowByName(v4265):SetVisible(v4266)
            end
        )
    end
    GMHelper.ChangeNick = function(v3395)
        GMHelper:openInput(
            {""},
            function(v4267)
                PlayerManager:getClientPlayer().Player:setShowName(v4267)
                UIHelper.showToast("^FF00EENickNameChanged")
            end
        )
    end
    GMHelper.LongJump = function(v3396)
        LuaTimer:scheduleTimer(
            function()
                PlayerManager:getClientPlayer().Player:setGlide(true)
            end,
            0.2,
            9e+23
        )
    end
    GMHelper.AdvancedUp = function(v3397)
        GMHelper:openInput(
            {""},
            function(v4268)
                local v4269 = VectorUtil.newVector3(0, v4268, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v4269)
            end
        )
    end
    GMHelper.AdvancedIn = function(v3398)
        GMHelper:openInput(
            {""},
            function(v4270)
                local v4271 = VectorUtil.newVector3(v4270, 0, 0)
                PlayerManager:getClientPlayer().Player:moveEntity(v4271)
            end
        )
    end
    GMHelper.AdvancedOn = function(v3399)
        GMHelper:openInput(
            {""},
            function(v4272)
                local v4273 = VectorUtil.newVector3(0, 0, v4272)
                PlayerManager:getClientPlayer().Player:moveEntity(v4273)
            end
        )
    end
    GMHelper.AdvancedDirect = function(v3400)
        GMHelper:openInput(
            {"", "", ""},
            function(v4274, v4275, v4276)
                local v4277 = VectorUtil.newVector3(v4274, v4275, v4276)
                PlayerManager:getClientPlayer().Player:moveEntity(v4277)
            end
        )
    end
    GMHelper.tpPos = function(v3401)
        GMHelper:openInput(
            {"", "", ""},
            function(v4278, v4279, v4280)
                local v4281 = VectorUtil.newVector3(v4278, v4279, v4280)
                local v4282 = VectorUtil.newVector3(1, 10, 1)
                PlayerManager:getClientPlayer().Player:setPosition(v4281)
                PlayerManager:getClientPlayer().Player:moveEntity(v4282)
            end
        )
    end
    GMHelper.HideHoldItem = function(v3402)
        A = not A
        PlayerManager:getClientPlayer():setHideHoldItem(true)
        UIHelper.showToast("^FF00EETrue")
        if A then
            PlayerManager:getClientPlayer():setHideHoldItem(false)
            UIHelper.showToast("^FF00EEFalse")
        end
    end
    GMHelper.DevFlyI = function(v3403)
        local v3404 = VectorUtil.newVector3(0, 1.35, 0)
        local v3405 = PlayerManager:getClientPlayer()
        v3405.Player:setAllowFlying(true)
        v3405.Player:setFlying(true)
        v3405.Player:moveEntity(v3404)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.SharpFly = function(v3406)
        A = not A
        ClientHelper.putBoolPrefs("DisableInertialFly", true)
        UIHelper.showToast("^FF00EE[ON] works when you have dev flight enabled")
        if A then
            ClientHelper.putBoolPrefs("DisableInertialFly", false)
            UIHelper.showToast("^FF00EE[OFF] works when you have dev flight enabled")
        end
    end
    GMHelper.WaterPush = function(v3407)
        A = not A
        local v3408 = PlayerManager:getClientPlayer().Player
        v3408:setBoolProperty("ignoreWaterPush", true)
        UIHelper.showToast("^FF00EEON")
        if A then
            v3408:setBoolProperty("ignoreWaterPush", false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.changeScale = function(v3409)
        GMHelper:openInput(
            {""},
            function(v4283)
                local v4284 = PlayerManager:getClientPlayer().Player
                v4284:setScale(v4283)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.BlockOFF = function(v3410)
        GMHelper:openInput(
            {""},
            function(v4285)
                local v4286 = v4285
                local v4287 = BlockManager.getBlockById(v4286)
                v4287:setBlockBounds(0, 0, 0, 0, 0, 0)
            end
        )
    end
    GMHelper.BlockON = function(v3411)
        GMHelper:openInput(
            {""},
            function(v4288)
                local v4289 = v4288
                local v4290 = BlockManager.getBlockById(v4289)
                v4290:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        )
    end
    GMHelper.SpeedManager = function(v3412)
        GMHelper:openInput(
            {""},
            function(v4291)
                PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(v4291)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SpeedUp = function(v3413)
        ClientHelper.putIntPrefs("SpeedAddMax", 20000000)
        UIHelper.showToast("^00FF00[DANGER]")
    end
    GMHelper.XRayManagerON = function(v3414)
        GMHelper:openInput(
            {"erase this text and write block id"},
            function(v4292)
                cBlockManager.cGetBlockById(v4292):setNeedRender(false)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.XRayManagerOFF = function(v3415)
        GMHelper:openInput(
            {"erase this text and write block id"},
            function(v4293)
                cBlockManager.cGetBlockById(v4293):setNeedRender(true)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.OFFDARK = function(v3416)
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for v4294 = 1, 40000 do
            local v4295 = BlockManager.getBlockById(v4294)
            if v4295 then
                v4295:setLightValue(150, 150, 150)
                UIHelper.showToast("^00FF00Success")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.ONDARK = function(v3417)
        cBlockManager.cGetBlockById(66):setNeedRender(true)
        cBlockManager.cGetBlockById(253):setNeedRender(true)
        for v4296 = 1, 40000 do
            local v4297 = BlockManager.getBlockById(v4296)
            if v4297 then
                v4297:setLightValue(0, 0, 0)
                UIHelper.showToast("^00FF00success")
                GUIGMControlPanel:hide()
            end
        end
    end
    GMHelper.SpawnNPC = function(v3418)
        GMHelper:openInput(
            {".actor"},
            function(v4298)
                local v4299 = PlayerManager:getClientPlayer():getPosition()
                local v4300 = PlayerManager:getClientPlayer():getYaw()
                EngineWorld:addActorNpc(
                    v4299,
                    v4300,
                    v4298,
                    function(v4742)
                    end
                )
            end
        )
    end
    GMHelper.TeleportByUID = function(v3419)
        GMHelper:openInput(
            {"id player"},
            function(v4301)
                local v4302 = PlayerManager:getClientPlayer().Player
                local v4303 = PlayerManager:getPlayerByUserId(v4301)
                if v4303 then
                    v4302:setPosition(v4303:getPosition())
                end
            end
        )
    end
    GMHelper.ChangeActorForMe = function(v3420)
        local v3421 = PlayerManager:getClientPlayer().Player
        GMHelper:openInput(
            {".actor"},
            function(v4304)
                Blockman.Instance():getWorld():changePlayerActor(v3421, v4304)
                Blockman.Instance():getWorld():changePlayerActor(v3421, v4304)
                v3421.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(v3421)
                UIHelper.showToast("^00FF00Success")
            end
        )
    end
    GMHelper.AFKmode = function(v3422)
        A = not A
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1
        UIHelper.showToast("^FF00EEStart")
        if A then
            PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
            UIHelper.showToast("^FF00EEStop")
        end
    end
    GMHelper.DevnoClip = function(v3424)
        A = not A
        PlayerManager:getClientPlayer().Player.noClip = true
        UIHelper.showToast("^FF00EETurned on")
        if A then
            PlayerManager:getClientPlayer().Player.noClip = false
            UIHelper.showToast("^FF00EETurned off")
        end
    end
    GMHelper.StepHeight = function(v3426)
        GMHelper:openInput(
            {"StepHeight Value"},
            function(v4306)
                PlayerManager:getClientPlayer().Player.stepHeight = v4306
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SpYaw = function(v3427)
        A = not A
        PlayerManager:getClientPlayer().Player.spYaw = true
        UIHelper.showToast("^FF00EEON")
        if A then
            PlayerManager:getClientPlayer().Player.spYaw = false
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.SpYawSet = function(v3429)
        GMHelper:openInput(
            {""},
            function(v4308)
                PlayerManager:getClientPlayer().Player.spYawRadian = v4308
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.HairSet = function(v3430)
        GMHelper:openInput(
            {""},
            function(v4310)
                PlayerManager:getClientPlayer().Player.m_isEquipWing = true
                PlayerManager:getClientPlayer().Player.m_isClothesChange = true
                PlayerManager:getClientPlayer().Player.m_isClothesChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SetHideAndShowArmor = function(v3431)
        A = not A
        LogicSetting.Instance():setHideArmor(true)
        UIHelper.showToast("^FF00EEON")
        if A then
            LogicSetting.Instance():setHideArmor(false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.SettingLongjump = function(v3432)
        GMHelper:openInput(
            {"speedglide", "drop resistance"},
            function(v4314, v4315)
                local v4316 = PlayerManager:getClientPlayer().Player
                v4316.m_isGlide = true
                v4316.m_glideMoveAddition = v4314
                v4316.m_glideDropResistance = v4315
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.SetAlpha = function(v3433)
        GMHelper:openInput(
            {"Gui name", "alpha"},
            function(v4320, v4321)
                GUIManager:getWindowByName(v4320):SetAlpha(v4321)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeHair = function(v3434)
        GMHelper:openInput(
            {"number"},
            function(v4322)
                local v4323 = PlayerManager:getClientPlayer().Player
                v4323.m_outLooksChanged = true
                v4323.m_hairID = v4322
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeFace = function(v3435)
        GMHelper:openInput(
            {"number"},
            function(v4326)
                local v4327 = PlayerManager:getClientPlayer().Player
                v4327.m_outLooksChanged = true
                v4327.m_faceID = v4326
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeTops = function(v3436)
        GMHelper:openInput(
            {"number"},
            function(v4330)
                local v4331 = PlayerManager:getClientPlayer().Player
                v4331.m_outLooksChanged = true
                v4331.m_topsID = v4330
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangePants = function(v3437)
        GMHelper:openInput(
            {"number"},
            function(v4334)
                local v4335 = PlayerManager:getClientPlayer().Player
                v4335.m_outLooksChanged = true
                v4335.m_pantsID = v4334
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeShoes = function(v3438)
        GMHelper:openInput(
            {"number"},
            function(v4338)
                local v4339 = PlayerManager:getClientPlayer().Player
                v4339.m_outLooksChanged = true
                v4339.m_shoesID = v4338
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeGlasses = function(v3439)
        GMHelper:openInput(
            {"number"},
            function(v4342)
                local v4343 = PlayerManager:getClientPlayer().Player
                v4343.m_outLooksChanged = true
                v4343.m_glassesId = v4342
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeScarf = function(v3440)
        GMHelper:openInput(
            {"number"},
            function(v4346)
                local v4347 = PlayerManager:getClientPlayer().Player
                v4347.m_outLooksChanged = true
                v4347.m_scarfId = v4346
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeWing = function(v3441)
        GMHelper:openInput(
            {"number"},
            function(v4350)
                local v4351 = PlayerManager:getClientPlayer().Player
                v4351.m_outLooksChanged = true
                v4351.m_wingId = v4350
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeHat = function(v3442)
        GMHelper:openInput(
            {"number"},
            function(v4354)
                PlayerManager:getClientPlayer().Player.m_hatId = v4354
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeDecHat = function(v3443)
        GMHelper:openInput(
            {"number"},
            function(v4357)
                PlayerManager:getClientPlayer().Player.m_decorate_hatId = v4357
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeTail = function(v3444)
        GMHelper:openInput(
            {"number"},
            function(v4360)
                PlayerManager:getClientPlayer().Player.m_tailId = v4360
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeBagI = function(v3445)
        GMHelper:openInput(
            {"number"},
            function(v4363)
                PlayerManager:getClientPlayer().Player.m_bagId = v4363
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.ChangeCrown = function(v3446)
        GMHelper:openInput(
            {""},
            function(v4366)
                PlayerManager:getClientPlayer().Player.m_crownId = v4366
                PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.CreateGUIDEArrow = function(v3447)
        local v3448 = PlayerManager:getClientPlayer():getPosition()
        PlayerManager:getClientPlayer().Player:addGuideArrow(v3448)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.DelAllGUIDEArrow = function(v3449)
        PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.JetPack = function(v3450)
        A = not A
        PlayerManager:getClientPlayer().Player.m_keepJumping = false
        UIHelper.showToast("^FF00EEВключено")
        if A then
            PlayerManager:getClientPlayer().Player.m_keepJumping = true
            UIHelper.showToast("^FF00EEВыключено")
        end
    end
    GMHelper.init1 = function(v3452)
        GUIManager:showWindowByName("DeathSettlement.binary")
        GUIManager:showWindowByName("DeathSettlement.json")
        GUIManager:setWindowByName("DeathSettlement.json"):SetVisible(true)
        GUIManager:setWindowByName("DeathSettlement.binary"):SetVisible(true)
    end
    GMHelper.init2 = function(v3453)
        local v3454 = PlayerManager:getClientPlayer().Player
        Blockman.Instance():getWorld():changePlayerActor(v3454, angel)
        Blockman.Instance():getWorld():changePlayerActor(v3454, angel)
        v3454.m_isPeopleActor = false
    end
    GMHelper.setGlide = function(v3456)
        A = not A
        PlayerManager:getClientPlayer().Player:setGlide(true)
        UIHelper.showToast("^00FF00Enabled")
        if A then
            PlayerManager:getClientPlayer().Player:setGlide(false)
            UIHelper.showToast("^00FF00Disabled")
        end
    end
    GMHelper.RespawnTool = function(v3457)
        PacketSender:getSender():sendRebirth()
    end
    GMHelper.makeGmButtonShow = function(v3458)
        GUIGMMain:setShow()
    end
    GMHelper.test666 = function(v3459)
        PlayerManager:getClientPlayer().Player:startParachute()
    end
    GMHelper.test555 = function(v3460)
        local v3461 = VectorUtil.newVector3(0, 1.35, 0)
        local v3462 = PlayerManager:getClientPlayer()
        v3462.Player:setAllowFlying(true)
        v3462.Player:setFlying(true)
        v3462.Player:moveEntity(v3461)
        PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(150000)
    end
    GMHelper.ReachIn = function(v3463)
        GMHelper:openInput(
            {"Val1", "Val2"},
            function(v4369, v4370)
                ClientHelper.putFloatPrefs("BlockReachDistance", v4369)
                ClientHelper.putFloatPrefs("EntityReachDistance", v4370)
            end
        )
    end
    GMHelper.Tus = function(v3464)
        GMHelper:openInput(
            {"Game", "Map"},
            function(v4371, v4372)
                Game:resetGame(v4371, PlayerManager:getClientPlayer().userId, v4372)
            end
        )
    end
    GMHelper.UserQ = function(v3465)
        UIHelper.showToast("ID: " .. PlayerManager:getClientPlayer().userId)
    end
    GMHelper.YawQ = function(v3466)
        UIHelper.showToast("Yaw: " .. PlayerManager:getClientPlayer():getYaw())
    end
    GMHelper.ItemQ = function(v3467)
        GMHelper:openInput(
            {"ID"},
            function(v4373)
                UIHelper.showToast("Item: " .. Lang:getItemName(v4373))
            end
        )
    end
    GMHelper.TimeW = function(v3468)
        local v3469 = EngineWorld:getWorld()
        local v3470 = v3469:getWorldTime()
        UIHelper.showToast("Time: " .. v3470)
    end
    GMHelper.RainbowWing = function(v3471)
        PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
        PlayerManager:getClientPlayer().Player.m_wingId = 27
        UIHelper.showToast("^FF00EEУспешно")
    end
    GMHelper.XLGoldWing = function(v3474)
        PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
        PlayerManager:getClientPlayer().Player.m_wingId = 26
        UIHelper.showToast("^FF00EEУспешно")
    end
    GMHelper.RedWing = function(v3477)
        PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
        PlayerManager:getClientPlayer().Player.m_wingId = 25
        UIHelper.showToast("^FF00EEУспешно")
    end
    GMHelper.CokieUwU = function(v3480)
        PlayerManager:getClientPlayer().Player.m_outLooksChanged = true
        PlayerManager:getClientPlayer().Player.m_wingId = 24
        UIHelper.showToast("^FF00EEУспешно")
    end
    GMHelper.Toast = function(v3483)
        GMHelper:openInput(
            {"Text"},
            function(v4374)
                UIHelper.showToast(v4374)
            end
        )
    end
    GMHelper.Pizdec = function(v3484)
        showEngineWindow("Main-VisibleBar")
        showEngineWindow("Main-ItemBarBg")
        showEngineWindow("Main-Control")
        showEngineWindow("Main-FlyingControls")
        showEngineWindow("Main-Fly")
        showEngineWindow("Main-PoleControl")
        showEngineWindow("Main-PoleControl-Move")
        showEngineWindow("Main-MoveState")
        showEngineWindow("Main-Skill-Release-btn")
        showEngineWindow("Main-Jump-Controls")
    end
    GMHelper.GetTextLang = function(v3485)
        GMHelper:openInput(
            {"String"},
            function(v4375)
                local v4376 = Lang:getString(v4375)
                CustomDialog.builder().setContentText(v4376).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.noLeftDialog = function(v3486)
        GMHelper:openInput(
            {"Text", "BtnName"},
            function(v4377, v4378)
                CustomDialog.builder().setContentText(v4377).setRightText(v4378).setHideLeftButton().show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.noRightDialog = function(v3487)
        GMHelper:openInput(
            {"Text", "BtnName"},
            function(v4379, v4380)
                CustomDialog.builder().setContentText(v4379).setHideRightButton().setLeftText(v4380).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.customDialogScr = function(v3488)
        GMHelper:openInput(
            {"Text", "Btn1Name", "Btn2Name", "ScrTextToast1", "ScrTextToast2"},
            function(v4381, v4382, v4383, v4384, v4385)
                CustomDialog.builder().setContentText(v4381).setRightText(v4382).setLeftText(v4383).setRightClickListener(
                    function()
                        UIHelper.showToast(v4384)
                    end
                ).setLeftClickListener(
                    function()
                        UIHelper.showToast(v4385)
                    end
                ).show()
                GUIGMControlPanel:hide()
            end
        )
    end
    GMHelper.ToggleShowPlayersHP = function(v3489)
        if (ModsConfig.IS_SHOW_PLAYERS_HP == true) then
            ModsConfig.IS_SHOW_PLAYERS_HP = false
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Show players health = " .. tostring(ModsConfig.IS_SHOW_PLAYERS_HP))
        else
            ModsConfig.IS_SHOW_PLAYERS_HP = true
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Show players health = " .. tostring(ModsConfig.IS_SHOW_PLAYERS_HP))
        end
    end
    GMHelper.CopyPlayersInfo = function(v3490)
        local v3491 = ""
        local v3492 = PlayerManager:getPlayers()
        for v4386, v4387 in pairs(v3492) do
            v3491 =
                v3491 ..
                "\n[Player Info] " ..
                    string.format(
                        "Username: %s | User ID: %s | Gender: %s",
                        v4387:getName(),
                        v4387.userId,
                        v4387.Player:getSex()
                    )
        end
        ClientHelper.onSetClipboard(v3491)
    end
    GMHelper.CloseGame = function(v3493, v3494)
        Game:exitGame(v3494)
    end
    GMHelper.SetNameColor = function(v3495, v3496)
        ModsConfig.PLAYER_NAME_COLOR = v3496
    end
    GMHelper.HidePlayersActor = function(v3498)
        if (ModsConfig.IS_PLAYERS_ACTORS_HIDDEN == true) then
            ModsConfig.IS_PLAYERS_ACTORS_HIDDEN = false
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Hide players actors = " .. tostring(ModsConfig.IS_PLAYERS_ACTORS_HIDDEN))
        else
            ModsConfig.IS_PLAYERS_ACTORS_HIDDEN = true
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Hide players actors = " .. tostring(ModsConfig.IS_PLAYERS_ACTORS_HIDDEN))
        end
    end
    GMHelper.HidePlayers = function(v3499)
        if (ModsConfig.IS_PLAYERS_HIDDEN == true) then
            ModsConfig.IS_PLAYERS_HIDDEN = false
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Hide players = " .. tostring(ModsConfig.IS_PLAYERS_HIDDEN))
        else
            ModsConfig.IS_PLAYERS_HIDDEN = true
            GUIGMControlPanel:hide()
            MsgSender.sendBottomTips(5, "Hide players = " .. tostring(ModsConfig.IS_PLAYERS_HIDDEN))
        end
    end
    GMHelper.SwitchPerson = function(v3500, v3501)
        Blockman.Instance():setPersonView(v3501)
        GUIGMControlPanel:hide()
    end
    GMHelper.SpawnGottya = function(v3502)
        GMHelper:openInput(
            {""},
            function(v4388)
                local v4389 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:setBlock(v4389, v4388)
            end
        )
    end
    GMHelper.SetFOV = function(v3503)
        GMHelper:openInput(
            {""},
            function(v4390)
                Blockman.Instance().m_gameSettings:setFovSetting(v4390)
                UIHelper.showToast("success")
            end
        )
    end
    GMHelper.BlockReachSet = function(v3504)
        GMHelper:openInput(
            {"Input Float. Default: 6.5"},
            function(v4391)
                ClientHelper.putFloatPrefs("BlockReachDistance", v4391)
                UIHelper.showToast("done")
            end
        )
    end
    GMHelper.ReachSet = function(v3505)
        GMHelper:openInput(
            {"Delete this sentence and type your reach. Default: 5"},
            function(v4392)
                ClientHelper.putFloatPrefs("EntityReachDistance", v4392)
                UIHelper.showToast("sukses")
            end
        )
    end
    GMHelper.SpamRespawn = function(v3506)
        GMHelper:openInput(
            {""},
            function(v4393)
                for v4753 = 1, v4393 do
                    PacketSender:getSender():sendRebirth()
                end
            end
        )
    end
    GMHelper.ShowReviveUI = function(v3507)
        local v3508 = {}
        v3508.watchAdTimesLimit = true
        v3508.AdType = 101401
        v3508.showUITime = 10
        v3508.revivePrice = 10
        v3508.invincibleTimeHere = 3
        v3508.invincibleTimeBase = 5
        UIHelper.showGameGUILayout("GUIVideoAdAndCubeTip", v3508)
    end
    GMHelper.OffShowReviveUI = function(v3515)
        local v3516 = {}
        v3516.watchAdTimesLimit = false
        v3516.AdType = 101401
        v3516.showUITime = 10
        v3516.revivePrice = 10
        v3516.invincibleTimeHere = 3
        v3516.invincibleTimeBase = 5
        UIHelper.showGameGUILayout("GUIVideoAdAndCubeTip", v3516)
    end
    GMHelper.ShowReviveDialogUI = function(v3523)
        local v3524 = {}
        v3524.watchAdTimesLimit = packet.watchAdTimesLimit
        v3524.AdType = packet.AdType
        v3524.showUITime = packet.showUITime
        v3524.revivePrice = packet.revivePrice
        v3524.invincibleTimeHere = packet.invincibleTimeHere
        v3524.invincibleTimeBase = packet.invincibleTimeBase
        UIHelper.showGameGUILayout("GUIVideoAdAndCubeTip", v3524)
    end
    GMHelper.Rvanka = function(v3537)
        GMHelper:openInput(
            {"id"},
            function(v4394)
                LuaTimer:scheduleTimer(
                    function()
                        local v4754 = PlayerManager:getClientPlayer().Player
                        local v4755 = PlayerManager:getPlayerByUserId(v4394)
                        if v4755 then
                            v4754:setPosition(v4755:getPosition())
                        end
                    end,
                    0.1,
                    1e+38
                )
            end
        )
    end
    GMHelper.Tracer = function(v3538)
        UIHelper.showToast("^FF00EE[ON]")
        local v3539 = PlayerManager:getClientPlayer()
        LuaTimer:scheduleTimer(
            function()
                PlayerManager.getClientPlayer().Player:deleteAllGuideArrow()
                local v4395 = PlayerManager:getPlayers()
                for v4756, v4757 in pairs(v4395) do
                    if (v4757 ~= v3539) then
                        v3539.Player:addGuideArrow(v4757:getPosition())
                    end
                end
            end,
            500,
            -1
        )
    end
    GMHelper.updateBedWarArrowSpeed = function(v3540)
        GMHelper:openInput(
            {"speed"},
            function(v4396)
                local v4397 = tonumber(v4396) or 0
                PlayerManager:getClientPlayer().Player:setFloatProperty("ArrowSpeedScale", v4397)
                PlayerManager:getClientPlayer():sendPacket({pid = "updateBedWarArrowSpeed", scale = v4397})
            end
        )
    end
    GMHelper.Scaffold = function(v3541)
        A = not A
        LuaTimer:cancel(v3541.timer)
        UIHelper.showToast("^00FF00Scaffold TurnOFF")
        if A then
            GMHelper:openInput(
                {"BlockID"},
                function(v4975)
                    v3541.timer =
                        LuaTimer:scheduleTimer(
                        function()
                            local v5126 = PlayerManager:getClientPlayer():getPosition()
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x, v5126.y - 2, v5126.z), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x - 1, v5126.y - 2, v5126.z - 1), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x + 1, v5126.y - 2, v5126.z + 1), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x, v5126.y - 2, v5126.z + 1), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x, v5126.y - 2, v5126.z - 1), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x + 1, v5126.y - 2, v5126.z), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x - 1, v5126.y - 2, v5126.z), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x - 1, v5126.y - 2, v5126.z + 1), v4975)
                            EngineWorld:setBlock(VectorUtil.newVector3(v5126.x + 1, v5126.y - 2, v5126.z - 1), v4975)
                        end,
                        0.15,
                        -1
                    )
                    UIHelper.showToast("^00FF00Scaffold TurnON")
                end
            )
        end
    end
    GMHelper.Scaffald = function(v3542)
        A = not A
        LuaTimer:cancel(v3542.timer)
        UIHelper.showToast("Closed.")
        if A then
            v3542.timer =
                LuaTimer:scheduleTimer(
                function()
                    local v4977 = PlayerManager:getClientPlayer():getPosition()
                    EngineWorld:setBlock(VectorUtil.newVector3(v4977.x, v4977.y - 2, v4977.z), 116)
                end,
                0.15,
                1e+28
            )
            UIHelper.showToast("Oppened.")
        end
    end
    GMHelper.Scaffuld = function(v3543)
        A = not A
        LuaTimer:cancel(v3543.timer)
        UIHelper.showToast("Closed.")
        if A then
            v3543.timer =
                LuaTimer:scheduleTimer(
                function()
                    local v4978 = PlayerManager:getClientPlayer():getPosition()
                    EngineWorld:setBlock(VectorUtil.newVector3(v4978.x, v4978.y - 2, v4978.z), 0)
                end,
                0.15,
                1e+28
            )
            UIHelper.showToast("Oppened.")
        end
    end
    GMHelper.Scaffeld = function(v3544)
        A = not A
        LuaTimer:cancel(v3544.timer)
        UIHelper.showToast("Closed.")
        if A then
            v3544.timer =
                LuaTimer:scheduleTimer(
                function()
                    local v4979 = PlayerManager:getClientPlayer():getPosition()
                    EngineWorld:setBlock(VectorUtil.newVector3(v4979.x, v4979.y - 2, v4979.z), 1)
                end,
                0.15,
                1e+28
            )
            UIHelper.showToast("Oppened.")
        end
    end
    GMHelper.ChangeBlockTextures = function(v3545, v3546)
        local v3547 = GMHelper.guiTextures or false
        if not v3547 then
            Blockman.Instance():changeBlockTextures("./gui.zip")
            GMHelper.guiTextures = true
        else
            Blockman.Instance():changeBlockTextures("")
            GMHelper.guiTextures = false
        end
        if (#v3546 > 0) then
            Blockman.Instance():changeBlockTextures("Media/Textures/package/" .. v3546)
        else
            Blockman.Instance():changeGuiTextures("")
        end
        GUIGMControlPanel:hide()
    end
    GMHelper.texturecrash = function(v3548)
        local v3549 = "Не ебу, Иди нахуй. "
        local v3550 = "САМ ИДИ НАХУЙ"
        local v3551 = "Фикс :"
        CustomDialog.builder().setContentText(v3549).setRightText(v3550).setTitleText(v3551).setHideLeftButton().setPanelSize(
            600,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.Creator = function(v3552)
        local v3553 = PlayerManager:getClientPlayer().Player
        v3553.m_canBuildBlockQuickly = true
        v3553.m_quicklyBuildBlock = true
        UIHelper.showToast("^00FF00@RICHH_BG")
    end
    GMHelper.XLParachute = function(v3556)
        GUIManager:getWindowByName("Main-Parachute"):SetVisible(true)
        GUIManager:getWindowByName("Main-Parachute", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                PlayerManager:getClientPlayer().Player:startParachute()
                UIHelper.showToast("^00FF00ON")
            end
        )
    end
    GMHelper.AutoParachute = function(v3557)
        A = not A
        LuaTimer:cancel(v3557.timer)
        UIHelper.showToast("^00FF00AutoParachute OFF")
        if A then
            v3557.timer =
                LuaTimer:scheduleTimer(
                function()
                    PlayerManager:getClientPlayer().Player:startParachute()
                    UIHelper.showToast("^00FF00AutoParachute ON")
                end,
                0.15,
                -1
            )
        end
    end
    GMHelper.XLParachuteX = function(v3558)
        GUIManager:getWindowByName("Main-Parachute"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.TNTButtonViewX = function(v3559)
        GUIManager:showWindowByName("Main-throwpot-Controls")
        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.ViewFreecam = function(v3560)
        GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible(true)
        GUIGMControlPanel:hide()
    end
    GMHelper.ViewFreecamX = function(v3561)
        GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.AutoSpawnNPC = function(v3562)
        GMHelper:openInput(
            {"TypeValue"},
            function(v4398)
                LuaTimer:scheduleTimer(
                    function()
                        local v4764 = PlayerManager:getClientPlayer()
                        local v4765 = v4764.Player:getPosition()
                        local v4766 = PlayerManager:getPlayers()
                        for v4980, v4981 in pairs(v4766) do
                            if (v4981 ~= v4764) then
                                local v5213 = v4981:getPosition()
                                local v5214 = MathUtil:distanceSquare2d(v5213, v4765)
                                if (v5214 < 35) then
                                    EngineWorld:addActorNpc(
                                        v5213,
                                        0,
                                        v4398,
                                        function(v5252)
                                        end
                                    )
                                end
                            end
                        end
                    end,
                    100,
                    -1
                )
            end
        )
    end
    GMHelper.ViewBomba = function(v3563)
        GUIManager:getWindowByName("Main-Cannon"):SetVisible(true)
        GUIManager:getWindowByName("Main-Cannon", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                local v4399 = 0
                local v4400 = 3
                local v4401 = 0
                local v4402 = VectorUtil.newVector3(v4399, v4400, v4401)
                PlayerManager:getClientPlayer().Player:setVelocity(v4402)
                UIHelper.showToast("^00FF00By Richh and zxcEnter")
            end
        )
    end
    GMHelper.ViewBombaX = function(v3564)
        GUIManager:getWindowByName("Main-Cannon"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.ViewRaket = function(v3565)
        GUIManager:getWindowByName("Main-BuildWar-Block"):SetVisible(true)
        GUIManager:getWindowByName("Main-BuildWar-Block", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                local v4403 = VectorUtil.newVector3(0, 1.35, 0)
                local v4404 = PlayerManager:getClientPlayer()
                v4404.Player:setAllowFlying(true)
                v4404.Player:setFlying(true)
                v4404.Player:moveEntity(v4403)
                PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(150000)
                UIHelper.showToast("^00FF00ON")
            end
        )
    end
    GMHelper.ViewRaketX = function(v3566)
        GUIManager:getWindowByName("Main-BuildWar-Block"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.ViewRespawn = function(v3567)
        GUIManager:getWindowByName("Main-BlockFort-Del-Shortcut"):SetVisible(true)
        GUIManager:getWindowByName("Main-BlockFort-Del-Shortcut", GUIType.Button):registerEvent(
            GUIEvent.ButtonClick,
            function()
                PacketSender:getSender():sendRebirth()
                UIHelper.showToast("^00FF00ON")
            end
        )
    end
    GMHelper.ViewRespawnX = function(v3568)
        GUIManager:getWindowByName("Main-BlockFort-Del-Shortcut"):SetVisible(false)
        GUIGMControlPanel:hide()
    end
    GMHelper.AutoClick = function(v3569)
        A = not A
        LuaTimer:cancel(v3569.timer)
        UIHelper.showToast("^00FF00AutoClick OFF")
        if A then
            v3569.timer =
                LuaTimer:scheduleTimer(
                function()
                    CGame.Instance():handleTouchClick(800, 50)
                    UIHelper.showToast("^00FF00AutoClick ON")
                end,
                0.15,
                -1
            )
        end
    end
    GMHelper.AutoClickX = function(v3570)
        A = not A
        LuaTimer:cancel(v3570.timer)
        UIHelper.showToast("^00FF00AutoClick (Bost) OFF")
        if A then
            v3570.timer =
                LuaTimer:scheduleTimer(
                function()
                    CGame.Instance():handleTouchClick(800, 360)
                    UIHelper.showToast("^00FF00AutoClick (Bost) ON")
                end,
                0.15,
                -1
            )
        end
    end
    GMHelper.XPWarnLevel = function(v3571)
        local v3572 = PlayerManager:getClientPlayer().Player
        v3572.m_canBuildBlockQuickly = false
        v3572.m_quicklyBuildBlock = true
        UIHelper.showToast("^00FF00WARN XP = LEVEL")
    end
    GMHelper.Razmer1 = function(v3575)
        local v3576 = PlayerManager:getClientPlayer()
        local v3577 = PlayerManager:getPlayers()
        for v4405, v4406 in pairs(v3577) do
            if (v4406 ~= v3576) then
                v4406:setScale(1)
                UIHelper.showToast("^00FF00ON")
            end
        end
    end
    GMHelper.Razmer2 = function(v3578)
        local v3579 = PlayerManager:getClientPlayer()
        local v3580 = PlayerManager:getPlayers()
        for v4407, v4408 in pairs(v3580) do
            if (v4408 ~= v3579) then
                v4408:setScale(6)
                UIHelper.showToast("^00FF00ON")
            end
        end
    end
    GMHelper.Razmer3 = function(v3581)
        local v3582 = PlayerManager:getClientPlayer()
        local v3583 = PlayerManager:getPlayers()
        for v4409, v4410 in pairs(v3583) do
            if (v4410 ~= v3582) then
                v4410:setScale(12)
                UIHelper.showToast("^00FF00ON")
            end
        end
    end
    GMHelper.ChangeActorTextures = function(v3584, v3585)
        local v3586 = GMHelper.guiTextures or false
        if not v3586 then
            Blockman.Instance():changeBlockTextures("./gui.zip")
            GMHelper.guiTextures = true
        else
            Blockman.Instance():changeBlockTextures("")
            GMHelper.guiTextures = false
        end
        if (#v3585 > 0) then
            Blockman.Instance():changeBlockTextures("Media/Actor/package/" .. v3585)
        else
            Blockman.Instance():changeGuiTextures("")
        end
        GUIGMControlPanel:hide()
    end
    GMHelper.SetUpBuild = function(v3587)
        GMHelper:openInput(
            {""},
            function(v4411)
                ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v4411)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.EasyWay = function(v3588)
        local v3589 = PlayerManager:getClientPlayer():getInventory()
        v3589:removeAllItemFromHotBar()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.WatchMode = function(v3590)
        A = not A
        local v3591 = VectorUtil.newVector3(0, 1.35, 0)
        PlayerManager:getClientPlayer().Player:setAllowFlying(true)
        PlayerManager:getClientPlayer().Player:setFlying(true)
        PlayerManager:getClientPlayer().Player:setWatchMode(true)
        PlayerManager:getClientPlayer().Player:moveEntity(v3591)
        UIHelper.showToast("^FF00EEON")
        if A then
            PlayerManager:getClientPlayer().Player:setAllowFlying(false)
            PlayerManager:getClientPlayer().Player:setFlying(false)
            PlayerManager:getClientPlayer().Player:setWatchMode(false)
            UIHelper.showToast("^FF00EEOFF")
        end
    end
    GMHelper.ShowRegion = function(v3592)
        UIHelper.showToast("RegionID=" .. Game:getRegionId())
    end
    GMHelper.GameID = function(v3593)
        UIHelper.showToast("GameID=" .. CGame.Instance():getGameType())
    end
    GMHelper.LogInfo = function(v3594)
        local v3595 = HostApi.getClientInfo()
        ClientHelper.onSetClipboard(v3595)
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.GetAllInfoT = function(v3596)
        local v3597 = PlayerManager:getPlayers()
        for v4412, v4413 in pairs(v3597) do
            MsgSender.sendMsg(
                "^00FF00INFO: " ..
                    string.format(
                        "^00FF00UserName: %s {} ID: %s {} Gender: %s",
                        v4413:getName(),
                        v4413.userId,
                        v4413.Player:getSex()
                    )
            )
        end
    end
    GMHelper.test2300 = function(v3598)
        GMHelper:openInput(
            {""},
            function(v4414)
                local v4415 = PlayerManager:getClientPlayer().Player
                v4415.length = v4414
                v4415.isCollidedHorizontally = true
                v4415.isCollidedVertically = true
                v4415.isCollided = true
            end
        )
    end
    GMHelper.test1222 = function(v3599)
        local v3600 = PlayerManager:getClientPlayer().Player
        v3600.m_canBuildBlockQuickly = true
        v3600.m_quicklyBuildBlock = true
        UIHelper.showToast("2:")
    end
    GMHelper.test2222 = function(v3603)
        local v3604 = PlayerManager:getClientPlayer().Player
        v3604.m_opacity = 0.2
        UIHelper.showToast("1:")
    end
    GMHelper.spawnCar = function(v3606)
        GMHelper:openInput(
            {"Car ID (erase this text and write carID)"},
            function(v4420)
                local v4421 = PlayerManager:getClientPlayer():getPosition()
                local v4422 = PlayerManager:getClientPlayer():getYaw()
                Blockman.Instance():getWorld():addVehicle(v4421, v4420, v4422)
                UIHelper.showToast("^FF00EECar Spawn Success")
            end
        )
    end
    GMHelper.SpawnItemX = function(v3607)
        GMHelper:openInput(
            {"ID", "Count"},
            function(v4423, v4424)
                local v4425 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:addEntityItem(v4423, v4424, 0, 600, v4425, VectorUtil.ZERO)
            end
        )
    end
    GMHelper.SpawnItem = function(v3608, v3609)
        EngineWorld:addEntityItem(
            v3609,
            1,
            nil,
            nil,
            PlayerManager:getClientPlayer().Player:getPosition(),
            VectorUtil.ZERO,
            true,
            true
        )
    end
    GMHelper.CheckUpdates = function(v3610)
        SoundUtil.playSound(1)
        local v3611 =
            "To find out if a new panel update has been released, follow the link below. \nhttps://pastebin.com/raw/y4U69Ted\nThe link will change with each update!"
        local v3612 = "OK"
        local v3613 = "https://pastebin.com/raw/y4U69Ted"
        local v3614 = "The link has been copied to the clipboard!"
        CustomDialog.builder().setContentText(v3611).setRightText(v3612).setHideLeftButton().setRightClickListener(
            function()
                ClientHelper.onSetClipboard(v3613)
                UIHelper.showCenterToast(v3614, 5000)
            end
        ).setLeftClickListener(
            function()
                UIHelper.showToast(scrm)
            end
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.CrashFix = function(v3615)
        local v3616 =
            "If you don't understand how to run 'bypass.lua' correctly, then read this short guide.(\n1)Launch the GameGuardian, then enter the Bedwars.\n2)As soon as you enter, select the Bedwars process and run the 'bypass.lua' script, then select the Bedwars(BlockmanGo) process and run the script again.\n3)If the gameguard writes that the game or process has been completed, i.e. closed, then you select two processes again and run the script.\n4)After exiting the mode, immediately select these two processes again and run the script(GameGuardian will tell you that they have been closed)."
        local v3617 = "OK"
        local v3618 = "How to fix crashes."
        CustomDialog.builder().setContentText(v3616).setRightText(v3617).setTitleText(v3618).setHideLeftButton().setPanelSize(
            1200,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.EnteringValues = function(v3619)
        local v3620 =
            "If you're having trouble typing a value in a function and clicking the send button, and you're just wrapping it to another line, then use a different keyboard, such as from Microsoft\n(For example, you have selected the function to change wings, written a number, but you do not send a command)"
        local v3621 = "OK"
        local v3622 = "Fix Entering Values"
        CustomDialog.builder().setContentText(v3620).setRightText(v3621).setTitleText(v3622).setHideLeftButton().setPanelSize(
            600,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.updates = function(v3623)
        local v3624 =
            "Version 1.1 added:\nSetUpBuild, ChangeHat, ChangeTail, ChangeBagI, ChangeCrown, CreateGUIDEArrow, DelAllGUIDEArrow, EasyWay, WatchMode, Blink, NoFall, TreasureReset, QuickPlaceBlock, Parachute, FlyParachute and the 'README' category.\nI'll explain some of the functions (the rest are already clear)\nSetUpBuild - function lets you put down multiple blocks at once in a certain direction. You can choose how many blocks to place and the direction they'll go.\nCreateGUIDEArrow - creates an arrow underneath you, can be used as a marker.\nWatchMode - puts you in spectator mode.\nBlink - When you activate this feature, the character will remain where you activated the function, after which you can run anywhere and deal damage to everyone (you will not be visible).\nTreasureRest - Restore the mine in the TreasureHunter.\nFlyParachute - Gives you a fly and a parachute that is visible to all players (i.e. not visual)"
        local v3625 = "OK"
        local v3626 = "What's New?"
        CustomDialog.builder().setContentText(v3624).setRightText(v3625).setTitleText(v3626).setHideLeftButton().setPanelSize(
            1200,
            450
        ).show()
        GUIGMControlPanel:hide()
    end
    GMHelper.BlinkOP = function(v3627)
        A = not A
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        if A then
            UIHelper.showToast("^00FF00Blink Enabled!")
            return
        end
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        UIHelper.showToast("^00FF00Blink Disabled!")
    end
    GMHelper.NoFall = function(v3628)
        A = not A
        ClientHelper.putIntPrefs("SprintLimitCheck", 7)
        if A then
            UIHelper.showToast("Enabled")
            return
        end
        ClientHelper.putIntPrefs("SprintLimitCheck", 0)
        UIHelper.showToast("Disabled")
    end
    GMHelper.NoFallSet = function(v3629)
        GMHelper:openInput(
            {"TypeValue"},
            function(v4426)
                ClientHelper.putIntPrefs("SprintLimitCheck", v4426)
                UIHelper.showToast("Done, now it will have like a protection")
            end
        )
    end
    GMHelper.MineReset = function(v3630)
        local v3631 = VectorUtil.newVector3(536, 2.78, -136)
        local v3632 = VectorUtil.newVector3(0, 0, 0)
        PlayerManager:getClientPlayer().Player:setPosition(v3631)
        PlayerManager:getClientPlayer().Player:moveEntity(v3632)
    end
    GMHelper.quickblock = function(v3633)
        GMHelper:openInput(
            {""},
            function(v4427)
                ClientHelper.putIntPrefs("QuicklyBuildBlockNum", v4427)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.startParachute = function(v3634)
        PlayerManager:getClientPlayer().Player:startParachute()
    end
    GMHelper.FlyParachute = function(v3635)
        local v3636 = VectorUtil.newVector3(0, 1.35, 0)
        local v3637 = PlayerManager:getClientPlayer()
        v3637.Player:setAllowFlying(true)
        v3637.Player:setFlying(true)
        v3637.Player:moveEntity(v3636)
        PlayerManager:getClientPlayer().Player:startParachute()
        UIHelper.showToast("^FF00EESuccess")
    end
    GMHelper.SetBlockToAir = function(v3638)
        GMHelper:openInput(
            {"block Position X", "block Position Y", "block Position Z"},
            function(v4428, v4429, v4430)
                local v4431 = VectorUtil.newVector3(v4428, v4429, v4430)
                EngineWorld:setBlockToAir(v4431)
            end
        )
    end
    GMHelper.SetNameColor = function(v3639, v3640)
        ModsConfig.PLAYER_NAME_COLOR = v3640
    end
    GMHelper.SpawnBlock = function(v3642)
        GMHelper:openInput(
            {""},
            function(v4432)
                local v4433 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:setBlock(v4433, v4432)
            end
        )
    end
    GMHelper.getColorFromName = function(v3643, v3644)
        if (v3644 == "Red") then
            return "▢FF00FF00"
        end
        if (v3644 == "Blue") then
            return "▢FF0000FF"
        end
        if (v3644 == "Black") then
            return "▢FF000000"
        end
        if (v3644 == "White") then
            return "▢FFFFFFFF"
        end
        if (v3644 == "Green") then
            return "▢FF00FF00"
        end
        if (v3644 == "Yellow") then
            return "▢FF00FF00"
        end
        if (v3644 == "Purple") then
            return "▢FF00FF00"
        end
        if (v3644 == "Pink") then
            return "▢FFFF1B89"
        end
        if (v3644 == "Orange") then
            return "▢FFFF8000"
        end
        if (v3644 == "Gold") then
            return "▢FFFFD700"
        end
        if (v3644 == "Aqua") then
            return "▢FF00FFFF"
        end
    end
    GMHelper.updateShowPlayersActors = function(v3645)
        if (ModsConfig.IS_PLAYERS_ACTORS_HIDDEN == true) then
            v3645.Player:setActorInvisible(true)
        else
            v3645.Player:setActorInvisible(false)
        end
    end
    GMHelper.updateShowPlayers = function(v3646)
        if (ModsConfig.IS_PLAYERS_HIDDEN == true) then
            v3646.Player:setInvisible(true)
        else
            v3646.Player:setInvisible(false)
        end
    end
    GMHelper.init = function(v3647)
        v3647.lastShowHP = 0
        v3647.lastShowName = ""
        v3647.realName = ""
    end
    GMHelper.onUpdate = function(v3651)
        v3651:updateBLShowName()
        v3651:updateShowPlayersActors()
        v3651:updateShowPlayers()
    end
    GMHelper.setShowGunFlameCoordinate = function(v3652, v3653)
        Blockman.Instance():setShowGunFlameCoordinate(v3653)
        if v3653 then
            GUIGMControlPanel:setBackgroundColor(Color.TRANS)
        else
            GUIGMControlPanel:setBackgroundColor({0, 0, 0, 0.784314})
        end
    end
    GMHelper.BW = function(v3654)
        GMHelper:openInput(
            {""},
            function(v4434)
                ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", v4434)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.BWV2 = function(v3655)
        GMHelper:openInput(
            {""},
            function(v4435)
                ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", v4435)
                UIHelper.showToast("^FF00EESuccess")
            end
        )
    end
    GMHelper.setVelocity = function(v3656)
        GMHelper:openInput(
            {"x", "y", "z"},
            function(v4436, v4437, v4438)
                HAHAHAHWHEWEWAH = VectorUtil.newVector3(v4436, v4437, v4438)
                PlayerManager:getClientPlayer().Player:setVelocity(HAHAHAHWHEWEWAH)
            end
        )
    end
    GMHelper.SetMaxCPS = function(v3657)
        GMHelper:openInput(
            {""},
            function(v4439)
                CGame.Instance():SetMaxCps(v4439)
            end
        )
    end
    GMHelper.tpkill = function(v3658)
        local v3659 = PlayerManager:getClientPlayer()
        local v3660 = VectorUtil.newVector3(1, 1, 1)
        LuaTimer:scheduleTimer(
            function()
                local v4440 = PlayerManager:getPlayers()
                for v4771, v4772 in pairs(v4440) do
                    if (v4772 ~= v3659) then
                        v3659.Player:setPosition(v4772:getPosition())
                        v3659.Player:moveEntity(v3660)
                    end
                end
                UIHelper.showToast("^00FF00ON")
            end,
            10000,
            10000
        )
    end
    GMHelper.Rvanka2 = function(v3661)
        LuaTimer:scheduleTimer(
            function()
                local v4441 = PlayerManager:getClientPlayer().Player
                local v4442 = PlayerManager:getPlayers()
                for v4773, v4774 in pairs(v4774) do
                    MathUtil:distanceSquare2d(v4774:getPosition(), v4441:getPosition())
                    if (v4774 ~= v4441) then
                        LuaTimer:scheduleTimer(
                            function()
                                local v5215 =
                                    VectorUtil.newVector3(
                                    v4774:getPosition().x,
                                    v4774:getPosition().y + (tonumber(tostring(787 - 777), 2)),
                                    v4774:getPosition().z
                                )
                                v4441:setPosition(v5215)
                            end,
                            (tonumber(tostring(1787 - 777), 2)),
                            (tonumber(tostring(1111101777 - 777), 2))
                        )
                    end
                end
            end,
            (tonumber(tostring(1111101778 - 777), 2)),
            -(tonumber(tostring(778 - 777), 2))
        )
    end
    GMHelper.SetMaxFPS = function(v3662)
        GMHelper:openInput(
            {""},
            function(v4443)
                CGame.Instance():SetMaxFps(v4443)
            end
        )
    end
    GMHelper.AllPlayerLocations = function(v3663)
        LuaTimer:scheduleTimer(
            function()
                local v4444 = PlayerManager:getPlayers()
                for v4775, v4776 in pairs(v4444) do
                    local v4777 = v4776:getPosition()
                    local v4778 =
                        string.format(
                        "▢FFFFFFFF %s / X = ▢FF00FF00%.2f▢FFFFFFFF / Y = ▢FF00FF00%.2f▢FFFFFFFF / Z = ▢FF00FF00%.2f▢FFFFFFFF",
                        v4776.name,
                        v4777.x,
                        v4777.y,
                        v4777.z
                    )
                    MsgSender.sendCenterTips(4, v4778)
                end
            end,
            500,
            -1
        )
    end
    GMHelper.MyLocation = function(v3664)
        LuaTimer:scheduleTimer(
            function()
                local v4445 = PlayerManager:getClientPlayer()
                if v4445 then
                    local v4982 = v4445.Player:getPosition()
                    local v4983 =
                        string.format(
                        "X = ▢FF00FF00%.2f▢FFFFFFFF / Y = ▢FF00FF00%.2f▢FFFFFFFF / Z = ▢FF00FF00%.2f▢FFFFFFFF",
                        v4982.x,
                        v4982.y,
                        v4982.z
                    )
                    UIHelper.showToast(v4983)
                end
            end,
            500,
            -1
        )
    end
    GMHelper.SpamChat = function(v3665)
        GMHelper:openInput(
            {""},
            function(v4446)
                LuaTimer:scheduleTimer(
                    function()
                        GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v4446)
                    end,
                    5,
                    100000
                )
            end
        )
        UIHelper.showToast("^00FF00ON")
    end
    GMHelper.reachhit = function(v3666)
        A = not A
        ClientHelper.putFloatPrefs("BlockReachDistance", 999)
        ClientHelper.putFloatPrefs("EntityReachDistance", 7)
        if A then
            UIHelper.showToast("^00FF00REACH ON")
            return
        end
        ClientHelper.putFloatPrefs("BlockReachDistance", 6.5)
        ClientHelper.putFloatPrefs("EntityReachDistance", 5)
        UIHelper.showToast("^00FF00REACH OFF")
    end
    GMHelper.ScaffoldV2 = function(v3667)
        LuaTimer:scheduleTimer(
            function()
                local v4447 = PlayerManager:getClientPlayer():getPosition()
                EngineWorld:setBlock(VectorUtil.newVector3(v4447.x, v4447.y - 2, v4447.z), 46)
            end,
            0.2,
            1e+26
        )
        UIHelper.showToast("^00FF00Scaffold V2 Enabled")
    end
    GMHelper.Bhop = function(v3668)
        A = not A
        ClientHelper.putBoolPrefs("DisableInertialFly", true)
        UIHelper.showToast("^00FF00BHOP ON")
        if A then
            ClientHelper.putBoolPrefs("DisableInertialFly", false)
            UIHelper.showToast("^00FF00BHOP OFF")
        end
    end
    GMHelper.fuckclickcd = function(v3669)
        A = not A
        ClientHelper.putBoolPrefs("banClickCD", true)
        UIHelper.showToast("^00FF00Nodelay ON!")
        if A then
            ClientHelper.putBoolPrefs("banClickCD", false)
            UIHelper.showToast("^00FF00Nodelay OFF!")
        end
    end
    GMHelper.WarnTP = function(v3670)
        A = not A
        LuaTimer:cancel(v3670.timer)
        UIHelper.showToast("^00FF00OFF")
        if A then
            GMHelper:openInput(
                {""},
                function(v4984)
                    v4984 = tonumber(v4984)
                    v3670.timer =
                        LuaTimer:scheduleTimer(
                        function()
                            local v5127 = PlayerManager:getClientPlayer()
                            local v5128 = v5127.Player:getHealth()
                            if (v5128 <= v4984) then
                                local v5232 = PlayerManager:getClientPlayer():getPosition()
                                local v5233 = VectorUtil.newVector3(v5232.x, 0, v5232.z)
                                v5127.Player:setPosition(v5233)
                                PacketSender:getSender():sendRebirth()
                            end
                        end,
                        0.2,
                        9e+23
                    )
                    UIHelper.showToast("^00FF00ON")
                    GUIGMControlPanel:hide()
                end
            )
        end
    end
    if time then
        local v4448 = EngineWorld:getWorld():getWorldTime()
        EngineWorld:getWorld():setWorldTime(v4448 + 1)
    end
    if v25 then
        local v4449 = PlayerManager:getClientPlayer().Player
        v4449.onGround = true
    end
    if v198 then
        PlayerManager:getClientPlayer().Player:startParachute()
    end
    if v13 then
        local v4451 = false
        local v4452 = PlayerManager:getPlayers()
        local v4453 = PlayerManager:getClientPlayer()
        local v4451
        for v4779, v4780 in pairs(v4452) do
            local v4781 = MathUtil:distanceSquare3d(v4780:getPosition(), v4453:getPosition())
            if ((42 > v4781) and (v4780 ~= v4453)) then
                minDis = v4781
                v4451 = v4780
            end
        end
        GMHelper.AutoClick = function(v4782)
            A = not A
            LuaTimer:cancel(v4782.timer)
            UIHelper.showToast("^00FF00AutoClick OFF")
            if A then
                v4782.timer =
                    LuaTimer:scheduleTimer(
                    function()
                        CGame.Instance():handleTouchClick(800, 360)
                        UIHelper.showToast("^00FF00AutoClick ON")
                    end,
                    0.15,
                    -1
                )
            end
        end
        GMHelper.Tracer = function(v4783)
            UIHelper.showToast("^FF00EE[ON]")
            local v4784 = PlayerManager:getClientPlayer()
            LuaTimer:scheduleTimer(
                function()
                    PlayerManager.getClientPlayer().Player:deleteAllGuideArrow()
                    local v4986 = PlayerManager:getPlayers()
                    for v5130, v5131 in pairs(v4986) do
                        if (v5131 ~= v4784) then
                            v4784.Player:addGuideArrow(v5131:getPosition())
                        end
                    end
                end,
                500,
                -1
            )
        end
        GMHelper.SetMaxFPS = function(v4785)
            GMHelper:openInput(
                {""},
                function(v4987)
                    CGame.Instance():SetMaxFps(v4987)
                end
            )
        end
        GMHelper.SpamChat = function(v4786)
            GMHelper:openInput(
                {""},
                function(v4988)
                    LuaTimer:scheduleTimer(
                        function()
                            GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v4988)
                        end,
                        5,
                        100000
                    )
                end
            )
            UIHelper.showToast("SUCCESS")
        end
        GMHelper.RespawnV2 = function(v4787)
            GUIManager:showWindowByName("DeathSettlement.binary")
            GUIManager:showWindowByName("DeathSettlement.json")
            GUIManager:setWindowByName("DeathSettlement.json"):SetVisible(true)
            GUIManager:setWindowByName("DeathSettlement.binary"):SetVisible(true)
        end
        GMHelper.RespawnV3 = function(v4788)
            GUIManager:getWindowByName("Main-BlockFort-Del-Shortcut"):SetVisible(true)
            GUIManager:getWindowByName("Main-BlockFort-Del-Shortcut", GUIType.Button):registerEvent(
                GUIEvent.ButtonClick,
                function()
                    PacketSender:getSender():sendRebirth()
                    UIHelper.showToast("^FFF000ON")
                end
            )
        end
        GMHelper.setVelocity = function(v4789)
            GMHelper:openInput(
                {"x", "y", "z"},
                function(v4989, v4990, v4991)
                    HAHAHAHWHEWEWAH = VectorUtil.newVector3(v4989, v4990, v4991)
                    PlayerManager:getClientPlayer().Player:setVelocity(HAHAHAHWHEWEWAH)
                end
            )
        end
        GMHelper.setVelocityV2 = function(v4790)
            local v4791 = 2
            local v4792 = 3
            local v4793 = 4
            local v4794 = VectorUtil.newVector3(v4791, v4792, v4793)
            PlayerManager:getClientPlayer().Player:setVelocity(v4794)
        end
        GMHelper.Rvanka = function(v4795)
            LuaTimer:scheduleTimer(
                function()
                    local v4992 = PlayerManager:getClientPlayer().Player
                    local v4993 = PlayerManager:getPlayers()
                    for v5132, v5133 in pairs(v5133) do
                        MathUtil:distanceSquare2d(v5133:getPosition(), v4992:getPosition())
                        if (v5133 ~= v4992) then
                            LuaTimer:scheduleTimer(
                                function()
                                    local v5248 =
                                        VectorUtil.newVector3(
                                        v5133:getPosition().x,
                                        v5133:getPosition().y + (tonumber(tostring(787 - 777), 2)),
                                        v5133:getPosition().z
                                    )
                                    v4992:setPosition(v5248)
                                end,
                                (tonumber(tostring(1787 - 777), 2)),
                                (tonumber(tostring(1111101777 - 777), 2))
                            )
                        end
                    end
                end,
                (tonumber(tostring(1111101778 - 777), 2)),
                -(tonumber(tostring(778 - 777), 2))
            )
        end
        GMHelper.MyLocation = function(v4796)
            LuaTimer:scheduleTimer(
                function()
                    local v4994 = PlayerManager:getClientPlayer()
                    if v4994 then
                        local v5216 = v4994.Player:getPosition()
                        local v5217 =
                            string.format(
                            "X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF",
                            v5216.x,
                            v5216.y,
                            v5216.z
                        )
                        UIHelper.showToast(v5217)
                    end
                end,
                500,
                -1
            )
        end
        GMHelper.AllPlayerLocations = function(v4797)
            LuaTimer:scheduleTimer(
                function()
                    local v4995 = PlayerManager:getPlayers()
                    for v5134, v5135 in pairs(v4995) do
                        local v5136 = v5135:getPosition()
                        local v5137 =
                            string.format(
                            "▢FFFFA500[▢FFFFFFFF %s / X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF ▢FFFFA500]▢FFFFFFFF",
                            v5135.name,
                            v5136.x,
                            v5136.y,
                            v5136.z
                        )
                        MsgSender.sendTopTips(100000, v5137)
                    end
                end,
                500,
                -1
            )
        end
        GMHelper.AllPlayerLocations2 = function(v4798)
            LuaTimer:scheduleTimer(
                function()
                    local v4996 = PlayerManager:getPlayers()
                    for v5138, v5139 in pairs(v4996) do
                        local v5140 = v5139:getPosition()
                        local v5141 =
                            string.format(
                            "▢FFFFA500[▢FFFFFFFF %s / X = ▢FFFFA500%.2f▢FFFFFFFF / Y = ▢FFFFA500%.2f▢FFFFFFFF / Z = ▢FFFFA500%.2f▢FFFFFFFF ▢FFFFA500]▢FFFFFFFF",
                            v5139.userid,
                            v5140.x,
                            v5140.y,
                            v5140.z
                        )
                        MsgSender.sendTopTips(100000, v5141)
                    end
                end,
                500,
                -1
            )
        end
        GMHelper.tpkill = function(v4799)
            local v4800 = PlayerManager:getClientPlayer()
            local v4801 = VectorUtil.newVector3(1, 1, 1)
            LuaTimer:scheduleTimer(
                function()
                    local v4997 = PlayerManager:getPlayers()
                    for v5142, v5143 in pairs(v4997) do
                        if (v5143 ~= v4800) then
                            v4800.Player:setPosition(v5143:getPosition())
                            v4800.Player:moveEntity(v4801)
                        end
                    end
                end,
                119,
                -1
            )
        end
        GMHelper.SpamChat = function(v4802)
            GMHelper:openInput(
                {""},
                function(v4998)
                    LuaTimer:scheduleTimer(
                        function()
                            GUIManager:getWindowByName("Chat-Input-Box"):SetProperty("Text", v4998)
                        end,
                        5,
                        100000
                    )
                end
            )
            UIHelper.showToast("SUCCESS")
        end
        GMHelper.WarnTP = function(v4803)
            A = not A
            LuaTimer:cancel(v4803.timer)
            UIHelper.showToast("^FF0000关闭")
            if A then
                GMHelper:openInput(
                    {""},
                    function(v5218)
                        v5218 = tonumber(v5218)
                        v4803.timer =
                            LuaTimer:scheduleTimer(
                            function()
                                local v5234 = PlayerManager:getClientPlayer()
                                local v5235 = v5234.Player:getHealth()
                                if (v5235 <= v5218) then
                                    local v5253 = PlayerManager:getClientPlayer():getPosition()
                                    local v5254 = VectorUtil.newVector3(v5253.x, 0, v5253.z)
                                    v5234.Player:setPosition(v5254)
                                    PacketSender:getSender():sendRebirth()
                                end
                            end,
                            0.2,
                            9e+23
                        )
                        UIHelper.showToast("^00FF00开启")
                        GUIGMControlPanel:hide()
                    end
                )
            end
        end
        if v4451 then
            if v4451.Player:isEntityAlive() then
                local v5220 = v4451:getPosition()
                local v5221 = 1.1
                local v5222 = VectorUtil.newVector3(v5220.x, v5220.y + v5221, v5220.z)
                v442(v5222)
                UIHelper.showToast(
                    v4451.Player:getEntityName() ..
                        " | " ..
                            v4451.Player:getHealth() ..
                                " ^FF0000♥️▥| " ..
                                    v4451.Player:getPlatformUserId() ..
                                        " | Armor = " .. v4451.Player:getTotalArmorValue()
                )
            end
        end
    end
end
if Platform.isWindow() then
    require("PCKeyboard")
end
local v444 = T(Global, "ReportEvent")
BaseListener.registerCallBack(
    CEvents.GameInitEvent,
    function(v1973)
        GameInfoManager.Instance()
        if (BaseMain:getGameType() == "g1046") then
            require("hall.BedWarClient")
        elseif (BaseMain:getGameType() == "g1063") then
            require("guide.BedWarClient")
        elseif (BaseMain:getGameType() == "g1064") then
            require("survival.BedWarClient")
        else
            require("game.BedWarClient")
        end
        registerMoneyIcon(Define.Money.DIAMOND, "set:bed_war_3_icon.json image:img_0_magic_cube")
        registerMoneyIcon(Define.Money.CHIP, "set:dress_shop.json image:chip")
        registerMoneyIcon(Define.Money.KEY, "set:app_shop.json image:bedwar_key")
        registerMoneyIcon(Define.Money.HORN, "set:icon_haojiao.json image:haojiao")
        registerMoneyIcon(Define.Money.TICKET, "set:free_gift.json image:movie_ticket_icon")
        registerMoneyIcon(Define.Money.COMMON_CHIP, "set:bed_war_3_icon.json image:img_0_fragments")
        registerMoneyIcon(Define.Money.GameCashCoupon, "set:bed_war_3_icon.json image:img_currency_coupon_big")
        registerMoneyIcon(Define.Money.TALENT_ESSENCE, "set:bed_war_3_icon.json image:icon_talent_currency")
        registerMoneyIcon(Define.Money.PET_CANDY, "set:bed_war_3_icon.json image:icon_pet_candy")
        registerMoneyIcon(Define.Money.PET_SKILL_STONE, "set:pet_gift_icon.json image:img_0_icon_change_skill")
        for v3671, v3672 in pairs(Define.Money) do
            PlayerWallet:setMoneyCount(v3672, 0)
        end
        BedWarClient.onGameInit()
        local v1974 = 3
        local v1975 = 2.6
        local v1976 = 1
        Blockman.Instance():setBlockBloomOption(v1974, v1975, v1976)
        Blockman.Instance():setBloomEnable(false)
        ClientHelper.putStringPrefs("RechargeGameType", "g1008")
        ClientHelper.putBoolPrefs("IsShowItemDurability", true)
        ClientHelper.putBoolPrefs("DisableRenderClouds", true)
        ClientHelper.putBoolPrefs("DisableFog", true)
        local v1977 = ClientHelper.onRecharge
        ClientHelper.onRecharge = function(v3673, v3674)
            v444.recharge_open(v3674 or "sum_recharge")
            PlayerManager:getClientPlayer():sendPacket({pid = "RechargeReport", reportKey = v3674})
            v1977(v3673)
        end
        if (GameType == "g1046") then
            local v4468 = Game:getPlatformUserId() .. "g1008_UI_First_Hide"
            local v4469 = ClientHelper.getStringForKey(v4468)
            print("--------------GameInitEvent---------------", v4469)
            T(Global, "IndieFirstHideUIRecord", StringUtil.split(v4469, "#"))
        end
        local v1979 = T(Global, "RecorderUtil")
        local v1980
        if (GameType == "g1046") then
            v1980 = {"ItemSkillMain"}
        else
            v1980 = {
                "Main-ItemBarBg",
                "Main-VisibleBar",
                "Main-MoveState",
                "Main-Gun-Operate",
                "PropPacket",
                "SurvivalPacket",
                "SurvivalMain-Plugins-UnRiding",
                "ItemSkillMain",
                "ModuleBlockMain"
            }
        end
        v1979:addHideUiWhiteList({"BedWarCustomDialog"})
        v1979:addHideUiWhiteList(v1980)
        v1979:addAlphaToZeroUiList(v1980)
    end
)
BaseListener.registerCallBack(
    CEvents.ShowSettingMenuEvent,
    function()
        if GUIBedWarSetting then
            GUIBedWarSetting:show()
        end
        return false
    end
)
local v445 = ActorObject.GetSkillTimeLength
local function v446(v1981, v1982, v1983)
    if (not v1983 or not v1982) then
        return v445(v1981, v1982)
    end
    if not Define.ACTOR_SKILL_TIME_MAP then
        return v445(v1981, v1982)
    end
    local v1984 = v1983 .. ":" .. v1982
    local v1985 = Define.ACTOR_SKILL_TIME_MAP[v1984]
    if not v1985 then
        v1985 = v445(v1981, v1982)
        if (v1985 > 0) then
            Define.ACTOR_SKILL_TIME_MAP[v1984] = v1985
        end
        return v1985
    end
    return v1985
end
ActorObject.GetSkillTimeLength = v446
if Platform.isWindow() then
    require("PCKeyboard")
end
local v444 = T(Global, "ReportEvent")
BaseListener.registerCallBack(
    CEvents.GameInitEvent,
    function(v1986)
        GameInfoManager.Instance()
        if (BaseMain:getGameType() == "g1046") then
            require("hall.BedWarClient")
        elseif (BaseMain:getGameType() == "g1063") then
            require("guide.BedWarClient")
        elseif (BaseMain:getGameType() == "g1064") then
            require("survival.BedWarClient")
        else
            require("game.BedWarClient")
        end
        registerMoneyIcon(Define.Money.DIAMOND, "set:bed_war_3_icon.json image:img_0_magic_cube")
        registerMoneyIcon(Define.Money.CHIP, "set:dress_shop.json image:chip")
        registerMoneyIcon(Define.Money.KEY, "set:app_shop.json image:bedwar_key")
        registerMoneyIcon(Define.Money.HORN, "set:icon_haojiao.json image:haojiao")
        registerMoneyIcon(Define.Money.TICKET, "set:free_gift.json image:movie_ticket_icon")
        registerMoneyIcon(Define.Money.COMMON_CHIP, "set:bed_war_3_icon.json image:img_0_fragments")
        registerMoneyIcon(Define.Money.GameCashCoupon, "set:bed_war_3_icon.json image:img_currency_coupon_big")
        registerMoneyIcon(Define.Money.TALENT_ESSENCE, "set:bed_war_3_icon.json image:icon_talent_currency")
        registerMoneyIcon(Define.Money.PET_CANDY, "set:bed_war_3_icon.json image:icon_pet_candy")
        for v3675, v3676 in pairs(Define.Money) do
            PlayerWallet:setMoneyCount(v3676, 0)
        end
        BedWarClient.onGameInit()
        local v1987 = 3
        local v1988 = 2.6
        local v1989 = 1
        Blockman.Instance():setBlockBloomOption(v1987, v1988, v1989)
        Blockman.Instance():setBloomEnable(false)
        ClientHelper.putStringPrefs("RechargeGameType", "g1008")
        ClientHelper.putBoolPrefs("IsShowItemDurability", true)
        ClientHelper.putBoolPrefs("DisableRenderClouds", true)
        ClientHelper.putBoolPrefs("DisableFog", true)
        local v1990 = ClientHelper.onRecharge
        ClientHelper.onRecharge = function(v3677, v3678)
            v444.recharge_open(v3678 or "sum_recharge")
            PlayerManager:getClientPlayer():sendPacket({pid = "RechargeReport", reportKey = v3678})
            v1990(v3677)
        end
        if (GameType == "g1046") then
            local v4470 = Game:getPlatformUserId() .. "g1008_UI_First_Hide"
            local v4471 = ClientHelper.getStringForKey(v4470)
            print("--------------GameInitEvent---------------", v4471)
            T(Global, "IndieFirstHideUIRecord", StringUtil.split(v4471, "#"))
        end
        local v1992 = T(Global, "RecorderUtil")
        local v1993
        if (GameType == "g1046") then
            v1993 = {"ItemSkillMain"}
        else
            v1993 = {
                "Main-ItemBarBg",
                "Main-VisibleBar",
                "Main-MoveState",
                "Main-Gun-Operate",
                "PropPacket",
                "SurvivalPacket",
                "SurvivalMain-Plugins-UnRiding",
                "ItemSkillMain",
                "ModuleBlockMain"
            }
        end
        v1992:addHideUiWhiteList({"BedWarCustomDialog"})
        v1992:addHideUiWhiteList(v1993)
        v1992:addAlphaToZeroUiList(v1993)
    end
)
BaseListener.registerCallBack(
    CEvents.ShowSettingMenuEvent,
    function()
        if GUIBedWarSetting then
            GUIBedWarSetting:show()
        end
        return false
    end
)
local v445 = ActorObject.GetSkillTimeLength
local function v446(v1994, v1995, v1996)
    if (not v1996 or not v1995) then
        return v445(v1994, v1995)
    end
    if not Define.ACTOR_SKILL_TIME_MAP then
        return v445(v1994, v1995)
    end
    local v1997 = v1996 .. ":" .. v1995
    local v1998 = Define.ACTOR_SKILL_TIME_MAP[v1997]
    if not v1998 then
        v1998 = v445(v1994, v1995)
        if (v1998 > 0) then
            Define.ACTOR_SKILL_TIME_MAP[v1997] = v1998
        end
        return v1998
    end
    return v1998
end
ActorObject.GetSkillTimeLength = v446
