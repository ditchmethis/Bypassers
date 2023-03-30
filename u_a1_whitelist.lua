--[[ Remember, no nerds, whoever i sent this, i'm trusting you "ONLY" with this source code, please don't leak it. ]]--

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local whitelistUserIDs = {4465099169,4107611025,4372408668,2907828338,3851987510,152465161,4468191251,1230837341,3399118134,152465161,1289035848,3755258827,222502658,3401747947,4258730850,173345995,3304060295}

--local blacklistedUserIDs = {2894178680}

local discord_link = "https://discord.gg/BZ35GwQ8WE"

if not table.find(whitelistUserIDs,LocalPlayer.UserId) then
while true do
wait()
for i,v in pairs(workspace:GetDescendants()) do
if v.ClassName == "Sound" then
    v.Volume = 10
    v.PlaybackSpeed = .4
    v:Play()
end
end
end
task.wait(5)
LocalPlayer:Kick("You have been banned Remaining duration: "..math.random(10000000,99999999)..":"..math.random(1,10)..":"..math.random(1,10)..":"..math.random(10,100).." Reason: Exploiting If you feel you were falsely banned, you can appeal in the Communications server below the game's description (Ban appeal)")
end


task.wait(3)

--[[
if not table.find(whitelistUserIDs,LocalPlayer.UserId) then
    LocalPlayer:Kick("Execution Error (26A10): You are not whitelisted to use this script!")
end
]]

if table.find(whitelistUserIDs,LocalPlayer.UserId) then
game.StarterGui:SetCore("SendNotification", {
    Title = "Lumware v1.4 Loaded!";
    Text = "You're whitelisted, "..LocalPlayer.Name.."!";
    Duration = math.random(1,1.5);
})

--setclipboard(tostring(discord_link))

game.StarterGui:SetCore("SendNotification", {
    Title = "yo "..LocalPlayer.Name.." i saw u in discord";
    Text = "better vouch after this 😎";
    Duration = math.random(2,3);
})

task.wait(3)

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zMaaaaaaark/UI-/main/uilib2.lua"))()
local venyx = library.new("Lumware ⭐", 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local mouse = Players.LocalPlayer:GetMouse()
local nevermore_modules = rawget(require(game.ReplicatedStorage.Framework.Nevermore), "_lookupTable")
local network = rawget(nevermore_modules, "Network") -- whole fucked up network hidden in the framework
local anticheat = rawget(nevermore_modules, "AntiCheatHandlerClient")
local events = game:GetService("ReplicatedStorage").Communication.Events
local remotes_table = getupvalue(getsenv(network).GetEventHandler, 1)
local events_table = getupvalue(getsenv(network).GetFunctionHandler, 1)
local remotes = {}
local lines = {}
local texts = {}
local players = {}
local boxes = {}
local boxoutlines = {}
local healthbars = {}
local healthbaroutlines = {}

local straferange
local hitpart
local ARROW
local bruh = Instance.new("Highlight",game.CoreGui)
bruh.FillColor = Color3.fromRGB(97, 242, 136)
bruh.FillTransparency = 1
bruh.OutlineTransparency = 1
local closest
local flying
local holdingm2 = false
local aimbotLocked
local retard
local shot = false
local arrowsshooted = 1
local angle = 0


local walkspeed = 16
local infjump
local antidamage
local autospawn
local apdist = 1
local tracersenabled
local nofall
local textenabled
local noclip
local stompaura
local jumppower = 50
local killsay = false
local killaura = false
local hidename = false
local aimbot
local silentaim
local autoequip = false
local nospread
local jumppowerenabled = false
local walkspeedenabled = false
local silentaimhitchance
local instantcharge = false
local boxesenabled = false
local targetStrafe = false

getgenv().TracerColor = Color3.fromRGB(99, 13, 197)

RunService.Stepped:Connect(function()
for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))) do
    v:Disable()
    end
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"))) do
    v:Disable()
    end
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("HipHeight"))) do
    v:Disable()
    end
end)

setmetatable(remotes, {
    __call = function(table2, ...)
        local args = {...}

        table.foreach(args, print)

        table2[args[1]]:FireServer(args[2])
    end
})

do
    for i, v in pairs(remotes_table) do
        remotes[i] = rawget(v, "Remote")
    end
    for i, v in pairs(events_table) do
        remotes[i] = rawget(v, "Remote")
    end
end

local modules = {}
for i,v in pairs(rawget(require(game:GetService("ReplicatedStorage").Framework.Nevermore), "_lookupTable")) do
    modules[i] = require(v)
end

--[[
for i,v in pairs(getgc(true)) do
    if typeof(v) ~= 'table' then continue end
    if rawget(v, 'getIsBodyMoverCreatedByGame') then
        v.getIsBodyMoverCreatedByGame = function(gg)
            return true
        end
        
    end

    if rawget(v, 'connectCharacter') then
         v.connectCharacter = function(gg) return wait(9e9) end
    end
    

    if rawget(v, "punish") then
        local hf;hf=hookfunction(v.punish, function(...)
            return
        end)
    end
end


local old_namecall;old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == 'Kick' then return wait(9e9) end
    if self == remotes["BAC"] then return end
    if self == remotes["ExportClientErrors"] then return end
    return old_namecall(self,unpack(args))
end))

local function getRemote(name)
    return game:GetService("ReplicatedStorage").Communication.Events[name]
