local Credit = getgenv().WindowNah:AddTab("Credit / Join", "rbxassetid://7733955511")
local CreditTab = Credit:AddLeftGroupbox("Credit")
local CreditScript = {
	["Giang Hub"] = {
		Text = '[<font color="rgb(73, 230, 133)">Giang Hub</font>] Co-Owner Of Article Hub and Nihahaha Hub',
		Image = "rbxassetid://138779531145636"
	},
	["Nova Hoang"] = {
		Text = '[<font color="rgb(73, 230, 133)">Nova Hoang (Nguyễn Tn Hoàng)</font>] Owner Of Article Hub and Nihahaha Hub',
		Image = "rbxassetid://77933782593847",
	}
}

if CreditScript then
	for i, v in pairs(CreditScript) do
		CreditTab:AddLabel(CreditScript[i].Text, true)
		CreditTab:AddImage("Image "..i, {Image = CreditScript[i].Image, Height = 200})
	end
else
	CreditTab:AddLabel("[N/A]", true)
end

local CreditTab2 = Credit:AddRightGroupbox("Join Server")

local quest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local HttpService = game:GetService("HttpService")
local InviteCode = "aD7gjtvPmv"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"
local success, result = pcall(function()
    return HttpService:JSONDecode(quest({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "RobloxBot/1.0",
            ["Accept"] = "application/json"
        }
    }).Body)
end)

if success and result and result.guild then
	CreditTab2:AddLabel(result.guild.name, true)
	local InfoDiscord = CreditTab2:AddLabel('<font color="#52525b">•</font> Member Count : '..tostring(result.approximate_member_count)..'\n<font color="#16a34a">•</font> Online Count : ' .. tostring(result.approximate_presence_count), true)
	CreditTab2:AddImage("Image Discord", {Image = "rbxassetid://138779531145636", Height = 200})

	CreditTab2:AddButton("Update Info", function()
	    local updated, updatedResult = pcall(function()
            return HttpService:JSONDecode(quest({
                Url = DiscordAPI,
                Method = "GET",
            }).Body)
        end)            
        if updated and updatedResult and updatedResult.guild then
            InfoDiscord:SetText(
                '<font color="#52525b">•</font> Member Count : ' .. tostring(updatedResult.approximate_member_count) ..
                '\n<font color="#16a34a">•</font> Online Count : ' .. tostring(updatedResult.approximate_presence_count)
            )
        end
	end)

    CreditTab2:AddButton("Copy Discord Invite", function()
        setclipboard("https://discord.gg/"..InviteCode)
    end)
else
    CreditTab2:AddLabel("Error fetching Discord Info", true)
    CreditTab2:AddButton("Copy Discord Invite", function()
        setclipboard("https://discord.gg/"..InviteCode)
    end)
end

CreditTab2:AddButton("Copy Zalo", function()
    setclipboard("https://zalo.me/g/qlukiy407")
end)