--[[
    Panda Development API   |   https://pandadevelopment.net/
    Luarmor API   |   https://luarmor.net/
]]

local cloneref = (cloneref or clonereference or function(instance: any)
    return instance
end)

local getgenv = getgenv or function()
    return shared
end

local Services = setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		else
			error("Invalid Service: "..tostring(name))
		end
	end
})

local HttpService = Services.HttpService
local Players = Services.Players
local frequest, fsetclipboard = request or http_request or syn_request, setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local ServiceKey = {}

function ServiceKey:Luarmor(scriptId, discord)
    local APIURL = "https://sdkapi-public.luarmor.net/library.lua"
    local API = loadstring(game.HttpGetAsync and game:HttpGetAsync(APIURL) or HttpService:GetAsync(APIURL))()
    API.script_id = scriptId
    
    function ValidateKey(key)
        local status = API.check_key(key);
        if (status.code == "KEY_VALID") then
            return true, "Whitelisted!"
        elseif (status.code == "KEY_HWID_LOCKED") then
            return false, "Key linked to a different HWID. Please reset it using our bot"
        elseif (status.code == "KEY_INCORRECT") then
            return false, "Key is wrong or deleted!"
        else
            return false, "Key check failed:" .. status.message .. " Code: " .. status.code
        end
    end
    
    function CopyLink()
        fsetclipboard(tostring(discord))
    end
    
    return {
        Verify = ValidateKey,
        Copy = CopyLink
    }
end

function ServiceKey:PandaDevelopment(serviceId)
	local hwid = gethwid or function()
		return Players.LocalPlayer.UserId
	end
	
	function ValidateKey(key)
		local validationUrl = "https://new.pandadevelopment.net/api/v1/keys/validate"
		local payload = {
			ServiceID = serviceId,
			HWID = tostring(hwid()),
			Key = tostring(key),
		}

		local jsonData = HttpService:JSONEncode(payload)
		local success, response = pcall(function()
			return frequest({
				Url = validationUrl,
				Method = "POST",
				Headers = {
					["User-Agent"] = "Roblox/Exploit",
					["Content-Type"] = "application/json",
				},
				Body = jsonData,
			})
		end)

		if success and response then
			if response.Success then
				local decodeSuccess, jsonData = pcall(function()
					return HttpService:JSONDecode(response.Body)
				end)

				if decodeSuccess and jsonData then
					if jsonData.Authenticated_Status and jsonData.Authenticated_Status == "Success" then
						return true, "Authenticated"
					else
						local reason = jsonData.Note or "Unknown reason"
						return false, "Authentication failed: " .. reason
					end
				else
					return false, "JSON decode error"
				end
			else
				warn("HTTP request was not successful. Code: " .. tostring(response.StatusCode) .. " Message: " .. response.StatusMessage)
				return false, "HTTP request failed: " .. response.StatusMessage
			end
		else
			return false, "Request pcall error"
		end
	end

	function GetKeyLink()
		return "https://new.pandadevelopment.net/getkey/" .. tostring(serviceId) .. "?hwid=" .. tostring(hwid())
	end

	function CopyLink()
		return fsetclipboard(GetKeyLink())
	end

	return {
		Verify = ValidateKey,
		Copy = CopyLink,
	}
end

return ServiceKey