end

    local local_player = game:GetService("Players").LocalPlayer
    local kick_hook; kick_hook = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local args = {...}
    local self = args[1]
    local namecall_method = getnamecallmethod()
    if not checkcaller() and self == local_player and namecall_method == "Kick" or namecall_method == "kick" then
    return
    end
    return kick_hook(...)
    end))
    
    for i,v in pairs(getgc(true)) do
    if typeof(v) ~= 'table' then continue end
    if rawget(v, 'getIsBodyMoverCreatedByGame') then
        v.getIsBodyMoverCreatedByGame = function(gg)
            return true
        end
        
    end
    if rawget(v, 'connectCharacter') then
         v.connectCharacter = function(gg) return wait(9e9) end
    end
    

    if rawget(v, "punish") then
        local hf;hf=hookfunction(v.punish, function(...)
            return
        end)
    end
end

    for _, tbl in ipairs(getgc(true)) do
    if typeof(tbl) == "table" and rawget(tbl, "Remote") then
    tbl.Remote.Name = tbl.Name
    end
    end
    
    function getEvent(name)
    for i, v in ipairs(game:GetService("ReplicatedStorage").Communication.Events:GetChildren()) do
    if v.Name == name then
    return v
    end
    end
    end
    
    function getFunction(name)
    for i, v in ipairs(game:GetService("ReplicatedStorage").Communication.Functions:GetChildren()) do
    if v.Name == name then
    return v
    end
    end
    end
    
    local Remotes = {}
    local NetworkEnvironment = getmenv(rawget(rawget(require(game.ReplicatedStorage.Framework.Nevermore), '_lookupTable'), 'Network'))
    local EventsTable = debug.getupvalue(NetworkEnvironment.GetEventHandler, 1)
    local FunctionsTable = debug.getupvalue(NetworkEnvironment.GetFunctionHandler, 1)
    
    
    hookfunction(anticheat._startModule, function(self, ...)
    for i,v in pairs(anticheat, self) do
    hookfunction(v,function() return end)
    end
    
     if self == remotes["ExportClientErrors"] then return end
      local args = {...}
    local method = getnamecallmethod()  
    if method == 'Kick' or method == 'kick' then return wait(9e9) end
     return hookfunction(self,unpack(args))
    --return
    end)

    local OldNameCall
    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()

    if not checkcaller() and Self == debug and NamecallMethod == "info" then
        return true
    end

    return OldNameCall(Self, ...)
    end)
    
  
    debug.info = function(self, ...)
    local arguments = {...}
    local callMethod = getnamecallmethod()
    
    if not checkcaller() then
       if (self == debug and self == LocalPlayer and callMethod == "info") then return wait(9e9) end
       end
     return debug.info(self, ...)
    end
    

    local function AddRemotes(StorageTable)
    for Name, Info in pairs(StorageTable) do
    if rawget(Info, 'Remote') then
    Remotes[rawget(Info, 'Remote')] = Name
    end
    end
    end
    AddRemotes(EventsTable)
    AddRemotes(FunctionsTable)
    
    local Index
    Index = hookmetamethod(game, '__index', function(Self, Key)
    if checkcaller() and (Key == 'Name' or Key == 'name') and Remotes[Self] then
    return Remotes[Self]
    end
    
    return Index(Self, Key)
    end)
    
    for a,b in next, getgc(true) do
    if typeof(b) == 'function' then
    if getinfo(b).name == 'punish' then
    replaceclosure(b, function() return wait(9e9); end)
    end
    end
end

for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "kick") then
        v.kick =  function()
            return
        end
    end

    if typeof(v) == 'table' and rawget(v, 'getIsBodyMoverCreatedByGame') then
        v.getIsBodyMoverCreatedByGame = function(among)
            return true
        end
   end
   if typeof(v) == "table" and rawget(v, "randomDelayKick") then
        v.randomDelayKick = function()
            return wait(9e9)
        end
    end
    if typeof(v) == "table" and rawget(v, "kick") then
        v.randomDelayKick = function()
            return wait(9e9)
        end
    end
    if typeof(v) == "table" and rawget(v, "serverKick") then
        v.randomDelayKick = function()
            return wait(9e9)
        end
    end
end

table.foreach(remotes_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)

table.foreach(events_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)



local pog
pog = hookmetamethod(game, "__index", function(self, key)
    if (key == "Name" or key == "name") and remotes[self] then
       return remotes[self]
    end

    return pog(self, key)
end)


local function getRemote(name)
    for i,v in pairs(remotes) do
        if i.Name == name then
            return i
        end
    end
end

local old_namecall;old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == 'Kick' or method == 'kick' then return wait(9e9 * 10000) end
    if self == remotes["BAC"] then return wait(9e9 * 10000) end
    if self == remotes["ExportClientErrors"] then return wait(9e9 * 10000) end
    return old_namecall(self,unpack(args))
end))
]]

local function getClosest()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    local closestblackperson
    local closest_distance = math.huge
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local plr_pos = v.Character.HumanoidRootPart.Position
            local plr_distance = (hrp - plr_pos).Magnitude
    
            if plr_distance < closest_distance then
                closest_distance = plr_distance
                closestblackperson = v
            end
        end
    end

    return closestblackperson
end

local function getClosestToMouse()
    local player, nearestDistance = nil, math.huge
    for i,v in pairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local root, visible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if visible then
                local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(root.X, root.Y)).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    player = v
                end
            end
        end
    end
    return player
end

local function calculateArrowHitChance(v)
    local chance = math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100
    return chance <= math.floor(v) / 100
end

local function firehit(character)    
    local fakepos = character[hitpart].Position + Vector3.new(math.random(1,5),math.random(1,5),math.random(1,5))
    local args = {
        [1] = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
        [2] = character.Head,
        [3] = fakepos,
        [4] = character.Head.CFrame:ToObjectSpace(CFrame.new(fakepos)),
        [5] = math.random(0,0.4),
        [6] = tostring(arrowsshooted)
    }
    remotes["RangedHit"]:FireServer(unpack(args))
