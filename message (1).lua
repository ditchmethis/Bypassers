if getgenv().executed then
	return
end
getgenv().executed = true

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

task.wait(1)
Notification:Notify(
	{Title = "Lumware (Premium) is loaded.", Description = "You're whitelisted, "..game.Players.LocalPlayer.DisplayName.."! Make sure to vouch in the #vouch channel after using this."},
	{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 10, Type = "image"},
	{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
)

if not syn then
	task.wait(1)
	Notification:Notify(
		{Title = "Lumware Version: v1.4", Description = "CL: Synapse Support! including new features with Synapse, you're not using synapse tho ;p"},
		{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 15, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
	)
end

if syn then
	task.wait(1)
	Notification:Notify(
		{Title = "Lumware Version: v1.4", Description = "CL: Synapse Support! You're using Synapse, Lumware supports more new features and stability!"},
		{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 15, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
	)
end

task.wait(3)

local synTag = "Lumware (Premium) ⭐ | Synapse Supported"
local normTag = "Lumware (Premium) ⭐"
local TagChoices

if syn then
	TagChoices = synTag
else
	TagChoices = normTag
end

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zMaaaaaaark/UI-/main/uilib2.lua"))()
local venyx = library.new(TagChoices, 5013109572)

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
local _lookupTable = rawget(require(game:GetService("ReplicatedStorage").Framework.Nevermore), "_lookupTable")
local network = rawget(_lookupTable, "Network")
local remotes_table = getupvalue(getsenv(network).GetEventHandler, 1)
local events_table = getupvalue(getsenv(network).GetFunctionHandler, 1)
local modules = {}
local remotes = {}
local lines = {}
local texts = {}
local players = {}
local boxes = {}
local boxoutlines = {}
local healthbars = {}
local healthbaroutlines = {}

local straferange = 1
local hitpart
local ARROW
local bruh = Instance.new("Highlight",game.CoreGui)
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
local noclipping = false
local apdist = 1
local autoparry_chance = 1
local antiparry_chance = 1
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

bruh.FillColor = Color3.fromRGB(97, 242, 136)
bruh.FillTransparency = 1
bruh.OutlineTransparency = 1

for i,v in pairs(_lookupTable) do
	modules[i] = require(v)
end

setmetatable(remotes, {
	__call = function(table2, ...)
		local args = {...}

		table.foreach(args, print)

		table2[args[1]]:FireServer(args[2])
	end
})

do
	for i, v in pairs(remotes_table) do
		-- index is name, value is info table
		remotes[i] = rawget(v, "Remote")
	end
	for i, v in pairs(events_table) do
		-- index is name, value is info table
		remotes[i] = rawget(v, "Remote")
	end
end

RunService.Stepped:Connect(function()
	for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"))) do
		v:Disable()
	end
	for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"))) do
		v:Disable()
	end
	for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("HipHeight"))) do
		v:Disable()
	end
end)

if syn then -- start of syn closure (ez bypass)
	hookfunction(modules["AntiCheatHandler"].punish, function(...)
		return
	end)
	hookfunction(modules["AntiCheatHandlerClient"]._startModule, function(...)
		return
	end)

	local old;old=hookfunction(modules["JumpHandlerClient"].getCanJump,function(...)
		if _G.nojumpcooldown == true then
			return true
		end
		return old(...)
	end)

	local function getRemote(name)
		return game:GetService("ReplicatedStorage").Communication.Events[name]
	end

end -- end of syn closure

local function getClosest()
	local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position or Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
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
		[5] = math.random(0,1),
		[6] = tostring(arrowsshooted)
	}
	remotes["RangedHit"]:FireServer(unpack(args))
end

getgenv().hitremote = nil
getgenv().swingremote = nil
getgenv().fallremote = nil
getgenv().ragdollremote = nil

local Network = modules["Network"]

if syn then
	local old;old=hookfunction(debug.info,function(context,type)
		if context == 2 and type == "s" then
			return true
		end
		return old(context,type)
	end)
end

if not syn then
	hookfunction(debug.info,function(context,type)
		if context == 2 and type == "s" then
			return true
		end
	end)
end

task.wait(0.5)
-- by len
pcall(function()
	for i = 1,25 do
		remotes("StartFastRespawn")
		remotes("CompleteFastRespawn")
		wait()
	end
end)

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

