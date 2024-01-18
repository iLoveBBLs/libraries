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

tab:Textbox("Textbox",true, function(t)
print(t)
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