end


getgenv().hitremote = nil
getgenv().swingremote = nil
getgenv().fallremote = nil
getgenv().ragdollremote = nil

local modules = {}
local _lookupTable = rawget(require(game:GetService("ReplicatedStorage").Framework.Nevermore), "_lookupTable")
for i,v in pairs(_lookupTable) do
    modules[i] = require(v)
end

local Network = modules["Network"]

hookfunction(debug.info,function(context,type)
    if context == 2 and type == "s" then
        return true
    end
end)

local Whitelist = {}

function CheckWhitelist(Name)
    if table.find(Whitelist,Name) then
        return false
    end
    if (_G.kawhitelist == true and Players:FindFirstChild(Name) and Players:FindFirstChild(Name):IsFriendsWith(LocalPlayer.UserId)) then
        return false
    end
    return true
end

function GetPlayer(Distance,SortTable)
    local Character = LocalPlayer.Character
    if not Character then return {} end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return {} end
    local PlayerTable = {}
    for i,v in pairs(Players:GetPlayers()) do
        if (v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid")) then
            local Mag = (HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if Mag <= Distance then
                PlayerTable[v.Name] = v.Character.Humanoid.Health
            end
        end
    end
    if SortTable then
        table.sort(PlayerTable)
    end
    return PlayerTable
end

function GetWeaponMetadata(DisplayName)
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v,"refundIfVaulted") then
            if rawget(v,"displayName") == DisplayName then
                return v
            end
        end
    end
end

function GetWeapon()
    local Weapon
    for i, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            if v:FindFirstChild("Hitboxes") then
                Weapon = v
            end
        end
    end
    return Weapon
end

local DataHandler = modules["DataHandler"]
function IsParrying(Player)
    if DataHandler.getSessionDataRoduxStoreForPlayer(Player) then
        return DataHandler.getSessionDataRoduxStoreForPlayer(Player):getState().parry.isParrying
    end
    return nil
end

local Cooldowns = {}

for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v,"lethalLimbDismembermentChance") then
        Cooldowns[rawget(v,"displayName")] = rawget(v,"cooldown")
    end
end

local page = venyx:addPage("Main", 5012544693)
local section1 = page:addSection("Parry Section")
local section2 = page:addSection("Gameplay Behavior")

local debounce = false
local AutoCD_Debounce = true
local AntiCD_Debounce = true
local animationInfo = {}
local autoparrycooldown
local autoparryrange
local antiparrycooldown
local antiparryrange
local kacooldownewapon
local kaparrycheck
local attackoneka
local attackmultika
local killauradistance 
local kahealthenabled
local killaurahitcooldown

section1:addToggle("Auto-Parry", nil, function(value)
    _G.autoparry = value
end)

--[[
section1:addDropdown("Auto-Parry Method", {"Keypress", "Remote"}, function(text)
if text == "Keypress" then
    _G.apkeypress = true
elseif text == "Remote" then
    _G.apremote = true
end
end)

]]
section1:addToggle("Anti-Parry", nil, function(value)
    _G.antiparry = value
end)

local antiparryRS

workspace.PlayerCharacters.DescendantAdded:Connect(function(e)
    pcall(function()
        if (e:IsA("Sound") and e.SoundId == "rbxassetid://211059855") then
            if e.Parent.Parent.Name ~= LocalPlayer.Name then
                local p = (e.Parent and e.Parent)
                if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
                    if (distance <= antiparryrange and _G.antiparry == true) then
                        local Weapon
                        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") then
                                if v:FindFirstChild("Hitboxes") ~= nil then
                                    Weapon = v
                                end
                            end
                        end
                        if Weapon and AntiCD_Debounce == true then
                            task.spawn(function()
                                AntiCD_Debounce = false
                               antiparryRS = RunService.Stepped:Connect(function()
                                    if AntiCD_Debounce == false then
                                LocalPlayer.Character.Humanoid:UnequipTools()
                                p:GetPropertyChangedSignal'Transparency':wait()
                                else
                                    LocalPlayer.Character.Humanoid:EquipTool(Weapon)
                                    antiparryRS:Disconnect()
                                    end
                                end)
                                game.StarterGui:SetCore("SendNotification", {
                                    Icon = "rbxassetid://12844101824";
                                    Title = "Anti-Parry Triggered!";
                                    Text = "Have fun sweating :)";
                                    Duration = 1;
                                })
                                task.wait(antiparrycooldown)
                                AntiCD_Debounce = true
                            end)
                        end
                    end
                end
            end
        end
    end)
end)

section1:addSlider("Auto-Parry Range", 11, 11, 16, function(value)
    apdist = value
end)

function getInfo(id)
  local success, info = pcall(function()
      return game:GetService("MarketplaceService"):GetProductInfo(id)
  end)
  if success then
      return info
  end
  return {Name=''}
end

local AnimNames = {
  'Slash',
  'Swing',
  'Sword'
}

function block(player)
  keypress(0x46)
  task.wait()
  keyrelease(0x46)
end