--[[
function RollBack(data)
   if DataHandler.GetInitialPlayerDataRoduxStoreState then
   DataHandler.GetInitialPlayerDataRoduxStoreState:FireServer(data,"\255")
   DataHandler:getDataRoduxStoreForPlayer("GetInitialPlayerDataRoduxStoreState"):SetAsync("fucked", "\255")
   end
   return nil
end

RollBack()
]]

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
local section1 = page:addSection("Auto Parry Section")
local antiparrysec = page:addSection("Anti-Parry Section")
local apmisc = page:addSection("Parry Miscellaneous Section")
local section2 = page:addSection("Gameplay Behavior")

local debounce = false
local AutoCD_Debounce = true
local AntiCD_Debounce = true
local autoparrycooldown = 0
local autoparryrange
local antiparrycooldown
local antiparryrange
local kacooldownewapon
local kaparrycheck
local attackoneka
local attackmultika
local killauradistance = 1
local kahealthenabled
local killaurahitcooldown

--[[
function AutoParryChance(number)
   return (math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100) <= math.floor(number) / 100
end

function AntiParryChance(number)
   return (math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100) <= math.floor(number) / 100
end
]]

local function AutoParryChance(v)
	local chance = math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100
	return chance <= math.floor(v) / 100
end

local function AntiParryChance(v)
	local chance = math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100
	return chance <= math.floor(v) / 100
end

section1:addToggle("Auto-Parry", nil, function(value)
	_G.autoparry = value
end)

--[[
section1:addToggle("Auto-Parry TP", nil, function(value)
   _G.aptp = value
end)
]]

--[[
section1:addToggle("Auto Equip Weapon on Trigger", nil, function(value)
   _G.equiptool = value
end)
]]

antiparrysec:addToggle("Anti-Parry", nil, function(value)
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
									if (AntiCD_Debounce == false) then
										LocalPlayer.Character.Humanoid:UnequipTools()
										p:GetPropertyChangedSignal'Transparency':wait()
									else
										LocalPlayer.Character.Humanoid:EquipTool(Weapon)
										antiparryRS:Disconnect()
									end
								end)
								Notification:Notify(
									{Title = "Anti-Parry Triggered!", Description = "that person prob messed up, i hope you didn't messed up as well"},
									{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 3, Type = "image"},
									{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
								)
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

section1:addSlider("Auto-Parry Range", 1, 1, 16, function(value)
	apdist = value
end)

--[[]
section1:addSlider("Auto-Parry Chance", 1, 1, 100, function(value)
   autoparry_chance = value
end)
]]

local animationInfo = {}

local remAP = false
local kpAP = false

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

function block2(player)
	Network:FireServer("Parry")
end

