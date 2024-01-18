-- VARIABLES NEEDED
local function service(...) return game:GetService(...) end
local Players = service("Players")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))
local Connection = ReplicatedStorage:WaitForChild("Connection")
local ConnectionEvent = ReplicatedStorage:WaitForChild("ConnectionEvent")
local function getservers()
	return Connection:InvokeServer(399)
end
local function joinserver(instid)
	return Connection:InvokeServer(400,instid)
end
-- END OF VARIABLES

-- GUI VARIABLES
local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("MEEPCITY",Color3.fromRGB(44, 120,s 224), Enum.KeyCode.RightControl)
local tab0 = win:Tab("Items")
local tab1 = win:Tab("Avatar")
local tab2 = win:Tab("Fishing")
local tab3 = win:Tab("Servers")
-- END OF GUI VARIABLES
local function colorToTable(clr) return {tostring(clr.R*255),tostring(clr.G*255),tostring(clr.B*255)} end
local function ExtractData(humdes)
	local ava = {}
	for _,v in pairs({"WidthScale", "HeadScale","HeightScale","DepthScale","BodyTypeScale","ProportionScale"}) do
		ava[v] = humdes[v]
	end
	for _,v in pairs({"Face","Head","LeftArm","RightArm","LeftLeg","RightLeg","Torso"}) do
		ava[v] = humdes[v]
	end
	for _,v in pairs({"HeadColor","LeftArmColor","RightArmColor","LeftLegColor","RightLegColor","TorsoColor"}) do
		ava[v] = colorToTable(humdes[v])
	end
	for _,v in pairs({"GraphicTShirt","Shirt","Pants"}) do
		ava[v] = humdes[v]
	end

	for _,v in pairs({"ClimbAnimation","FallAnimation","IdleAnimation","JumpAnimation","RunAnimation","SwimAnimation","WalkAnimation"}) do
		ava[v] = humdes[v]
	end
	for _,v in pairs({"Hat","Hair","Back","Face","Front","Neck","Shoulders","Waist"}) do
		ava[v .. "Accessory"] = humdes[v .. "Accessory"]
	end
	ava.Emotes = humdes:GetEmotes()
	local layered = humdes:GetAccessories(false)
	for i,v in pairs(layered) do
		if v.AccessoryType and typeof(v.AccessoryType) == "EnumItem" then
			v.AccessoryType = v.AccessoryType.Name
		end
	end
	ava.AccessoryBlob = layered
	return ava
end

tab1:Textbox("Morph into user:",true, function(username)
	if username and Players:GetUserIdFromNameAsync(username) then
		local data = ExtractData(Players:GetHumanoidDescriptionFromUserId(Players:GetUserIdFromNameAsync(username)))
		ConnectionEvent:FireServer(315,data,true)
	end
end)
tab1:Textbox("Morph into userid:",true, function(userid)
	if userid and tonumber(userid) and Players:GetHumanoidDescriptionFromUserId(tonumber(userid)) then
		local data = ExtractData(Players:GetHumanoidDescriptionFromUserId(tonumber(userid)))
		ConnectionEvent:FireServer(315,data,true)
	end
end)
tab1:Toggle("Unlimited Outfits",false, function(b)
	if b then
		Constants.STATS.MAXAvatarEditorCustomOutfits = 999999
	else
		Constants.STATS.MAXAvatarEditorCustomOutfits = 3
	end
end)

-- END OF TAB1

tab2:Toggle("Silent Aim",false, function(b)
	if b then
		Constants.STATS.FISHCastObjectMinDistanceToCatch = 9999999
	else
		Constants.STATS.FISHCastObjectMinDistanceToCatch = 50
	end
end)
tab2:Toggle("Unlimited Bucket Size",false, function(b)
	if b then
		Constants.STATS.FISHMaxAllowedInBucket = 9999999
	else
		Constants.STATS.FISHMaxAllowedInBucket = 20
	end
end)
tab3:Button("Join Most Populated Server", function()
lib:Notification("Notification", "Joining Most Populated Server", "Okay!")
	local server = getservers()[1]
	joinserver(server.InstanceId)
end)
tab3:Button("Join Least Populated Server", function()
lib:Notification("Notification", "Joining Least Populated Server", "Okay!")
	local servers = getservers()
	local server = servers[#servers]
	joinserver(server.InstanceId)
end)
tab3:Button("Join Random Server", function()
lib:Notification("Notification", "Joining Random Server", "Okay!")
	local servers = getservers()
	local server = servers[math.random(1, #servers)]
	joinserver(server.InstanceId)
end)
tab3:Button("Open Server List", function()
	local serverbrowsermodule = require(game.Players.LocalPlayer.PlayerGui:WaitForChild("ServerBrowserGui"):WaitForChild("ServerBrowserGUI"))
	serverbrowsermodule.Open()
end)
tab0:Textbox("Equip Avatar Item:",true, function(assetid)
	assetid = tonumber(assetid)
	if assetid then
	local info = MarketplaceService:GetProductInfo(assetid)
	local data = Connection:InvokeServer(Constants.AE_REQUEST_AE_DATA)
	local wearing = data.PlayerCurrentTemporaryOutfit or data.PlayerCurrentlyWearing
		wearing.HeadAccessory = AddAccessoryString(wearing.HeadAccessory,assetid)
		end
		ConnectionEvent:FireServer(315,wearing,true)
	end
end)
--[[
tab:Button("Button", function()
lib:Notification("Notification", "Hello!", "Hi!")
end)

tab:Toggle("Toggle",false, function(t)
print(t)
end)

tab:Dropdown("Dropdown",{"Option 1","Option 2","Option 3","Option 4","Option 5"}, function(t)
print(t)
end)

tab:Textbox("Textbox",true, function(t)
print(t)
end)
]]--