local function playerAdded(v)
    local function charadded(char)
      local humanoid = char:WaitForChild("Humanoid", 5)
      if humanoid then
          humanoid.AnimationPlayed:Connect(function(track)
              local info = animationInfo[track.Animation.AnimationId]
              if not info then
                  info = getInfo(tonumber(track.Animation.AnimationId:match("%d+")))
                  animationInfo[track.Animation.AnimationId] = info
              end
              if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Head")) then
                  local mag = (v.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                  if mag < apdist and AutoCD_Debounce == true then
                    AutoCD_Debounce = false
                      for _, animName in pairs(AnimNames) do
                          if info.Name:match(animName) and _G.autoparry == true then
                              pcall(block, v)
			                task.wait(autoparrycooldown)
                          end
                          AutoCD_Debounce = true
                      end
                  end
              end
          end)
      end
  end
 
  if v.Character then
      charadded(v.Character)
  end
  v.CharacterAdded:Connect(charadded)
end

for i,v in pairs(game.Players:GetPlayers()) do
   if v ~= LocalPlayer then
       playerAdded(v)
   end
end

game.Players.PlayerAdded:Connect(playerAdded)

section1:addSlider("Anti-Parry Range", 15, 15, 26, function(value)
    antiparryrange = value
end)

section1:addSlider("Auto-Parry Cooldown", 0, 0, 2, function(value)
    autoparrycooldown = value
end)

section1:addSlider("Anti-Parry Cooldown", 0, 0, 1, function(value)
    antiparrycooldown = value
end)

section1:addToggle("No Parry Cooldown", nil, function(value)
    _G.noparrycd = value
    for i,v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "PARRY_COOLDOWN_IN_SECONDS") and rawget(v, "PARRY_COOLDOWN_IN_SECONDS_AFTER_SUCCESSFUL_PARRY") then
            if _G.noparrycd == true then
                v.PARRY_COOLDOWN_IN_SECONDS = 0
                v.PARRY_COOLDOWN_IN_SECONDS_AFTER_SUCCESSFUL_PARRY = 0
            else
                v.PARRY_COOLDOWN_IN_SECONDS = 3
                v.PARRY_COOLDOWN_IN_SECONDS_AFTER_SUCCESSFUL_PARRY = 0.33
            end
        end
    end
end)


section2:addToggle("Infinite Stamina & Air", nil, function(value)
    _G.infstam = value
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "_setStamina") then
            local old = v._setStamina
            v._setStamina = function(among, us)
                if _G.infstam == true then
                    among._stamina = math.huge
                    among._staminaChangedSignal:Fire(150)
                else
                    return old(among, us)
                end
            end
        end
     end
end)

section2:addToggle("No Dash Cooldown", nil, function(value)
    _G.nodashcd = value
    for i,v2 in pairs(getgc(true)) do
        if typeof(v2) == "table" and rawget(v2, "DASH_COOLDOWN") then
            if _G.nodashcd == true then
                v2.DASH_COOLDOWN = 0
            else
                v2.DASH_COOLDOWN = 3
            end
        end
    end
end)

section2:addToggle("Stomp Aura", nil, function(value)
    _G.stompaura = value
end)

section2:addToggle("Auto-Spawn", nil, function(value)
    autospawn = value
end)

section2:addToggle("Player Strafe (w/Anti-Strafe)", nil, function(value)
    _G.strafe = value
end)

section2:addSlider("Strafe Distance", 1, 1, 40, function(value)
    straferange = value
end)

section2:addToggle("Enable Fast Walkspeed", nil, function(value)
    walkspeedenabled = value
end)

section2:addToggle("Enable High JumpPower", nil, function(value)
    jumppowerenabled = value
end)

--[[
section2:addToggle("Anti-Ragdoll", nil, function(value)
    _G.nord = value
end)
]]

section2:addToggle("No Fall Damage // No Ragdoll Fall", nil, function(value)
    _G.nfd = value
    RunService.Stepped:Connect(function()
        if _G.nfd == true then
    DataHandler.getSessionDataRoduxStoreForPlayer(LocalPlayer):getState().fallDamageClient.isDisabled = true
        else
            DataHandler.getSessionDataRoduxStoreForPlayer(LocalPlayer):getState().fallDamageClient.isDisabled = false
        end
    end)
end)

section2:addToggle("No Beartrap // No Molotov Fire Pool", nil, function(value)
    _G.nbt = value
    RunService.Stepped:Connect(function()
        if _G.nbt == true then
        for i, v in pairs(workspace.EffectsJunk:GetChildren()) do
        if v.Name == "OpenBearTrap" or v.Name == "" then
            v:Destroy()
        end 
        end
    else
        RS:Disconnect()
    end
    end)
end)

section2:addToggle("Fast Player Revive", nil, function(value)
    _G.fastplrrev = value
    for a,b in next, getgc(true) do
        if typeof(b) == 'table' and rawget(b, 'REVIVE_DURATION') and _G.fastplrrev == true then
            rawset(b, 'REVIVE_DURATION', value and 1.5 or 2)
            game.StarterGui:SetCore("SendNotification", {
        		Title = "Fast Player Revive Enabled.";
        		Text = "Enjoy exploiting! :)";
        		Duration = .5;
        		})
        elseif typeof(b) == 'table' and rawget(b, 'REVIVE_DURATION') then
            rawset(b, 'REVIVE_DURATION', value and 5 or 5)
            game.StarterGui:SetCore("SendNotification", {
        		Title = "Fast Player Revive Disabled.";
        		Text = "Enjoy exploiting! :)";
        		Duration = .5;
        		})
        end
    end
end)

section2:addToggle("Always Reset when Downed", nil, function(value)
_G.Toggled = value
if _G.Toggled == true then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Reset when Downed Enabled!";
        Text = "Remember, this will prevent the glory bug.";
        Duration = 3;
    })
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Reset when Downed Enabled!";
        Text = "Turning this off will get you in glory bug risk!";
        Duration = 3;
    })
end

local Reset

