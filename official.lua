local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("MEEPCITY",Color3.fromRGB(44, 120,s 224), Enum.KeyCode.RightControl)
local tab1 = win:Tab("Avatar")

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
