local cloneref = (cloneref or clonereference or function(instance: any)
    return instance
end)

local quest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local InviteCode = "aD7gjtvPmv"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"
success, result = pcall(function()
    return HttpService:JSONDecode(quest({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "RobloxBot/1.0",
            ["Accept"] = "application/json"
        }
    }).Body)
end)

function UpdateDiscord()
	return HttpService:JSONDecode(quest({Url = DiscordAPI, Method = "GET"}).Body)
end

CreditScript = {
    ["Giang Hub"] = {
        Text = '[<font color="rgb(73, 230, 133)">Giang Hub</font>] Co-Owner Of Article Hub and Nihahaha Hub',
        Image = "rbxassetid://138779531145636"
    },
    ["Nova Hoang"] = {
        Text = '[<font color="rgb(73, 230, 133)">Nova Hoang (Nguyễn Tn Hoàng)</font>] Owner Of Article Hub and Nihahaha Hub',
        Image = "rbxassetid://77933782593847",
    }
}

if getgenv().CreditToUi == "Orion" then
local TabCredits = getgenv().WindowNah:MakeTab({Name = "Credit / Join", Icon = "rbxassetid://7733955511", PremiumOnly = false})
if CreditScript then
        for i, v in pairs(CreditScript) do
                TabCredits:AddLabel(CreditScript[i].Text)
                TabCredits:AddImage({Icon = CreditScript[i].Image, Size = 200})
        end
else
        TabCredits:AddLabel("[N/A]")
end
TabCredits:AddSection({Name = "Join Server"})

if success and result and result.guild then
    TabCredits:AddLabel(result.guild.name)
    local InfoDiscord = TabCredits:AddLabel('<font color="#52525b">•</font> Member Count : '..tostring(result.approximate_member_count)..'\n<font color="#16a34a">•</font> Online Count : ' .. tostring(result.approximate_presence_count))
    TabCredits:AddImage({Icon = "rbxassetid://138779531145636", Size = 200})
	TabCredits:AddButton({Name = "Update Info", Callback = function()
		local updated, updatedResult = pcall(UpdateDiscord())
        if updated and updatedResult and updatedResult.guild then
            InfoDiscord:Set(
                '<font color="#52525b">•</font> Member Count : ' .. tostring(updatedResult.approximate_member_count) ..
                '\n<font color="#16a34a">•</font> Online Count : ' .. tostring(updatedResult.approximate_presence_count)
            )
        end
	end})           

    TabCredits:AddButton({Name = "Copy Discord Invite", Callback = function()
        setclipboard("https://discord.gg/"..InviteCode)
    end})
else
    TabCredits:AddLabel("Error fetching Discord Info")
    TabCredits:AddButton({Name = "Copy Discord Invite", Callback = function()
        setclipboard("https://discord.gg/"..InviteCode)
    end})
end

TabCredits:AddButton({Name = "Copy Zalo Invite", Callback = function()
    setclipboard("https://zalo.me/g/qlukiy407")
end})
else
local Credit = getgenv().WindowNah:AddTab("Credit / Join", "rbxassetid://7733955511")
local CreditTab = Credit:AddLeftGroupbox("Credit")

if CreditScript then
        for i, v in pairs(CreditScript) do
                CreditTab:AddLabel(CreditScript[i].Text, true)
                CreditTab:AddImage("Image "..i, {Image = CreditScript[i].Image, Height = 200})
        end
else
        CreditTab:AddLabel("[N/A]", true)
end

local CreditTab2 = Credit:AddRightGroupbox("Join Server")

if success and result and result.guild then
    CreditTab2:AddLabel(result.guild.name, true)
    local InfoDiscord = CreditTab2:AddLabel('<font color="#52525b">•</font> Member Count : '..tostring(result.approximate_member_count)..'\n<font color="#16a34a">•</font> Online Count : ' .. tostring(result.approximate_presence_count), true)
    CreditTab2:AddImage("Image Discord", {Image = "rbxassetid://138779531145636", Height = 200})

    CreditTab2:AddButton("Update Info", function()
        local updated, updatedResult = pcall(UpdateDiscord())
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
end