Reset = RunService.Stepped:Connect(function()
if _G.Toggled == true then
if workspace.PlayerCharacters:WaitForChild(LocalPlayer.Name).Humanoid.Health <= 15 then
workspace.PlayerCharacters:FindFirstChild(LocalPlayer.Name).Humanoid.Health = 0
    else
    Reset:Disconnect()
end
end
end)
end)

section2:addToggle("Kill Aura", nil, function(value)
    _G.killaura = value
    task.spawn(function()
        while true do
            local weapon = GetWeapon()
            if (weapon and _G.killaura == true) then
                local wpcooldown
                local kaprior = kahealthenabled
                local closest = GetPlayer(killauradistance,kaprior == "Health" and true or false)
                local origPos = getClosest().Character.HumanoidRootPart.CFrame
                wpcooldown = Cooldowns[weapon.Name]
                local closestPlayers = 0
            for i,v in pairs(closest) do
                closestPlayers = closestPlayers + 1
            end
            if closestPlayers >= 1 then
                Network:FireServer("MeleeSwing",weapon,math.random(1,4))
            end
            for i,v in pairs(closest) do
                if (Players:FindFirstChild(i) and Players[i].Character and weapon and Players[i].Character:FindFirstChild("Head")) then
                    if kaparrycheck == true then
                        if IsParrying(Players[i]) then continue end
                    end
                    Network:FireServer("MeleeDamage",weapon,Players[i].Character:FindFirstChild("Head"),weapon.Hitboxes:FindFirstChild('Hitbox'),Players[i].Character.Head.Position,CFrame.new(),Vector3.new())
                    if attackoneka == true then
                        break
                    end
                end
            end
                if kacooldownewapon == true then
                    if wpcooldown then
                        task.wait(wpcooldown)
                    else
                        task.wait()
                    end
                else
                    task.wait(.14)
                end
            else
                warn("hit")
            end
	    end
    end)
end)

--[[
section2:addTextbox("Notification", "Default", function(value, focusLost)
print("Input", value)
if focusLost then
venyx:Notify("Title", value)
end
end)
]]


--[[
section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
section2:addColorPicker("ColorPicker2")


section2:addSlider("Slider", 0, -100, 100, function(value)
print("Dragged", value)
end)
]]

--[[
section2:addSlider("Kill Aura Hit Cooldown", 0.15, 0.15, 1, function(value)
    killauraswingcooldown = value
end)
]]

section2:addToggle("Kill Aura Friend Whitelist", nil, function(value)
    _G.kawhitelist = value
end)

section2:addToggle("Kill Aura Weapon Based CD", nil, function(value)
    kacooldownewapon = value
end)

section2:addToggle("Kill Aura Parry Check", nil, function(value)
    kaparrycheck = value
end)


local karstp
local karstpdeb = false
local killauratpdistance

--[[
section2:addToggle("Player Strafe", nil, function(value)
    _G.killauratp = value
end)
]]

--[[
section2:addSlider("Kill Aura Tp Distance", 1, 1, 10, function(value)
    killauratpdistance = value
end)
]]

section2:addSlider("Kill Aura Distance", 1, 1, 30, function(value)
    killauradistance = value
end)

local drop1 = section2:addDropdown("Kill Aura Type", {"Attack One", "Attack Multiple"}, function(text)
   if text == "Attack One" then
    attackoneka = text
    warn('attack one')
   elseif text == "Attack Multiple" then
       warn('attack multi')
    attackmultika = text
   end
end)


local drop2 = section2:addDropdown("Kill Aura Priority", {"None", "Health"}, function(text)
if text == "Health" then
    kahealthenabled = text
    warn('prio health')
end
end)

-- second page
local page2 = venyx:addPage("Servers", 5012544693)
local s_hop = page2:addSection("Server Hop")

s_hop:addButton("Join Console Beginner Server", function()
game:GetService("TeleportService"):Teleport(11979321561,LocalPlayer)
end)

-- third page
local page3 = venyx:addPage("Others", 5012544693)
local colors = page3:addSection("Theme Colors")
local aimsection = page3:addSection("Range Section")
local section3 = page3:addSection("Misc")

for page3, color in pairs(themes) do
    colors:addColorPicker(page3, color, function(color3)
    venyx:setTheme(page3, color3)
    end)
end

section3:addButton("Hitbox Expander", function()
    local oldPos = {}
    for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            for i2,v2 in pairs(v.Hitboxes.Hitbox:GetChildren()) do
                if v2:IsA("Attachment") and v2.Name == "DmgPoint" then
                    table.insert(oldPos, v2.Position)
                    v2.Visible = true
                    v2.Position += Vector3.new(0, 3, 0)
                end
            end
        end
    end
end)

aimsection:addToggle("Aim-lock", nil, function(value)
    _G.aimbot = value
end)

aimsection:addToggle("Silent Aim", nil, function(value)
    _G.silentaim = value
end)

aimsection:addToggle("Silent Aim Highlight Player", nil, function(value)
    _G.highlight = value
end)

aimsection:addSlider("Silent Aim Hit Chance (by Percent)", 1, 1, 100, function(value)
    silentaimhitchance = value
end)

aimsection:addSlider("Silent Aim Hitbox Expander (by Magnitude)", 1, 1, 15, function(value)
    silentaimhitboxexpander = value
end)

aimsection:addDropdown("Silent Aim Hit Part", {"Head", "Torso"}, function(text)
    if text == "Head" then
    hitpart = "Head"
    elseif text == "Torso" then
    hitpart = "Torso"
    end
end)

