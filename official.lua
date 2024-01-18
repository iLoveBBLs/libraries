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