function playerAdded(v)
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
					local magn = (v.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
					if magn < apdist then
						for _, animName in pairs(AnimNames) do
							if info.Name:match(animName) and AutoCD_Debounce == true and _G.autoparry == true then
								AutoCD_Debounce = true
								if kpAP == true and remAP == false then
									pcall(block, v)
								elseif kpAP == false and remAP == true then
									pcall(block2, v)
								end
								task.wait(autoparrycooldown)
								AutoCD_Debounce = true
							end
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

antiparrysec:addSlider("Anti-Parry Range", 15, 15, 26, function(value)
	antiparryrange = value
end)

--[[
antiparrysec:addSlider("Anti-Parry Chance", 1, 1, 100, function(value)
   antiparry_chance = value
end)
]]

antiparrysec:addSlider("Anti-Parry Cooldown", 0, 0, 1, function(value)
	antiparrycooldown = value
end)

apmisc:addToggle("No Parry Cooldown", nil, function(value)
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

section1:addSlider("Auto-Parry Cooldown", 0, 0, 2, function(value)
	autoparrycooldown = value
end)

section1:addDropdown("Auto-Parry Method", {"Remote", "Keypress"}, function(text)
	if text == "Remote" then
		remAP = true
		kpAP = false
	elseif text == "Keypress" then
		remAP = false
		kpAP = true 
	end
end)


section2:addToggle("Infinite Stamina", nil, function(value)
	_G.infstam = value
end)

section2:addToggle("Infinite Air", nil, function(value)
	_G.infair = value
end)

section2:addToggle("No Dash Cooldown", nil, function(value)
	_G.nodashcd = value
end)

if syn then
	section2:addToggle("No Jump Cooldown (Synapse Exclusive)", nil, function(value)
		_G.nojumpcooldown = value
	end)
end

local Stamina = modules["DefaultStaminaHandlerClient"].getDefaultStamina()

task.spawn(function()
	RunService.Stepped:Connect(function()
		if _G.infstam == true then
			Stamina:setStamina(math.huge)
		else
			Stamina:setStamina(100)
		end
		if _G.infair == true then
			modules["AirConstants"].AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = 0
		else
			modules["AirConstants"].AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = 1
		end
		if _G.nojumpcooldown == true then
			modules["JumpConstants"].JUMP_DELAY_ADD = 0
		else
			modules["JumpConstants"].JUMP_DELAY_ADD = 1
		end
		if _G.nodashcd == true then
			modules["DashConstants"].DASH_COOLDOWN = 0
			DataHandler.getSessionDataRoduxStoreForPlayer(LocalPlayer):getState().dashClient.isDashing = false
		else
			modules["DashConstants"].DASH_COOLDOWN = 3
		end
		if walkspeedenabled == true then
			if (not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
				Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
			else
				Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed + 50
			end
		end
		if jumppowerenabled == true then
			Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 130
		else
			Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
		end
	end)
end)

section2:addToggle("No Ragdoll", nil, function(value)
	_G.noragdoll = value
end)

section2:addToggle("Instant Self-Revive", nil, function(value)
	_G.instantrev = value
end)

section2:addToggle("Stomp Aura", nil, function(value)
	_G.stompaura = value
end)

section2:addToggle("Auto-Spawn", nil, function(value)
	autospawn = value
end)

section2:addToggle("Fast Respawn", nil, function(value)
	_G.fastres = value
end)

section2:addToggle("Noclip (Walk Through Walls)", nil, function(value)
	noclipping = value
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
end)

RunService.Stepped:Connect(function()
	if _G.nbt == true then
		for i, v in pairs(workspace.EffectsJunk:GetChildren()) do
			if v.Name == "OpenBearTrap" or v.Name == "" then
				v:Destroy()
			end 
		end
	end
end)

section2:addToggle("Fast Player Revive", nil, function(value)
	_G.fastplrrev = value
	for a,b in next, getgc(true) do
		if typeof(b) == 'table' and rawget(b, 'REVIVE_DURATION') and _G.fastplrrev == true then
			rawset(b, 'REVIVE_DURATION', value and 2 or 2.5)
		elseif typeof(b) == 'table' and rawget(b, 'REVIVE_DURATION') then
			rawset(b, 'REVIVE_DURATION', value and 5 or 5)
		end
	end
end)

section2:addToggle("Always Reset when Downed", nil, function(value)
	_G.Toggled = value
end)

if syn then
	section2:addToggle("Velocity Fly", nil, function(value)
		toggleFly(value,false)
	end)

	section2:addToggle("Ragdoll Fly", nil, function(value)
		toggleFly(value,value)
	end)
end

function toggleFly(value,ragdoll) -- ez fly
	DataHandler.getSessionDataRoduxStoreForPlayer(game.Players.LocalPlayer):getState().fly.isFlying = value
	if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid:FindFirstChild("RagdollRemoteEvent")) then
		LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(ragdoll)
	end
	if value == true then
		getupvalue(modules["FlyHandlerClient"]._startModule,2)(game.Players.LocalPlayer.Character)
	else
		if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("LinearVelocity")) then
			LocalPlayer.Character.HumanoidRootPart.LinearVelocity:Destroy()
		end
	end
end

task.spawn(function()
	RunService.Stepped:Connect(function()
		if _G.Toggled == true then
			if LocalPlayer.Character.Humanoid.Health <= 15 then
				LocalPlayer.Character.Humanoid.Health = 0
			end
		end
	end)
end)

section2:addToggle("Player Strafe (w/Anti-Strafe)", nil, function(value)
	_G.strafe = value
end)

section2:addSlider("Strafe Distance", 1, 1, 40, function(value)
	straferange = value
end)

local KillAuraSec = page:addSection("Kill Aura Section")

-- Whitelisting system
local Whitelist = {}

Players.PlayerAdded:Connect(function(Player)
	if Player:IsFriendsWith(LocalPlayer.UserId) then
		table.insert(Whitelist, Player.Name)
	end
end)

Players.PlayerRemoving:Connect(function(Player)
	if table.find(Whitelist,Player.Name) then
		table.remove(Whitelist,table.find(Whitelist,Player.Name))
	end
end)

function CheckWhitelist(Name)
	if table.find(Whitelist,Name) then
		return false
	end
	if (_G.kawhitelist == true and Players:FindFirstChild(Name) and Players:FindFirstChild(Name):IsFriendsWith(LocalPlayer.UserId)) then
		return false
	end
	return true
end

KillAuraSec:addToggle("Kill Aura", nil, function(value)
	_G.killaura = value
	task.spawn(function()
		while true do
			local weapon = GetWeapon()
			if (weapon and _G.killaura == true) then
				local wpcooldown
				local kaprior = kahealthenabled
				local closest = GetPlayer(killauradistance,kaprior == "Health" and true or false)
				local origin = getClosest().Character.HumanoidRootPart.CFrame
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
						if _G.kawhitelist == true then
							if (Players[i]:IsFriendsWith(LocalPlayer.UserId)) then continue end
						end
                       --[[
                       if not (Players[i]:IsFriendsWith(LocalPlayer.UserId) and _G.katp == true) then
                           if (Players[i]:IsFriendsWith(LocalPlayer.UserId) and _G.kawhitelist == true) then continue end
                           task.wait(.1)
                           LocalPlayer.Character.HumanoidRootPart.CFrame = origin * CFrame.new(0, 0, killauratpdistance)
                       end
                       ]]
						if not (Players[i]:IsFriendsWith(LocalPlayer.UserId) or Players[i]:IsFriendsWith(LocalPlayer.UserId) and _G.kawhitelist == false) then
							Network:FireServer("MeleeDamage",weapon,Players[i].Character:FindFirstChild("Head"),weapon.Hitboxes:FindFirstChild('Hitbox'),Players[i].Character:FindFirstChild("HumanoidRootPart").Position,CFrame.new(),Vector3.new())
							Network:FireServer("MeleeDamage",weapon,Players[i].Character:FindFirstChild("Torso"),weapon.Hitboxes:FindFirstChild('Hitbox'),Players[i].Character:FindFirstChild("HumanoidRootPart").Position,CFrame.new(),Vector3.new())
						end
						if attackoneka then
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
					task.wait(0.055)
				end
			else
				task.wait()
			end
		end
	end)
end)

--[[
KillAuraSec:addToggle("Kill Aura TP", nil, function(value)
   _G.katp = value
end)
]]

KillAuraSec:addToggle("Kill Aura Friend Whitelist", nil, function(value)
	_G.kawhitelist = value
end)

KillAuraSec:addToggle("Kill Aura Weapon Based CD", nil, function(value)
	kacooldownewapon = value
end)

KillAuraSec:addToggle("Kill Aura Parry Check", nil, function(value)
	kaparrycheck = value
end)

--[[
KillAuraSec:addSlider("Kill Aura TP Distance", 1, 1, 10, function(value)
   killauratpdistance = value
end)
]]

KillAuraSec:addSlider("Kill Aura Distance", 1, 1, 25, function(value)
	killauradistance = value
end)

local drop1 = KillAuraSec:addDropdown("Kill Aura Type", {"Attack One", "Attack Multiple"}, function(text)
	if text == "Attack One" then
		attackoneka = text

		Notification:Notify(
			{Title = "⚠️ WARNING!", Description = "This feature has a high chance of getting kicked."},
			{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 3, Type = "image"},
			{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
		)

		Notification:Notify(
			{Title = "⚠️ REMINDER!", Description = "If you wish to use this, turn on Kill Aura Weapon Based Cooldown!"},
			{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 3, Type = "image"},
			{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
		)

		task.wait(1)

		Notification:Notify(
			{Title = "⚠️ WARNING!", Description = "It's recommended to use 'Attack Multiple' to avoid getting kicked."},
			{OutlineColor = Color3.fromRGB(110, 255, 124),Time = 3, Type = "image"},
			{Image = "http://www.roblox.com/asset/?id=", ImageColor = Color3.fromRGB(0, 255, 60)}
		)
	elseif text == "Attack Multiple" then
		attackmultika = text
	end
end)


local drop2 = KillAuraSec:addDropdown("Kill Aura Priority", {"None", "Health"}, function(text)
	if text == "Health" then
		kahealthenabled = text
	end
end)

-- second page
local page2 = venyx:addPage("Servers", 5012544693)
local s_hop = page2:addSection("Server Hop")

s_hop:addButton("Teleport to Console Server", function()
	game:GetService("TeleportService"):Teleport(11979327002,LocalPlayer)
end)

s_hop:addButton("Teleport to Console Beginners Server", function()
	game:GetService("TeleportService"):Teleport(11979321561,LocalPlayer)
end)

s_hop:addButton("Teleport to PC Beginners Server", function()
	game:GetService("TeleportService"):Teleport(11979315221,LocalPlayer)
end)

s_hop:addButton("Teleport to Mobile Server", function()
	game:GetService("TeleportService"):Teleport(11979325120,LocalPlayer)
end)

s_hop:addButton("Teleport to Mobile Beginners Server", function()
	game:GetService("TeleportService"):Teleport(11979319180,LocalPlayer)
end)

s_hop:addButton("Teleport to Mobile VC Only Server", function()
	game:GetService("TeleportService"):Teleport(11990852350,LocalPlayer)
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

section3:addButton("Hitbox Expander", function()
	for i, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v:FindFirstChild("Hitboxes") ~= nil then
				if Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
					v.Parent = Players.LocalPlayer.Character
				end
			end
		end
	end
	task.wait(.1)
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


section3:addButton("Always Enable Reset Button", function()
	while true do
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
		game:GetService("RunService").RenderStepped:Wait()
	end
end)

section3:addButton("Anti-Aimlock", function()
	getgenv().VelocityChanger = true
	getgenv().Velocity = Vector3.new(500,-1,360 * -2)

	local Character   = LocalPlayer.Character
	local RootPart    = Character:FindFirstChild("HumanoidRootPart")

	local Heartbeat, RStepped, Stepped = RunService.Heartbeat, RunService.RenderStepped, RunService.Stepped

	LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
		Character = NewCharacter
	end)

	local RVelocity, YVelocity = nil, 0.01

	while true do
		if VelocityChanger then
			--// this a dumb check asnilsadsa
			if (not RootPart) or (not RootPart.Parent) or (not RootPart.Parent.Parent) then
				RootPart = Character:FindFirstChild("HumanoidRootPart")
			else
				RVelocity = RootPart.Velocity
				RootPart.Velocity = type(Velocity) == "vector" and Velocity or Velocity(RVelocity)
				RStepped:wait()
				RootPart.Velocity = RVelocity
			end
		end
		Heartbeat:wait()
	end
end)

section3:addKeybind("Toggle GUI", Enum.KeyCode.RightControl, function()
	--print("Activated Keybind")
	venyx:toggle()
end, function()
	--print("Changed Keybind")
end)

FLYING = false
iyflyspeed = 1
vehicleflyspeed = 1
-- i love stealing features from infinite yield and adding them to my script :sunglasses:

function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character.HumanoidRootPart and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = Players.LocalPlayer.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end


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

local placeholder = true

local Weapon
task.spawn(function()
	while task.wait(KillAuraHitCooldown) do
		if placeholder == false then
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

				--remotes["MeleeSwing"]:FireServer(args1)
				---remotes["MeleeDamage"]:FireServer(args1)
				--remotes["MeleeDamage"]:FireServer(args1)
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

		if _G.highlight == true then
			bruh.OutlineTransparency = 0
		else
			bruh.OutlineTransparency = 1
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

local revRS

revRS = game:GetService("RunService").Stepped:Connect(function()
	if (LocalPlayer.Character:WaitForChild("Humanoid").Health <= 16) then
		if (_G.instantrev == true) then
			Network:FireServer("SelfReviveStart")
			Network:FireServer("SelfRevive")
		end
	end
end)

function NoRagdoll()
	if _G.noragdoll == true then
		game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):WaitForChild("RagdollRemoteEvent"):FireServer(false)
	end
end

game:GetService('RunService').Heartbeat:Connect(NoRagdoll)

function fastRespawn()
	if _G.fastres == true then
		if LocalPlayer.Character.Humanoid.Health <= 0 then
			task.wait(0.5)
			pcall(function()
				for i = 1, 8 do
					remotes("StartFastRespawn")
					remotes("CompleteFastRespawn")
					task.wait()
				end
			end)
		end
	end
end

game:GetService('RunService').Heartbeat:Connect(fastRespawn)

function autoSpawn()
	if autospawn == true and Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") then
		keypress(0x20)
		keyrelease(0x20)
	end  
end

game:GetService('RunService').Heartbeat:Connect(autoSpawn)

function NoclipLoop()
	if (noclipping == true and LocalPlayer.Character) then
		for i,v in pairs(LocalPlayer.Character:GetChildren()) do
			if (v:IsA("BasePart") and v.Transparency ~= 1 and v.CanCollide == true) then
				v.CanCollide = false
			end
		end
	elseif (noclipping == false and LocalPlayer.Character) then
		for i,v in pairs(LocalPlayer.Character:GetChildren()) do
			if (v:IsA("BasePart") and not v.Name:match("Arm") and not v.Name:match("Leg") and v.Transparency ~= 1 and v.CanCollide == false) then
				v.CanCollide = true
			end
		end
	end
end

game:GetService("RunService").Stepped:Connect(NoclipLoop)

venyx:SelectPage(venyx.pages[1], true)