--[[
aimsection:addTextbox("Silent Aim Outline Color", "(RGB Code)", function(value, focusLost)
    --print("Input", value)
    bruh.OutlineColor = Color3.fromRGB(value, value, value)
    if focusLost then
    venyx:Notify("Set to:", value)
    end
end)
]]

 aimsection:addToggle("Wallbang", nil, function(value)
    _G.WallBang = value
    if _G.WallBang == true then
        game.CollectionService:AddTag(game:GetService("Workspace").Map,'RANGED_CASTER_IGNORE_LIST')
    else
        game.CollectionService:RemoveTag(game:GetService("Workspace").Map,'RANGED_CASTER_IGNORE_LIST')
    end
 end)    

aimsection:addToggle("No Recoil", nil, function(value)
    _G.norecoil = value
    for i,v in pairs(getgc(true)) do
        if typeof(v) == 'table' and rawget(v,'maxSpread') then
            if _G.norecoil == true then
                v.recoilYMin = 0
                v.recoilZMin = 0
                v.recoilXMin = 0
                v.recoilYMax = 0
                v.recoilZMax = 0
                v.recoilXMax = 0
            end
        end
    end
end)

aimsection:addToggle("No Spread", nil, function(value)
    _G.nospread = value
end)

aimsection:addToggle("No Gravity", nil, function(value)
    _G.nogravity = value
    for i,v2 in pairs(getgc(true)) do
        if typeof(v2) == "table" and rawget(v2, "recoilAmount") then
            if _G.nogravity == true then
                v2.gravity = Vector3.new(0,0,0)
            else
                v2.gravity = Vector3.new(0, -10, 0)
            end
        end
    end
end)

--[[
aimsection:addToggle("Lowred Bow/Kunai Reload Time", nil, function(value)
    for a,b in next, getgc(true) do
        if typeof(b) == 'table' and rawget(b, 'reloadTime') then
        rawset(b, 'reloadTime', 0.1 and (0.1) or 0.2)
        end
    end
end)


aimsection:addToggle("Lowered Kunai Cooldown", nil, function(value)
    _G.TIMEKUNAI = value
    for a,b in next, getgc(true) do
        if typeof(b) == 'table' and rawget(b, 'cooldown') then
            rawset(b, 'cooldown', 0.1 and 0.1 or 0.2)
        end
    end
end)
]]

aimsection:addToggle("Instant Charge", nil, function(value)
    _G.instacharge = value
end)

section3:addKeybind("Toggle GUI", Enum.KeyCode.RightControl, function()
    --print("Activated Keybind")
    venyx:toggle()
    end, function()
    --print("Changed Keybind")
end)

section3:addButton("Always Enable Reset Button", function()
    while true do
     game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
     game:GetService("RunService").RenderStepped:Wait()
end
end)

for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= Players.LocalPlayer then
        table.insert(players, v.Name)
        if v.Character then
            local line = Drawing.new("Line")
            line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
            line.Color = TracerColor
            line.Thickness = 2
            lines[v] = line
    
            local text = Drawing.new("Text")
            text.Text = v.Name
            text.Size = 20
            text.Outline = true
            text.OutlineColor = Color3.new(0,0,0)        
            text.Center = true
            texts[v] = text

            local box = Drawing.new("Square")
            box.Thickness = 1
            box.Filled = false
            box.Visible = false
            box.ZIndex = 50
            boxes[v] = box
    
            local boxoutline = Drawing.new("Square")
            boxoutline.Visible = false
            boxoutline.Thickness = 2
            boxoutline.Filled = false
            boxoutline.ZIndex = 1
            boxoutlines[v] = boxoutline
    
            local healthbaroutline = Drawing.new("Square")
            healthbaroutline.Visible = false
            healthbaroutline.Filled = true
            healthbaroutline.Thickness = 2
            healthbaroutline.ZIndex = 1
            healthbaroutlines[v] = healthbaroutline
    
            local healthbar = Drawing.new("Square")
            healthbar.Visible = false
            healthbar.Filled = true
            healthbar.ZIndex = 50
            healthbars[v] = healthbar
        end
        v.CharacterAdded:Connect(function()
            local line = Drawing.new("Line")
            line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
            line.Color = TracerColor
            line.Thickness = 2
            lines[v] = line
    
            local text = Drawing.new("Text")
            text.Text = v.Name
            text.Size = 20
            text.Outline = true
            text.OutlineColor = Color3.new(0,0,0)        
            text.Center = true
            texts[v] = text
        end)
        v.CharacterRemoving:Connect(function()
            lines[v]:Remove()
            lines[v] = nil
            texts[v]:Remove()
            texts[v] = nil
        end)
    end
end

Players.PlayerAdded:Connect(function(v)
    table.insert(players, v.Name)
    v.CharacterAdded:Connect(function()
        local line = Drawing.new("Line")
        line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
        line.Color = TracerColor
        line.Thickness = 2
        lines[v] = line

        local text = Drawing.new("Text")
        text.Text = v.Name
        text.Size = 20
        text.Outline = true
        text.OutlineColor = Color3.new(0,0,0)
        text.Center = true
        texts[v] = text

        if v ~= Players.LocalPlayer and not boxes[v] then
            local box = Drawing.new("Square")
            box.Thickness = 1
            box.Filled = false
            box.Visible = false
            boxes[v] = box

            local boxoutline = Drawing.new("Square")
            boxoutline.Visible = false
            boxoutline.Thickness = 2
            boxoutline.Filled = false
            boxoutline.ZIndex = 1
            boxoutlines[v] = boxoutline
    
            local healthbaroutline = Drawing.new("Square")
            healthbaroutline.Visible = false
            healthbaroutline.Filled = true
            healthbaroutline.Thickness = 2
            healthbaroutline.ZIndex = 1
            healthbaroutlines[v] = healthbaroutline
    
            local healthbar = Drawing.new("Square")
            healthbar.Visible = false
            healthbar.Filled = true
            healthbar.ZIndex = 50
            healthbars[v] = healthbar
        end
    end)

    v.CharacterRemoving:Connect(function()
        lines[v]:Remove()
        lines[v] = nil
        texts[v]:Remove()
        texts[v] = nil
    end)
end)


