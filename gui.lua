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
local win = lib:Window("MEEPCITY",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local tab = win:Tab("Avatar")
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

tab:Textbox("Morph into user:",true, function(username)
	if username and Players:GetUserIdFromNameAsync(username) then
		local data = ExtractData(Players:GetHumanoidDescriptionFromUserId(Players:GetUserIdFromNameAsync(username)))
		ConnectionEvent:FireServer(315,data,true)
	end
end)

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