mouse.KeyDown:Connect(function(v)
    if infjump and v == " " then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
    end
end)

UserInputService.InputBegan:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingm2 = true
        retard = getClosestToMouse()
    end
end)

UserInputService.InputEnded:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingm2 = false
        aimbotLocked = false
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end)
local bee
bee = workspace.EffectsJunk.ChildAdded:Connect(function(p)
    if Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") == nil then
        shot = false
        return
    end
    local Tool = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if Tool:FindFirstChild("ClientAmmo") == nil then
        shot = false
        return
    end
    if shot and p:IsA("MeshPart") then
        ARROW = p
        Instance.new("SelectionBox",p).Adornee = p
        shot = false
        print("arrow var set to arrow part")
    end
end)

for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v,"shoot") then
        local Old = v.shoot
        v.shoot = function(tbl)
            shot = true
            arrowsshooted = tbl.shotIdx
            closest = getClosestToMouse()
            return Old(tbl)
        end
    end
    if typeof(v) == "table" and rawget(v,"calculateFireDirection") then
        old = v.calculateFireDirection
        v.calculateFireDirection = function(p3,p4,p5,p6)
            local Tool = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if Tool:FindFirstChild("ClientAmmo") == nil then
                return old(p3,p4,p5,p6)
            end
            if _G.nospread == true then
                p4 = 0
                p5 = 0
            end
            if _G.silentaim == true and shot then
                local closesta = getClosestToMouse()
                local whereHeGonnaBe = closesta.Character.Head.CFrame + (closesta.Character.Head.Velocity * 0.19 + Vector3.new(0, .1, 0))
                return (CFrame.lookAt(Tool.Contents.Handle.FirePoint.WorldCFrame.Position, whereHeGonnaBe.Position)).LookVector * 30;
            end
            return old(p3,p4,p5,p6)
        end
    end
end

local Weapon
task.spawn(function()
    while task.wait(KillAuraHitCooldown) do
        if _G.killaura then
            pcall(function()
                Closest = getClosest()
                for i, v in pairs(Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") then
                        if v:FindFirstChild("Hitboxes") ~= nil then
                            Weapon = v
                        end
                    end
                end
                local rayOrigin = Players.LocalPlayer.Character.HumanoidRootPart.Position
                local rayDirection = Vector3.new(10, 10, 10)
                local raycastParams = RaycastParams.new()
                raycastParams.IgnoreWater = true
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                local args1 = {
                    [1] = Weapon,
                    [2] = math.random(1, 4)
                }

                local args = {
                    [1] = Weapon,
                    [2] = Closest.Character.Head,
                    [3] = Weapon.Hitboxes.Hitbox,
                    [4] = Closest.Character.Head.Position,
                    [5] = Closest.Character.Head.CFrame:ToObjectSpace(
                        CFrame.new(Closest.Character.Head.Position)
                    ),
                    [6] = raycastResult
                }

                    remotes["MeleeSwing"]:FireServer(args1)
                    remotes["MeleeDamage"]:FireServer(args1)
                end)
        end

        if _G.silentaim == true then
            pcall(function()
                local bow = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if closest then
                    bruh.Adornee = getClosestToMouse().Character
                end
                if ARROW then
                    if closest then
                        if (ARROW.Position - closest.Character.HumanoidRootPart.Position).Magnitude <= silentaimhitboxexpander then
                            if silentaimhitchance == 100 then
                                firehit(closest.Character,ARROW)
                                ARROW = nil
                                shot = false
                            else
                                local didIHitThat = calculateArrowHitChance(silentaimhitchance)
                                if didIHitThat then
                                    firehit(closest.Character,ARROW)
                                    ARROW = nil
                                    shot = false
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    RunService.Stepped:Connect(function()

        if _G.strafe == true then
        local origin = getClosest().Character.HumanoidRootPart.CFrame
        if (LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - origin.Position).Magnitude <= straferange then
        angle = (angle + 0.04 * 9) % (1 * math.pi);
        LocalPlayer.Character.HumanoidRootPart.CFrame = origin * CFrame.new(math.cos(angle) * -4 * 2.3 , 0, math.sin(angle) * -8);
        end
        end

        if walkspeedenabled then
            if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
            else
                Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed + 50
            end
        end
                
        if jumppowerenabled then
            Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 130
        end

	if _G.highlight == true then
	bruh.OutlineTransparency = 0
	else
	bruh.OutlineTransparency = 1
	end

        if autospawn == true and Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") then
            keypress(0x20)
            keyrelease(0x20)
        end
    
        if _G.stompaura == true then
            for i,v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health <= 15 then
                    if (v.Character.HumanoidRootPart.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                        keypress(0x51)
                        keyrelease(0x51)
                    end
                end
            end
        end
        
        pcall(function()
            if _G.aimbot == true and holdingm2 then
                aimbotLocked = true
                if aimbotLocked and retard ~= nil then
                    local whereHeGonnaBe = retard.Character.HumanoidRootPart.CFrame + (retard.Character.HumanoidRootPart.Velocity * 0.19 + Vector3.new(0, .1, 0))
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, whereHeGonnaBe.Position)
                    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
                end
            end
        end)
--[[
        if hidename then
            --remotes("UpdateIsCrouching", true)
        else
            --remotes("UpdateIsCrouching", false)
        end
]]
        pcall(
            function()
                for i, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        if v:FindFirstChild("Hitboxes") ~= nil then
                            if autoequip and not Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                                v.Parent = Players.LocalPlayer.Character
                            end
                        end
                    end
                end
            end
        )
        if noclip then
            for i,v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
        
        if tracersenabled then
            for player,line in pairs(lines) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    --local pos,visible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                    line.Color = TracerColor
                    line.To = Vector2.new(pos.X, pos.Y)
                    -- line.Color = player.Character.Torso.Color
                    line.Visible = visible
                else
                    line.Visible = false
                end
            end
        else
            for player,line in pairs(lines) do
                line.Visible = false
            end
        end
    
        if textenabled then
            for player,text in pairs(texts) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    local head, HeadVisible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.Head.Position)
                    text.Position = Vector2.new(head.X, head.Y - 28)
                    text.Color = TracerColor
                    text.Visible = HeadVisible
                else
                    text.Visible = false
                end
            end
        else
            for player,text in pairs(texts) do
                text.Visible = false
            end
        end

        if boxesenabled then
            for i,v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    local hrp, visible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    local head, headvisible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position + Vector3.new(0, 1, 0))
                    local leg, legvisible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position - Vector3.new(0,3,0))
                    local X = 2000 / hrp.Z
                    local Y = head.Y - leg.Y
                    boxes[v].Visible = visible
                    boxoutlines[v].Visible = visible
                    healthbars[v].Visible = visible
                    healthbaroutlines[v].Visible = visible
        
                    if visible then
                        boxes[v].Position = Vector2.new(hrp.X - boxes[v].Size.X / 2, hrp.Y - boxes[v].Size.Y / 2)
                        boxes[v].Size = Vector2.new(X, Y)
                        boxes[v].Color = TracerColor
                        boxoutlines[v].Position = Vector2.new(hrp.X - boxes[v].Size.X / 2, hrp.Y - boxes[v].Size.Y / 2)
                        boxoutlines[v].Size = Vector2.new(X, Y)
                        healthbaroutlines[v].Size = Vector2.new(3, Y)
                        healthbaroutlines[v].Position = Vector2.new(hrp.X - boxes[v].Size.X / 2, hrp.Y - boxes[v].Size.Y / 2) - Vector2.new(6, 0)
                        healthbars[v].Color = Color3.fromRGB(173, 0, 0):Lerp(Color3.fromRGB(0, 160, 0), v.Character:FindFirstChild("Humanoid").Health/v.Character:FindFirstChild("Humanoid").MaxHealth)
                        healthbars[v].Size = Vector2.new(2, (-healthbaroutlines[v].Size.Y - 2) * (v.Character:FindFirstChild("Humanoid").Health/v.Character:FindFirstChild("Humanoid").MaxHealth))
                        healthbars[v].Position = healthbaroutlines[v].Position + Vector2.new(1, -1 + healthbaroutlines[v].Size.Y)
                    end
                else
                    if v ~= Players.LocalPlayer then
                        boxes[v].Visible = false
                        boxoutlines[v].Visible = false
                        healthbars[v].Visible = false
                        healthbaroutlines[v].Visible = false
                    end
                end
            end
        else
            for i,v in pairs(boxes) do
                v.Visible = false
            end
            for i,v in pairs(boxoutlines) do
                v.Visible = false
            end
            for i,v in pairs(healthbars) do
                v.Visible = false
            end
            for i,v in pairs(healthbaroutlines) do
                v.Visible = false
            end
        end
       

        local Tool = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if Tool ~= nil and Tool:FindFirstChild("ClientAmmo") == nil then
            return
        end

        if Players.LocalPlayer.Character then
            if Players.LocalPlayer.Character:FindFirstChild('Longbow') or Players.LocalPlayer.Character:FindFirstChild('Heavy Bow') and _G.instacharge == true then
                for i,v in pairs(getconnections(Tool.ChargeProgressClient:GetPropertyChangedSignal("Value"))) do
                    v:Disable()
                end
                Tool.ChargeProgressClient.Value = 1
            end
        end
    end)
end)

local katp
local deb = false

--[[
task.spawn(function()
while true do
    local weapon = GetWeapon()
       local cooldown
        local kaprior = kahealthenabled
        local closest = GetPlayer(killauradistance,kaprior == "Health" and true or false)
        local origin = getClosest().Character.HumanoidRootPart.CFrame
        cooldown = Cooldowns[weapon.Name]
        for i,v in pairs(closest) do
            if (Players:FindFirstChild(i) and Players[i].Character and weapon and Players[i].Character:FindFirstChild("Head")) then
                if kaparrycheck == true then
                     if IsParrying(Players[i]) then continue end
                       end
                    if (Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - origin.Position).Magnitude <= 15 and deb == false then
                deb = true
                Network:FireServer("MeleeSwing",weapon,math.random(1,4))
                Network:FireServer("MeleeDamage",weapon,Players[i].Character:FindFirstChild("Head"),weapon.Hitboxes:FindFirstChild('Hitbox'),Players[i].Character.Head.Position,CFrame.new(),Vector3.new())
            angle = (angle + 0.04 * 8) % (1 * math.pi);
            LocalPlayer.Character.HumanoidRootPart.CFrame = origin * CFrame.new(math.cos(angle) * 4 * 2.5 , 0, math.sin(angle) * 10);
            if attackoneka then
                            break
                        end
                    end
                end
        end
        task.wait(cooldown)
        deb = false
     end
end)
]]
-- load
venyx:SelectPage(venyx.pages[1], true)
end
