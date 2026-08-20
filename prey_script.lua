-- Cloud sync configuration (change `CLOUD_URL` to your server API)
getgenv().script_key = getgenv().script_key or 'XxcVYIWfftLoPaiJPGzsXMIBtfZdZhua'
local CLOUD_URL = "https://prey.wtf"; local HttpService = game:GetService("HttpService")
local function http_post(url, bodyTable)
    local ok, encoded = pcall(function() return HttpService:JSONEncode(bodyTable) end)
    if not ok then return false, "encode_failed" end
    if syn and syn.request then
        local ok2, res = pcall(function() return syn.request({Url = url, Method = "POST", Body = encoded, Headers = {["Content-Type"] = "application/json"}, Timeout = 3}) end)
        if ok2 and res and (res.StatusCode == 200 or res.StatusCode == 201) then return true, res.Body end
        return false, res
    end
    if request then
        local ok2, res = pcall(function() return request({Url = url, Method = "POST", Body = encoded, Headers = {["Content-Type"] = "application/json"}, Timeout = 3}) end)
        if ok2 and res and (res.StatusCode == 200 or res.StatusCode == 201) then return true, res.Body end
        return false, res
    end
    if pcall(function() return game.HttpPost end) then
        local ok2, res = pcall(function() return game:HttpPost(url, encoded, true) end)
        if ok2 then return true, res end
        return false, res
    end
    return false, "no_post_available"
end
-- Robust GET that works across executors (syn.request / request / game:HttpGet)
local function http_get(url)
    if request then
        local ok, res = pcall(function() return request({Url = url, Method = "GET", Timeout = 3}) end)
        if ok and res and (res.StatusCode == 200 or res.StatusCode == 201) then return true, res.Body end
    end
    if syn and syn.request then
        local ok, res = pcall(function() return syn.request({Url = url, Method = "GET", Timeout = 3}) end)
        if ok and res and (res.StatusCode == 200 or res.StatusCode == 201) then return true, res.Body end
    end
    local ok, body = pcall(function() return game:HttpGet(url, true) end)
    if ok and body then return true, body end
    return false, "no_get_available"
end
-- ==============================================================================
-- PREY AUTHORITY PROTOCOL (VIP CROWN & IMMUNITY SYSTEM)
-- Fully configurable via cloud config: getgenv().Prey['Authority']
-- ==============================================================================
getgenv().Prey = {
    ['Main'] = {
        ['Keybind'] = {
            ['Aim Assist']       = 'C', ['Triggerbot']       = 'C', ['Esp']              = 'P', ['Select']           = 'C', ['Speed']            = 'V', ['Panic Ground']     = 'X',
            ['Inventory Sorter'] = 'E', ['Auto Armor']       = 'B', },
        ['Target'] = { ['Mode'] = 'Target', ['Unlock'] = { ['Knocked'] = true, ['Grabbed'] = true, ['Through Walls'] = true, ['Vehicle'] = true, },
        },
        ['Allowed'] = {
            ['Combat'] = {
                ['Silent Aim'] = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
                ['Aim Assist'] = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
                ['Triggerbot'] = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
            },
            ['Gun'] = {
                ['Hitbox Expander']  = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
                ['Damage Overrider'] = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
                ['Spread']           = {'[Double-Barrel SG]', '[Revolver]', '[TacticalShotgun]'},
            }, }, },
    ['Future'] = {
        ['Enabled'] = true, ['Lure'] = true, ['Enable Both'] = false,
        ['[Silent Aim]'] = {
            ['Future'] = {
                ['Enabled'] = true, ['Lure'] = true,
                ['Pistols']  = { ['Values'] = { ['X'] = 0.2, ['Y'] = 0.2, ['Z'] = 0.2 } },
                ['Shotguns'] = { ['Values'] = { ['X'] = 0.002904223, ['Y'] = 0.0072502123, ['Z'] = 0.0072502123 } },
                ['Others']   = { ['Values'] = { ['X'] = 0.013, ['Y'] = 0.013, ['Z'] = 0.013 } },
            }
        },
        ['[Triggerbot]'] = {
            ['Distance'] = 200,
            ['Future'] = {
                ['Enabled'] = false, ['Lure'] = true,
                ['Pistols']  = { ['Values'] = { ['X'] = 0.22, ['Y'] = 0.22, ['Z'] = 0.22 } },
                ['Shotguns'] = { ['Values'] = { ['X'] = 0.018, ['Y'] = 0.018, ['Z'] = 0.018 } },
                ['Others']   = { ['Values'] = { ['X'] = 0.013, ['Y'] = 0.013, ['Z'] = 0.013 } },
            }
        }, },
    ['Combat'] = { ['Silent Aim'] = { ['Enabled'] = true, ['Hit Chance'] = 100, ['HitPart'] = 'ClosestPart', ['Closest Point Scale'] = { ['Enabled'] = true, ['Scale'] = 0.15, },
            ['Prediction'] = { ['Enabled'] = true, ['X'] = 0, ['Y'] = 0, },
            ['Weapon Configuration'] = { ['[Double-Barrel SG]'] = false, ['[Revolver]'] = true, ['[TacticalShotgun]'] = false, },
        },
        ['Aim Assist'] = { ['Enabled'] = true, ['Smoothness'] = 1, ['Mode'] = 'Toggle', ['Shake'] = { ['Enabled'] = false, ['Amount'] = 1, },
        }, ['HitPart'] = 'Head',
        ['Closest Point'] = { ['Mode'] = 'Regular', ['Scale'] = 0.35, },
        ['Easing Style'] = { ['Style'] = 'Quadratic', ['Direction'] = 'InOut', },
        ['Triggerbot'] = { ['Enabled'] = true, ['Use Crosshair'] = false, ['Distance'] = 'Auto', ['Functionality Type'] = { ['Mode'] = 'Keybind', ['Type'] = 'Toggle', },
            ['Hit Part'] = { ['Enabled'] = true, ['Part'] = 'Head', },
            ['Prediction'] = { ['X'] = 0.02, ['Y'] = 0.02, ['Z'] = 0.02, },
            ['Shot Accuracy'] = { ['Enabled'] = true, ['Mode'] = 'Chance', ['Chance'] = 100, },
        },
        ['Distance Check'] = {
            ['Enabled'] = true, ['Universal'] = true, ['Max Distance'] = 200,
            ['Guns'] = { ['[Double-Barrel SG]'] = 300, ['[Revolver]'] = 200, ['[TacticalShotgun]'] = 300, },
        },
        ['Universal Ammo Conservation'] = { ['Enabled'] = true, },
    },
    ['Spread Modifications'] = {
        ['Enabled'] = true, ['Mode'] = 'Normal',
        ['Double-Barrel SG'] = {
            ['Normal'] = 0,
            ['Randomizer'] = {0, 0}
        },
        ['TacticalShotgun'] = {
            ['Normal'] = 20,
            ['Randomizer'] = {40, 50}
        },
        ['Shotgun'] = {
            ['Normal'] = 20,
            ['Randomizer'] = {30, 50}
        }
    },
    ['Tools'] = { ['Mods'] = { ['Hitbox Expander'] = { ['Enabled'] = false, ['X'] = 33, ['Y'] = 33, ['Z'] = 33, },
            ['Delay Changer'] = { ['Enabled'] = true,  ['Weapon Configs'] = { ['Enabled'] = true, ['TacticalShotgun'] = { ['Delay'] = 0, },
                    ['Revolver'] = { ['Delay'] = 0, },
                    ['Double-Barrel SG'] = { ['Delay'] = 60, },
                }, },
            ['Damage Overrider'] = { ['Enabled'] = true, ['Type'] = 'Full', ['Chance'] = 100, ['Weapons'] = { ['Shotguns'] = { ['Enabled'] = true, ['Mode'] = 'Full', },
                    ['Pistols'] = { ['Enabled'] = true, ['Mode'] = 'Full', },
                    ['Others'] = { ['Enabled'] = true, ['Mode'] = 'Full', },
                }, }, },
        ['Skin Changer'] = {
            ['enabled'] = true,
            ['Skins'] = { ['[Double-Barrel SG]'] = 'Galaxy', ['[Revolver]'] = 'Golden Age', ['[TacticalShotgun]'] = 'Galaxy', ['[Knife]'] = 'Golden Age Tanto', },
        },
        ['Hood Customs'] = {
            ['skins'] = {
                ['enabled'] = false,
                ['weapons'] = {
                    ['[DoubleBarrel]'] = 'Ascension', ['Revolver'] = 'Lovestruck', ['[Shotgun]'] = 'Black Ice', ['[TacticalShotgun]'] = 'Lovestruck', ['[Knife]_HC'] = 'Beta', }, },
            ['Bullet Beams'] = { ['mode'] = 'Skin', ['DoubleBarrel'] = 'Beta', ['Revolver'] = 'Beta', ['TacticalShotgun'] = 'Beta', ['Silencer'] = 'Beta', },
        }, },
    ['FOV'] = {
        ['Silent'] = {
            ['Options'] = '2D',
            ['Width'] = {555, 555},
            ['Height'] = {555, 555},
            ['3D'] = { ['Width'] = 11, ['Height'] = 11, ['Depth'] = 11 },
            ['Visualize'] = { ['Enabled'] = false, ['Color'] = Color3.fromRGB(255, 255, 255) },
        },
        ['Aimbot'] = {
            ['Options'] = '2D',
            ['Width'] = {555, 555},
            ['Height'] = {555, 555},
            ['3D'] = { ['Width'] = 61, ['Height'] = 61, ['Depth'] = 61 },
            ['Visualize'] = { ['Enabled'] = false, ['Color'] = Color3.fromRGB(255, 255, 255) },
        },
        ['Triggerbot'] = {
            ['Options'] = '2D',
            ['Width'] = {555, 555},
            ['Height'] = {555, 55},
            ['3D'] = { ['Width'] = 116, ['Height'] = 116, ['Depth'] = 116 },
            ['Visualize'] = { ['Enabled'] = true, ['Color'] = Color3.fromRGB(255, 255, 255) },
        }, },
    ['Visuals'] = {
        ['Esp'] = {
            ['Enabled'] = true,
            ['Name'] = {
                ['Enabled'] = true, ['Color'] = Color3.fromRGB(255, 255, 255), ['Target Color'] = Color3.fromRGB(144, 238, 144), ['Position'] = 'Bottom', ['Font'] = 'Legacy',
                ['Size'] = 8, },
            ['Box'] = { ['Enabled'] = false, ['Color'] = Color3.fromRGB(255, 255, 255), ['Target Color'] = Color3.fromRGB(255, 0, 0), ['Transparency'] = 1, ['Thickness'] = 1, },
            ['Health'] = { ['Enabled'] = true, ['Mode'] = 'Selected', ['Position'] = 'Bottom', ['Color'] = Color3.fromRGB(144, 238, 144), },
            ['Armor'] = { ['Enabled'] = true, ['Mode'] = 'Selected', ['Position'] = 'Bottom', ['Color'] = Color3.fromRGB(120, 249, 255), },
        }, },
    ['Animation'] = {
        ['Enabled'] = true, ['Mode'] = 'HybridCustom', ['ChosenBundleName'] = 'HybridCustom',
        ['HybridSettings'] = {
            ['run']      = "Zombie", ['walk']     = "Zombie", ['jump']     = "Ninja", ['idle1']    = "Zombie", ['idle2']    = "Zombie", ['fall']     = "Mage",
            ['climb']    = "Default", ['swim']     = "Pirate",
            ['swimidle'] = "Pirate"
        }, },
    ['Panic Ground'] = { ['Enabled'] = true, ['Key'] = 'X', ['Mode'] = 'Instant', ['Smooth Speed'] = 400, ['Preserve Velocity'] = true, },
    ['AntiGravity'] = { ['Enabled'] = true, ['Key'] = 'T', ['Float Speed'] = 311, },
    ['Spiderman'] = {
        ['Enabled'] = true, ['Wall Distance'] = 1, ['Cooldown'] = 0, ['Jump Power'] = 333, ['Knife Jump Power'] = 333, ['Require Double Jump'] = true, },
    ['Inventory Sorter'] = { ['Enabled'] = true, ['Order'] = { '[Revolver]', '[Double-Barrel SG]', '[TacticalShotgun]', '[Knife]' }, },
    ['Speed Modifications'] = { ['Enabled'] = true, ['Speeds'] = { ['Shooting'] = 1111, ['Low health'] = 1111, ['Knife'] = 1111, ['Reloading'] = 1111, ['Normal'] = 1111, },
    },
    ['Watermark'] = {
        ['Enabled'] = true,
        ['Glow Theme'] = { ['Gradient'] = false, ['Color 1'] = Color3.fromRGB(255, 250, 255), ['Color 2'] = Color3.fromRGB(70, 70, 70), ['Shift Speed'] = 3.5, },
        ['Positioning'] = { ['Preset'] = 'Top', ['Text Size'] = 15, ['X'] = 0.5, ['Y'] = 0.9, },
    },
    ['Global'] = {
        ['Mod Detector'] = {
            ['Enabled'] = true, ['Action'] = "Kick", ['Group Id'] = 17215700, ['Role'] = nil, ['Notify Duration'] = 6, ['Kick Message'] = "A moderator has joined the game!", }, },
    ['Auto Armor'] = { ['Enabled'] = true, ['Key'] = 'B', },
    ['Noclip'] = { ['Enabled'] = true, ['Key'] = 'N', },
    ['No Jump Cooldown'] = { ['Enabled'] = true, },
    ['Anti Trip'] = { ['Enabled'] = true, },
    ['Char'] = { ['Active'] = true, ['TargetUser'] = 'rustontweath', ['Sizing'] = { ['Enabled'] = true, ['Profile'] = 'Skinny', },
        ['Cosmetics'] = { ['Enabled'] = true, ['Headless'] = true, ['Korblox'] = true, ['Remove Accessories'] = true, },
    },
}
if not getgenv().Prey['Authority'] then
    getgenv().Prey['Authority'] = {
        Enabled = true, IsCrownUser = false, AllowOtherUsersToHarmMe = false, ShowPreyUserBadges = true, BadgeText = "🦅 [Prey User]", CrownText = "👑 [Prey VIP]",
    }
end
getgenv().PreyAuthorityProtocol = getgenv().Prey['Authority']
-- Owner Whitelist Definition
local ownerWhitelist = { ["x1439721"] = true, ["zestf_ll"] = true, }
local function isOwnerUser(plr)
    if not plr then return false end
    return ownerWhitelist[string.lower(plr.Name)] == true
end
-- Inter-client FE Replicated Presence Tracker
local PREY_SIG_ANIM_ID = "rbxassetid://92080889861410"
local knownPreyUsers = {}
-- Shared workspace network container for inter-client presence
local function getPreyClientsFolder()
    local folder = workspace:FindFirstChild("Prey_Active_Clients")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "Prey_Active_Clients"
        folder.Parent = workspace
    end
    return folder
end
local function getPreyClientStatus(plr)
    if not plr then return nil, false end
    local isOwner = isOwnerUser(plr)
    -- 1. Whitelisted owners are ALWAYS Crown
    if isOwner then return "Crown", true end
    -- 2. LocalPlayer running the script is always active User on own client
    local lp = game:GetService("Players").LocalPlayer
    if plr == lp then return "User", true end
    -- 3. Check known registered Prey users map (pings from FE scan)
    if knownPreyUsers[plr.UserId] or knownPreyUsers[tostring(plr.UserId)] or knownPreyUsers[string.lower(plr.Name)] then return "User", true end
    -- 4. Check FE Replicated Signature Animation Track on Player's Character Animator
    local char = plr.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    if track.Animation and (track.Animation.AnimationId == PREY_SIG_ANIM_ID or track.Animation.AnimationId:find("92080889861410")) then
                        knownPreyUsers[plr.UserId] = true
                        return "User", true
                    end
                end
            end
        end
        if char:FindFirstChild("PreyClientMarker", true) or char:GetAttribute("PreyClientActive") == true then
            knownPreyUsers[plr.UserId] = true
            return "User", true
        end
        local head = char:FindFirstChild("Head")
        if head and (head:FindFirstChild("PreyClientMarker") or head:GetAttribute("PreyClientActive") == true) then
            knownPreyUsers[plr.UserId] = true
            return "User", true
        end
    end
    -- 5. Check workspace shared folder
    local folder = workspace:FindFirstChild("Prey_Active_Clients")
    if folder then
        local val = folder:FindFirstChild(tostring(plr.UserId)) or folder:FindFirstChild(plr.Name)
        if val then
            knownPreyUsers[plr.UserId] = true
            return "User", true
        end
    end
    -- 6. Check Player Instance markers & attributes
    if plr:FindFirstChild("PreyActiveClient") or plr:GetAttribute("PreyClientActive") == true or plr:GetAttribute("PreyActive") == true then
        knownPreyUsers[plr.UserId] = true
        return "User", true
    end
    return nil, false
end
-- Clean protection validator (Returns true if target is a whitelisted Owner with a Crown)
function IsPlayerProtected(plr)
    if not plr or plr == game:GetService("Players").LocalPlayer then return false end
    local proto = getgenv().Prey['Authority'] or getgenv().PreyAuthorityProtocol
    if not proto or not proto.Enabled then return false end
    local status, isActive = getPreyClientStatus(plr)
    if isActive and status == "Crown" then return true end
    return false
end
-- Network Presence Sync Loop & Instant Full-Server Scan
task.spawn(function()
    local Players = game:GetService("Players")
    local function broadcastLocalPresence()
        local proto = getgenv().Prey['Authority'] or getgenv().PreyAuthorityProtocol; local lp = Players.LocalPlayer
        if not lp then return end
        local isOwner = isOwnerUser(lp); local statusVal = isOwner and "Crown" or "User"
        if proto and proto.Enabled then
            -- A. Play FE Replicated Signature Animation Track (replicates across FE to all clients)
            if lp.Character then
                local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 2)
                    if animator then
                        local isAlreadyPlaying = false
                        for _, trk in ipairs(animator:GetPlayingAnimationTracks()) do
                            if trk.Animation and trk.Animation.AnimationId == PREY_SIG_ANIM_ID then
                                isAlreadyPlaying = true
                                break
                            end
                        end
                        if not isAlreadyPlaying then
                            pcall(function()
                                local anim = Instance.new("Animation")
                                anim.Name = "PreyClientMarker"
                                anim.AnimationId = PREY_SIG_ANIM_ID
                                local trk = animator:LoadAnimation(anim)
                                trk.Priority = Enum.AnimationPriority.Core
                                trk:Play(0, 0.001, 0)
                            end)
                        end
                    end
                end
            end
            -- B. Tag Player object & attributes
            local pMarker = lp:FindFirstChild("PreyActiveClient")
            if not pMarker then
                pMarker = Instance.new("StringValue")
                pMarker.Name = "PreyActiveClient"
                pMarker.Value = statusVal
                pMarker.Parent = lp
            end
            lp:SetAttribute("PreyActive", true)
            lp:SetAttribute("PreyClientActive", true)
            lp:SetAttribute("PreyClientIsCrown", isOwner)
            -- C. Register in Workspace Shared Folder
            local folder = getPreyClientsFolder(); local myVal = folder:FindFirstChild(tostring(lp.UserId))
            if not myVal then
                myVal = Instance.new("StringValue")
                myVal.Name = tostring(lp.UserId)
                myVal.Parent = folder
            end
            myVal.Value = statusVal
            -- D. Tag Character & Head
            local char = lp.Character
            if char then
                char:SetAttribute("PreyActive", true)
                char:SetAttribute("PreyClientActive", true)
                local head = char:FindFirstChild("Head")
                if head then
                    head:SetAttribute("PreyActive", true)
                    head:SetAttribute("PreyClientActive", true)
                    if not head:FindFirstChild("PreyClientMarker") then
                        local hMarker = Instance.new("StringValue")
                        hMarker.Name = "PreyClientMarker"
                        hMarker.Value = statusVal
                        hMarker.Parent = head
                    end
                end
            end
            -- E. Scan all players in server to update presence & trigger notifications
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lp then
                    local status, isActive = getPreyClientStatus(plr)
                    if isActive and isOwner then
                        if not knownPreyUsers[plr.UserId] then
                            knownPreyUsers[plr.UserId] = true
                            local label = plr.DisplayName .. " (@" .. plr.Name .. ")"
                            warn("[Prey] Scan detected active Prey user: " .. label)
                            pcall(function()
                                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Prey User Detector", Text = "Prey user active: " .. label, Duration = 5, })
                            end)
                        end
                    end
                end
            end
        end
    end
    pcall(broadcastLocalPresence)
    while task.wait(0.3) do
        pcall(broadcastLocalPresence)
    end
end)
-- ==============================================================================
-- UNDETECTED OWNER TELEPORT PROTOCOL (/tp)
-- Allows Whitelisted Crown Owners to bring all standard Prey users safely & undetected
-- ==============================================================================
local function executeUndetectedTeleport(targetPosition)
    local lp = game:GetService("Players").LocalPlayer
    if not lp or not lp.Character then return end
    local hrp = lp.Character:FindFirstChild("HumanoidRootPart"); local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    -- Calculate random circular offset so teleported users don't collide or stack inside each other
    local angle = math.random() * math.pi * 2
    local offsetDist = math.random(3, 7); local rawLandingPos = targetPosition + Vector3.new(math.cos(angle) * offsetDist, 0, math.sin(angle) * offsetDist)
    -- Raycast down to find ground level safely
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {lp.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local rayRes = workspace:Raycast(rawLandingPos + Vector3.new(0, 10, 0), Vector3.new(0, -35, 0), rayParams)
    local finalPos = rayRes and (rayRes.Position + Vector3.new(0, 3.5, 0)) or rawLandingPos
    local _, yRot = hrp.CFrame:ToEulerAnglesYXZ(); local targetCF = CFrame.new(finalPos) * CFrame.Angles(0, yRot, 0)
    -- UNDETECTED TELEPORT ALGORITHM:
    -- 1. Dampen velocity to prevent fall/speed checks
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
    -- 2. Fast smooth micro-tween (0.18s) passes physics & server position threshold anti-cheat checks
    local TweenService = game:GetService("TweenService")
    local tpTween = TweenService:Create(hrp, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { CFrame = targetCF })
    tpTween:Play()
    tpTween.Completed:Wait()
    -- 3. Final velocity zeroing post-arrival
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end
local function createRealisticToilet(parentFolder, cframe)
    local model = Instance.new("Model")
    model.Name = "RealisticToilet"
    model.Parent = parentFolder
    -- Base Pedestal
    local base = Instance.new("Part")
    base.Name = "ToiletBase"
    base.Size = Vector3.new(2.4, 1.8, 3.2)
    base.Color = Color3.fromRGB(245, 245, 250)
    base.Material = Enum.Material.SmoothPlastic
    base.Anchored = true
    base.CanCollide = true
    base.CFrame = cframe * CFrame.new(0, 0.9, 0)
    base.Parent = model
    -- Toilet Bowl Rim
    local bowl = Instance.new("Part")
    bowl.Name = "ToiletBowl"
    bowl.Size = Vector3.new(2.8, 0.8, 3.6)
    bowl.Color = Color3.fromRGB(255, 255, 255)
    bowl.Material = Enum.Material.SmoothPlastic
    bowl.Anchored = true
    bowl.CanCollide = true
    bowl.CFrame = cframe * CFrame.new(0, 2.0, -0.2)
    bowl.Parent = model
    -- Water Surface inside bowl
    local water = Instance.new("Part")
    water.Name = "ToiletWater"
    water.Size = Vector3.new(2.2, 0.1, 2.6)
    water.Color = Color3.fromRGB(80, 170, 220)
    water.Transparency = 0.35
    water.Material = Enum.Material.Glass
    water.Anchored = true
    water.CanCollide = false
    water.CFrame = cframe * CFrame.new(0, 2.1, -0.2)
    water.Parent = model
    -- Toilet Tank (Back)
    local tank = Instance.new("Part")
    tank.Name = "ToiletTank"
    tank.Size = Vector3.new(2.8, 3.2, 1.4)
    tank.Color = Color3.fromRGB(245, 245, 250)
    tank.Material = Enum.Material.SmoothPlastic
    tank.Anchored = true
    tank.CanCollide = true
    tank.CFrame = cframe * CFrame.new(0, 3.8, 1.2)
    tank.Parent = model
    -- Tank Lid
    local lid = Instance.new("Part")
    lid.Name = "ToiletLid"
    lid.Size = Vector3.new(3.0, 0.4, 1.6)
    lid.Color = Color3.fromRGB(250, 250, 255)
    lid.Material = Enum.Material.SmoothPlastic
    lid.Anchored = true
    lid.CanCollide = true
    lid.CFrame = cframe * CFrame.new(0, 5.5, 1.2)
    lid.Parent = model
    -- Flush Handle
    local handle = Instance.new("Part")
    handle.Name = "FlushHandle"
    handle.Size = Vector3.new(0.3, 0.6, 0.8)
    handle.Color = Color3.fromRGB(200, 200, 200)
    handle.Material = Enum.Material.Metal
    handle.Anchored = true
    handle.CanCollide = false
    handle.CFrame = cframe * CFrame.new(-1.55, 4.8, 1.2)
    handle.Parent = model
    -- Black Toilet Seat Ring
    local seat = Instance.new("Part")
    seat.Name = "SeatRing"
    seat.Size = Vector3.new(2.9, 0.3, 3.5)
    seat.Color = Color3.fromRGB(30, 30, 30)
    seat.Material = Enum.Material.SmoothPlastic
    seat.Anchored = true
    seat.CanCollide = true
    seat.CFrame = cframe * CFrame.new(0, 2.45, -0.2)
    seat.Parent = model
    return model
end
local function executePoopSequence(targetPlayer)
    local lp = game:GetService("Players").LocalPlayer; local targetPlr = targetPlayer or lp
    if not targetPlr or not targetPlr.Character then return end
    local char = targetPlr.Character; local hrp = char:FindFirstChild("HumanoidRootPart"); local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    -- Folder created directly in workspace so EVERY client sees it in real-time
    local folderName = "Prey_Poop_Tower_" .. targetPlr.Name; local oldFolder = workspace:FindFirstChild(folderName)
    if oldFolder then oldFolder:Destroy() end
    local folder = Instance.new("Folder")
    folder.Name = folderName
    folder.Parent = workspace
    -- Play Toilet Sitting animation on target character
    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 2); local animTrack = nil
    if animator then
        pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://4417977954"
            animTrack = animator:LoadAnimation(anim)
            animTrack.Priority = Enum.AnimationPriority.Action
            animTrack:Play(0.1, 1, 1)
        end)
    end
    -- Construct Realistic 3D Toilet beneath the player
    local spawnCF = CFrame.new(hrp.Position - Vector3.new(0, 2.4, 0))
    createRealisticToilet(folder, spawnCF)
    -- Anchor target HRP during animation stack to prevent falling off tower
    if targetPlr == lp then hrp.Anchored = true end
    -- Spawn 35 CONSECUTIVE BIGGER & THICKER POOPS stacking MUCH higher into the sky
    local baseCF = spawnCF * CFrame.new(0, 2.45, -0.2)
    for i = 1, 35 do
        if not char or not humanoid or humanoid.Health <= 0 then break end
        -- Thicker & bigger poop parts
        local poop = Instance.new("Part")
        poop.Name = "PoopSegment_" .. i
        local width = 3.2 + (i * 0.08); local height = 1.6 + (i * 0.05)
        poop.Size = Vector3.new(width, height, width)
        poop.Shape = Enum.PartType.Ball
        poop.Color = Color3.fromRGB(85 + math.random(-15, 10), 42 + math.random(-10, 8), 12)
        poop.Material = Enum.Material.Pebble
        poop.Anchored = true
        poop.CanCollide = true
        -- High vertical stack offset: ascends up to 45+ studs into the air!
        local heightOffset = 0.6 + (i * 1.35); local rotOffset = CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(i * 42), math.rad(math.random(-5, 5)))
        poop.CFrame = baseCF * CFrame.new(0, heightOffset, 0) * rotOffset
        poop.Parent = folder
        -- Elevate character on top of growing poop tower
        hrp.CFrame = baseCF * CFrame.new(0, heightOffset + 3.0, 0)
        -- Fart & Splat sound effects per poop
        pcall(function()
            local snd = Instance.new("Sound")
            snd.SoundId = "rbxassetid://9114223179"
            snd.Volume = 0.85
            snd.Pitch = 0.9 + (i * 0.015)
            snd.Parent = poop
            snd:Play()
            game:GetService("Debris"):AddItem(snd, 2.0)
        end)
        task.wait(0.12)
    end
    task.wait(0.3)
    -- Unanchor LocalPlayer HRP right before explosion
    if targetPlr == lp then hrp.Anchored = false end
    -- Final Huge Explosion & Respawn when all 35 poops finish stacking!
    if hrp and char then
        local exp = Instance.new("Explosion")
        exp.Position = hrp.Position
        exp.BlastRadius = 25
        exp.BlastPressure = 1000000
        exp.DestroyJointRadiusPercent = 1
        exp.Parent = workspace
        if targetPlr == lp then
            pcall(function()
                if animTrack then animTrack:Stop() end
                char:BreakJoints()
                humanoid.Health = 0
            end)
        end
    end
    task.delay(1.5, function() folder:Destroy() end)
end
local function createClownNPC(parentFolder, holdKnife)
    local clown = Instance.new("Model")
    clown.Name = "ClownKidnapper"
    clown.Parent = parentFolder
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp.CanCollide = false
    hrp.Anchored = true
    hrp.Parent = clown
    -- Split Color Polka-Dot Clown Torso
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Color = Color3.fromRGB(235, 45, 45)
    torso.Material = Enum.Material.SmoothPlastic
    torso.Anchored = true
    torso.Parent = clown
    -- White Clown Face Painted Head
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.2, 1.2, 1.2)
    head.Shape = Enum.PartType.Ball
    head.Color = Color3.fromRGB(255, 255, 255)
    head.Material = Enum.Material.SmoothPlastic
    head.Anchored = true
    head.Parent = clown
    -- Red Neon Ball Nose
    local nose = Instance.new("Part")
    nose.Name = "ClownNose"
    nose.Size = Vector3.new(0.45, 0.45, 0.45)
    nose.Shape = Enum.PartType.Ball
    nose.Color = Color3.fromRGB(255, 20, 20)
    nose.Material = Enum.Material.Neon
    nose.Anchored = true
    nose.Parent = clown
    -- Dual Fluffy Wig Pom-Poms (Left & Right Afro Bunches)
    local wigL = Instance.new("Part")
    wigL.Size = Vector3.new(1.0, 1.0, 1.0)
    wigL.Shape = Enum.PartType.Ball
    wigL.Color = Color3.fromRGB(255, 40, 180)
    wigL.Material = Enum.Material.Pebble
    wigL.Anchored = true
    wigL.Parent = clown
    local wigR = Instance.new("Part")
    wigR.Size = Vector3.new(1.0, 1.0, 1.0)
    wigR.Shape = Enum.PartType.Ball
    wigR.Color = Color3.fromRGB(0, 200, 255)
    wigR.Material = Enum.Material.Pebble
    wigR.Anchored = true
    wigR.Parent = clown
    -- Polka-Dot Neck Ruff Collar
    local neckRuff = Instance.new("Part")
    neckRuff.Size = Vector3.new(2.2, 0.25, 2.2)
    neckRuff.Color = Color3.fromRGB(255, 220, 30)
    neckRuff.Material = Enum.Material.SmoothPlastic
    neckRuff.Anchored = true
    neckRuff.Parent = clown
    -- Neon Suit Buttons (3 on chest)
    local buttons = {}
    for bIdx = 1, 3 do
        local btn = Instance.new("Part")
        btn.Size = Vector3.new(0.35, 0.35, 0.2)
        btn.Shape = Enum.PartType.Ball
        btn.Color = (bIdx == 1) and Color3.fromRGB(255, 220, 30) or ((bIdx == 2) and Color3.fromRGB(40, 220, 40) or Color3.fromRGB(40, 180, 255))
        btn.Material = Enum.Material.Neon
        btn.Anchored = true
        btn.Parent = clown
        table.insert(buttons, btn)
    end
    -- Realistic Limbs (Arms & Legs)
    local armL = Instance.new("Part")
    armL.Size = Vector3.new(1, 2, 1)
    armL.Color = Color3.fromRGB(245, 190, 40)
    armL.Material = Enum.Material.SmoothPlastic
    armL.Anchored = true
    armL.Parent = clown
    local armR = Instance.new("Part")
    armR.Size = Vector3.new(1, 2, 1)
    armR.Color = Color3.fromRGB(40, 140, 240)
    armR.Material = Enum.Material.SmoothPlastic
    armR.Anchored = true
    armR.Parent = clown
    local legL = Instance.new("Part")
    legL.Size = Vector3.new(1, 2, 1)
    legL.Color = Color3.fromRGB(245, 190, 40)
    legL.Material = Enum.Material.SmoothPlastic
    legL.Anchored = true
    legL.Parent = clown
    local legR = Instance.new("Part")
    legR.Size = Vector3.new(1, 2, 1)
    legR.Color = Color3.fromRGB(40, 140, 240)
    legR.Material = Enum.Material.SmoothPlastic
    legR.Anchored = true
    legR.Parent = clown
    -- Big Red Clown Shoes
    local shoeL = Instance.new("Part")
    shoeL.Size = Vector3.new(1.3, 0.7, 1.8)
    shoeL.Color = Color3.fromRGB(255, 20, 20)
    shoeL.Material = Enum.Material.SmoothPlastic
    shoeL.Anchored = true
    shoeL.Parent = clown
    local shoeR = Instance.new("Part")
    shoeR.Size = Vector3.new(1.3, 0.7, 1.8)
    shoeR.Color = Color3.fromRGB(255, 20, 20)
    shoeR.Material = Enum.Material.SmoothPlastic
    shoeR.Anchored = true
    shoeR.Parent = clown
    local knifeHandle, knifeBlade = nil, nil
    if holdKnife then
        knifeHandle = Instance.new("Part")
        knifeHandle.Size = Vector3.new(0.3, 0.8, 0.3)
        knifeHandle.Color = Color3.fromRGB(30, 30, 30)
        knifeHandle.Material = Enum.Material.SmoothPlastic
        knifeHandle.Anchored = true
        knifeHandle.Parent = clown
        knifeBlade = Instance.new("Part")
        knifeBlade.Size = Vector3.new(0.1, 1.4, 0.35)
        knifeBlade.Color = Color3.fromRGB(240, 240, 250)
        knifeBlade.Material = Enum.Material.Metal
        knifeBlade.Anchored = true
        knifeBlade.Parent = clown
    end
    local function updateClownCFrame(targetCF)
        hrp.CFrame = targetCF
        torso.CFrame = targetCF
        head.CFrame = targetCF * CFrame.new(0, 1.5, 0)
        nose.CFrame = head.CFrame * CFrame.new(0, 0, -0.65)
        wigL.CFrame = head.CFrame * CFrame.new(-0.7, 0.4, 0)
        wigR.CFrame = head.CFrame * CFrame.new(0.7, 0.4, 0)
        neckRuff.CFrame = targetCF * CFrame.new(0, 0.95, 0)
        for bIdx, btn in ipairs(buttons) do
            btn.CFrame = torso.CFrame * CFrame.new(0, 0.6 - (bIdx - 1) * 0.5, -0.52)
        end
        armL.CFrame = targetCF * CFrame.new(-1.5, 0, 0)
        armR.CFrame = targetCF * CFrame.new(1.5, 0, 0)
        legL.CFrame = targetCF * CFrame.new(-0.55, -2.0, 0)
        legR.CFrame = targetCF * CFrame.new(0.55, -2.0, 0)
        shoeL.CFrame = targetCF * CFrame.new(-0.55, -2.85, -0.3)
        shoeR.CFrame = targetCF * CFrame.new(0.55, -2.85, -0.3)
        if holdKnife and knifeHandle and knifeBlade then
            knifeHandle.CFrame = armR.CFrame * CFrame.new(0, -0.8, -0.4) * CFrame.Angles(math.rad(45), 0, 0)
            knifeBlade.CFrame = knifeHandle.CFrame * CFrame.new(0, 0.9, 0)
        end
    end
    return clown, updateClownCFrame
end
local function createDetailedClownVan(parentFolder)
    local van = Instance.new("Model")
    van.Name = "ClownVan"
    van.Parent = parentFolder
    -- Fully White Van Base & Chassis
    local vanBody = Instance.new("Part")
    vanBody.Name = "VanBody"
    vanBody.Size = Vector3.new(9, 0.6, 17)
    vanBody.Color = Color3.fromRGB(250, 250, 250)
    vanBody.Material = Enum.Material.SmoothPlastic
    vanBody.Anchored = true
    vanBody.CanCollide = true
    vanBody.Parent = van
    -- White Roof
    local vanRoof = Instance.new("Part")
    vanRoof.Name = "VanRoof"
    vanRoof.Size = Vector3.new(9, 0.5, 17)
    vanRoof.Color = Color3.fromRGB(250, 250, 250)
    vanRoof.Material = Enum.Material.SmoothPlastic
    vanRoof.Anchored = true
    vanRoof.CanCollide = true
    vanRoof.Parent = van
    -- Left & Right Side Walls
    local wallL = Instance.new("Part")
    wallL.Name = "WallL"
    wallL.Size = Vector3.new(0.4, 4.8, 17)
    wallL.Color = Color3.fromRGB(250, 250, 250)
    wallL.Material = Enum.Material.SmoothPlastic
    wallL.Anchored = true
    wallL.CanCollide = true
    wallL.Parent = van
    local wallR = Instance.new("Part")
    wallR.Name = "WallR"
    wallR.Size = Vector3.new(0.4, 4.8, 17)
    wallR.Color = Color3.fromRGB(250, 250, 250)
    wallR.Material = Enum.Material.SmoothPlastic
    wallR.Anchored = true
    wallR.CanCollide = true
    wallR.Parent = van
    -- Front Hood & Grille Nose (Encloses Front Engine)
    local frontHood = Instance.new("Part")
    frontHood.Name = "FrontHood"
    frontHood.Size = Vector3.new(8.8, 2.4, 4.5)
    frontHood.Color = Color3.fromRGB(250, 250, 250)
    frontHood.Material = Enum.Material.SmoothPlastic
    frontHood.Anchored = true
    frontHood.CanCollide = true
    frontHood.Parent = van
    local frontBumper = Instance.new("Part")
    frontBumper.Name = "FrontBumper"
    frontBumper.Size = Vector3.new(8.8, 1.4, 0.5)
    frontBumper.Color = Color3.fromRGB(20, 20, 20)
    frontBumper.Material = Enum.Material.SmoothPlastic
    frontBumper.Anchored = true
    frontBumper.Parent = van
    -- Back Enclosed Doors
    local backDoors = Instance.new("Part")
    backDoors.Name = "BackDoors"
    backDoors.Size = Vector3.new(8.8, 4.8, 0.4)
    backDoors.Color = Color3.fromRGB(250, 250, 250)
    backDoors.Material = Enum.Material.SmoothPlastic
    backDoors.Anchored = true
    backDoors.CanCollide = true
    backDoors.Parent = van
    -- Interior Dashboard & Steering Wheel
    local dashboard = Instance.new("Part")
    dashboard.Name = "Dashboard"
    dashboard.Size = Vector3.new(8.4, 1.2, 1.6)
    dashboard.Color = Color3.fromRGB(25, 25, 25)
    dashboard.Material = Enum.Material.SmoothPlastic
    dashboard.Anchored = true
    dashboard.Parent = van
    local steeringWheel = Instance.new("Part")
    steeringWheel.Name = "SteeringWheel"
    steeringWheel.Size = Vector3.new(1.4, 1.4, 0.2)
    steeringWheel.Shape = Enum.PartType.Cylinder
    steeringWheel.Color = Color3.fromRGB(15, 15, 15)
    steeringWheel.Material = Enum.Material.SmoothPlastic
    steeringWheel.Anchored = true
    steeringWheel.Parent = van
    -- Side Signs: "🍦 FREE ICE CREAM 🍦"
    local signGuiL = Instance.new("SurfaceGui")
    signGuiL.Face = Enum.NormalId.Left
    signGuiL.Parent = wallL
    local signTextL = Instance.new("TextLabel")
    signTextL.Size = UDim2.new(1, 0, 1, 0)
    signTextL.BackgroundTransparency = 1
    signTextL.Text = "🍦 FREE ICE CREAM 🍦"
    signTextL.TextColor3 = Color3.fromRGB(255, 40, 40)
    signTextL.TextScaled = true
    signTextL.Font = Enum.Font.FredokaOne
    signTextL.Parent = signGuiL
    local signGuiR = Instance.new("SurfaceGui")
    signGuiR.Face = Enum.NormalId.Right
    signGuiR.Parent = wallR
    local signTextR = Instance.new("TextLabel")
    signTextR.Size = UDim2.new(1, 0, 1, 0)
    signTextR.BackgroundTransparency = 1
    signTextR.Text = "🍦 FREE ICE CREAM 🍦"
    signTextR.TextColor3 = Color3.fromRGB(255, 40, 40)
    signTextR.TextScaled = true
    signTextR.Font = Enum.Font.FredokaOne
    signTextR.Parent = signGuiR
    -- Sleek Tinted Black Windshield
    local glass = Instance.new("Part")
    glass.Name = "Windshield"
    glass.Size = Vector3.new(8.4, 2.6, 0.3)
    glass.Color = Color3.fromRGB(15, 15, 15)
    glass.Transparency = 0.15
    glass.Material = Enum.Material.SmoothPlastic
    glass.Anchored = true
    glass.Parent = van
    -- Headlights
    local lightL = Instance.new("Part")
    lightL.Size = Vector3.new(1.2, 1.2, 0.3)
    lightL.Color = Color3.fromRGB(255, 255, 180)
    lightL.Material = Enum.Material.Neon
    lightL.Anchored = true
    lightL.Parent = van
    local lightR = Instance.new("Part")
    lightR.Size = Vector3.new(1.2, 1.2, 0.3)
    lightR.Color = Color3.fromRGB(255, 255, 180)
    lightR.Material = Enum.Material.Neon
    lightR.Anchored = true
    lightR.Parent = van
    -- Deep Black Wheels
    local wheels = {}
    for wIndex, wPos in ipairs({
        Vector3.new(-4.6, -1.8, 5.5), Vector3.new(4.6, -1.8, 5.5),
        Vector3.new(-4.6, -1.8, -5.5), Vector3.new(4.6, -1.8, -5.5)
    }) do
        local wheel = Instance.new("Part")
        wheel.Size = Vector3.new(1.6, 2.6, 2.6)
        wheel.Shape = Enum.PartType.Cylinder
        wheel.Color = Color3.fromRGB(15, 15, 15)
        wheel.Material = Enum.Material.Rubber
        wheel.Anchored = true
        wheel.Parent = van
        table.insert(wheels, {Part = wheel, Offset = wPos})
    end
    -- SEATS FACING DIRECTLY AT EACH OTHER ACROSS THE AISLE
    local seatVisualParts = {}
    local seatPositions = {
        CFrame.new(-2.2, 0.8, -4.5) * CFrame.Angles(0, 0, 0), CFrame.new(2.2, 0.8, -4.5) * CFrame.Angles(0, 0, 0), CFrame.new(-2.6, 0.8, -0.5) * CFrame.Angles(0, math.rad(90), 0),
        CFrame.new(2.6, 0.8, -0.5) * CFrame.Angles(0, math.rad(-90), 0), CFrame.new(-2.6, 0.8, 3.5) * CFrame.Angles(0, math.rad(90), 0),
        CFrame.new(2.6, 0.8, 3.5) * CFrame.Angles(0, math.rad(-90), 0),
    }
    for idx, sOffset in ipairs(seatPositions) do
        local seatCushion = Instance.new("Part")
        seatCushion.Name = "SeatCushion_" .. idx
        seatCushion.Size = Vector3.new(1.8, 0.6, 1.8)
        seatCushion.Color = (idx <= 2) and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(180, 40, 40)
        seatCushion.Material = Enum.Material.SmoothPlastic
        seatCushion.Anchored = true
        seatCushion.CanCollide = false
        seatCushion.Parent = van
        local backrest = Instance.new("Part")
        backrest.Name = "SeatBackrest_" .. idx
        backrest.Size = Vector3.new(1.8, 1.8, 0.3)
        backrest.Color = (idx <= 2) and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(160, 30, 30)
        backrest.Material = Enum.Material.SmoothPlastic
        backrest.Anchored = true
        backrest.CanCollide = false
        backrest.Parent = van
        table.insert(seatVisualParts, { Cushion = seatCushion, Backrest = backrest, Offset = sOffset })
    end
    -- Create 3 Clown NPCs dynamically linked to the Van model
    local clown1, updateClown1 = createClownNPC(parentFolder, false)
    local clown2, updateClown2 = createClownNPC(parentFolder, false); local clown3, updateClown3 = createClownNPC(parentFolder, true)
    local function updateVanCFrame(cf)
        vanBody.CFrame = cf
        vanRoof.CFrame = cf * CFrame.new(0, 4.8, 0)
        wallL.CFrame = cf * CFrame.new(-4.3, 2.4, 0)
        wallR.CFrame = cf * CFrame.new(4.3, 2.4, 0)
        frontHood.CFrame = cf * CFrame.new(0, 1.2, -6.8)
        frontBumper.CFrame = cf * CFrame.new(0, 0.7, -9.0)
        backDoors.CFrame = cf * CFrame.new(0, 2.4, 8.4)
        glass.CFrame = cf * CFrame.new(0, 3.4, -6.8)
        dashboard.CFrame = cf * CFrame.new(0, 1.8, -5.2)
        steeringWheel.CFrame = cf * CFrame.new(-2.2, 2.4, -4.6) * CFrame.Angles(math.rad(60), 0, 0)
        lightL.CFrame = cf * CFrame.new(-3.0, 0.8, -9.1)
        lightR.CFrame = cf * CFrame.new(3.0, 0.8, -9.1)
        for _, wData in ipairs(wheels) do
            wData.Part.CFrame = cf * CFrame.new(wData.Offset) * CFrame.Angles(0, 0, math.rad(90))
        end
        for _, sData in ipairs(seatVisualParts) do
            sData.Cushion.CFrame = cf * sData.Offset
            sData.Backrest.CFrame = cf * sData.Offset * CFrame.new(0, 1.0, 0.8)
        end
        -- Dynamically update all 3 Clown NPCs with the van's movement
        updateClown1(cf * CFrame.new(-2.2, 2.8, -4.5))
        updateClown2(cf * CFrame.new(2.2, 2.8, -4.5))
        updateClown3(cf * CFrame.new(0, 2.8, 6.2))
    end
    return van, vanBody, updateVanCFrame, seatPositions
end
local function executeClownVanGroupSequence(targetGroup, vanIndex)
    if not targetGroup or #targetGroup == 0 then return end
    local lp = game:GetService("Players").LocalPlayer; local idxOffset = (vanIndex or 1) - 1
    -- Filter targets with valid characters
    local validTargets = {}
    for _, plr in ipairs(targetGroup) do
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then table.insert(validTargets, plr) end
        end
    end
    if #validTargets == 0 then return end
    local primaryPos = validTargets[1].Character.HumanoidRootPart.Position; local folderName = "Prey_Clown_Van_Group_" .. tostring(vanIndex) .. "_" .. tostring(tick())
    local oldFolder = workspace:FindFirstChild(folderName)
    if oldFolder then oldFolder:Destroy() end
    local folder = Instance.new("Folder")
    folder.Name = folderName
    folder.Parent = workspace
    local van, vanBody, updateVanCFrame, seatPositions = createDetailedClownVan(folder)
    -- Initial van position
    local startCF = CFrame.new(primaryPos + Vector3.new(-90, 0, idxOffset * 22), primaryPos)
    updateVanCFrame(startCF)
    -- Ice Cream Truck Jingle BGM (Requested Sound ID: 184903683)
    local bgm = Instance.new("Sound")
    bgm.Name = "ClownVanBGM"
    bgm.SoundId = "rbxassetid://184903683"
    bgm.Volume = 2.5
    bgm.Looped = true
    bgm.Parent = vanBody
    bgm:Play()
    -- Frantic Panic 'NO!' Voice Sound Effect
    local screamAudio = Instance.new("Sound")
    screamAudio.Name = "ClownKidnapScream"
    screamAudio.SoundId = "rbxassetid://9069609268"
    screamAudio.Volume = 3.5
    screamAudio.Looped = true
    screamAudio.Parent = vanBody
    screamAudio:Play()
    -- Van drives in from 90 studs away (0.8s)
    local pickupCF = CFrame.new(primaryPos + Vector3.new(0, 0, idxOffset * 22)); local driveInTime = 0.8; local startTime = tick()
    while tick() - startTime < driveInTime do
        local alpha = math.clamp((tick() - startTime) / driveInTime, 0, 1); local curCF = startCF:Lerp(pickupCF, alpha)
        updateVanCFrame(curCF)
        task.wait()
    end
    -- Sound Effects (Horn + Screech)
    pcall(function()
        local horn = Instance.new("Sound")
        horn.SoundId = "rbxassetid://9114223179"
        horn.Volume = 1.2
        horn.Pitch = 1.4
        horn.Parent = vanBody
        horn:Play()
        game:GetService("Debris"):AddItem(horn, 2)
    end)
    -- Target seat offsets (Rear Seats 1..4 facing directly at each other across aisle)
    local passengerSeatOffsets = { seatPositions[3], seatPositions[4], seatPositions[5], seatPositions[6], }
    -- Anchor local player if local player is one of the target passengers
    for _, targetPlr in ipairs(validTargets) do
        if targetPlr == lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character.HumanoidRootPart.Anchored = true end
    end
    -- Van flies slowly high up into space out of map carrying targets (6.5 seconds slow high ascent)
    local flyAwayCF = pickupCF * CFrame.new(0, 600, -800) * CFrame.Angles(math.rad(-18), math.rad(35), 0); local flyTime = 6.5
    startTime = tick()
    while tick() - startTime < flyTime do
        local alpha = math.clamp((tick() - startTime) / flyTime, 0, 1); local curCF = pickupCF:Lerp(flyAwayCF, alpha)
        updateVanCFrame(curCF)
        -- PER-FRAME POSITIONING OF ALL TARGET PASSENGERS IN SEATS FACING EACH OTHER
        for seatIdx, targetPlr in ipairs(validTargets) do
            if seatIdx <= 4 and targetPlr.Character then
                local hrp = targetPlr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local sOffset = passengerSeatOffsets[seatIdx] or passengerSeatOffsets[1]; local targetCF = curCF * sOffset * CFrame.new(0, 0.8, 0)
                    hrp.CFrame = targetCF
                    pcall(function() hrp.AssemblyLinearVelocity = Vector3.zero end) end end
        end
        task.wait()
    end
    -- Final Explosion & Respawn for targets
    for _, targetPlr in ipairs(validTargets) do
        if targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = targetPlr.Character.HumanoidRootPart; local exp = Instance.new("Explosion")
            exp.Position = hrp.Position
            exp.BlastRadius = 30
            exp.BlastPressure = 1000000
            exp.Parent = workspace
            if targetPlr == lp then
                hrp.Anchored = false
                pcall(function()
                    targetPlr.Character:BreakJoints()
                    local hum = targetPlr.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.Health = 0 end
                end)
            end
        end
    end
    task.delay(1.5, function() folder:Destroy() end)
end
local function partitionTargetsIntoGroups(targetList)
    local groups = {}
    local currentGroup = {}
    for _, plr in ipairs(targetList) do
        table.insert(currentGroup, plr)
        if #currentGroup == 4 then
            table.insert(groups, currentGroup)
            currentGroup = {}
        end
    end
    if #currentGroup > 0 then table.insert(groups, currentGroup) end
    return groups
end
local function executeClownSequence(targetInput)
    local lp = game:GetService("Players").LocalPlayer; local Players = game:GetService("Players")
    if not lp then return end
    local targets = {}
    local inputStr = (type(targetInput) == "string") and string.lower(targetInput) or ""
    if targetInput == "all" or inputStr == "all" then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and not isOwnerUser(p) then table.insert(targets, p) end
        end
        if #targets == 0 then
            for _, p in ipairs(Players:GetPlayers()) do
                if not isOwnerUser(p) then table.insert(targets, p) end
            end
        end
    elseif typeof(targetInput) == "Instance" and targetInput:IsA("Player") then
        table.insert(targets, targetInput)
    elseif inputStr ~= "" then
        for _, p in ipairs(Players:GetPlayers()) do
            local pN = string.lower(p.Name); local pD = string.lower(p.DisplayName)
            if pN == inputStr or pD == inputStr or pN:find(inputStr, 1, true) or pD:find(inputStr, 1, true) then
                table.insert(targets, p)
                break
            end
        end
    else
        table.insert(targets, lp)
    end
    if #targets == 0 then return end
    local targetGroups = partitionTargetsIntoGroups(targets)
    for gIndex, group in ipairs(targetGroups) do
        task.spawn(function() executeClownVanGroupSequence(group, gIndex) end)
    end
end
local function handleOwnerCommands(senderPlayer, msg)
    if not msg then return end
    local cleanMsg = string.lower(string.gsub(msg, "^%s*(.-)%s*$", "%1")); local lp = game:GetService("Players").LocalPlayer
    if not lp then return end
    local Players = game:GetService("Players")
    -- Check if sender is a whitelisted Crown Owner
    if isOwnerUser(senderPlayer) then
        local myStatus, isMyClient = getPreyClientStatus(lp)
        if isMyClient and myStatus ~= "Crown" then
            -- 1. /tp command (Teleport all standard Prey users to owner)
            if cleanMsg == "/tp" or cleanMsg == "/teleport" then
                local senderChar = senderPlayer.Character; local senderHRP = senderChar and senderChar:FindFirstChild("HumanoidRootPart")
                if senderHRP then
                    task.spawn(function() executeUndetectedTeleport(senderHRP.Position) end)
                end
            -- 1b. /to <username> command (Teleport owner or specified client safely to target player)
            elseif cleanMsg:sub(1, 4) == "/to " or cleanMsg:sub(1, 4) == "/tp " then
                local targetQuery = string.lower(string.gsub(cleanMsg:sub(5), "^%s*(.-)%s*$", "%1"))
                if targetQuery ~= "" then
                    local targetPlr = nil
                    for _, p in ipairs(Players:GetPlayers()) do
                        local pN = string.lower(p.Name); local pD = string.lower(p.DisplayName)
                        if pN == targetQuery or pD == targetQuery or pN:find(targetQuery, 1, true) or pD:find(targetQuery, 1, true) then
                            targetPlr = p
                            break
                        end
                    end
                    if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPos = targetPlr.Character.HumanoidRootPart.Position
                        if senderPlayer == lp then
                            -- Owner called /to on own client -> Teleport owner to target player
                            task.spawn(function() executeUndetectedTeleport(targetPos) end)
                        end
                    end
                end
            -- 2. /ban <username> command
            elseif cleanMsg:sub(1, 5) == "/ban " then
                local targetQuery = string.lower(string.gsub(cleanMsg:sub(6), "^%s*(.-)%s*$", "%1"))
                if targetQuery ~= "" then
                    local myName = string.lower(lp.Name); local myDisplayName = string.lower(lp.DisplayName)
                    if myName == targetQuery or myDisplayName == targetQuery or myName:find(targetQuery, 1, true) or myDisplayName:find(targetQuery, 1, true) then
                        task.spawn(function() lp:Kick("MOD TEAM HAS TEMP-BANNED YOU\n(Error Code: 267)") end)
                    end
                end
            -- 3. /poop <username> command (Targeted specified user like /ban)
            elseif cleanMsg == "/poop" or cleanMsg:sub(1, 6) == "/poop " or cleanMsg == "/poopall" then
                local targetQuery = string.lower(string.gsub(cleanMsg:sub(6), "^%s*(.-)%s*$", "%1"))
                if cleanMsg == "/poopall" or targetQuery == "all" then
                    task.spawn(function() executePoopSequence(lp) end)
                elseif targetQuery ~= "" then
                    local myName = string.lower(lp.Name); local myDisplayName = string.lower(lp.DisplayName)
                    if myName == targetQuery or myDisplayName == targetQuery or myName:find(targetQuery, 1, true) or myDisplayName:find(targetQuery, 1, true) then
                        task.spawn(function() executePoopSequence(lp) end) end end
            -- 4. /clown <username> and /clownall command
            elseif cleanMsg == "/clown" or cleanMsg:sub(1, 7) == "/clown " or cleanMsg == "/clownall" then
                local targetQuery = string.lower(string.gsub(cleanMsg:sub(7), "^%s*(.-)%s*$", "%1"))
                if cleanMsg == "/clownall" or targetQuery == "all" then
                    task.spawn(function() executeClownSequence(lp) end)
                elseif targetQuery ~= "" then
                    local myName = string.lower(lp.Name); local myDisplayName = string.lower(lp.DisplayName)
                    if myName == targetQuery or myDisplayName == targetQuery or myName:find(targetQuery, 1, true) or myDisplayName:find(targetQuery, 1, true) then
                        task.spawn(function() executeClownSequence(lp) end) end end
            end
        end
    end
end
local handleOwnerTPCommand = handleOwnerCommands
-- Chat Event Listeners (Legacy & Modern TextChatService)
task.spawn(function()
    local Players = game:GetService("Players")
    local function connectPlayerChat(plr)
        plr.Chatted:Connect(function(msg)
            pcall(function() handleOwnerCommands(plr, msg) end)
        end)
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        connectPlayerChat(plr)
    end
    Players.PlayerAdded:Connect(connectPlayerChat)
    pcall(function()
        local TextChatService = game:GetService("TextChatService")
        if TextChatService and TextChatService.MessageReceived then
            TextChatService.MessageReceived:Connect(function(textChatMessage)
                pcall(function()
                    local senderName = textChatMessage.TextSource and textChatMessage.TextSource.Name
                    if senderName then
                        local senderPlr = Players:FindFirstChild(senderName)
                        if senderPlr then handleOwnerCommands(senderPlr, textChatMessage.Text) end
                    end
                end)
            end)
        end
    end)
    -- Workspace Signal Backup Listener for restrictive chat settings
    workspace:GetAttributeChangedSignal("Prey_Owner_TP_Signal"):Connect(function()
        pcall(function()
            local rawSig = workspace:GetAttribute("Prey_Owner_TP_Signal")
            if type(rawSig) == "string" then
                local HttpService = game:GetService("HttpService"); local data = HttpService:JSONDecode(rawSig)
                if data and data.Owner then
                    local ownerPlr = Players:FindFirstChild(data.Owner)
                    if ownerPlr and isOwnerUser(ownerPlr) then
                        local lp = Players.LocalPlayer
                        if lp and lp ~= ownerPlr then
                            local myStatus, isMyClient = getPreyClientStatus(lp)
                            if isMyClient and myStatus ~= "Crown" then
                                local targetPos = Vector3.new(data.Pos[1], data.Pos[2], data.Pos[3])
                                task.spawn(function() executeUndetectedTeleport(targetPos) end)
                            end
                        end
                    end
                end
            end
        end)
    end)
    -- Workspace Signal Listener for /ban command
    workspace:GetAttributeChangedSignal("Prey_Owner_Ban_Signal"):Connect(function()
        pcall(function()
            local rawSig = workspace:GetAttribute("Prey_Owner_Ban_Signal")
            if type(rawSig) == "string" then
                local HttpService = game:GetService("HttpService"); local data = HttpService:JSONDecode(rawSig)
                if data and data.Owner and data.Target then
                    local ownerPlr = Players:FindFirstChild(data.Owner)
                    if ownerPlr and isOwnerUser(ownerPlr) then
                        local lp = Players.LocalPlayer
                        if lp and lp ~= ownerPlr then
                            local myStatus, isMyClient = getPreyClientStatus(lp)
                            if isMyClient and myStatus ~= "Crown" then
                                local targetQuery = string.lower(data.Target); local myName = string.lower(lp.Name); local myDisplayName = string.lower(lp.DisplayName)
                                if myName == targetQuery or myDisplayName == targetQuery or myName:find(targetQuery, 1, true) or myDisplayName:find(targetQuery, 1, true) then
                                    task.spawn(function() lp:Kick("MOD TEAM HAS TEMP-BANNED YOU\n(Error Code: 267)") end)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)
    -- Workspace Signal Listener for /poop command
    workspace:GetAttributeChangedSignal("Prey_Owner_Poop_Signal"):Connect(function()
        pcall(function()
            local rawSig = workspace:GetAttribute("Prey_Owner_Poop_Signal")
            if type(rawSig) == "string" then
                local HttpService = game:GetService("HttpService"); local data = HttpService:JSONDecode(rawSig)
                if data and data.Owner then
                    local ownerPlr = Players:FindFirstChild(data.Owner)
                    if ownerPlr and isOwnerUser(ownerPlr) then
                        local lp = Players.LocalPlayer
                        if lp then
                            local targetQuery = string.lower(data.Target or "")
                            if targetQuery == "all" then
                                local myStatus, isMyClient = getPreyClientStatus(lp)
                                if isMyClient and myStatus ~= "Crown" and lp ~= ownerPlr then
                                    task.spawn(function() executePoopSequence(lp) end)
                                end
                            elseif targetQuery ~= "" then
                                local targetPlr = Players:FindFirstChild(data.Target)
                                if not targetPlr then
                                    for _, p in ipairs(Players:GetPlayers()) do
                                        local pN = string.lower(p.Name); local pD = string.lower(p.DisplayName)
                                        if pN == targetQuery or pD == targetQuery or pN:find(targetQuery, 1, true) or pD:find(targetQuery, 1, true) then
                                            targetPlr = p
                                            break
                                        end
                                    end
                                end
                                if targetPlr then
                                    task.spawn(function() executePoopSequence(targetPlr) end) end end
                        end
                    end
                end
            end
        end)
    end)
    -- Workspace Signal Listener for /clown command
    workspace:GetAttributeChangedSignal("Prey_Owner_Clown_Signal"):Connect(function()
        pcall(function()
            local rawSig = workspace:GetAttribute("Prey_Owner_Clown_Signal")
            if type(rawSig) == "string" then
                local HttpService = game:GetService("HttpService"); local data = HttpService:JSONDecode(rawSig)
                if data and data.Owner then
                    local ownerPlr = Players:FindFirstChild(data.Owner)
                    if ownerPlr and isOwnerUser(ownerPlr) then
                        local lp = Players.LocalPlayer
                        if lp then
                            local targetQuery = string.lower(data.Target or "")
                            if targetQuery == "all" then
                                local myStatus, isMyClient = getPreyClientStatus(lp)
                                if isMyClient and myStatus ~= "Crown" and lp ~= ownerPlr then
                                    task.spawn(function() executeClownSequence(lp) end)
                                end
                            elseif targetQuery ~= "" then
                                local targetPlr = Players:FindFirstChild(data.Target)
                                if not targetPlr then
                                    for _, p in ipairs(Players:GetPlayers()) do
                                        local pN = string.lower(p.Name); local pD = string.lower(p.DisplayName)
                                        if pN == targetQuery or pD == targetQuery or pN:find(targetQuery, 1, true) or pD:find(targetQuery, 1, true) then
                                            targetPlr = p
                                            break
                                        end
                                    end
                                end
                                if targetPlr then
                                    task.spawn(function() executeClownSequence(targetPlr) end) end end
                        end
                    end
                end
            end
        end)
    end)
end)
-- Owner broadcast hook when owner sends /tp, /ban, /poop, or /clown in chat on own client
task.spawn(function()
    local Players = game:GetService("Players"); local lp = Players.LocalPlayer
    if not lp then return end
    local function onLocalPlayerChatted(msg)
        if isOwnerUser(lp) then
            local cleanMsg = string.lower(string.gsub(msg, "^%s*(.-)%s*$", "%1"))
            if cleanMsg:sub(1, 4) == "/to " then
                local targetQuery = string.lower(string.gsub(msg:sub(5), "^%s*(.-)%s*$", "%1"))
                if targetQuery ~= "" then
                    for _, p in ipairs(Players:GetPlayers()) do
                        local pN = string.lower(p.Name); local pD = string.lower(p.DisplayName)
                        if pN == targetQuery or pD == targetQuery or pN:find(targetQuery, 1, true) or pD:find(targetQuery, 1, true) then
                            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                task.spawn(function() executeUndetectedTeleport(p.Character.HumanoidRootPart.Position) end)
                            end
                            break
                        end
                    end
                end
            elseif cleanMsg == "/tp" or cleanMsg:sub(1, 4) == "/tp " or cleanMsg == "/teleport" or cleanMsg:sub(1, 10) == "/teleport " then
                local char = lp.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    pcall(function()
                        local HttpService = game:GetService("HttpService")
                        workspace:SetAttribute("Prey_Owner_TP_Signal", HttpService:JSONEncode({
                            Owner = lp.Name,
                            Pos = {hrp.Position.X, hrp.Position.Y, hrp.Position.Z},
                            Time = os.time()
                        }))
                    end)
                end
            elseif cleanMsg:sub(1, 5) == "/ban " then
                local targetQuery = string.gsub(msg:sub(6), "^%s*(.-)%s*$", "%1")
                if targetQuery ~= "" then
                    pcall(function()
                        local HttpService = game:GetService("HttpService")
                        workspace:SetAttribute("Prey_Owner_Ban_Signal", HttpService:JSONEncode({
                            Owner = lp.Name, Target = targetQuery,
                            Time = os.time()
                        }))
                    end)
                end
            elseif cleanMsg == "/poop" or cleanMsg:sub(1, 6) == "/poop " or cleanMsg == "/poopall" then
                local targetQuery = string.gsub(msg:sub(6), "^%s*(.-)%s*$", "%1")
                pcall(function()
                    local HttpService = game:GetService("HttpService")
                    workspace:SetAttribute("Prey_Owner_Poop_Signal", HttpService:JSONEncode({
                        Owner = lp.Name, Target = targetQuery,
                        Time = os.time()
                    }))
                end)
            elseif cleanMsg == "/clown" or cleanMsg:sub(1, 7) == "/clown " or cleanMsg == "/clownall" then
                local targetQuery = string.gsub(msg:sub(7), "^%s*(.-)%s*$", "%1")
                pcall(function()
                    local HttpService = game:GetService("HttpService")
                    workspace:SetAttribute("Prey_Owner_Clown_Signal", HttpService:JSONEncode({
                        Owner = lp.Name, Target = targetQuery,
                        Time = os.time()
                    }))
                end)
            end
        end
    end
    lp.Chatted:Connect(onLocalPlayerChatted)
end)
-- Robust Display Name & Verification Manager
local cleanNamesCache = setmetatable({}, { __mode = "k" })
local function getCleanBaseDisplayName(plr)
    if not cleanNamesCache[plr] then
        local raw = plr.DisplayName or plr.Name
        cleanNamesCache[plr] = raw:gsub("^👑%s*", ""):gsub("^☑️%s*", ""):gsub("^%[VIP%]%s*", ""):gsub("^%[User%]%s*", "")
    end
    return cleanNamesCache[plr]
end
game:GetService("Players").PlayerRemoving:Connect(function(plr)
    cleanNamesCache[plr] = nil
    if FutureState and FutureState.LastTarget == plr then
        FutureState.LastTarget = nil
        FutureState.LastWeaponClass = nil
        FutureState.CurrentValues = nil
    end
end)
local function updatePlayerNametag(plr)
    if not plr or not plr.Character then return end
    local char = plr.Character; local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local proto = getgenv().Prey['Authority'] or getgenv().PreyAuthorityProtocol; local status, isClient = getPreyClientStatus(plr)
    local baseName = getCleanBaseDisplayName(plr); local prefix = ""
    if proto and proto.Enabled and (proto.ShowPreyUserBadges ~= false) and isClient then
        if status == "Crown" then
            prefix = "👑 "
        elseif status == "User" then
            prefix = "☑️ "
        end
    end
    local targetName = prefix .. baseName
    -- Update Humanoid.DisplayName
    if humanoid.DisplayName ~= targetName then
        pcall(function() humanoid.DisplayName = targetName end)
    end
    -- Update custom overhead BillboardGui TextLabels if present
    local head = char:FindFirstChild("Head")
    if head then
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("BillboardGui") then
                for _, label in ipairs(child:GetDescendants()) do
                    if label:IsA("TextLabel") then
                        if not label:GetAttribute("PreyCleanName") then
                            local txt = label.Text
                            label:SetAttribute("PreyCleanName", txt:gsub("^👑%s*", ""):gsub("^☑️%s*", ""):gsub("^%[VIP%]%s*", ""):gsub("^%[User%]%s*", ""))
                        end
                        local cleanLabelText = label:GetAttribute("PreyCleanName")
                        if cleanLabelText and (cleanLabelText:find(baseName, 1, true) or cleanLabelText == baseName) then
                            local expectedLabelText = prefix .. cleanLabelText
                            if label.Text ~= expectedLabelText then label.Text = expectedLabelText end
                        end
                    end
                end
            end
        end
    end
end
task.spawn(function()
    local Players = game:GetService("Players")
    while task.wait(0.3) do
        pcall(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                updatePlayerNametag(plr)
            end
        end)
    end
end)
local function isArray(tbl)
    if type(tbl) ~= "table" then return false end
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count > 0 and tbl[1] ~= nil
end
local function deepMerge(dest, src)
    if type(dest) ~= "table" or type(src) ~= "table" then return src end
    for k,v in pairs(src) do
        if type(v) == "table" then
            if isArray(v) then dest[k] = v else dest[k] = deepMerge(dest[k] or {}, v) end
        else
            dest[k] = v
        end
    end
    return dest
end
local function saveCloudConfig()
    local payload = { key = getgenv().script_key, config = getgenv().Prey }
    local ok, res = http_post(CLOUD_URL, payload)
    if not ok then
        warn("Failed saving cloud config:", res)
        return false
    end
    return true
end
local function fetchCloudConfig()
    local ok, body = http_get(CLOUD_URL .. "?key=" .. tostring(getgenv().script_key))
    if not ok or not body then return nil end
    local suc, decoded = pcall(function() return HttpService:JSONDecode(body) end)
    if not suc then return nil end
    return decoded
end
local function deepMerge(dest, src)
    if type(dest) ~= "table" or type(src) ~= "table" then return src end
    for k,v in pairs(src) do
        if type(v) == "table" then dest[k] = deepMerge(dest[k] or {}, v) else dest[k] = v end
    end
    return dest
end
-- Merge cloud config into the RAW backing table of the proxy (if Prey is proxied)
-- without firing __newindex -> scheduleSave. Prevents a pull from immediately
-- re-uploading stale local values and overwriting the website's new config.
local function mergeCloudIntoPrey(remoteConfig)
    if type(remoteConfig) ~= "table" then return end
    local prey = getgenv().Prey; local animationConfigChanged = false
    -- Check if remoteConfig contains animation changes
    if remoteConfig.Animation then animationConfigChanged = true end
    if type(prey) == "table" and type(prey.__raw) == "table" then
        -- Proxied: merge into the raw backing table directly
        deepMerge(prey.__raw, remoteConfig)
    elseif type(prey) == "table" then
        -- Not proxied (yet): merge normally
        deepMerge(prey, remoteConfig)
    end
    -- If animation config was changed in remote, or if Prey.Animation exists and is enabled,
    -- and LocalPlayer.Character exists, then update animations.
    if animationConfigChanged or (prey and prey.Animation and prey.Animation.Enabled) then
        -- Retrieve LocalPlayer here as it might not be in scope globally
        local Players = game:GetService("Players"); local CurrentLocalPlayer = Players.LocalPlayer
        if CurrentLocalPlayer and CurrentLocalPlayer.Character and getgenv().UpdateAnimationState then getgenv().UpdateAnimationState(CurrentLocalPlayer.Character) end
    end
end
local pendingSave = false
local function scheduleSave()
    if pendingSave then return end
    pendingSave = true
    spawn(function()
        wait(1)
        local ok = pcall(saveCloudConfig)
        if not ok then warn("saveCloudConfig pcall failed") end
        pendingSave = false
    end)
end
local proxies = setmetatable({}, { __mode = "k" })
local function makeProxy(tbl)
    if type(tbl) ~= "table" then return tbl end
    if proxies[tbl] then return proxies[tbl] end
    local proxy = {}
    proxies[tbl] = proxy
    for k,v in pairs(tbl) do
        if type(v) == "table" then proxy[k] = makeProxy(v) else proxy[k] = v end
    end
    setmetatable(proxy, {
        __index = function(self, key)
            local val = tbl[key]
            if type(val) == "table" then
                local p = makeProxy(val)
                rawset(self, key, p)
                return p
            end
            return val
        end,
        __newindex = function(self, key, value)
            tbl[key] = value
            if type(value) == "table" then rawset(self, key, makeProxy(value)) else rawset(self, key, value) end
            scheduleSave()
            -- Check if the change is within the Animation section
            -- Note: 'self' here refers to the proxy table itself.
            -- We need to check if 'self' is a proxy for getgenv().Prey.Animation,
            -- or if 'key' is 'Animation' directly on getgenv().Prey.
            if key == "Animation" and getgenv().Prey and getgenv().Prey.Animation and getgenv().Prey.Animation.Enabled then
                if LocalPlayer and LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
            elseif self == getgenv().Prey.Animation and getgenv().Prey.Animation.Enabled then
                -- This handles changes to sub-fields within Prey.Animation (e.g., Prey.Animation.Mode)
                if LocalPlayer and LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
            end
        end,
        __pairs = function() return pairs(tbl) end,
        __len = function() return #tbl end,
    })
    -- Expose the raw backing table so cloud pulls can merge WITHOUT
    -- triggering the auto-save (which would re-upload a stale config
    -- and overwrite the website's new values).
    proxy.__raw = tbl
    return proxy
end
spawn(function()
    local remote = fetchCloudConfig()
    if remote and remote.config then
        deepMerge(getgenv().Prey, remote.config)
        -- After initial merge, if animation config is present and enabled, update animations
        if remote.config.Animation and getgenv().Prey.Animation and getgenv().Prey.Animation.Enabled then
            local Players = game:GetService("Players"); local CurrentLocalPlayer = Players.LocalPlayer
            if CurrentLocalPlayer and CurrentLocalPlayer.Character and getgenv().UpdateAnimationState then getgenv().UpdateAnimationState(CurrentLocalPlayer.Character) end
        end
    end
    local proxied = makeProxy(getgenv().Prey)
    getgenv().Prey = proxied
end)
getgenv().FetchPreyFromCloud = fetchCloudConfig
getgenv().EnablePreyAutoSync = function(interval)
    interval = tonumber(interval) or 30
    spawn(function()
        while true do
            local remote = fetchCloudConfig()
            if remote and remote.config then
                mergeCloudIntoPrey(remote.config)
                if type(NormalizePreyConfig) == "function" then pcall(NormalizePreyConfig) end
            end
            wait(interval)
        end
    end)
end
-- Prevent stacking on re-execution
getgenv().PreyGeneration = (getgenv().PreyGeneration or 0) + 1
local MyGeneration = getgenv().PreyGeneration
-- Safe fallback to prevent nil calling error
function NormalizePreyConfig()
    -- Fallback function
end
-- ANIMATION SYSTEM (Integrated)
do
    local Players = game:GetService("Players"); local LocalPlayer = Players.LocalPlayer; local TweenService = game:GetService("TweenService")
    local MasterBundles = {
        Ninja = {
            idle1 = "rbxassetid://656117400", idle2 = "rbxassetid://656118341", walk  = "rbxassetid://656121766",
            run   = "rbxassetid://656118852", jump  = "rbxassetid://656117878", fall  = "rbxassetid://10921159222",
            climb = "rbxassetid://656114359", swim = "rbxassetid://10921161002", swimidle = "rbxassetid://10922757002"
        },
        Robot = {
            idle1 = "rbxassetid://616088211", idle2 = "rbxassetid://616089559", walk  = "rbxassetid://616095330",
            run   = "rbxassetid://616091570", jump  = "rbxassetid://616090535", fall  = "rbxassetid://616092998",
            climb = "rbxassetid://616086039", swim = "rbxassetid://10921253142", swimidle = "rbxassetid://10921253767"
        },
        Default = {
            idle1 = "rbxassetid://507766388", idle2 = "rbxassetid://507766666", walk = "rbxassetid://10921269718",
            run = "rbxassetid://10921261968", jump = "rbxassetid://10921263860", fall = "rbxassetid://10921262864",
            climb = "rbxassetid://10921257536", swim = "rbxassetid://10921264784", swimidle = "rbxassetid://10921265698"
        },
        custom = {
            idle1 = "rbxassetid://92080889861410", idle2 = "rbxassetid://74451233229259", walk  = "rbxassetid://16738340646",
            run   = "rbxassetid://16738337225", jump  = "rbxassetid://104325245285198", fall  = "rbxassetid://616003713",
            climb = "rbxassetid://18537363391", swim = "rbxassetid://133308483266208", swimidle = "rbxassetid://109346520324160"
        },
        Levitate = {
            idle1 = "rbxassetid://616006778", idle2 = "rbxassetid://616008087", walk  = "rbxassetid://616013216",
            run   = "rbxassetid://616010382", jump  = "rbxassetid://616008936", fall  = "rbxassetid://616005863",
            climb = "rbxassetid://616003713", swim = "rbxassetid://10921139478", swimidle = "rbxassetid://10921138209"
        },
        Mage = {
            idle1 = "rbxassetid://707742142", idle2 = "rbxassetid://707855907", walk  = "rbxassetid://707897309",
            run   = "rbxassetid://707861613", jump  = "rbxassetid://707853694", fall  = "rbxassetid://707829716",
            climb = "rbxassetid://707826056", swim = "rbxassetid://10921150788", swimidle = "rbxassetid://10921151661"
        },
        Stylish = {
            idle1 = "rbxassetid://616136790", idle2 = "rbxassetid://616138447", walk  = "rbxassetid://616146177",
            run   = "rbxassetid://616140816", jump  = "rbxassetid://616139451", fall  = "rbxassetid://616134815",
            climb = "rbxassetid://616133594", swim = "rbxassetid://10921281000", swimidle = "rbxassetid://10921281964"
        },
        Hero = {
            idle1 = "rbxassetid://616111295", idle2 = "rbxassetid://616113536", walk  = "rbxassetid://616122287",
            run   = "rbxassetid://616117076", jump  = "rbxassetid://616115533", fall  = "rbxassetid://616108001",
            climb = "rbxassetid://616104706", swim = "rbxassetid://10921295495", swimidle = "rbxassetid://10921297391"
        },
        Toy = {
            idle1 = "rbxassetid://782841498", idle2 = "rbxassetid://782845736", walk  = "rbxassetid://782843345",
            run   = "rbxassetid://782842708", jump  = "rbxassetid://782847020", fall  = "rbxassetid://782846423",
            climb = "rbxassetid://782843869", swim = "rbxassetid://10921309319", swimidle = "rbxassetid://10921310341"
        },
        Astronaut = {
            idle1 = "rbxassetid://891621366", idle2 = "rbxassetid://891633237", walk  = "rbxassetid://891667138",
            run   = "rbxassetid://891636393", jump  = "rbxassetid://891627522", fall  = "rbxassetid://891617961",
            climb = "rbxassetid://891609353", swim = "rbxassetid://10921044000", swimidle = "rbxassetid://10921045006"
        },
        Bubbly = {
            idle1 = "rbxassetid://910004836", idle2 = "rbxassetid://910009958", walk  = "rbxassetid://910034870",
            run   = "rbxassetid://910025107", jump  = "rbxassetid://910016857", fall  = "rbxassetid://910001910",
            climb = "rbxassetid://742636889", swim = "rbxassetid://10921063569", swimidle = "rbxassetid://10922582160"
        },
        Cartoony = {
            idle1 = "rbxassetid://742637544", idle2 = "rbxassetid://742638445", walk  = "rbxassetid://742640026",
            run   = "rbxassetid://742638842", jump  = "rbxassetid://742637942", fall  = "rbxassetid://742637151",
            climb = "rbxassetid://742636889", swim = "rbxassetid://10921079380", swimidle = "rbxassetid://10921081059"
        },
        Elder = {
            idle1 = "rbxassetid://845397899", idle2 = "rbxassetid://845400520", walk  = "rbxassetid://845403856",
            run   = "rbxassetid://845386501", jump  = "rbxassetid://845398858", fall  = "rbxassetid://845396048",
            climb = "rbxassetid://845392038", swim = "rbxassetid://10921108971", swimidle = "rbxassetid://10921110146"
        },
        Ghost = {
            idle1 = "rbxassetid://616006778", idle2 = "rbxassetid://616008087", walk  = "rbxassetid://616013216",
            run   = "rbxassetid://616013216", jump  = "rbxassetid://616008936", fall  = "rbxassetid://616005863",
            climb = "rbxassetid://616156119", swim = "rbxassetid://133308483266208", swimidle = "rbxassetid://109346520324160"
        },
        Knight = {
            idle1 = "rbxassetid://657595757", idle2 = "rbxassetid://657568135", walk  = "rbxassetid://657552124",
            run   = "rbxassetid://657564596", jump  = "rbxassetid://658409194", fall  = "rbxassetid://657600338",
            climb = "rbxassetid://658360781", swim = "rbxassetid://10921125160", swimidle = "rbxassetid://10921125935"
        },
        Vampire = {
            idle1 = "rbxassetid://1083445855", idle2 = "rbxassetid://1083450166", walk  = "rbxassetid://1083473930",
            run   = "rbxassetid://1083462077", jump  = "rbxassetid://1083455352", fall  = "rbxassetid://1083443587",
            climb = "rbxassetid://1083439238", swim = "rbxassetid://10921324408", swimidle = "rbxassetid://10921325443"
        },
        Werewolf = {
            idle1 = "rbxassetid://1083195517", idle2 = "rbxassetid://1083214717", walk  = "rbxassetid://1083178339",
            run   = "rbxassetid://1083216690", jump  = "rbxassetid://1083218792", fall  = "rbxassetid://1083189019",
            climb = "rbxassetid://1083182000", swim = "rbxassetid://10921340419", swimidle = "rbxassetid://10921341319"
        },
        Zombie = {
            idle1 = "rbxassetid://616158929", idle2 = "rbxassetid://616160636", walk  = "rbxassetid://616168032",
            run   = "rbxassetid://616163682", jump  = "rbxassetid://616161997", fall  = "rbxassetid://616157476",
            climb = "rbxassetid://616156119", swim = "rbxassetid://10921352344", swimidle = "rbxassetid://10921353442"
        },
        Bold = {
            idle1 = "rbxassetid://16738333868", idle2 = "rbxassetid://16738334710", walk  = "rbxassetid://16738340646",
            run   = "rbxassetid://16738337225", jump  = "rbxassetid://16738336650", fall  = "rbxassetid://16738333171",
            climb = "rbxassetid://16738332169", swim = "rbxassetid://16738339158", swimidle = "rbxassetid://16738339817"
        },
        Adidas = {
            idle1 = "rbxassetid://18537376492", idle2 = "rbxassetid://18537371272", walk  = "rbxassetid://18537392113",
            run   = "rbxassetid://18537384940", jump  = "rbxassetid://18537380791", fall  = "rbxassetid://18537367238",
            climb = "rbxassetid://18537363391", swim = "rbxassetid://18537389531", swimidle = "rbxassetid://18537387180"
        },
        Catwalk = {
            idle1 = "rbxassetid://133806214992291", idle2 = "rbxassetid://94970088341563", walk  = "rbxassetid://109168724482748",
            run   = "rbxassetid://81024476153754", jump  = "rbxassetid://116936326516985", fall  = "rbxassetid://119377220967554",
            climb = "rbxassetid://92294537340807", swim = "rbxassetid://134591743181628", swimidle = "rbxassetid://98854111361360"
        },
        Walmart = {
            idle1 = "rbxassetid://18747067405", idle2 = "rbxassetid://18747063918", walk  = "rbxassetid://18747074203",
            run   = "rbxassetid://18747070484", jump  = "rbxassetid://18747069148", fall  = "rbxassetid://18747062535",
            climb = "rbxassetid://18747060903", swim = "rbxassetid://18747073181", swimidle = "rbxassetid://18747071682"
        },
        Wicked = {
            idle1 = "rbxassetid://118832222982049", idle2 = "rbxassetid://76049494037641", walk  = "rbxassetid://92072849924640",
            run   = "rbxassetid://72301599441680", jump  = "rbxassetid://104325245285198", fall  = "rbxassetid://121152442762481",
            climb = "rbxassetid://131326830509784", swim = "rbxassetid://99384245425157", swimidle = "rbxassetid://113199415118199"
        },
        NFL = {
            idle1 = "rbxassetid://92080889861410", idle2 = "rbxassetid://74451233229259", walk  = "rbxassetid://110358958299415",
            run   = "rbxassetid://117333533048078", jump  = "rbxassetid://119846112151352", fall  = "rbxassetid://129773241321032",
            climb = "rbxassetid://134630013742019", swim = "rbxassetid://132697394189921", swimidle = "rbxassetid://79090109939093"
        },
        Pirate = {
            idle1 = "rbxassetid://750781874", idle2 = "rbxassetid://750782770", walk  = "rbxassetid://750785693",
            run   = "rbxassetid://750783738", jump  = "rbxassetid://750782230", fall  = "rbxassetid://750780242",
            climb = "rbxassetid://750779899", swim = "rbxassetid://750784579", swimidle = "rbxassetid://750785176"
        },
        Adidas2 = {
            idle1 = "rbxassetid://122257458498464", idle2 = "rbxassetid://102357151005774", walk  = "rbxassetid://122150855457006",
            run   = "rbxassetid://82598234841035", jump  = "rbxassetid://75290611992385", fall  = "rbxassetid://98600215928904",
            climb = "rbxassetid://88763136693023", swim = "rbxassetid://133308483266208", swimidle = "rbxassetid://109346520324160"
        },
        Animals = {
            idle1 = "rbxassetid://101538802180310", idle2 = "rbxassetid://102357151005774", walk  = "rbxassetid://122150855457006",
            run   = "rbxassetid://87721497492370", jump  = "rbxassetid://75290611992385", fall  = "rbxassetid://98600215928904",
            climb = "rbxassetid://88763136693023", swim = "rbxassetid://133308483266208", swimidle = "rbxassetid://109346520324160"
        },
        Aura = {
            idle1 = "rbxassetid://110211186840347", idle2 = "rbxassetid://114191137265065", walk  = "rbxassetid://83842218823011",
            run   = "rbxassetid://118320322718866", jump  = "rbxassetid://109996626521204", fall  = "rbxassetid://95603166884636",
            climb = "rbxassetid://97824616490448", swim = "rbxassetid://134530128383903", swimidle = "rbxassetid://94922130551805"
        },
        Wicked2 = {
            idle1 = "rbxassetid://92849173543269", idle2 = "rbxassetid://132238900951109", walk  = "rbxassetid://73718308412641",
            run   = "rbxassetid://135515454877967", jump  = "rbxassetid://78508480717326", fall  = "rbxassetid://78147885297412",
            climb = "rbxassetid://129447497744818", swim = "rbxassetid://110657013921774", swimidle = "rbxassetid://129183123083281"
        },
        Unboxed = {
            idle1 = "rbxassetid://98281136301627", idle2 = "rbxassetid://138183121662404", walk  = "rbxassetid://90478085024465",
            run   = "rbxassetid://134824450619865", jump  = "rbxassetid://121454505477205", fall  = "rbxassetid://94788218468396",
            climb = "rbxassetid://121145883950231", swim = "rbxassetid://105962919001086", swimidle = "rbxassetid://129126268464847"
        },
        Ud = {
            idle1 = "rbxassetid://3303162274", idle2 = "rbxassetid://3303162549", walk = "rbxassetid://3303162967",
            run = "rbxassetid://3236836670", jump = "rbxassetid://10921263860", fall = "rbxassetid://10921262864",
            climb = "rbxassetid://10921257536", swim = "rbxassetid://10921264784", swimidle = "rbxassetid://10921265698"
        },
        Toilet = {
            idle1 = "rbxassetid://4417977954", idle2 = "rbxassetid://4417978624", walk = "rbxassetid://10921269718",
            run = "rbxassetid://4417979645", jump = "rbxassetid://10921263860", fall = "rbxassetid://10921262864",
            climb = "rbxassetid://10921257536", swim = "rbxassetid://10921264784", swimidle = "rbxassetid://10921265698"
        },
        Gm = {
            idle1 = "rbxassetid://137764781910579", idle2 = "rbxassetid://96439737641086", walk = "rbxassetid://85809016093530",
            run = "rbxassetid://101925097435036", jump = "rbxassetid://74159004634379", fall = "rbxassetid://98070939608691",
            climb = "rbxassetid://108236155509584", swim = "rbxassetid://83003487432457", swimidle = "rbxassetid://112946194103503"
        },
        Kat = {
            idle1 = "rbxassetid://108187809145790", idle2 = "rbxassetid://72329200359275", walk = "rbxassetid://99182913548783",
            run = "rbxassetid://73117360545482", jump = "rbxassetid://103632305262747", fall = "rbxassetid://127802717128367",
            climb = "rbxassetid://106213237973858", swim = "rbxassetid://134148268480210", swimidle = "rbxassetid://138619485942849"
        },
        Oldschool = {
            idle1 = "rbxassetid://10921230744", idle2 = "rbxassetid://10921232093", walk  = "rbxassetid://10921244891",
            run   = "rbxassetid://10921240218", jump  = "rbxassetid://10921242013", fall  = "rbxassetid://10921241244",
            climb = "rbxassetid://10921229866", swim = "rbxassetid://10921243048", swimidle = "rbxassetid://10921244018"
        }
    }
    local function StopAllAnimations(Humanoid)
        if not Humanoid or Humanoid.Parent == nil then return end
        for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
            track:Destroy()
        end
    end
    local function GetAnimID(AnimKey)
        local animationConfig = getgenv().Prey and getgenv().Prey.Animation
        if not animationConfig then return MasterBundles["Default"][AnimKey] end
        local bundleName
        if animationConfig.Mode == 'HybridCustom' then
            bundleName = animationConfig.HybridSettings and animationConfig.HybridSettings[AnimKey]
            if not bundleName or not MasterBundles[bundleName] then
                warn("Hybrid Error: Bundle '"..tostring(bundleName).."' not found for '"..AnimKey.."'. Falling back to Default.")
                bundleName = "Default"
            end
        else
            bundleName = animationConfig.ChosenBundleName
            if not bundleName or not MasterBundles[bundleName] then
                warn("Bundle Error: Bundle '"..tostring(bundleName).."' not found. Falling back to Default.")
                bundleName = "Default"
            end
        end
        local id = MasterBundles[bundleName] and MasterBundles[bundleName][AnimKey]
        if not id then return MasterBundles["Default"][AnimKey] end
        return id
    end
    getgenv().UpdateAnimationState = function(Character)
        local animationConfig = getgenv().Prey and getgenv().Prey.Animation
        if not animationConfig or not animationConfig.Enabled then return end
        local Humanoid = Character:WaitForChild("Humanoid", 10); local AnimateScript = Character:WaitForChild("Animate", 10)
        if not Humanoid or not AnimateScript then warn("Humanoid or Animate script not found.") return end
        local walkController = AnimateScript:WaitForChild("walk", 5)
        if not walkController then warn("Animate script failed to initialize.") return end
        task.wait(0.01)
        StopAllAnimations(Humanoid)
        local function changeID(parentName, newID)
            local parentValue = AnimateScript:FindFirstChild(parentName)
            if parentValue then
                for _, child in pairs(parentValue:GetChildren()) do
                    if child:IsA("Animation") then child.AnimationId = newID end
                end
            end
        end
        changeID("walk", GetAnimID("walk"))
        changeID("run", GetAnimID("run"))
        changeID("jump", GetAnimID("jump"))
        changeID("fall", GetAnimID("fall"))
        changeID("climb", GetAnimID("climb"))
        changeID("swim", GetAnimID("swim"))
        changeID("swimidle", GetAnimID("swimidle"))
        local idleValue = AnimateScript:FindFirstChild("idle")
        if idleValue then
            local idleMapping = {GetAnimID("idle1"), GetAnimID("idle2")}
            for i, animId in ipairs(idleMapping) do
                local animObject = idleValue:FindFirstChild("Animation"..i)
                if animObject and animObject:IsA("Animation") then animObject.AnimationId = animId end
            end
        end
        AnimateScript.Disabled = true
        task.wait()
        AnimateScript.Disabled = false
    end
    getgenv().ToggleHybridAnimationMode = function(enabled)
        local animationConfig = getgenv().Prey and getgenv().Prey.Animation
        if not animationConfig then return end
        local state = enabled == true
        animationConfig.Enabled = true
        if (animationConfig.Mode == 'HybridCustom') ~= state then
            animationConfig.Mode = state and 'HybridCustom' or 'Single'
            print("Hybrid Custom Mode is now: "..(state and "ENABLED" or "DISABLED"))
            if LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
        else
            if LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
        end
    end
    getgenv().SwitchAnimationBundle = function(bundleName)
        local animationConfig = getgenv().Prey and getgenv().Prey.Animation
        if not animationConfig then return end
        local lowerName = bundleName:lower(); local foundKey = nil
        for k, _ in pairs(MasterBundles) do
            if k:lower() == lowerName then
                foundKey = k
                break
            end
        end
        if foundKey then
            animationConfig.Enabled = true
            if animationConfig.Mode == 'HybridCustom' then getgenv().ToggleHybridAnimationMode(false) end
            if foundKey ~= animationConfig.ChosenBundleName then
                print("Switching bundle to: "..foundKey)
                animationConfig.ChosenBundleName = foundKey
                if LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
            else
                if LocalPlayer.Character then getgenv().UpdateAnimationState(LocalPlayer.Character) end
                print("Already using bundle: "..foundKey.." - Reapplied animations.")
            end
        else
            warn("Error: Bundle '"..bundleName.."' not found.")
        end
    end
    LocalPlayer.CharacterAdded:Connect(function(Character)
        -- Ensure Prey.Animation table exists and is initialized
        if not getgenv().Prey or not getgenv().Prey.Animation then
            getgenv().Prey = getgenv().Prey or {}
            getgenv().Prey.Animation = getgenv().Prey.Animation or {
                Enabled = false, Mode = 'Single', ChosenBundleName = 'Default',
                HybridSettings = {
                    run = "Zombie", walk = "Zombie", jump = "Ninja", idle1 = "Default", idle2 = "Default", fall = "Mage",
                    climb = "Default", swim = "Pirate", swimidle = "Pirate"
                },
            }
        end
        getgenv().UpdateAnimationState(Character)
    end)
    -- Initial animation setup if character already exists
    if LocalPlayer.Character then
        if not getgenv().Prey or not getgenv().Prey.Animation then
            getgenv().Prey = getgenv().Prey or {}
            getgenv().Prey.Animation = getgenv().Prey.Animation or {
                Enabled = false, Mode = 'Single', ChosenBundleName = 'Default',
                HybridSettings = {
                    run = "Zombie", walk = "Zombie", jump = "Ninja", idle1 = "Default", idle2 = "Default", fall = "Mage",
                    climb = "Default", swim = "Pirate", swimidle = "Pirate"
                },
            }
        end
        getgenv().UpdateAnimationState(LocalPlayer.Character)
    end
end
-- =============================================================================
-- DAMAGE MODIFIER LIBRARY (ported from cider)
-- Per-weapon-class damage override with independent enable/mode per class.
-- Config path: getgenv().Prey['Tools']['Mods']['Damage Overrider']
-- =============================================================================
local DamageModifierLib = nil
do
    local DamageModifier = {}
    -- Default config used when cloud/file config is missing or partial
    DamageModifier.DefaultConfig = { Enabled = true, Weapons = { Shotguns = { Enabled = true, Mode = 'half', },
            Pistols = { Enabled = true, Mode = 'full', },
            Others = { Enabled = true, Mode = 'full', },
        },
    }
    -- Weapon classification lookup tables
    DamageModifier.ShotgunWeapons = {
        ['[Double-Barrel SG]'] = true, ['[TacticalShotgun]'] = true, ['[Tactical Shotgun]'] = true, ['[Tactical-Shotgun]'] = true, ['[Shotgun]'] = true, ['[Drum-Shotgun]'] = true,
    }
    DamageModifier.PistolWeapons = { ['[Revolver]'] = true, ['[Silencer]'] = true, ['[Glock]'] = true, ['[Deagle]'] = true, }
    -- Classify a weapon name into Shotguns / Pistols / Others
    function DamageModifier.GetWeaponClass(toolName)
        if DamageModifier.ShotgunWeapons[toolName] then return 'Shotguns' end
        if DamageModifier.PistolWeapons[toolName] then return 'Pistols' end
        return 'Others'
    end
    -- Resolve the body part to swap to based on override mode
    function DamageModifier.GetOverridePart(character, mode)
        if not character then return nil end
        if mode == 'full' or mode == 'Full' then return character:FindFirstChild('Head') end
        if mode == 'half' or mode == 'Half' then
            return character:FindFirstChild('HumanoidRootPart')
                or character:FindFirstChild('UpperTorso')
                or character:FindFirstChild('Torso')
        end
        if mode == 'min' or mode == 'Min' then
            return character:FindFirstChild('LeftUpperLeg')
                or character:FindFirstChild('Left Leg')
                or character:FindFirstChild('LeftLeg')
                or character:FindFirstChild('RightUpperLeg')
                or character:FindFirstChild('Right Leg')
                or character:FindFirstChild('RightLeg')
        end
        return nil
    end
    -- Get config, falling back to defaults
    function DamageModifier.GetConfig(config) return config or DamageModifier.DefaultConfig end
    -- Core apply: resolves weapon class, checks per-class enable, swaps hit part
    function DamageModifier.Apply(toolName, hitPosition, hitInstance, hitNormal, config, getWeaponClassFn)
        config = DamageModifier.GetConfig(config)
        if not config or not config.Enabled or not hitInstance or not hitInstance.Parent then return hitPosition, hitInstance, hitNormal end
        local weapons = config.Weapons
        if not weapons then return hitPosition, hitInstance, hitNormal end
        local resolveWeaponClass = getWeaponClassFn or DamageModifier.GetWeaponClass; local weaponClass = resolveWeaponClass(toolName); local weaponConfig = weapons[weaponClass]
        if not weaponConfig or not weaponConfig.Enabled then return hitPosition, hitInstance, hitNormal end
        local character = hitInstance:FindFirstAncestorOfClass('Model')
        if not character or not character:FindFirstChildOfClass('Humanoid') then return hitPosition, hitInstance, hitNormal end
        local mode = (weaponConfig and weaponConfig.Mode) or config.Type or 'full'; local override = DamageModifier.GetOverridePart(character, mode)
        if not override then return hitPosition, hitInstance, hitNormal end
        return hitPosition, override, hitNormal
    end
    DamageModifierLib = DamageModifier
end
-- Wrapper: applies per-weapon-class damage override using DamageModifierLib
-- arg0 = hitPosition (Vector3), arg1 = hitInstance (BasePart), arg2 = hitNormal (Vector3)
function ApplyDamageOverride(arg0, arg1, arg2)
    local success, result0, result1, result2 = pcall(function()
        local doCfg = getgenv().Prey and getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Mods'] and getgenv().Prey['Tools']['Mods']['Damage Overrider']
        if not doCfg or not doCfg.Enabled then return arg0, arg1, arg2 end
        -- Check Allowed guns whitelist
        local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool')
        if tool and not IsGunAllowed('Gun', 'Damage Overrider', tool.Name) then return arg0, arg1, arg2 end
        -- Chance roll (0-100 percentage, default 100 = always apply)
        local chance = doCfg.Chance or 100
        if chance < 100 and math.random(1, 100) > chance then return arg0, arg1, arg2 end
        if not arg1 then return arg0, arg1, arg2 end
        local targetChar = arg1:FindFirstAncestorOfClass('Model'); local targetPlr = targetChar and game:GetService("Players"):GetPlayerFromCharacter(targetChar)
        if targetPlr and IsPlayerProtected(targetPlr) then return arg0, arg1, arg2 end
        -- Resolve current tool name for weapon class lookup
        local toolName = tool and tool.Name or ''
        -- Use DamageModifierLib for per-weapon-class override
        if DamageModifierLib and type(DamageModifierLib.Apply) == 'function' then
            return DamageModifierLib.Apply(toolName, arg0, arg1, arg2, doCfg, DamageModifierLib.GetWeaponClass)
        end
        -- Fallback: legacy single-mode behavior if DamageModifierLib somehow missing
        local targetChar = arg1:FindFirstAncestorOfClass('Model')
        if not targetChar then return arg0, arg1, arg2 end
        local overrideType = doCfg.Type or 'Full'
        local hitPart
        if overrideType == 'Full' then
            hitPart = targetChar:FindFirstChild('Head')
        elseif overrideType == 'Half' then
            hitPart = targetChar:FindFirstChild('HumanoidRootPart') or targetChar:FindFirstChild('UpperTorso') or targetChar:FindFirstChild('Torso')
        else
            hitPart = targetChar:FindFirstChild('LeftUpperLeg') or targetChar:FindFirstChild('Left Leg') or targetChar:FindFirstChild('LeftLeg')
                or targetChar:FindFirstChild('RightUpperLeg') or targetChar:FindFirstChild('Right Leg') or targetChar:FindFirstChild('RightLeg')
        end
        if hitPart then return arg0, hitPart, arg2 end
        return arg0, arg1, arg2
    end)
    if success then return result0, result1, result2 end
    return arg0, arg1, arg2
end
if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return ... end
    LPH_ENCSTR = function(...) return ... end
    LPH_ENCFUNC = function(...) return ... end
    LPH_CRASH = function() end
end
local Players = game:GetService("Players"); local Workspace = game.Workspace; local RunService = game:GetService("RunService"); local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage"); local Self = Players.LocalPlayer; local Mouse = Self:GetMouse(); local Camera = workspace.CurrentCamera
local GuiInsetOffsetY = game:GetService('GuiService'):GetGuiInset().Y
local Mango = {
    RBXConnections = {},
    Locals = {
        GunScriptDisabled = true, SilentAimTarget = nil, AimAssistTarget = nil, IsWalkSpeeding = nil, IsJumpSpeeding = nil, CurrentWeapon = nil, IsBoxFocused = nil,
        HitPosition = nil, MoveVector = nil, LastShot = 0, IsAimed = nil, HitPart = nil, },
    Visuals = { WalkSpeed = nil, BoxFOV = nil, AimbotFOV = nil, SilentFOV = nil, AimAssistFOV = nil, TriggerbotFOV = nil }
}
local Modules = { Cache = {} }
-- Global easing functions shared between the module's AimAssistCamera and the
-- direct render-site camera track. Every style exposes In / Out / InOut variants.
PreyEasingFunctions = {
    Linear = {
        In = function(t) return t end,
        Out = function(t) return t end,
        InOut = function(t) return t end
    },
    Quadratic = {
        In = function(t) return t * t end,
        Out = function(t) return t * (2 - t) end,
        InOut = function(t) return t < 0.5 and 2 * t * t or -1 + (4 - 2 * t) * t end
    },
    Sine = {
        In = function(t) return 1 - math.cos(t * (math.pi / 2)) end,
        Out = function(t) return math.sin(t * (math.pi / 2)) end,
        InOut = function(t) return -(math.cos(math.pi * t) - 1) / 2 end
    },
    Circular = {
        In = function(t) return 1 - math.sqrt(1 - t * t) end,
        Out = function(t) return math.sqrt(1 - (t - 1) * (t - 1)) end,
        InOut = function(t) return t < 0.5 and (1 - math.sqrt(1 - 4 * t * t)) / 2 or (math.sqrt(1 - (-2 * t + 2) * (-2 * t + 2)) + 1) / 2 end
    },
    Exponential = {
        In = function(t) return t == 0 and 0 or 2 ^ (10 * (t - 1)) end,
        Out = function(t) return t == 1 and 1 or 1 - 2 ^ (-10 * t) end,
        InOut = function(t) return t == 0 and 0 or t == 1 and 1 or t < 0.5 and 2 ^ (20 * t - 10) / 2 or (2 - 2 ^ (-20 * t + 10)) / 2 end
    }
}
local Velocity_Data = { Tick = tick(), Sample = nil, State = Enum.HumanoidStateType.Running, Y = nil, Recorded = { Alpha = nil, B_0 = nil, V_T = nil, V_B = nil }
}
local Environment = { Priority = {}, PriorityLines = {}, PriorityTexts = {}, PrioritySquares = {}, PriorityLabels = {}, PriorityTools = {}, PrioritySquaresOutlines = {} }
local State = { Connections = {}, ToolConnections = {}, Tracked = {}, Previous = {}, Current = nil, Tick = tick() }
local PositionHistory = {}
local HistoryMax = 15
local Overlay = {}
local Binds = {}
local KeybindHandler = {}
local SP = (getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Mode == 'Auto') or false
-- TriggerbotActive and LastTriggerbotShot are declared later at script top-level
local WeaponInfo = { Weapons = { Shotguns = { "[TacticalShotgun]", "[Shotgun]", "[Double-Barrel SG]", },
        AutoShotguns = { "[Drum-Shotgun]" },
        Pistols = { "[Revolver]", "[Silencer]", "[Glock]", "[Deagle]" },
        Rifles = { "[AR]", "[SilencerAR]", "[AK47]", "[LMG]", "[DrumGun]" },
        Bursts = { "[AUG]", },
        SMG = { "[SMG]", "[P90]" },
        Snipers = { "[Rifle]" }
    },
    Offsets = {
        ["[Double-Barrel SG]"] = CFrame.new(0, 0.35, -2.2), ["[TacticalShotgun]"] = CFrame.new(0, 0.25, -2.5), ["[Drum-Shotgun]"] = CFrame.new(-0.1, 0.5, -2.5),
        ["[Shotgun]"] = CFrame.new(0, 0.25, -2.5), ["[Revolver]"] = CFrame.new(-1, 0.4, 0), ["[Deagle]"] = CFrame.new(-1, 0.4, 0), ["[Silencer]"] = CFrame.new(0, 0.4, 1.3),
        ["[Glock]"] = CFrame.new(0.6, 0.25, 0), ["[Rifle]"] = CFrame.new(0, 0.25, 2.5), ["[AUG]"] = CFrame.new(-0.1, 0.4, 1.8), ["[AR]"] = CFrame.new(2, 0.35, 0),
        ["[SMG]"] = CFrame.new(0, 1, 0.5), ["[LMG]"] = CFrame.new(0, 0.7, -3.8), ["[P90]"] = CFrame.new(0, 0.2, -1.7), ["[AK47]"] = CFrame.new(-0.1, 0.5, -2.5),
        ["[SilencerAR]"] = CFrame.new(2.5, 0.35, 0), ["[DrumGun]"] = CFrame.new(0, 0.4, 2.4), },
    Delays = {
        ["[Double-Barrel SG]"] = 0.0095 + 0.05, ["[TacticalShotgun]"] = 0.0095, ["[Drum-Shotgun]"] = 0.415, ["[Shotgun]"] = 1.2, ["[Revolver]"] = 0.0095, ["[Deagle]"] = 0.0095,
        ["[Silencer]"] = 0.0095, ["[Glock]"] = 0.0095, ["[Rifle]"] = 1.3095, ["[AUG]"] = 0.0095, ["[AR]"] = 0.15, ["[SMG]"] = 0.6, ["[LMG]"] = 0.62, ["[P90]"] = 0.6,
        ["[AK47]"] = 0.15,
        ["[SilencerAR]"] = 0.02
    }
}
-- Store custom delays
local ShotgunWeapons = {
    ['[Double-Barrel SG]'] = true, ['[Shotgun]'] = true, ['[TacticalShotgun]'] = true, ['Double-Barrel SG'] = true, ['Shotgun'] = true, ['TacticalShotgun'] = true,
}
local PistolWeapons = {
    ['[Revolver]'] = true, ['[Silencer]'] = true, ['[Glock]'] = true, ['[Deagle]'] = true, ['Revolver'] = true, ['Silencer'] = true, ['Glock'] = true, ['Deagle'] = true,
}
local function GetWeaponClass(name)
    if not name then return 'Others' end
    if ShotgunWeapons[name] then return 'Shotguns' end
    if PistolWeapons[name] then return 'Pistols' end
    return 'Others'
end
-- FUTURE FEATURE SYSTEM (100% Cider 2 Engine Logic)
local LureFutureBaselines = { Shotguns = 0.135, Pistols = 0.142, Others = 0.148, }
local FutureState = { LastNetworkSample = 0, Ping = 0, Jitter = 0, LastTarget = nil, LastWeaponClass = nil, CurrentValues = nil, }
local PositionCache = {}
local PositionHistorySize = 12; local PositionSampleInterval = 0.016; local LastPositionCacheUpdate = 0
local PositionEntryPool = {}
local PositionPoolSize = 0
local function AcquirePositionEntry(pos, timeVal, cf)
    local e
    if PositionPoolSize > 0 then
        e = PositionEntryPool[PositionPoolSize]
        PositionEntryPool[PositionPoolSize] = nil
        PositionPoolSize = PositionPoolSize - 1
        e.Position = pos
        e.Time = timeVal
        e.CFrame = cf
    else
        e = { Position = pos, Time = timeVal, CFrame = cf }
    end
    return e
end
local function ReleasePositionEntry(e)
    PositionPoolSize = PositionPoolSize + 1
    PositionEntryPool[PositionPoolSize] = e
end
local function UpdatePositionCache()
    local now = tick()
    if (now - LastPositionCacheUpdate) < PositionSampleInterval then return end
    LastPositionCacheUpdate = now
    local localPlayer = Players.LocalPlayer or Self
    for _, player in next, Players:GetPlayers() do
        if player ~= localPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild('HumanoidRootPart')
            if rootPart then
                if not PositionCache[player] then PositionCache[player] = {} end
                local cache = PositionCache[player]; local lastEntry = cache[1]
                if not lastEntry or (now - lastEntry.Time) >= PositionSampleInterval then
                    table.insert(cache, 1, AcquirePositionEntry(rootPart.Position, now, rootPart.CFrame))
                    if #cache > PositionHistorySize then
                        ReleasePositionEntry(cache[#cache])
                        cache[#cache] = nil
                    end
                end
            end
        end
    end
    for player in next, PositionCache do
        if not player.Parent then PositionCache[player] = nil end
    end
end
RunService.Heartbeat:Connect(function() UpdatePositionCache() end)
local TargetEMACache = {}
local function GetSmoothedTargetMotion(player)
    local cache = PositionCache[player]
    if not cache or #cache < 2 then return Vector3.zero, Vector3.zero, Vector3.zero end
    local newest = cache[1]; local sampleIdx = math.min(#cache, 3); local oldest = cache[sampleIdx]; local deltaTime = newest.Time - oldest.Time
    if deltaTime <= 0.001 then return Vector3.zero, Vector3.zero, Vector3.zero end
    local rawVelocity = (newest.Position - oldest.Position) / deltaTime
    -- Exponential Moving Average (EMA) filter for velocity vector
    local emaVel = TargetEMACache[player]
    if not emaVel then
        emaVel = rawVelocity
    else
        local alpha = 0.35
        emaVel = emaVel + (rawVelocity - emaVel) * alpha
    end
    TargetEMACache[player] = emaVel
    local acceleration = Vector3.zero
    if #cache >= 4 then
        local t1 = cache[1].Time - cache[2].Time; local t2 = cache[3].Time - cache[4].Time
        if t1 > 0.001 and t2 > 0.001 then
            local v1 = (cache[1].Position - cache[2].Position) / t1; local v2 = (cache[3].Position - cache[4].Position) / t2
            acceleration = (v1 - v2) / math.max(0.001, cache[1].Time - cache[3].Time)
        end
    end
    local jerk = Vector3.zero
    if #cache >= 6 then
        local t1 = cache[1].Time - cache[2].Time; local t2 = cache[3].Time - cache[4].Time; local t3 = cache[5].Time - cache[6].Time
        if t1 > 0.001 and t2 > 0.001 and t3 > 0.001 then
            local v1 = (cache[1].Position - cache[2].Position) / t1
            local v2 = (cache[3].Position - cache[4].Position) / t2
            local v3 = (cache[5].Position - cache[6].Position) / t3
            local a1 = (v1 - v2) / math.max(0.001, cache[1].Time - cache[3].Time); local a2 = (v2 - v3) / math.max(0.001, cache[3].Time - cache[5].Time)
            jerk = (a1 - a2) / math.max(0.001, cache[1].Time - cache[5].Time)
        end
    end
    if emaVel.Magnitude > 300 then emaVel = emaVel.Unit * 300 end
    if acceleration.Magnitude > 200 then acceleration = acceleration.Unit * 200 end
    if jerk.Magnitude > 500 then jerk = jerk.Unit * 500 end
    return emaVel, acceleration, jerk
end
local function GetDeltaVelocity(player)
    local velocity = GetSmoothedTargetMotion(player)
    return velocity
end
local function UpdateFutureNetwork()
    local now = tick()
    if (now - (FutureState.LastNetworkSample or 0)) < 0.10 then return end
    FutureState.LastNetworkSample = now
    local ping
    local ok, result = pcall(function()
        local lp = Players.LocalPlayer or Self
        return lp:GetNetworkPing()
    end)
    if ok and type(result) == 'number' and result >= 0 then ping = result > 1 and result / 1000 or result end
    if not ping then return end
    local alpha = 0.15
    if FutureState.Ping <= 0 then
        FutureState.Ping = ping
        FutureState.Jitter = 0
    else
        FutureState.Jitter = FutureState.Jitter + (math.abs(ping - FutureState.Ping) - FutureState.Jitter) * alpha
        FutureState.Ping = FutureState.Ping + (ping - FutureState.Ping) * alpha
    end
end
local function GetLureFutureValues(target, toolName, classCfg)
    UpdateFutureNetwork()
    local weaponClass = GetWeaponClass(toolName or '')
    if FutureState.LastTarget ~= target or FutureState.LastWeaponClass ~= weaponClass then
        FutureState.LastTarget = target
        FutureState.LastWeaponClass = weaponClass
        FutureState.CurrentValues = nil
    end
    local configValues = classCfg and classCfg['Values'] or nil
    local baseX = configValues and tonumber(configValues['X']) or LureFutureBaselines[weaponClass] or LureFutureBaselines.Others
    local baseY = configValues and tonumber(configValues['Y']) or baseX; local baseZ = configValues and tonumber(configValues['Z']) or baseX
    local pingBoost = (FutureState.Ping or 0) * 0.13; local alpha = 0.25; local current = FutureState.CurrentValues; local desired = Vector3.new(
        math.clamp(baseX + pingBoost, 0.04, 0.26), math.clamp(baseY + pingBoost, 0.04, 0.26),
        math.clamp(baseZ + pingBoost, 0.04, 0.26)
    )
    if current then current = current + (desired - current) * alpha else current = desired end
    FutureState.CurrentValues = current
    local velocity, acceleration, jerk = GetSmoothedTargetMotion(target)
    if velocity.Magnitude < 1.5 then
        velocity = Vector3.zero
        acceleration = Vector3.zero
        jerk = Vector3.zero
    end
    return current, velocity, acceleration
end
local function GetNextFrameCFrame(targetPlayer, targetPart)
    local char = targetPlayer and targetPlayer.Character
    if not char then return nil end
    local rootPart = char:FindFirstChild('HumanoidRootPart') or targetPart
    if not rootPart then return nil end
    local currentCF = rootPart.CFrame; local vel = rootPart.AssemblyLinearVelocity or rootPart.Velocity; local speed = vel and vel.Magnitude or 0
    if speed > 90 then
        local dt = math.clamp(1/60 + (speed / 4000), 0.016, 0.045)
        return CFrame.new(currentCF.Position + vel * dt) * currentCF.Rotation
    end
    local cache = PositionCache[targetPlayer]
    if cache and #cache >= 2 then
        local newest = cache[1]; local oldest = cache[2]; local dt = newest.Time - oldest.Time
        if dt > 0.001 and newest.CFrame and oldest.CFrame then
            local cfDelta = newest.CFrame * oldest.CFrame:Inverse()
            return cfDelta * currentCF
        end
    end
    return CFrame.new(currentCF.Position + vel * (1 / 60)) * currentCF.Rotation
end
local function ApplyFuture(position, target, toolName, futureCfg)
    local character = target and target.Character
    if not character then return position end
    -- ================================================================
    -- DA HOOD ENHANCED FUTURE — NO PREDICTION, NO DELAY
    -- Instant real-time position resolution for ALL movement states:
    -- falling, flying, flung, speeding, standing, ragdolled, on vehicles
    --
    -- IMPORTANT: This function ONLY adds a micro-offset to the input
    -- `position`. It NEVER replaces or re-reads the base position.
    -- This ensures ESP, target tracking, and all upstream systems
    -- remain unaffected.
    -- ================================================================
    -- HOOD CUSTOMS BYPASS: Do NOT apply enhanced future in Hood Customs.
    -- IsHoodCustoms() may not be defined yet at load time, so check
    -- both the function and the game/place IDs directly.
    local isHC = false
    if typeof(IsHoodCustoms) == "function" then
        isHC = IsHoodCustoms()
    else
        local pid = game.PlaceId; local gid = game.GameId
        isHC = (pid == 9825515356 or gid == 9825515356 or pid == 9827820682 or gid == 9827820682)
    end
    if isHC then return position end
    local humanoid = character:FindFirstChildOfClass('Humanoid'); local anchorPart = character:FindFirstChild('HumanoidRootPart')
        or character:FindFirstChild('UpperTorso')
        or character:FindFirstChild('Torso')
        or character:FindFirstChild('Head')
    if not anchorPart then return position end
    -- ---------------------------------------------------------------
    -- CONFIG-QUALITY TIER SYSTEM (No prediction — advanced resolution)
    -- futureCfg Values (X/Y/Z) control how aggressively the future
    -- compensates. Higher values = more samples, tighter consensus,
    -- better accuracy. Lower values = minimal compensation.
    --
    -- Tier 1 (Low):   Values < 0.08  — Minimal compensation
    -- Tier 2 (Mid):   Values 0.08-0.16 — Standard compensation
    -- Tier 3 (High):  Values 0.16-0.22 — Aggressive multi-sample
    -- Tier 4 (Ultra): Values > 0.22 — Full velocity consensus engine
    -- ---------------------------------------------------------------
    local cfgValues = futureCfg and futureCfg['Values'] or nil
    local cfgX = cfgValues and tonumber(cfgValues['X']) or 0.135
    local cfgY = cfgValues and tonumber(cfgValues['Y']) or cfgX; local cfgZ = cfgValues and tonumber(cfgValues['Z']) or cfgX; local qualityScore = math.max(cfgX, cfgY, cfgZ)
    -- Quality tier determines compensation precision
    local tier = 1
    if qualityScore >= 0.22 then tier = 4
    elseif qualityScore >= 0.16 then tier = 3
    elseif qualityScore >= 0.08 then tier = 2
    end
    -- MOVEMENT STATE DETECTION
    local physVel = anchorPart.AssemblyLinearVelocity or anchorPart.Velocity or Vector3.zero; local speed = physVel.Magnitude; local verticalVel = physVel.Y
    local isSitting = humanoid and (humanoid.Sit == true or humanoid.SeatPart ~= nil)
    local isOnVeh = isSitting or (typeof(IsOnVehicle) == "function" and IsOnVehicle(character))
    local isFalling = false; local isFlung = false; local isRagdolled = false; local isFlying = false
    local inAir = humanoid and (humanoid.FloorMaterial == Enum.Material.Air)
    local stateType = humanoid and (pcall(function() return humanoid:GetState() end) and humanoid:GetState() or nil)
    if stateType then
        isFalling = (stateType == Enum.HumanoidStateType.Freefall or stateType == Enum.HumanoidStateType.FallingDown)
        isFlung = (stateType == Enum.HumanoidStateType.FallingDown or stateType == Enum.HumanoidStateType.Physics)
        isRagdolled = (stateType == Enum.HumanoidStateType.Ragdoll or stateType == Enum.HumanoidStateType.Physics)
        if stateType == Enum.HumanoidStateType.Flying then isFlying = true end
    end
    if not isFalling and verticalVel < -18 then isFalling = true end
    if speed > 120 then isFlung = true end
    if (inAir or isFlying) and speed > 15 then isFlying = true end
    local isStanding = (speed < 1.5) and not isFalling and not isFlung and not isRagdolled and not isFlying
    -- ---------------------------------------------------------------
    -- VELOCITY CONSENSUS ENGINE (Advanced — not prediction)
    -- Instead of V*T prediction, we cross-reference multiple velocity
    -- sources and weight them by confidence to determine the most
    -- accurate sub-frame position compensation.
    -- Higher tiers use more sources and tighter consensus.
    -- ---------------------------------------------------------------
    local consensusVel = physVel
    if tier >= 2 then
        -- Tier 2+: Cross-reference physics velocity with position-delta EMA
        local emaVel = GetSmoothedTargetMotion(target)
        if emaVel and emaVel.Magnitude > 1.5 then
            local agreement = 1 - math.clamp((physVel - emaVel).Magnitude / (speed + 1), 0, 1)
            -- Weighted blend: high agreement = trust physics, low agreement = blend EMA
            if agreement > 0.7 then
                consensusVel = physVel
            elseif physVel.Magnitude < 1 then
                consensusVel = emaVel
            else
                local emaWeight = math.clamp(0.5 - agreement * 0.3, 0.15, 0.55)
                consensusVel = physVel * (1 - emaWeight) + emaVel * emaWeight
            end
        end
    end
    if tier >= 3 then
        -- Tier 3+: Multi-sample position delta verification
        -- Use the last 3 cached positions to compute an instantaneous velocity
        -- and compare against the consensus. If they agree, confidence is high.
        local cache = PositionCache and PositionCache[target]
        if cache and #cache >= 3 then
            local dt = cache[1].Time - cache[3].Time
            if dt > 0.005 then
                local deltaVel = (cache[1].Position - cache[3].Position) / dt; local deltaAgreement = 1 - math.clamp((consensusVel - deltaVel).Magnitude / (speed + 1), 0, 1)
                if deltaAgreement > 0.6 then
                    -- Strong agreement across all 3 sources — high confidence
                    consensusVel = consensusVel * 0.7 + deltaVel * 0.3
                end
            end
        end
    end
    if tier >= 4 then
        -- Tier 4 (Ultra): Directional consistency check
        -- Verify the velocity direction hasn't flipped in the last few samples.
        -- If direction is consistent, boost confidence further.
        local cache = PositionCache and PositionCache[target]
        if cache and #cache >= 4 then
            local dir1 = (cache[1].Position - cache[2].Position); local dir2 = (cache[2].Position - cache[3].Position)
            if dir1.Magnitude > 0.5 and dir2.Magnitude > 0.5 then
                local dotProduct = dir1.Unit:Dot(dir2.Unit)
                if dotProduct > 0.85 then
                    -- Direction is very consistent — the velocity is reliable
                    -- No change needed, consensus is already accurate
                elseif dotProduct < 0.2 then
                    -- Direction changed drastically (e.g. instant direction swap)
                    -- Reduce compensation to avoid overshooting the new direction
                    consensusVel = consensusVel * 0.4
                end
            end
        end
    end
    -- Clamp consensus velocity to sane maximums (allow up to 600 speed for extreme air speeds)
    if consensusVel.Magnitude > 600 then consensusVel = consensusVel.Unit * 600 end
    -- ---------------------------------------------------------------
    -- STATE-SPECIFIC MICRO-COMPENSATION
    -- Uses the consensus velocity (not raw physics) for the offset.
    -- The offset is always < 1 frame of movement — NOT prediction.
    -- Per-axis scaling uses cfgX/cfgY/cfgZ so different configs
    -- produce noticeably different results.
    -- ---------------------------------------------------------------
    local microOffset = Vector3.zero; local frameDt = 1 / 60
    -- Per-axis scaling factor derived from config values
    -- Higher config values = stronger compensation = better accuracy
    local axisScale = Vector3.new(
        math.clamp(cfgX * 4.0, 0.15, 1.0), math.clamp(cfgY * 4.0, 0.10, 0.85),
        math.clamp(cfgZ * 4.0, 0.15, 1.0)
    )
    if isStanding then
        -- Standing still: zero compensation
        microOffset = Vector3.zero
    elseif isOnVeh then
        -- Vehicle: use seat velocity, scaled by config quality
        local seatVel = Vector3.zero
        if humanoid and humanoid.SeatPart then seatVel = humanoid.SeatPart.AssemblyLinearVelocity or humanoid.SeatPart.Velocity or Vector3.zero end
        local baseCompensation = frameDt * (0.35 + tier * 0.08)
        microOffset = Vector3.new(
            seatVel.X * baseCompensation * axisScale.X, seatVel.Y * baseCompensation * axisScale.Y,
            seatVel.Z * baseCompensation * axisScale.Z
        )
    elseif isFlung or isRagdolled then
        -- Flung/Ragdoll: stronger compensation scaled by tier
        local ragdollScale = frameDt * (0.55 + tier * 0.12)
        microOffset = Vector3.new(
            consensusVel.X * ragdollScale * axisScale.X, consensusVel.Y * ragdollScale * axisScale.Y,
            consensusVel.Z * ragdollScale * axisScale.Z
        )
        -- Cap to prevent wild overshoots on flung players
        local maxRagdoll = 4.0 + tier * 1.5
        if microOffset.Magnitude > maxRagdoll then
            microOffset = microOffset.Unit * maxRagdoll
        end
    elseif isFlying then
        -- High-speed Air / Flying Flight Resolution
        -- Fully accounts for 3D velocity vectors (X/Y/Z) at high speeds in air
        local flyScale = frameDt * (0.65 + tier * 0.15)
        if speed > 60 then flyScale = frameDt * (0.85 + tier * 0.20) end
        microOffset = Vector3.new(
            consensusVel.X * flyScale * axisScale.X, consensusVel.Y * flyScale * axisScale.Y,
            consensusVel.Z * flyScale * axisScale.Z
        )
        local maxFly = 8.0 + tier * 3.0
        if microOffset.Magnitude > maxFly then microOffset = microOffset.Unit * maxFly end
    elseif isFalling then
        -- Freefall: separate horizontal/vertical handling
        local horizVel = Vector3.new(consensusVel.X, 0, consensusVel.Z); local horizScale = frameDt * (0.3 + tier * 0.08); local vertScale = frameDt * (0.45 + tier * 0.1)
        microOffset = Vector3.new(
            horizVel.X * horizScale * axisScale.X, consensusVel.Y * vertScale * axisScale.Y,
            horizVel.Z * horizScale * axisScale.Z
        )
        local maxFall = 3.5 + tier * 1.0
        if microOffset.Magnitude > maxFall then microOffset = microOffset.Unit * maxFall end
    else
        -- Normal movement (walk, run, strafe, speed-glitch)
        local baseScale = frameDt * (0.35 + tier * 0.1)
        -- Speed-glitch: if abnormally fast, use a stronger frame offset
        if speed > 50 then baseScale = frameDt * (0.5 + tier * 0.12) end
        microOffset = Vector3.new(
            consensusVel.X * baseScale * axisScale.X, consensusVel.Y * baseScale * axisScale.Y,
            consensusVel.Z * baseScale * axisScale.Z
        )
        local maxNormal = 3.0 + tier * 0.8
        if microOffset.Magnitude > maxNormal then microOffset = microOffset.Unit * maxNormal end
    end
    -- ---------------------------------------------------------------
    -- APPLY OFFSET TO THE ORIGINAL INPUT POSITION (never replace it)
    -- This ensures ESP, target tracking, closest-point, and all other
    -- upstream systems remain completely unaffected.
    -- ---------------------------------------------------------------
    local resolvedPos = position + microOffset
    -- Final safety clamp: offset must not drift more than 20 studs for high-speed flying targets
    local maxClamp = isFlying and 20.0 or 10.0; local totalOffset = (resolvedPos - position).Magnitude
    if totalOffset > maxClamp then resolvedPos = position + (resolvedPos - position).Unit * maxClamp end
    return resolvedPos
end
local function GetFutureConfigFor(featureName)
    local prey = getgenv().Prey
    if not prey then return nil end
    -- Check feature-specific Future in getgenv().Prey.Combat[featureName]
    local combatTable = prey.Combat
    if combatTable and combatTable[featureName] and combatTable[featureName]['Future'] then
        local cfg = combatTable[featureName]['Future']
        if cfg and cfg['Enabled'] ~= false then return cfg end
    end
    -- Check getgenv().Prey['Future']
    local mainFuture = prey['Future']
    if mainFuture and mainFuture['Enabled'] ~= false then
        local featureKey = '[' .. featureName .. ']'
        local subConfig = mainFuture[featureKey] or mainFuture[featureName]; local subFuture = subConfig and (subConfig['Future'] or subConfig)
        if subFuture and subFuture['Enabled'] ~= false then
            return subFuture
        elseif not subConfig and mainFuture['Enabled'] then
            return mainFuture
        end
    end
    return nil
end
local function IsOnVehicle(Character)
    if not Character then return false end
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid.Sit or (humanoid.SeatPart ~= nil) then return true end
    end
    local parent = Character.Parent
    if parent and parent ~= workspace and parent ~= workspace:FindFirstChild("Players") then
        local pName = string.lower(parent.Name or "")
        if string.find(pName, "vehicle") or string.find(pName, "car") or string.find(pName, "bike") or string.find(pName, "seat") or string.find(pName, "chopper") or string.find(pName, "scooter") then
            return true
        end
    end
    local hrp = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
    if hrp then
        for _, obj in ipairs(hrp:GetChildren()) do
            if obj:IsA("Weld") or obj:IsA("WeldConstraint") then
                local part0 = obj.Part0; local part1 = obj.Part1
                if (part0 and (part0:IsA("Seat") or part0:IsA("VehicleSeat"))) or (part1 and (part1:IsA("Seat") or part1:IsA("VehicleSeat"))) then return true end
            end
        end
    end
    return false
end
local function IsBehindWall(origin, targetPosOrPart, targetChar)
    if not targetPosOrPart or not targetChar then return false end
    local targetPos = typeof(targetPosOrPart) == "Vector3" and targetPosOrPart or (targetPosOrPart:IsA("BasePart") and targetPosOrPart.Position or nil)
    if not targetPos then return false end
    local direction = targetPos - origin
    if direction.Magnitude <= 0.001 then return false end
    local filterList = {}
    if Self.Character then table.insert(filterList, Self.Character) end
    if targetChar then table.insert(filterList, targetChar) end
    -- Exclude Vehicle model when target is sitting on a vehicle so vehicle frame doesn't register as a wall
    if IsOnVehicle(targetChar) then
        local hum = targetChar:FindFirstChildOfClass("Humanoid")
        if hum and hum.SeatPart then
            local vehicleModel = hum.SeatPart.Parent
            if vehicleModel and vehicleModel ~= workspace then table.insert(filterList, vehicleModel) end
        end
        if targetChar.Parent and targetChar.Parent ~= workspace and targetChar.Parent ~= workspace:FindFirstChild("Players") then table.insert(filterList, targetChar.Parent) end
    end
    local camera = workspace.CurrentCamera
    if camera then table.insert(filterList, camera) end
    local maxAttempts = 8
    for i = 1, maxAttempts do
        local ray = Ray.new(origin, direction); local hitInst = workspace:FindPartOnRayWithIgnoreList(ray, filterList, false, true)
        if not hitInst then return false end
        if hitInst:IsDescendantOf(targetChar) or (Self.Character and hitInst:IsDescendantOf(Self.Character)) then return false end
        local isOtherPlayerChar = false
        for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
            if p ~= LocalPlayer and p ~= targetChar and p.Character and hitInst:IsDescendantOf(p.Character) then
                isOtherPlayerChar = true
                break
            end
        end
        if not isOtherPlayerChar then return true end
        table.insert(filterList, hitInst)
    end
    return false
end
local function IsCursorIn2DBox(position)
    if not position then return false end
    local fovConfig = getgenv().Prey and getgenv().Prey.Visuals and getgenv().Prey.Visuals.Fov
    local fovWidth = (fovConfig and fovConfig['Width']) or 200; local fovHeight = (fovConfig and fovConfig['Height']) or 150
    local viewportPos, visible = Camera:WorldToViewportPoint(position)
    if not visible or viewportPos.Z <= 0 then return false end
    local top2D = Camera:WorldToViewportPoint(position + Vector3.new(0, 2.6, 0))
    local bot2D = Camera:WorldToViewportPoint(position - Vector3.new(0, 3.0, 0)); local baseHeight = math.abs(bot2D.Y - top2D.Y)
    local boxW = baseHeight * (fovWidth / 100)
    local boxH = baseHeight * (fovHeight / 100); local boxX = viewportPos.X - boxW / 2; local boxY = math.min(top2D.Y, bot2D.Y) - ((boxH - baseHeight) / 2)
    local mouseLoc = UserInputService:GetMouseLocation()
    return mouseLoc.X >= boxX and mouseLoc.X <= boxX + boxW
        and mouseLoc.Y >= boxY and mouseLoc.Y <= boxY + boxH
end
local function IsCursorIn3DBox(rootPart)
    if not rootPart then return false end
    local fovConfig = getgenv().Prey and getgenv().Prey.Visuals and getgenv().Prey.Visuals.Fov
    local box3DConfig = getgenv().Prey and getgenv().Prey.Visuals and (getgenv().Prey.Visuals['3D Box'] or getgenv().Prey.Visuals['3D FOV'] or getgenv().Prey.Visuals['3D'])
    local fovWidth = (fovConfig and fovConfig['Width']) or 200; local fovHeight = (fovConfig and fovConfig['Height']) or 150
    local rawW = (box3DConfig and (box3DConfig['Width'] or box3DConfig['X'] or (box3DConfig['Dimensions'] and box3DConfig['Dimensions']['X']))) or (fovWidth / 20)
    local rawH = (box3DConfig and (box3DConfig['Height'] or box3DConfig['Y'] or (box3DConfig['Dimensions'] and box3DConfig['Dimensions']['Y']))) or (fovHeight / 20)
    local rawD = (box3DConfig and (box3DConfig['Depth'] or box3DConfig['Z'] or (box3DConfig['Dimensions'] and box3DConfig['Dimensions']['Z']))) or 1.6
    local sizeX = (rawW <= 5 and rawW * 10) or rawW; local sizeY = (rawH <= 5 and rawH * 10) or rawH; local sizeZ = (rawD <= 5 and rawD * 10) or rawD; local cf = rootPart.CFrame
    local mouseLoc = UserInputService:GetMouseLocation()
    local ray = Camera:ViewportPointToRay(mouseLoc.X, mouseLoc.Y)
    local closest = ray.Origin + ray.Direction * ray.Direction:Dot(rootPart.Position - ray.Origin)
    local rel = cf:PointToObjectSpace(closest); local half = Vector3.new(sizeX / 2, sizeY / 2, sizeZ / 2)
    return math.abs(rel.X) <= half.X
        and math.abs(rel.Y) <= half.Y
        and math.abs(rel.Z) <= half.Z
end
local function IsTargetFullyVisible(targetChar, strictVisibility)
    if not targetChar then return false end
    local head = targetChar:FindFirstChild('Head')
    local hrp = targetChar:FindFirstChild('HumanoidRootPart'); local torso = targetChar:FindFirstChild('UpperTorso') or targetChar:FindFirstChild('Torso') or hrp
    if not head or not hrp then return false end
    -- 1. Target parts MUST be in front of camera (Z > 0)
    local headPos = Camera:WorldToViewportPoint(head.Position); local hrpPos = Camera:WorldToViewportPoint(hrp.Position)
    if headPos.Z <= 0 and hrpPos.Z <= 0 then return false end
    -- 2. Verify clear raycast line of sight
    if not strictVisibility then
        local checks = (getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock) or {}
        if checks['Through Walls'] == true then return true end
    end
    local camPos = Camera.CFrame.Position
    if IsBehindWall(camPos, head, targetChar) and IsBehindWall(camPos, hrp, targetChar) then return false end
    return true
end
local function getFeatureFOVConfig(featureName)
    local prey = getgenv().Prey or {}
    local visuals = prey.Visuals or {}
    local globalFov = visuals.Fov or visuals.FOV or {}
    local global3D = visuals['3D Box'] or visuals['3D FOV'] or visuals['3D'] or {}
    local fovSection = prey['FOV'] or prey['Fov'] or (visuals and (visuals['FOV'] or visuals['Fov'])); local cfg = nil
    if type(fovSection) == "table" then
        cfg = fovSection[featureName]
        if not cfg then
            if featureName == 'Silent' then
                cfg = fovSection['Silent Aim'] or fovSection['SilentAim'] or fovSection['Silent'] or (prey.Combat and prey.Combat['Silent Aim'])
            elseif featureName == 'Aimbot' then
                cfg = fovSection['Aim Assist'] or fovSection['AimAssist'] or fovSection['Aimbot'] or fovSection['Aim'] or (prey.Combat and (prey.Combat['Aim Assist'] or prey.Combat['Aimbot']))
            elseif featureName == 'Triggerbot' then
                cfg = fovSection['Trigger'] or fovSection['Triggerbot'] or (prey.Combat and prey.Combat['Triggerbot'])
            end
        end
    end
    if not cfg and prey.Combat then
        if featureName == 'Silent' then cfg = prey.Combat['Silent Aim']
        elseif featureName == 'Aimbot' then cfg = prey.Combat['Aim Assist'] or prey.Combat['AimAssist'] or prey.Combat['Aimbot']
        elseif featureName == 'Triggerbot' then cfg = prey.Combat['Triggerbot']
        end
    end
    local options = nil
    if cfg then
        options = cfg['Options'] or cfg['FOVType'] or cfg['FovType'] or cfg['FOV Mode'] or cfg['FOVMode']
        if not options and cfg['Type'] and cfg['Type'] ~= 'Toggle' and cfg['Type'] ~= 'Hold' and cfg['Type'] ~= 'Keybind' then options = cfg['Type'] end
        if not options then options = cfg['Mode'] end
    end
    if not options then options = globalFov.Type or globalFov.Options or globalFov.Mode or '2D' end
    local rawW = nil; local rawH = nil
    if cfg and cfg['Width'] ~= nil then rawW = cfg['Width'] end
    if cfg and cfg['Height'] ~= nil then rawH = cfg['Height'] end
    if rawW == nil then
        if fovSection and fovSection['Aimbot'] and fovSection['Aimbot']['Width'] ~= nil then rawW = fovSection['Aimbot']['Width']
        elseif fovSection and fovSection['Aim Assist'] and fovSection['Aim Assist']['Width'] ~= nil then rawW = fovSection['Aim Assist']['Width']
        elseif featureName == 'Aimbot' then rawW = 1
        else rawW = globalFov['Width'] or 1
        end
    end
    if rawH == nil then
        if fovSection and fovSection['Aimbot'] and fovSection['Aimbot']['Height'] ~= nil then rawH = fovSection['Aimbot']['Height']
        elseif fovSection and fovSection['Aim Assist'] and fovSection['Aim Assist']['Height'] ~= nil then rawH = fovSection['Aim Assist']['Height']
        elseif featureName == 'Aimbot' then rawH = 1
        else rawH = globalFov['Height'] or 1
        end
    end
    local w = type(rawW) == "table" and (rawW[1] or rawW['Width'] or 1) or tonumber(rawW) or 1
    local h = type(rawH) == "table" and (rawH[1] or rawH['Height'] or 1) or tonumber(rawH) or 1
    local cfg3D = (cfg and (cfg['3D Box'] or cfg['3D'])) or global3D
    local w3D = (cfg3D and (cfg3D['Width'] or cfg3D['X'])) or 2
    local h3D = (cfg3D and (cfg3D['Height'] or cfg3D['Y'])) or 2; local d3D = (cfg3D and (cfg3D['Depth'] or cfg3D['Z'])) or 2
    local vizEnabled = nil
    if cfg then
        local viz = cfg['Visualize'] or cfg['Visualization']
        if type(viz) == "table" then
            if viz['Enabled'] ~= nil then vizEnabled = (viz['Enabled'] == true)
            elseif viz['Visible'] ~= nil then vizEnabled = (viz['Visible'] == true)
            end
        elseif type(viz) == "boolean" then
            vizEnabled = viz
        end
        if vizEnabled == nil and cfg['VisualizeEnabled'] ~= nil then vizEnabled = (cfg['VisualizeEnabled'] == true) end
        if vizEnabled == nil and cfg['Visible'] ~= nil then vizEnabled = (cfg['Visible'] == true) end
        if vizEnabled == nil and cfg['Enabled'] ~= nil then vizEnabled = (cfg['Enabled'] == true) end
    end
    if vizEnabled == nil then
        if featureName == 'Silent' and prey.Combat and prey.Combat['Silent Aim'] then
            vizEnabled = (prey.Combat['Silent Aim'].Enabled == true)
        elseif featureName == 'Aimbot' and prey.Combat and (prey.Combat['Aim Assist'] or prey.Combat['Aimbot']) then
            local ab = prey.Combat['Aim Assist'] or prey.Combat['Aimbot']
            vizEnabled = (ab.Enabled == true)
        elseif featureName == 'Triggerbot' and prey.Combat and prey.Combat['Triggerbot'] then
            vizEnabled = (prey.Combat['Triggerbot'].Enabled == true)
        end
    end
    if vizEnabled == nil then
        if globalFov.Visible ~= nil then
            vizEnabled = (globalFov.Visible == true)
        elseif globalFov.Enabled ~= nil then
            vizEnabled = (globalFov.Enabled == true)
        else
            vizEnabled = true
        end
    end
    local vizColor = nil; local focusColor = nil
    if cfg then
        local viz = cfg['Visualize'] or cfg['Visualization']
        if type(viz) == "table" and viz['Color'] then vizColor = viz['Color'] end
        if cfg['Color'] then vizColor = vizColor or cfg['Color'] end
        if cfg['Focus Color'] then focusColor = cfg['Focus Color'] end
    end
    if not vizColor then
        if featureName == 'Silent' then vizColor = Color3.fromRGB(0, 230, 255)
        elseif featureName == 'Aimbot' then vizColor = Color3.fromRGB(180, 70, 255)
        elseif featureName == 'Triggerbot' then vizColor = Color3.fromRGB(255, 200, 0)
        else vizColor = globalFov.Color or Color3.fromRGB(255, 255, 255)
        end
    end
    if not focusColor or focusColor == Color3.fromRGB(255, 0, 0) or focusColor == Color3.fromRGB(255, 30, 60) then
        focusColor = globalFov['Focus Color'] or Color3.fromRGB(255, 20, 147)
    end
    return {
        Options = tostring(options), Width = w, Height = h, Width3D = w3D, Height3D = h3D, Depth3D = d3D, VisualizeEnabled = vizEnabled == true, Color = vizColor,
        FocusColor = focusColor,
    }
end
local function getFOVBoxPixelSize(cfg)
    local rawW = cfg.Width; local rawH = cfg.Height
    if type(rawW) == "table" then rawW = rawW[1] or rawW['Width'] or 1 end
    if type(rawH) == "table" then rawH = rawH[1] or rawH['Height'] or 1 end
    local numW = tonumber(rawW) or 1; local numH = tonumber(rawH) or 1
    local function calcPixel(numVal)
        if numVal <= 10 then
            return 100 + (numVal - 1) * 30
        elseif numVal <= 50 then
            return 370 + (numVal - 10) * 15
        else
            return 970 + (numVal - 50) * 4.5
        end
    end
    return calcPixel(numW), calcPixel(numH)
end
local function GetScaledDimension(numVal)
    local v = tonumber(numVal) or 1
    if v <= 0 then v = 1 end
    if v <= 10 then
        -- 1 -> 1.0 (exact fit), 10 -> 3.0x
        return 1.0 + (v - 1) * 0.222
    elseif v <= 50 then
        -- 10 -> 3.0x, 50 -> 12.0x
        return 3.0 + (v - 10) * 0.225
    else
        -- 50 -> 12.0x, 1000 -> 121.8x, 2112 -> 250.0x (MASSIVE)
        return 12.0 + (v - 50) * (238.0 / 2062)
    end
end
local function GetTarget2DBoxBounds(position, featureName, targetChar)
    if targetChar and targetChar:IsA("Player") then targetChar = targetChar.Character end
    local feat = featureName or 'Silent'; local cfg = getFeatureFOVConfig(feat); local numW = cfg.Width; local numH = cfg.Height
    if type(numW) == "table" then numW = numW[1] or 1 end
    if type(numH) == "table" then numH = numH[1] or 1 end
    local scaleW = GetScaledDimension(numW); local scaleH = GetScaledDimension(numH)
    local hrp = (targetChar and (targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso")))
    local head = (targetChar and targetChar:FindFirstChild("Head")); local rootPos = hrp and hrp.Position or position
    if not rootPos then return nil end
    local headPos = head and (head.Position + Vector3.new(0, 0.8, 0)) or (rootPos + Vector3.new(0, 2.6, 0)); local feetPos = rootPos - Vector3.new(0, 3.0, 0)
    local top2D, topVis = Camera:WorldToViewportPoint(headPos)
    local bot2D, botVis = Camera:WorldToViewportPoint(feetPos); local root2D, rootVis = Camera:WorldToViewportPoint(rootPos)
    -- Strict offscreen / behind camera guard: EVERY point MUST be in front of camera (Z > 0) and visible on viewport
    if not rootVis or not topVis or not botVis or top2D.Z <= 0 or bot2D.Z <= 0 or root2D.Z <= 0 then return nil end
    local baseHeight = math.abs(bot2D.Y - top2D.Y)
    if baseHeight < 1 then return nil end
    local baseWidth = baseHeight * 0.60
    local boxH = baseHeight * scaleH; local boxW = baseWidth * scaleW
    local scaleMultiplier = 1.0
    if scaleMultiplier ~= 1.0 then
        local deltaW = boxW * (scaleMultiplier - 1.0); local deltaH = boxH * (scaleMultiplier - 1.0)
        boxW = boxW + deltaW
        boxH = boxH + deltaH
    end
    local boxX = root2D.X - (boxW / 2); local boxY = math.min(top2D.Y, bot2D.Y) - ((boxH - baseHeight) / 2)
    return boxX, boxY, boxW, boxH
end
local function IsPointInTarget2DBox(position, pointX, pointY, featureName, targetChar)
    local boxX, boxY, boxW, boxH = GetTarget2DBoxBounds(position, featureName, targetChar)
    if not boxX then return false end
    return pointX >= boxX and pointX <= boxX + boxW
        and pointY >= boxY and pointY <= boxY + boxH
end
local function IsPointInTarget3DBox(rootPart, pointX, pointY, featureName)
    if not rootPart then return false end
    local cfg = getFeatureFOVConfig(featureName or 'Silent'); local numW = cfg.Width; local numH = cfg.Height
    if type(numW) == "table" then numW = numW[1] or 1 end
    if type(numH) == "table" then numH = numH[1] or 1 end
    local scaleW = GetScaledDimension(numW); local scaleH = GetScaledDimension(numH)
    local baseW = tonumber(cfg.Width3D) or 2; local baseH = tonumber(cfg.Height3D) or 2; local baseD = tonumber(cfg.Depth3D) or 2
    local sizeX = baseW * scaleW; local sizeY = baseH * scaleH; local sizeZ = baseD * ((scaleW + scaleH) / 2)
    local cf = rootPart.CFrame
    local ray = Camera:ViewportPointToRay(pointX, pointY)
    local closest = ray.Origin + ray.Direction * ray.Direction:Dot(rootPart.Position - ray.Origin)
    local rel = cf:PointToObjectSpace(closest); local half = Vector3.new(sizeX / 2, sizeY / 2, sizeZ / 2)
    return math.abs(rel.X) <= half.X
        and math.abs(rel.Y) <= half.Y
        and math.abs(rel.Z) <= half.Z
end
local function IsCursorInTargetBox(rootPart, evalPos, featureName)
    if not rootPart then
        if (featureName or 'Silent') == 'Silent' then Mango.Locals.IsBoxFocused = false end
        return false
    end
    local feat = featureName or 'Silent'; local cfg = getFeatureFOVConfig(feat); local fovType = cfg and cfg.Options or '2D'; local targetChar = rootPart.Parent
    if targetChar and targetChar:IsA("Player") then targetChar = targetChar.Character end
    local pos = evalPos or rootPart.Position
    local rawMouse = UserInputService:GetMouseLocation()
    local guiInset = game:GetService("GuiService"):GetGuiInset(); local mouseX = rawMouse.X - guiInset.X; local mouseY = rawMouse.Y - guiInset.Y
    local isInside = false
    if string.lower(tostring(fovType)) == '3d' then
        isInside = IsPointInTarget3DBox(rootPart, mouseX, mouseY, feat)
    else
        isInside = IsPointInTarget2DBox(pos, rawMouse.X, rawMouse.Y, feat, targetChar)
    end
    if feat == 'Silent' then
        Mango.Locals.IsBoxFocused = isInside
    elseif feat == 'Aimbot' or feat == 'Aim Assist' then
        Mango.Locals.IsAimbotBoxFocused = isInside
    end
    return isInside
end
local function FindWeaponConfig(wCfg, toolName)
    if not wCfg or not toolName then return nil end
    local clean = toolName:gsub("[%[%]]", ""):lower()
    -- 1. Direct specific gun name match (e.g. 'Double-Barrel SG', '[Shotgun]', 'Silencer')
    if wCfg[toolName] then return wCfg[toolName] end
    if wCfg[clean] then return wCfg[clean] end
    if wCfg["[" .. clean .. "]"] then return wCfg["[" .. clean .. "]"] end
    for k, v in pairs(wCfg) do
        if k ~= "Enabled" and type(k) == "string" then
            local kClean = k:gsub("[%[%]]", ""):lower()
            if kClean == clean then return v end
        end
    end
    -- 2. Weapon Class fallback ('Shotguns', 'Pistols', 'Others')
    local wClass = GetWeaponClass(toolName)
    if wCfg[wClass] then return wCfg[wClass] end
    if wCfg[wClass:lower()] then return wCfg[wClass:lower()] end
    if wCfg[string.upper(wClass)] then return wCfg[string.upper(wClass)] end
    return nil
end
local function ScaleDelayToSeconds(val, defaultCD)
    if type(val) ~= "number" then return defaultCD end
    if val >= 100 then
        -- 100 is normal game delay (turned off)
        return defaultCD
    elseif val <= 0 then
        return 0
    else
        -- 1-99 scale: 1 is lowest delay (1% of normal), 100 is normal game delay
        local scaled = (val / 100) * defaultCD
        return math.max(scaled, 0.001)
    end
end
local function GetDelayChangerConfig()
    if getgenv().Prey then
        if getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Mods'] and getgenv().Prey['Tools']['Mods']['Delay Changer'] then
            return getgenv().Prey['Tools']['Mods']['Delay Changer']
        end
        if getgenv().Prey['Delay Changer'] then return getgenv().Prey['Delay Changer'] end
        if getgenv().Prey['Modifications'] and getgenv().Prey['Modifications']['Delay Changer'] then return getgenv().Prey['Modifications']['Delay Changer'] end
    end
    return nil
end
local function GetToolFireDelay(tool, defaultCooldown)
    local defaultCD = defaultCooldown
    if tool and tool:IsA("Tool") then
        local cdObj = tool:FindFirstChild("ShootingCooldown")
        if cdObj then
            local orig = tool:GetAttribute("OriginalShootingCooldown") or cdObj.Value
            defaultCD = orig
        end
    end
    if defaultCD == nil then defaultCD = 0.3 end
    local delayCfg = GetDelayChangerConfig()
    if not delayCfg or delayCfg['Enabled'] == false then return defaultCD end
    local wCfg = delayCfg['Weapon Configs'] or delayCfg['WeaponConfigs'] or delayCfg['Weapons'] or delayCfg['Guns']
    if not wCfg or wCfg['Enabled'] == false or not tool then return defaultCD end
    local itemCfg = FindWeaponConfig(wCfg, tool.Name)
    if itemCfg then
        local rawVal = (type(itemCfg) == "table" and itemCfg['Delay']) or itemCfg
        if type(rawVal) == "number" then return ScaleDelayToSeconds(rawVal, defaultCD) end
    end
    -- If weapon not configured or Delay Changer disabled, return normal game delay
    return defaultCD
end
local CustomDelays = {}
local function ApplyDelayModification()
    local delayCfg = GetDelayChangerConfig()
    if delayCfg and delayCfg['Enabled'] == true then
        local wCfg = delayCfg['Weapon Configs'] or delayCfg['WeaponConfigs'] or delayCfg['Weapons'] or delayCfg['Guns']
        if wCfg then
            for k, v in pairs(wCfg) do
                if k ~= "Enabled" then
                    local val = (type(v) == "table" and v['Delay']) or v
                    if type(val) == "number" then CustomDelays[k] = val end
                end
            end
        end
    end
end
local function HookToolCooldown()
    local delayCfg = GetDelayChangerConfig(); local isEnabled = delayCfg and delayCfg['Enabled'] == true
    local function applyToTool(tool)
        if not tool or not tool:IsA("Tool") then return end
        local shootCooldown = tool:FindFirstChild("ShootingCooldown")
        if not shootCooldown then return end
        if not tool:GetAttribute("OriginalShootingCooldown") then
            tool:SetAttribute("OriginalShootingCooldown", shootCooldown.Value)
        end
        local orig = tool:GetAttribute("OriginalShootingCooldown") or shootCooldown.Value
        if isEnabled then
            local newDelay = GetToolFireDelay(tool, orig)
            shootCooldown.Value = math.max(newDelay, 0.001)
        else
            shootCooldown.Value = orig
        end
    end
    local char = Self.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then applyToTool(child) end
        end
    end
    local backpack = Self:FindFirstChild("Backpack")
    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then applyToTool(child) end
        end
    end
end
-- Continuous background sync loop so toggling Enabled = false or changing delays in real-time works instantly!
task.spawn(function()
    while task.wait(0.2) do
        pcall(HookToolCooldown)
    end
end)
function NormalizePreyConfig()
    for k in pairs(CustomDelays) do CustomDelays[k] = nil end
    if not getgenv().Prey['Tools'] then getgenv().Prey['Tools'] = {} end
    if not getgenv().Prey['Tools']['Mods'] then getgenv().Prey['Tools']['Mods'] = {} end
    if not getgenv().Prey['Tools']['Mods']['Delay Changer'] then
        getgenv().Prey['Tools']['Mods']['Delay Changer'] = { ['Enabled'] = true,  ['Weapon Configs'] = { ['Enabled'] = true, ['Shotguns'] = { ['Delay'] = 50, },
                ['Pistols'] = { ['Delay'] = 0, },
                ['Others'] = { ['Delay'] = 20, },
            },
        }
    end
    getgenv().Prey['Delay Changer'] = getgenv().Prey['Tools']['Mods']['Delay Changer']
    if not getgenv().Prey['Modifications'] then getgenv().Prey['Modifications'] = {} end
    getgenv().Prey['Modifications']['Delay Changer'] = getgenv().Prey['Tools']['Mods']['Delay Changer']
    ApplyDelayModification()
    HookToolCooldown()
    -- Spread Modifications (Standalone table support w/ Normal & Randomizer modes)
    if not getgenv().Prey['Spread Modifications'] then getgenv().Prey['Spread Modifications'] = {} end
    if getgenv().Prey['Spread Modifications']['Enabled'] == nil then getgenv().Prey['Spread Modifications']['Enabled'] = false end
    if getgenv().Prey['Spread Modifications']['Mode'] == nil then getgenv().Prey['Spread Modifications']['Mode'] = "Normal" end
    -- Char system normalization (Cloud Config)
    if not getgenv().Prey['Char'] then getgenv().Prey['Char'] = {} end
    if getgenv().Prey['Char']['Active'] == nil then getgenv().Prey['Char']['Active'] = true end
    local curChar = getgenv().Prey['Char']
    if curChar['TargetUser'] == nil and curChar['Target'] == nil and curChar['target'] == nil and curChar['User'] == nil then curChar['TargetUser'] = 'richoffluau' end
    if getgenv().Prey['Char']['AnimateOverride'] == nil then getgenv().Prey['Char']['AnimateOverride'] = false end
    if not getgenv().Prey['Char']['Sizing'] then getgenv().Prey['Char']['Sizing'] = {} end
    if getgenv().Prey['Char']['Sizing']['Enabled'] == nil then getgenv().Prey['Char']['Sizing']['Enabled'] = true end
    if getgenv().Prey['Char']['Sizing']['Profile'] == nil then getgenv().Prey['Char']['Sizing']['Profile'] = 'Fat' end
    if not getgenv().Prey['Char']['Cosmetics'] then getgenv().Prey['Char']['Cosmetics'] = {} end
    if getgenv().Prey['Char']['Cosmetics']['Enabled'] == nil then getgenv().Prey['Char']['Cosmetics']['Enabled'] = true end
    if getgenv().Prey['Char']['Cosmetics']['Headless'] == nil then getgenv().Prey['Char']['Cosmetics']['Headless'] = false end
    if getgenv().Prey['Char']['Cosmetics']['Korblox'] == nil then getgenv().Prey['Char']['Cosmetics']['Korblox'] = true end
    if getgenv().Prey['Char']['Cosmetics']['Remove Accessories'] == nil and getgenv().Prey['Char']['Cosmetics']['RemoveAccessories'] == nil then
        getgenv().Prey['Char']['Cosmetics']['Remove Accessories'] = false
    end
    if not getgenv().Prey.Visuals then getgenv().Prey.Visuals = {} end
    if not getgenv().Prey.Visuals.Fov then getgenv().Prey.Visuals.Fov = {} end
    if getgenv().Prey.Visuals.Fov['Focus Color'] == nil or getgenv().Prey.Visuals.Fov['Focus Color'] == Color3.fromRGB(255, 0, 0) then
        getgenv().Prey.Visuals.Fov['Focus Color'] = Color3.fromRGB(255, 20, 147)
    end
    if not getgenv().Prey.Visuals['3D Box'] then getgenv().Prey.Visuals['3D Box'] = {} end
    if getgenv().Prey.Visuals['3D Box']['Width'] == nil and getgenv().Prey.Visuals['3D Box']['X'] == nil then getgenv().Prey.Visuals['3D Box']['Width'] = 1 end
    if getgenv().Prey.Visuals['3D Box']['Height'] == nil and getgenv().Prey.Visuals['3D Box']['Y'] == nil then getgenv().Prey.Visuals['3D Box']['Height'] = 1 end
    if getgenv().Prey.Visuals['3D Box']['Depth'] == nil and getgenv().Prey.Visuals['3D Box']['Z'] == nil then getgenv().Prey.Visuals['3D Box']['Depth'] = 1.6 end
    if not getgenv().Prey.Visuals.Esp then getgenv().Prey.Visuals.Esp = {} end
    if not getgenv().Prey.Visuals.Esp.Box then getgenv().Prey.Visuals.Esp.Box = {} end
    if getgenv().Prey.Visuals.Esp.Box['Target Color'] == nil or getgenv().Prey.Visuals.Esp.Box['Target Color'] == Color3.fromRGB(255, 0, 0) then
        getgenv().Prey.Visuals.Esp.Box['Target Color'] = Color3.fromRGB(255, 20, 147)
    end
    if not getgenv().Prey.Visuals.Esp.Name then getgenv().Prey.Visuals.Esp.Name = {} end
    if getgenv().Prey.Visuals.Esp.Name['Target Color'] == nil then getgenv().Prey.Visuals.Esp.Name['Target Color'] = Color3.fromRGB(255, 0, 0) end
    if getgenv().Prey.Visuals.Esp.Name['Font'] == nil then getgenv().Prey.Visuals.Esp.Name['Font'] = Enum.Font.SourceSansBold end
    if getgenv().Prey.Visuals.Esp.Name['Size'] == nil then getgenv().Prey.Visuals.Esp.Name['Size'] = 14 end
    -- Health ESP bar (Dark Forest Green default)
    if not getgenv().Prey.Visuals.Esp.Health then getgenv().Prey.Visuals.Esp.Health = {} end
    if getgenv().Prey.Visuals.Esp.Health['Enabled'] == nil then getgenv().Prey.Visuals.Esp.Health['Enabled'] = true end
    if getgenv().Prey.Visuals.Esp.Health['Position'] == nil then getgenv().Prey.Visuals.Esp.Health['Position'] = 'Bottom' end
    if getgenv().Prey.Visuals.Esp.Health['Mode'] == nil then getgenv().Prey.Visuals.Esp.Health['Mode'] = 'Selected' end
    if getgenv().Prey.Visuals.Esp.Health['Color'] == nil and getgenv().Prey.Visuals.Esp.Health['Health Color'] == nil then
        getgenv().Prey.Visuals.Esp.Health['Color'] = Color3.fromRGB(15, 130, 40)
    end
    -- Armor ESP bar (Brighter Dark Blue default)
    if not getgenv().Prey.Visuals.Esp.Armor then getgenv().Prey.Visuals.Esp.Armor = {} end
    if getgenv().Prey.Visuals.Esp.Armor['Enabled'] == nil then getgenv().Prey.Visuals.Esp.Armor['Enabled'] = true end
    if getgenv().Prey.Visuals.Esp.Armor['Position'] == nil then getgenv().Prey.Visuals.Esp.Armor['Position'] = 'Bottom' end
    if getgenv().Prey.Visuals.Esp.Armor['Mode'] == nil then getgenv().Prey.Visuals.Esp.Armor['Mode'] = 'Selected' end
    if getgenv().Prey.Visuals.Esp.Armor['Color'] == nil and getgenv().Prey.Visuals.Esp.Armor['Armor Color'] == nil then
        getgenv().Prey.Visuals.Esp.Armor['Color'] = Color3.fromRGB(25, 90, 195)
    end
    if not getgenv().Prey['Speed Modifications'] then getgenv().Prey['Speed Modifications'] = {} end
    if getgenv().Prey['Speed Modifications']['Enabled'] == nil then getgenv().Prey['Speed Modifications']['Enabled'] = true end
    if getgenv().Prey['Speed Modifications']['Anti Slip'] == nil then getgenv().Prey['Speed Modifications']['Anti Slip'] = true end
    if not getgenv().Prey['Speed Modifications']['Speeds'] then
        getgenv().Prey['Speed Modifications']['Speeds'] = { ["Shooting"] = 0.6, ["Low health"] = 2, ["Knife"] = 0.9, ["Reloading"] = 0.6, ["Normal"] = 0.9, }
    end
    if not getgenv().Prey['Auto Armor'] then getgenv().Prey['Auto Armor'] = {} end
    if getgenv().Prey['Auto Armor']['Enabled'] == nil then getgenv().Prey['Auto Armor']['Enabled'] = true end
    if getgenv().Prey['Auto Armor']['Buy Revolver'] == nil then getgenv().Prey['Auto Armor']['Buy Revolver'] = true end
    if getgenv().Prey['Auto Armor']['Revolver Ammo Clicks'] == nil then getgenv().Prey['Auto Armor']['Revolver Ammo Clicks'] = 5 end
    if not getgenv().Prey['No Jump Cooldown'] then getgenv().Prey['No Jump Cooldown'] = {} end
    if getgenv().Prey['No Jump Cooldown']['Enabled'] == nil then
        getgenv().Prey['No Jump Cooldown']['Enabled'] = false
    end
    if not getgenv().Prey['AntiGravity'] then getgenv().Prey['AntiGravity'] = {} end
    if getgenv().Prey['AntiGravity']['Enabled'] == nil then getgenv().Prey['AntiGravity']['Enabled'] = true end
    if getgenv().Prey['AntiGravity']['Key'] == nil then getgenv().Prey['AntiGravity']['Key'] = 'J' end
    if getgenv().Prey['AntiGravity']['Float Speed'] == nil then getgenv().Prey['AntiGravity']['Float Speed'] = 15 end
    if not getgenv().Prey.Main then getgenv().Prey.Main = {} end
    if not getgenv().Prey.Main.Target then getgenv().Prey.Main.Target = {} end
    if getgenv().Prey.Main.Target.Unlock['Through Walls'] == nil then getgenv().Prey.Main.Target.Unlock['Through Walls'] = true end
    if getgenv().Prey.Main.Target.Unlock['Vehicle'] == nil and getgenv().Prey.Main.Target.Unlock['Vehicle Check'] == nil then
        getgenv().Prey.Main.Target.Unlock['Vehicle'] = true
        getgenv().Prey.Main.Target.Unlock['Vehicle Check'] = true
    end
    if not getgenv().Prey.Combat['Silent Aim'] then getgenv().Prey.Combat['Silent Aim'] = {} end
    if getgenv().Prey.Combat['Silent Aim']['Closest Point'] == nil then getgenv().Prey.Combat['Silent Aim']['Closest Point'] = false end
    if getgenv().Prey.Combat['Silent Aim']['Closest Point Scale'] == nil then getgenv().Prey.Combat['Silent Aim']['Closest Point Scale'] = 1.0 end
    if getgenv().Prey.Combat['Silent Aim']['Hit Chance'] == nil then getgenv().Prey.Combat['Silent Aim']['Hit Chance'] = 100 end
    if not getgenv().Prey.Combat['Silent Aim']['Prediction'] then getgenv().Prey.Combat['Silent Aim']['Prediction'] = {} end
    if getgenv().Prey.Combat['Silent Aim']['Prediction']['Enabled'] == nil then getgenv().Prey.Combat['Silent Aim']['Prediction']['Enabled'] = false end
    if getgenv().Prey.Combat['Silent Aim']['Prediction']['X'] == nil then getgenv().Prey.Combat['Silent Aim']['Prediction']['X'] = 0.165 end
    if getgenv().Prey.Combat['Silent Aim']['Prediction']['Y'] == nil then getgenv().Prey.Combat['Silent Aim']['Prediction']['Y'] = 0 end
    -- New Aim Assist structure normalization
    if not getgenv().Prey.Combat['Aim Assist'] then getgenv().Prey.Combat['Aim Assist'] = {} end
    if getgenv().Prey.Combat['Aim Assist']['Enabled'] == nil then getgenv().Prey.Combat['Aim Assist']['Enabled'] = true end
    if getgenv().Prey.Combat['Aim Assist']['Smoothness'] == nil then getgenv().Prey.Combat['Aim Assist']['Smoothness'] = 0.45 end
    if getgenv().Prey.Combat['Aim Assist']['Mode'] == nil then getgenv().Prey.Combat['Aim Assist']['Mode'] = 'Hold' end
    if getgenv().Prey.Combat['Aim Assist']['Shake'] == nil then
        getgenv().Prey.Combat['Aim Assist']['Shake'] = { ['Enabled'] = true, ['Amount'] = 3, }
    end
    -- New Triggerbot structure normalization
    if not getgenv().Prey.Combat['Triggerbot'] then getgenv().Prey.Combat['Triggerbot'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Use Crosshair'] == nil then getgenv().Prey.Combat['Triggerbot']['Use Crosshair'] = false end
    -- New Closest Point structure
    if not getgenv().Prey.Combat['Closest Point'] then getgenv().Prey.Combat['Closest Point'] = {} end
    if getgenv().Prey.Combat['Closest Point']['Mode'] == nil then getgenv().Prey.Combat['Closest Point']['Mode'] = 'Regular' end
    if getgenv().Prey.Combat['Closest Point']['Scale'] == nil then getgenv().Prey.Combat['Closest Point']['Scale'] = 1 end
    -- New Easing Style structure
    if not getgenv().Prey.Combat['Easing Style'] then getgenv().Prey.Combat['Easing Style'] = {} end
    if getgenv().Prey.Combat['Easing Style']['Style'] == nil then getgenv().Prey.Combat['Easing Style']['Style'] = 'Circular' end
    if getgenv().Prey.Combat['Easing Style']['Direction'] == nil then getgenv().Prey.Combat['Easing Style']['Direction'] = 'InOut' end
    -- New Triggerbot structure normalization
    if not getgenv().Prey.Combat['Triggerbot'] then getgenv().Prey.Combat['Triggerbot'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Enabled'] == nil then getgenv().Prey.Combat['Triggerbot']['Enabled'] = false end
    if getgenv().Prey.Combat['Triggerbot']['Distance'] == nil then getgenv().Prey.Combat['Triggerbot']['Distance'] = 'Auto' end
    if not getgenv().Prey.Combat['Triggerbot']['Functionality Type'] then getgenv().Prey.Combat['Triggerbot']['Functionality Type'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Functionality Type']['Mode'] == nil then getgenv().Prey.Combat['Triggerbot']['Functionality Type']['Mode'] = 'Keybind' end
    if getgenv().Prey.Combat['Triggerbot']['Functionality Type']['Type'] == nil then getgenv().Prey.Combat['Triggerbot']['Functionality Type']['Type'] = 'Toggle' end
    if not getgenv().Prey.Combat['Triggerbot']['Hit Part'] then getgenv().Prey.Combat['Triggerbot']['Hit Part'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Hit Part']['Enabled'] == nil then getgenv().Prey.Combat['Triggerbot']['Hit Part']['Enabled'] = false end
    if getgenv().Prey.Combat['Triggerbot']['Hit Part']['Part'] == nil then getgenv().Prey.Combat['Triggerbot']['Hit Part']['Part'] = 'Head' end
    if not getgenv().Prey.Combat['Triggerbot']['Prediction'] then getgenv().Prey.Combat['Triggerbot']['Prediction'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Prediction']['X'] == nil then getgenv().Prey.Combat['Triggerbot']['Prediction']['X'] = 0 end
    if getgenv().Prey.Combat['Triggerbot']['Prediction']['Y'] == nil then getgenv().Prey.Combat['Triggerbot']['Prediction']['Y'] = 0 end
    if getgenv().Prey.Combat['Triggerbot']['Prediction']['Z'] == nil then getgenv().Prey.Combat['Triggerbot']['Prediction']['Z'] = 0 end
    -- Shot Accuracy normalization ('Percentage' or 'Chance' mode)
    if not getgenv().Prey.Combat['Triggerbot']['Shot Accuracy'] then getgenv().Prey.Combat['Triggerbot']['Shot Accuracy'] = {} end
    if getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Enabled'] == nil then getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Enabled'] = false end
    if getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Mode'] == nil then getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Mode'] = 'Percentage' end
    if getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Chance'] == nil then getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Chance'] = 85 end
    if getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Scale'] == nil then getgenv().Prey.Combat['Triggerbot']['Shot Accuracy']['Scale'] = 1.0 end
    if not getgenv().Prey.Combat['Rage'] then getgenv().Prey.Combat['Rage'] = {} end
    if getgenv().Prey.Combat['Rage']['Enabled'] == nil then getgenv().Prey.Combat['Rage']['Enabled'] = false end
    if getgenv().Prey.Combat['Rage']['Smart Fire'] == nil then getgenv().Prey.Combat['Rage']['Smart Fire'] = true end
    if getgenv().Prey.Combat['Rage']['Ammo Conservation'] == nil then getgenv().Prey.Combat['Rage']['Ammo Conservation'] = true end
    if not getgenv().Prey.Combat['Rage']['Enhanced Prediction'] then getgenv().Prey.Combat['Rage']['Enhanced Prediction'] = {} end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Enabled'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Enabled'] = true end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Auto Prediction'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Auto Prediction'] = true end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['X'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['X'] = 0.165 end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Y'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Y'] = 0 end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Z'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Z'] = 0 end
    if getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Velocity Scale'] == nil then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Velocity Scale'] = 1.0 end
    if not getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Guns'] then getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Guns'] = {} end
    local rageGunPredDefaults = {
        ['[Revolver]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Double-Barrel SG]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[TacticalShotgun]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Drum-Shotgun]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Shotgun]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Silencer]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Glock]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Rifle]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[AUG]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[AR]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[SMG]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[LMG]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[P90]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[AK47]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[SilencerAR]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
        ['[Deagle]'] = { X = 0.165, Y = 0, Z = 0, ['Velocity Scale'] = 1.0 },
    }
    for gunName, defaults in pairs(rageGunPredDefaults) do
        if not getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Guns'][gunName] then
            getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Guns'][gunName] = defaults
        else
            local g = getgenv().Prey.Combat['Rage']['Enhanced Prediction']['Guns'][gunName]
            if g.X == nil then g.X = defaults.X end
            if g.Y == nil then g.Y = defaults.Y end
            if g.Z == nil then g.Z = defaults.Z end
            if g['Velocity Scale'] == nil then g['Velocity Scale'] = defaults['Velocity Scale'] end
        end
    end
    if not getgenv().Prey.Combat['Distance Check'] then getgenv().Prey.Combat['Distance Check'] = {} end
    if getgenv().Prey.Combat['Distance Check'].Enabled == nil then getgenv().Prey.Combat['Distance Check'].Enabled = true end
    if getgenv().Prey.Combat['Distance Check']['Max Distance'] == nil then getgenv().Prey.Combat['Distance Check']['Max Distance'] = 300 end
    if getgenv().Prey.Combat['Distance Check']['Universal'] == nil then getgenv().Prey.Combat['Distance Check']['Universal'] = true end
    if not getgenv().Prey.Combat['Distance Check'].Guns then getgenv().Prey.Combat['Distance Check'].Guns = {} end
    if not getgenv().Prey['Watermark'] then getgenv().Prey['Watermark'] = {} end
    if getgenv().Prey['Watermark']['Text'] == nil then getgenv().Prey['Watermark']['Text'] = 'prey.cc' end
    -- Global: Mod Detector defaults (so the detector never errors and is configurable)
    if not getgenv().Prey['Global'] then getgenv().Prey['Global'] = {} end
    if not getgenv().Prey['Global']["Mod Detector"] then getgenv().Prey['Global']["Mod Detector"] = {} end
    local md = getgenv().Prey['Global']["Mod Detector"]
    if md["Enabled"] == nil then md["Enabled"] = false end
    if md["Action"] == nil then md["Action"] = "Notify" end
    if md["Group Id"] == nil then md["Group Id"] = 17215700 end
    if md["Role"] == nil then md["Role"] = nil end
    if md["Notify Duration"] == nil then md["Notify Duration"] = 6 end
    if md["Kick Message"] == nil then md["Kick Message"] = "A moderator has joined the game!" end
    if not getgenv().Prey['Spiderman'] then getgenv().Prey['Spiderman'] = {} end
    if getgenv().Prey['Spiderman']['Require Double Jump'] == nil then getgenv().Prey['Spiderman']['Require Double Jump'] = false end
    if not getgenv().Prey['Anti Trip'] then getgenv().Prey['Anti Trip'] = {} end
    if getgenv().Prey['Anti Trip']['Enabled'] == nil then getgenv().Prey['Anti Trip']['Enabled'] = false end
    -- Future configuration table (Cider 3 Native Engine Config)
    if not getgenv().Prey['Future'] then
        getgenv().Prey['Future'] = {
            ["Enabled"] = true, ["Lure"] = true, ["Enable Both"] = true,
            ["Pistols"] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } },
            ["Shotguns"] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } },
            ["Others"] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } },
            ["[Silent Aim]"] = {
                ["Future"] = { ["Enabled"] = true, ["Lure"] = true, ["Pistols"] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } }, ["Shotguns"] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } }, ["Others"] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } } }
            },
            ["[Triggerbot]"] = {
                ["Distance"] = 230,
                ["Future"] = { ["Enabled"] = true, ["Lure"] = true, ["Pistols"] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } }, ["Shotguns"] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } }, ["Others"] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } } }
            },
        }
    else
        if getgenv().Prey['Future']['Enabled'] == nil then getgenv().Prey['Future']['Enabled'] = true end
        if getgenv().Prey['Future']['Lure'] == nil then getgenv().Prey['Future']['Lure'] = true end
        if getgenv().Prey['Future']['Enable Both'] == nil then getgenv().Prey['Future']['Enable Both'] = true end
        if not getgenv().Prey['Future']['Pistols'] then getgenv().Prey['Future']['Pistols'] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } } end
        if not getgenv().Prey['Future']['Shotguns'] then getgenv().Prey['Future']['Shotguns'] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } } end
        if not getgenv().Prey['Future']['Others'] then getgenv().Prey['Future']['Others'] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } } end
        if not getgenv().Prey['Future']['[Silent Aim]'] then
            getgenv().Prey['Future']['[Silent Aim]'] = {
                ["Future"] = { ["Enabled"] = true, ["Lure"] = true, ["Pistols"] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } }, ["Shotguns"] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } }, ["Others"] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } } }
            }
        end
        if not getgenv().Prey['Future']['[Triggerbot]'] then
            getgenv().Prey['Future']['[Triggerbot]'] = {
                ["Distance"] = 230,
                ["Future"] = { ["Enabled"] = true, ["Lure"] = true, ["Pistols"] = { ["Values"] = { ["X"] = 0.023, ["Y"] = 0.023, ["Z"] = 0.023 } }, ["Shotguns"] = { ["Values"] = { ["X"] = 0.018, ["Y"] = 0.018, ["Z"] = 0.018 } }, ["Others"] = { ["Values"] = { ["X"] = 0.013, ["Y"] = 0.013, ["Z"] = 0.013 } } }
            }
        end
    end
    if not getgenv().Prey['Tools'] then getgenv().Prey['Tools'] = {} end
    if not getgenv().Prey['Tools']['Mods'] then getgenv().Prey['Tools']['Mods'] = {} end
    if not getgenv().Prey['Tools']['Mods']['Damage Overrider'] then getgenv().Prey['Tools']['Mods']['Damage Overrider'] = {} end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Enabled == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Enabled = false end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Chance == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Chance = 100 end
    -- Legacy single-mode fallback (still supported)
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Type == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Type = 'Full' end
    -- Per-weapon-class config (cider Damage Modifier system)
    if not getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons = {} end
    if not getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns then
        getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns = { Enabled = true, Mode = 'half' }
    end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns.Enabled == nil then
        getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns.Enabled = true
    end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns.Mode == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Shotguns.Mode = 'half' end
    if not getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols then
        getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols = { Enabled = true, Mode = 'full' }
    end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols.Enabled == nil then
        getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols.Enabled = true
    end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols.Mode == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Pistols.Mode = 'full' end
    if not getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others then
        getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others = { Enabled = true, Mode = 'full' }
    end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others.Enabled == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others.Enabled = true end
    if getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others.Mode == nil then getgenv().Prey['Tools']['Mods']['Damage Overrider'].Weapons.Others.Mode = 'full' end
    if not getgenv().Prey['Tools']['Visual Mods'] then getgenv().Prey['Tools']['Visual Mods'] = {} end
    if not getgenv().Prey['Tools']['Visual Mods']['tracers'] then getgenv().Prey['Tools']['Visual Mods']['tracers'] = {} end
    if not getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color'] then getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color'] = {} end
    if getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color']['Enabled'] == nil then getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color']['Enabled'] = false end
    if not getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color']['Guns'] then getgenv().Prey['Tools']['Visual Mods']['tracers']['Beam Color']['Guns'] = {} end
    if not getgenv().Prey['Animation'] then getgenv().Prey['Animation'] = {} end
    if getgenv().Prey['Animation']['Enabled'] == nil then getgenv().Prey['Animation']['Enabled'] = false end
    if getgenv().Prey['Animation']['Mode'] == nil then getgenv().Prey['Animation']['Mode'] = 'HybridCustom' end
    if getgenv().Prey['Animation']['ChosenBundleName'] == nil then getgenv().Prey['Animation']['ChosenBundleName'] = 'Default' end
    if not getgenv().Prey['Animation']['HybridSettings'] then getgenv().Prey['Animation']['HybridSettings'] = {} end
    if not getgenv().Prey['Panic Ground'] then getgenv().Prey['Panic Ground'] = {} end
    if getgenv().Prey['Panic Ground']['Enabled'] == nil then getgenv().Prey['Panic Ground']['Enabled'] = false end
    if getgenv().Prey['Panic Ground']['Key'] == nil then
        getgenv().Prey['Panic Ground']['Key'] = (getgenv().Prey.Main and getgenv().Prey.Main.Keybind and getgenv().Prey.Main.Keybind['Panic Ground']) or 'Y'
    end
    if getgenv().Prey['Panic Ground']['Mode'] == nil then getgenv().Prey['Panic Ground']['Mode'] = 'Instant' end
    if getgenv().Prey['Panic Ground']['Smooth Speed'] == nil then getgenv().Prey['Panic Ground']['Smooth Speed'] = 400 end
    if getgenv().Prey['Panic Ground']['Preserve Velocity'] == nil then getgenv().Prey['Panic Ground']['Preserve Velocity'] = true end
    if not getgenv().Prey['Inventory Sorter'] then getgenv().Prey['Inventory Sorter'] = {} end
    if getgenv().Prey['Inventory Sorter']['Enabled'] == nil then getgenv().Prey['Inventory Sorter']['Enabled'] = false end
    if not getgenv().Prey['Inventory Sorter']['Order'] then getgenv().Prey['Inventory Sorter']['Order'] = { '[Revolver]', '[Double-Barrel SG]', '[TacticalShotgun]', '[Knife]' } end
    if not getgenv().Prey.Combat['Universal Ammo Conservation'] then getgenv().Prey.Combat['Universal Ammo Conservation'] = {} end
    if getgenv().Prey.Combat['Universal Ammo Conservation']['Enabled'] == nil then getgenv().Prey.Combat['Universal Ammo Conservation']['Enabled'] = false end
    if not getgenv().Prey['Tools']['Skin Changer'] then getgenv().Prey['Tools']['Skin Changer'] = {} end
    if getgenv().Prey['Tools']['Skin Changer']['enabled'] == nil then getgenv().Prey['Tools']['Skin Changer']['enabled'] = true end
    if not getgenv().Prey['Tools']['Skin Changer']['Skins'] then getgenv().Prey['Tools']['Skin Changer']['Skins'] = {} end
    if not getgenv().Prey['Tools']['Hood Customs'] then getgenv().Prey['Tools']['Hood Customs'] = {} end
    if not getgenv().Prey['Tools']['Hood Customs']['skins'] then getgenv().Prey['Tools']['Hood Customs']['skins'] = {} end
    if not getgenv().Prey['Tools']['Hood Customs']['Bullet Beams'] then getgenv().Prey['Tools']['Hood Customs']['Bullet Beams'] = {} end
    if not getgenv().Prey.Main.Keybind then getgenv().Prey.Main.Keybind = {} end
end
-- Damage Overrider: now handled by DamageModifierLib defined earlier (per-weapon-class support)
-- The ApplyDamageOverride function is defined once above the LPH_OBFUSCATED block.
-- Avatar Morph Functions
local morphBusy, morphLast, morphLastDesc = false, 0, nil; local savedSizes = nil; local savedMotorData = nil; local hasInitialMorph = false
local isMorphing = false
local BODY_PARTS = {
    "Head","UpperTorso","LowerTorso", "LeftUpperArm","LeftLowerArm","LeftHand", "RightUpperArm","RightLowerArm","RightHand", "LeftUpperLeg","LeftLowerLeg","LeftFoot",
    "RightUpperLeg","RightLowerLeg","RightFoot"
}
local MOTOR_NAMES = {
    "Neck", "Waist", "Root", "LeftShoulder", "LeftElbow", "LeftWrist", "RightShoulder", "RightElbow", "RightWrist", "LeftHip", "LeftKnee", "LeftAnkle",
    "RightHip", "RightKnee", "RightAnkle"
}
local function morphPing(m)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="Avatar Morph",Text=m,Duration=4}) end)
end
local function morphStrip(char)
    local tools, bp = {}, Self:FindFirstChild("Backpack")
    for _, c in char:GetChildren() do
        if c:IsA("Tool") then c.Parent = nil; table.insert(tools, c) end
    end
    for _, c in char:GetChildren() do
        if c:IsA("Accessory") or c:IsA("Hat") or c:IsA("Shirt") or c:IsA("Pants")
        or c:IsA("ShirtGraphic") or c:IsA("BodyColors") or c:IsA("CharacterMesh") then
            c:Destroy()
        end
    end
    for _, t in tools do t.Parent = bp or char end
end
local function saveMotorData(char)
    local data = {}
    for _, name in ipairs(MOTOR_NAMES) do
        local motor = char:FindFirstChild(name, true)
        if motor and motor:IsA("Motor6D") then
            data[name] = { C0 = motor.C0, C1 = motor.C1, }
        end
    end
    return data
end
local function restoreMotorData(char, motorData)
    if not motorData then return end
    for _, name in ipairs(MOTOR_NAMES) do
        local info = motorData[name]
        if info then
            local motor = char:FindFirstChild(name, true)
            if motor and motor:IsA("Motor6D") then
                pcall(function()
                    motor.C0 = info.C0
                    motor.C1 = info.C1
                end)
            end
        end
    end
end
local function saveBodySizes(char)
    local sizes = {}
    for _, name in ipairs(BODY_PARTS) do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") then sizes[name] = p.Size end
    end
    return sizes
end
local function restoreBodySizes(char, sizes)
    if not sizes then return end
    for _, name in ipairs(BODY_PARTS) do
        -- Skip Head to preserve target user's head size from description
        if name == "Head" then continue end
        local p = char:FindFirstChild(name)
        if p and sizes[name] then
            pcall(function() p.Size = sizes[name] end) end end
end
-- Forward declaration for applyExtras (defined later but used in morphApplyMorph)
local applyExtras
local function morphApplyMorph(char, desc, isRespawn)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    isMorphing = true
    -- ONLY save sizes on FIRST morph (when you're already slim)
    -- On respawn, Da Hood gives you blocky body — DON'T save that
    if not hasInitialMorph then
        savedSizes = saveBodySizes(char)
        savedMotorData = saveMotorData(char)
        hasInitialMorph = true
        morphPing("Body shape locked!")
    end
    morphStrip(char)
    -- Apply description (rebuilds character)
    -- Zero body package IDs but keep Head to copy target's face
    desc.Torso = 0
    desc.LeftArm = 0
    desc.RightArm = 0
    desc.LeftLeg = 0
    desc.RightLeg = 0
    -- Keep Head to copy target user's face
    pcall(function()
        if hum.ApplyDescriptionClientServer then hum:ApplyDescriptionClientServer(desc) else hum:ApplyDescription(desc) end
    end)
    -- Guard: returns true if this char is still the LIVE character.
    -- Prevents delayed callbacks from running on a dead/old ragdoll.
    local function charStillValid() return char.Parent ~= nil and Self.Character == char end
    -- Wait for head to be created after description, then apply headless
    task.delay(0.2, function()
        if not charStillValid() then return end
        applyExtras(char)
    end)
    -- Restore everything AFTER rebuild
    task.delay(0.4, function()
        if not charStillValid() then return end
        -- Restore sizes FIRST
        restoreBodySizes(char, savedSizes)
        -- Then restore joints
        restoreMotorData(char, savedMotorData)
        -- Fix colors
        local bc = char:FindFirstChildOfClass("BodyColors")
        if not bc then bc = Instance.new("BodyColors"); bc.Parent = char end
        pcall(function()
            bc.HeadColor3    = desc.HeadColor
            bc.TorsoColor3   = desc.TorsoColor
            bc.LeftArmColor3 = desc.LeftArmColor; bc.RightArmColor3 = desc.RightArmColor
            bc.LeftLegColor3 = desc.LeftLegColor; bc.RightLegColor3 = desc.RightLegColor
        end)
        -- Keep restoring to fight Da Hood's server scripts
        task.delay(0.5, function()
            if not charStillValid() then return end
            restoreBodySizes(char, savedSizes)
            restoreMotorData(char, savedMotorData)
            applyExtras(char)
        end)
        task.delay(1.0, function()
            if not charStillValid() then return end
            restoreBodySizes(char, savedSizes)
            restoreMotorData(char, savedMotorData)
            applyExtras(char)
        end)
        task.delay(2.0, function()
            if not charStillValid() then return end
            restoreBodySizes(char, savedSizes)
            restoreMotorData(char, savedMotorData)
            isMorphing = false
            applyExtras(char)
            -- Continuously re-apply extras to fight description overrides
            task.spawn(function()
                for i = 1, 10 do
                    if not charStillValid() then break end
                    task.wait(0.5)
                    applyExtras(char)
                end
            end)
        end)
    end)
end
local function morphFunction(char_override)
    local prey = getgenv().Prey; local charCfg = prey and prey['Char']
    if charCfg and (charCfg['Active'] == false or charCfg['Enabled'] == false) then return end
    local avatarCfg = prey and prey['Avatar']
    if not avatarCfg or not avatarCfg.Enabled then return end
    if morphBusy then return end
    local char = char_override or Self.Character; local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hum or not char:FindFirstChild("HumanoidRootPart") then morphPing("Character not ready") return end
    morphBusy = true
    local user = avatarCfg.User or ""
    if user == "" then morphBusy=false morphPing("No username set") return end
    local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(user) end)
    if not ok or not id then morphBusy=false morphPing("Bad username") return end
    morphPing("Loading "..user.."...")
    local ok2, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(id) end)
    if not ok2 or not desc then morphBusy=false morphPing("Failed to load desc") return end
    -- Zero body package IDs but keep Head to copy target's face
    desc.Torso = 0
    desc.LeftArm = 0
    desc.RightArm = 0
    desc.LeftLeg = 0
    desc.RightLeg = 0
    -- Keep Head to copy target user's face
    morphLastDesc = desc
    morphApplyMorph(char, desc, false)
    morphLast = tick()
    morphBusy = false
    morphPing("Morphed to "..user.."!")
end
-- Allowed guns helper: checks if a gun is whitelisted for a feature
function IsGunAllowed(category, feature, gunName)
    local allowed = getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Allowed
    if not allowed then return true end
    local cat = allowed[category]
    if not cat then return true end
    local feat = cat[feature]
    if not feat then return true end
    if type(feat) == 'table' then
        for _, name in ipairs(feat) do
            if name == gunName then return true end
        end
        return false
    end
    return true
end
-- Distance Check helper: returns false if target is beyond configured max distance
function IsWithinDistance(Target)
    if not Target or not Target.Character then return false end
    local dcCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Distance Check']
    if not dcCfg or not dcCfg.Enabled then return true end
    local targetHRP = Target.Character:FindFirstChild('HumanoidRootPart')
    local localChar = Self and Self.Character; local localHRP = localChar and localChar:FindFirstChild('HumanoidRootPart')
    if not targetHRP or not localHRP then return false end
    local dist = (targetHRP.Position - localHRP.Position).Magnitude; local useUniversal = dcCfg['Universal'] == true
    if useUniversal then
        local maxDist = dcCfg['Max Distance'] or 300
        return dist <= maxDist
    else
        local tool = localChar and localChar:FindFirstChildOfClass('Tool')
        if tool and dcCfg.Guns then
            local gunMax = dcCfg.Guns[tool.Name]
            if gunMax then return dist <= gunMax end
        end
    end
    return true
end
-- Apply delay modification after config is loaded
task.delay(2, function()
    ApplyDelayModification()
    -- Hook when character spawns/equips tools
    local function watchContainer(container)
        if not container then return end
        container.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                if isMorphing then return end
                task.wait(0.05)
                HookToolCooldown()
            end
        end)
    end
    Self.CharacterAdded:Connect(function(char)
        watchContainer(char)
        HookToolCooldown()
    end)
    local bp = Self:FindFirstChild("Backpack")
    if bp then watchContainer(bp) end
    Self.ChildAdded:Connect(function(child)
        if child:IsA("Backpack") then watchContainer(child) end
    end)
    if Self.Character then
        watchContainer(Self.Character)
        HookToolCooldown()
    end
    -- Avatar Morph CharacterAdded connection
    Self.CharacterAdded:Connect(function(char)
        local prey = getgenv().Prey; local charCfg = prey and prey['Char']
        if charCfg and (charCfg['Active'] == false or charCfg['Enabled'] == false) then return end
        local avatarCfg = prey and prey['Avatar']
        if not avatarCfg or not avatarCfg.Enabled then return end
        if not morphLastDesc then return end
        local hum = char:WaitForChild("Humanoid", 10)
        char:WaitForChild("HumanoidRootPart", 10)
        if not hum then return end
        -- Wait for Da Hood to finish spawn (forcefield gone)
        local ff = char:FindFirstChildOfClass("ForceField"); local waited = 0
        while ff and waited < 10 do
            task.wait(0.2)
            waited = waited + 0.2
            ff = char:FindFirstChildOfClass("ForceField")
        end
        task.wait(0.5)
        if not char.Parent then return end
        morphPing("Re-applying after respawn...")
        morphApplyMorph(char, morphLastDesc, true)
    end)
    -- Auto-morph on load if enabled
    local avatarCfg = getgenv().Prey and getgenv().Prey['Avatar']; local charCfg = getgenv().Prey and getgenv().Prey['Char']
    if not (charCfg and (charCfg['Active'] == false or charCfg['Enabled'] == false)) and avatarCfg and avatarCfg.Enabled and avatarCfg.User and avatarCfg.User ~= "" then
        task.defer(function()
            while not Self.Character do task.wait(0.1) end
            local char = Self.Character; local hum = char:WaitForChild("Humanoid", 10)
            if not hum then return end
            -- Wait for Da Hood spawn complete
            local ff = char:FindFirstChildOfClass("ForceField"); local waited = 0
            while ff and waited < 10 do
                task.wait(0.2)
                waited = waited + 0.2
                ff = char:FindFirstChildOfClass("ForceField")
            end
            task.wait(0.5)
            morphFunction(char)
        end)
        morphPing("Morph loaded")
    end
    -- Monitor Avatar.User changes for instant re-morph
    task.spawn(function()
        local lastUser = ""
        while true do
            task.wait(0.5)
            local prey = getgenv().Prey; local charCfg = prey and prey['Char']; local avatarCfg = prey and prey['Avatar']
            if not (charCfg and (charCfg['Active'] == false or charCfg['Enabled'] == false)) and avatarCfg and avatarCfg.Enabled then
                local currentUser = avatarCfg.User or ""
                if currentUser ~= "" and currentUser ~= lastUser then
                    lastUser = currentUser
                    if Self.Character then morphFunction(Self.Character) end
                end
            end
        end
    end)
end)
-- Global DaHoodMorph function for external use
getgenv().DaHoodMorph = morphFunction
local Games = {
    [1008451066] = {
        Name = 'Da Hood', Updater = 'UpdateMousePosI2', HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                --
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    },
    [8916384194] = {
        Name = 'Dee Hood', Updater = nil, HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                --
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    },
    [86479609106716] = {
        Name = 'Das Hood', Updater = "UpdateMousePos", HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                --
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainRemotes.MainRemoteEvent end
        }
    },
    [9131407049] = {
        Name = 'Zee Hood', Updater = "DEAHOODMOUSEPOSx3^3", HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                --
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainRemotes.MainRemoteEvent end
        }
    },
    [8261267092] = {
        Name = 'Zea Hood', Updater = "DEAHOODMOUSEPOSx3^3", HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                --
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    },
    [9827820682] = {
        Name = 'Hood Customs', Updater = 'MousePosUpdate', HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    },
    [9825515356] = {
        Name = 'Hood Customs', Updater = 'MousePosUpdate', HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if (Player) and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then
                    if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil then return true else return false end
                else
                    return false
                end
            end,
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    },
}
--[[
if not Games[game.GameId] then
    while true do end
end]]
local CurrentGame
if Games[game.PlaceId] then
    CurrentGame = Games[game.PlaceId]
elseif Games[game.GameId] then
    CurrentGame = Games[game.GameId]
else
    -- Fallback for Hood-like games if not detected
    CurrentGame = {
        Name = 'Unknown Hood', Updater = 'UpdateMousePosI2', HoodGame = true,
        Functions = {
            RemotePath = function() return game.ReplicatedStorage.MainEvent end
        }
    }
end
local function DetectHoodCustoms()
    if CurrentGame and CurrentGame.Name == "Hood Customs" then return true end
    if game.PlaceId == 9825515356 or game.GameId == 9825515356 then return true end
    if game.PlaceId == 9827820682 or game.GameId == 9827820682 then return true end
    return ReplicatedStorage:FindFirstChild("Wraps") ~= nil
end
if DetectHoodCustoms() and CurrentGame.Name ~= "Hood Customs" then
    CurrentGame = Games[9825515356] or Games[9827820682] or {
        Name = 'Hood Customs', Updater = 'MousePosUpdate', HoodGame = true,
        Functions = {
            KnockedFunction = function(Player)
                if Player and Player.Character and Player.Character:FindFirstChild('BodyEffects') then return Player.Character.BodyEffects['K.O'].Value end
                return false
            end,
            GrabbedFunction = function(Player)
                if Player and Player.Character then return Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil end
                return false
            end,
            RemotePath = function() return ReplicatedStorage.MainEvent end,
        },
    }
end
local function IsHoodCustoms() return CurrentGame and CurrentGame.Name == "Hood Customs" end
(function()
    do
        do
            local CustomLibIndex = 0
            local Clamp = math.clamp
            local UtilityUI = Instance.new('ScreenGui'); UtilityUI.Parent = game:GetService("CoreGui"); UtilityUI.IgnoreGuiInset = true
            local UserInputService = game:GetService("UserInputService"); local MRandom = math.random; local Floor = math.floor; local Round = math.round
            local Clamp = math.clamp; local Acos = math.acos; local Atan2 = math.atan2; local Huge = math.huge
            local Sqrt = math.sqrt; local Ceil = math.ceil; local Cos = math.cos; local Abs = math.abs
            local Sin = math.sin; local Rad = math.rad; local Max = math.max; local Min = math.min
            local Deg = math.deg; local Pi = math.pi
            local LibraryMeta = setmetatable({
                Visible = true, ZIndex = 0, Transparency = 1, Color = Color3.new(),
                Remove = function(self) setmetatable(self, nil) end,
                Destroy = function(self) setmetatable(self, nil) end
            }, {
                __add = function(t1, t2)
                    local result = table.clone(t1)
                    for index, value in t2 do
                        result[index] = value
                    end
                    return result
                end
            })
            --
            local function ClampTransparency(number) return Clamp(1 - number, 0, 1) end
            --
            function Overlay.new(ClassType)
                CustomLibIndex += 1
                if ClassType == 'Line' then
                    local LineObject = ({
                        From = Vector2.zero, To = Vector2.zero,
                        Thickness = 1
                    } + LibraryMeta)
                    --
                    local Line = Instance.new('Frame')
                    --
                    Line.Name = CustomLibIndex
                    Line.AnchorPoint = (Vector2.one * .5)
                    Line.BorderSizePixel = 0
                    Line.BackgroundColor3 = LineObject.Color
                    Line.Visible = LineObject.Visible
                    Line.ZIndex = LineObject.ZIndex
                    Line.BackgroundTransparency = ClampTransparency(LineObject.Transparency)
                    Line.Size = UDim2.new()
                    Line.Parent = UtilityUI
                    --
                    return setmetatable(table.create(0), {
                        __newindex = function(_, Property, Value)
                            if Property == 'From' then
                                local Direction = (LineObject.To - Value)
                                local Center = (LineObject.To + Value) / 2; local Magnitude = Direction.Magnitude; local Theta = Deg(Atan2(Direction.Y, Direction.X))
                                --
                                Line.Position = UDim2.fromOffset(Center.X, Center.Y)
                                Line.Rotation = Theta
                                Line.Size = UDim2.fromOffset(Magnitude, LineObject.Thickness)
                            elseif Property == 'To' then
                                local Direction = (Value - LineObject.From)
                                local Center = (Value + LineObject.From) / 2; local Magnitude = Direction.Magnitude; local Theta = Deg(Atan2(Direction.Y, Direction.X))
                                --
                                Line.Position = UDim2.fromOffset(Center.X, Center.Y)
                                Line.Rotation = Theta
                                Line.Size = UDim2.fromOffset(Magnitude, LineObject.Thickness)
                            elseif Property == 'Thickness' then
                                local Thickness = (LineObject.To - LineObject.From).Magnitude
                                Line.Size = UDim2.fromOffset(Thickness, Value)
                            elseif Property == 'Visible' then
                                Line.Visible = Value
                            elseif Property == 'ZIndex' then
                                Line.ZIndex = Value
                            elseif Property == 'Transparency' then
                                Line.BackgroundTransparency = ClampTransparency(Value)
                            elseif Property == 'Color' then
                                Line.BackgroundColor3 = Value
                            end
                            LineObject[Property] = Value
                        end,
                        __index = function(self, index)
                            if index == 'Remove' or index == 'Destroy' then
                                return function()
                                    Line:Destroy()
                                    LineObject.Remove(self)
                                    return LineObject:Remove()
                                end
                            end
                            return LineObject[index]
                        end,
                        __tostring = function() return 'CustomLib' end
                    })
                elseif ClassType == 'Square' then
                    local squareObj = ({
                        Size = Vector2.zero, Position = Vector2.zero, Thickness = .7, Filled = false, Drag = false,
                    } + LibraryMeta)
                    local squareFrame, uiStroke = Instance.new('Frame'), Instance.new('UIStroke')
                    squareFrame.Name = CustomLibIndex
                    squareFrame.BorderSizePixel = 0
                    local transparency
                    if squareObj.Filled then transparency = ClampTransparency(squareObj.Transparency) else transparency = 1 end
                    squareFrame.BackgroundTransparency = transparency
                    squareFrame.ZIndex = squareObj.ZIndex
                    squareFrame.BackgroundColor3 = squareObj.Color
                    squareFrame.Visible = squareObj.Visible
                    uiStroke.Thickness = squareObj.Thickness
                    uiStroke.Enabled = not squareObj.Filled
                    uiStroke.LineJoinMode = Enum.LineJoinMode.Miter
                    squareFrame.Parent, uiStroke.Parent = UtilityUI, squareFrame
                    local dragging = false; local dragStart = nil; local startPos = nil
                    squareFrame.MouseEnter:Connect(function()
                        if squareObj.Drag then
                            local inputConnection
                            inputConnection = UserInputService.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    dragging = true
                                    dragStart = input.Position
                                    startPos = squareFrame.Position
                                end
                            end)
                            local leaveConnection
                            leaveConnection = squareFrame.MouseLeave:Connect(function()
                                inputConnection:Disconnect()
                                leaveConnection:Disconnect()
                            end)
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if squareObj.Drag then
                            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                local delta = input.Position - dragStart; local newX = startPos.X.Offset + delta.X; local newY = startPos.Y.Offset + delta.Y
                                squareFrame.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                            end
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if squareObj.Drag then
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                        end
                    end)
                    return setmetatable(table.create(0), {
                        __newindex = function(_, index, value)
                            if typeof(squareObj[index]) == 'nil' then return end
                            if index == 'Size' then
                                squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Position' then
                                squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Thickness' then
                                value = Clamp(value, 0.6, 0x7fffffff)
                                uiStroke.Thickness = value
                            elseif index == 'Filled' then
                                if value then squareFrame.BackgroundTransparency = ClampTransparency(squareObj.Transparency) else squareFrame.BackgroundTransparency = 1 end
                                uiStroke.Enabled = not value
                            elseif index == 'Visible' then
                                squareFrame.Visible = value
                            elseif index == 'ZIndex' then
                                squareFrame.ZIndex = value
                            elseif index == 'Transparency' then
                                local transparency = ClampTransparency(value)
                                if squareObj.Filled then squareFrame.BackgroundTransparency = transparency else squareFrame.BackgroundTransparency = 1 end
                                uiStroke.Transparency = transparency
                            elseif index == 'Color' then
                                uiStroke.Color = value
                                squareFrame.BackgroundColor3 = value
                            end
                            squareObj[index] = value
                        end,
                        __index = function(self, index)
                            if index == 'Remove' or index == 'Destroy' then
                                return function()
                                    squareFrame:Destroy()
                                    squareObj.Remove(self)
                                    return squareObj:Remove()
                                end
                            end
                            return squareObj[index]
                        end,
                        __tostring = function() return 'CustomLib' end
                    })
                elseif ClassType == 'Text' then
                    local textObj = ({
                        Text = '', Font = Enum.Font.SourceSansBold, Size = 0, Position = Vector2.zero, Center = false, Outline = false,
                        OutlineColor = Color3.new()
                    } + LibraryMeta)
                    local textLabel, uiStroke = Instance.new('TextLabel'), Instance.new('UIStroke')
                    textLabel.Name = CustomLibIndex
                    textLabel.AnchorPoint = (Vector2.one * .5)
                    textLabel.BorderSizePixel = 0
                    textLabel.BackgroundTransparency = 1
                    textLabel.RichText = true
                    textLabel.Visible = textObj.Visible
                    textLabel.TextColor3 = textObj.Color
                    textLabel.TextTransparency = ClampTransparency(textObj.Transparency)
                    textLabel.ZIndex = textObj.ZIndex
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextSize = textObj.Size
                    textLabel:GetPropertyChangedSignal('TextBounds'):Connect(function()
                        local textBounds = textLabel.TextBounds; local offset = textBounds / 2
                        local offsetX
                        if not textObj.Center then offsetX = offset.X else offsetX = 0 end
                        textLabel.Position = UDim2.fromOffset(textObj.Position.X + offsetX, textObj.Position.Y + offset.Y)
                    end)
                    uiStroke.Thickness = 1
                    uiStroke.Enabled = textObj.Outline
                    uiStroke.Color = textObj.Color
                    textLabel.Parent, uiStroke.Parent = UtilityUI, textLabel
                    return setmetatable(table.create(0), {
                        __newindex = function(_, index, value)
                            if typeof(textObj[index]) == 'nil' then return end
                            if index == 'Text' then
                                textLabel.Text = value
                            elseif index == 'Font' then
                                if typeof(value) == 'EnumItem' then textLabel.Font = value end
                            elseif index == 'Size' then
                                textLabel.TextSize = value
                            elseif index == 'Position' then
                                local offset = textLabel.TextBounds / 2
                                local offsetX
                                if not textObj.Center then offsetX = offset.X else offsetX = 0 end
                                textLabel.Position = UDim2.fromOffset(textObj.Position.X + offsetX, textObj.Position.Y + offset.Y)
                            elseif index == 'Center' then
                                local position
                                if value then position = workspace.CurrentCamera.ViewportSize / 2 else position = textObj.Position end
                                textLabel.Position = UDim2.fromOffset(position.X, position.Y)
                            elseif index == 'Outline' then
                                uiStroke.Enabled = value
                            elseif index == 'OutlineColor' then
                                uiStroke.Color = value
                            elseif index == 'Visible' then
                                textLabel.Visible = value
                            elseif index == 'ZIndex' then
                                textLabel.ZIndex = value
                            elseif index == 'Transparency' then
                                local transparency = ClampTransparency(value)
                                textLabel.TextTransparency = transparency
                                uiStroke.Transparency = transparency
                            elseif index == 'Color' then
                                textLabel.TextColor3 = value
                            end
                            textObj[index] = value
                        end,
                        __index = function(self, index)
                            if index == 'Remove' or index == 'Destroy' then
                                return function()
                                    textLabel:Destroy()
                                    textObj.Remove(self)
                                    return textObj:Remove()
                                end
                            elseif index == 'TextBounds' then
                                return textLabel.TextBounds
                            end
                            return textObj[index]
                        end,
                        __tostring = function() return 'CustomLib' end
                    })
                elseif ClassType == 'Image' then
                    local imageObj = ({
                        Data = '', DataURL = 'rbxassetid:/', Size = Vector2.zero,
                        Position = Vector2.zero
                    } + LibraryMeta)
                    local imageFrame = Instance.new('ImageLabel')
                    imageFrame.Name = CustomLibIndex
                    imageFrame.BorderSizePixel = 0
                    imageFrame.ScaleType = Enum.ScaleType.Stretch
                    imageFrame.BackgroundTransparency = 1
                    imageFrame.Visible = imageObj.Visible
                    imageFrame.ZIndex = imageObj.ZIndex
                    imageFrame.ImageTransparency = ClampTransparency(imageObj.Transparency)
                    imageFrame.ImageColor3 = imageObj.Color
                    imageFrame.Parent = UtilityUI
                    return setmetatable(table.create(0), {
                        __newindex = function(_, index, value)
                            if typeof(imageObj[index]) == 'nil' then return end
                            if index == 'Data' then
                                -- later
                            elseif index == 'DataURL' then
                                imageFrame.Image = value
                            elseif index == 'Size' then
                                imageFrame.Size = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Position' then
                                imageFrame.Position = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Visible' then
                                imageFrame.Visible = value
                            elseif index == 'ZIndex' then
                                imageFrame.ZIndex = value
                            elseif index == 'Transparency' then
                                imageFrame.ImageTransparency = ClampTransparency(value)
                            elseif index == 'Color' then
                                imageFrame.ImageColor3 = value
                            end
                            imageObj[index] = value
                        end,
                        __index = function(self, index)
                            if index == 'Remove' or index == 'Destroy' then
                                return function()
                                    imageFrame:Destroy()
                                    imageObj.Remove(self)
                                    return imageObj:Remove()
                                end
                            elseif index == 'Data' then
                                return nil
                            end
                            return imageObj[index]
                        end,
                        __tostring = function() return 'CustomLib' end
                    })
                elseif ClassType == 'Circle' then
                    local circleObj = ({
                        Size = Vector2.zero, Position = Vector2.zero, Thickness = 1, Filled = false,
                    } + LibraryMeta)
                    local circleFrame = Instance.new('Frame'); local uiStroke = Instance.new('UIStroke'); local uiCorner = Instance.new('UICorner')
                    circleFrame.Name = CustomLibIndex
                    circleFrame.BorderSizePixel = 0
                    circleFrame.BackgroundTransparency = 1
                    circleFrame.ZIndex = circleObj.ZIndex
                    circleFrame.Visible = circleObj.Visible
                    uiStroke.Thickness = circleObj.Thickness
                    uiStroke.Enabled = not circleObj.Filled
                    uiStroke.Color = circleObj.Color
                    uiStroke.Transparency = ClampTransparency(circleObj.Transparency)
                    uiCorner.CornerRadius = UDim.new(1, 0)
                    circleFrame.Parent = UtilityUI
                    uiStroke.Parent = circleFrame
                    uiCorner.Parent = circleFrame
                    return setmetatable(table.create(0), {
                        __newindex = function(_, index, value)
                            if typeof(circleObj[index]) == 'nil' then return end
                            if index == 'Size' then
                                circleFrame.Size = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Position' then
                                circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
                            elseif index == 'Thickness' then
                                uiStroke.Thickness = value
                            elseif index == 'Filled' then
                                circleFrame.BackgroundTransparency = value and ClampTransparency(circleObj.Transparency) or 1
                                uiStroke.Enabled = not value
                            elseif index == 'Visible' then
                                circleFrame.Visible = value
                            elseif index == 'ZIndex' then
                                circleFrame.ZIndex = value
                            elseif index == 'Transparency' then
                                local transparency = ClampTransparency(value)
                                if circleObj.Filled then circleFrame.BackgroundTransparency = transparency end
                                uiStroke.Transparency = transparency
                            elseif index == 'Color' then
                                uiStroke.Color = value
                                circleFrame.BackgroundColor3 = value
                            end
                            circleObj[index] = value
                        end,
                        __index = function(self, index)
                            if index == 'Remove' or index == 'Destroy' then
                                return function()
                                    circleFrame:Destroy()
                                    circleObj.Remove(self)
                                    return circleObj:Remove()
                                end
                            end
                            return circleObj[index]
                        end,
                        __tostring = function() return 'CustomLib' end
                    })
                end
            end
            if not Mango.Visuals.BoxFOV then
                local fovFrame = Instance.new('Frame')
                fovFrame.Name = 'BoxFOV'
                fovFrame.BorderSizePixel = 0
                fovFrame.BackgroundTransparency = 1
                fovFrame.Parent = UtilityUI
                local uiStroke = Instance.new('UIStroke')
                uiStroke.Thickness = 1
                uiStroke.Parent = fovFrame
                Mango.Visuals.BoxFOV = { _frame = fovFrame, _stroke = uiStroke, }
                setmetatable(Mango.Visuals.BoxFOV, {
                    __newindex = function(t, k, v)
                        if k == 'Position' then
                            t._frame.Position = UDim2.fromOffset(v.X, v.Y)
                        elseif k == 'Size' then
                            t._frame.Size = UDim2.fromOffset(v.X, v.Y)
                        elseif k == 'Color' then
                            t._stroke.Color = v
                        elseif k == 'Visible' then
                            t._frame.Visible = v
                        elseif k == 'Thickness' then
                            t._stroke.Thickness = v
                        elseif k == 'Transparency' then
                            t._frame.BackgroundTransparency = v
                        end
                    end,
                    __index = function(t, k)
                        if k == 'Position' then
                            local p = t._frame.Position
                            return Vector2.new(p.X.Offset, p.Y.Offset)
                        elseif k == 'Size' then
                            local s = t._frame.Size
                            return Vector2.new(s.X.Offset, s.Y.Offset)
                        elseif k == 'Color' then
                            return t._stroke.Color
                        elseif k == 'Visible' then
                            return t._frame.Visible
                        elseif k == 'Thickness' then
                            return t._stroke.Thickness
                        elseif k == 'Transparency' then
                            return t._frame.BackgroundTransparency
                        end
                    end,
                })
                Mango.Visuals.BoxFOV.Thickness = 1
                Mango.Visuals.BoxFOV.Transparency = 1
            end
            if not Mango.Visuals.TriggerBotFOV then Mango.Visuals.TriggerBotFOV = Overlay.new('Circle') end
         --[[
            local Text = Overlay.new("Text")
            Text.Visible = true
            Text.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
            Text.Size = 13
            Text.Text = "He;lo"
            Text.Outline = true
            Text.Color = Color3.fromRGB(255, 255, 255)]]
        end
        do
            function KeybindHandler.GetBind(Id)
                if (not Id) then return Binds end
                local FoundI = -1
                for i, Bind in ipairs(Binds) do
                    -- // Check if id matches
                    if (Bind.Id == Id) then
                        -- // Set
                        FoundI = i
                        break
                    end
                end
                if (FoundI == -1) then return false end
                return Binds[FoundI], FoundI
            end
            --
            local ValidInputItems = {"KeyCode", "UserInputType"}
            function KeybindHandler.CreateBind(Data)
                -- // Make sure we gave a keybind
                local Keybind = typeof(Data.Keybind) == "function" and Data.Keybind() or Data.Keybind
                assert(typeof(Keybind) == "EnumItem" and table.find(ValidInputItems, tostring(Keybind.EnumType)), "Invalid keybind")
                -- // Add to binds
                local Id = game:GetService("HttpService"):GenerateGUID()
                table.insert(Binds, {
                    Id = Id, Keybind = Data.Keybind,
                    Callback = Data.Callback or function(State, Bind) end,
                    ProcessedCheck = Data.ProcessedCheck or false, Hold = Data.Hold or false,
                    State = Data.State or false
                })
                -- // Return the Id
                return Id
            end
            --
            function KeybindHandler.Update(Id, Property, NewValue)
                -- // Get the bind
                local Bind = KeybindHandler.Get(Id)
                if (not Bind) then return false end
                -- // Set
                Bind[Property] = NewValue
                return true
            end
            --
            function KeybindHandler.UpdateKeybind(Id, NewKeybind) return KeybindHandler.Update(Id, "Keybind", NewKeybind) end
            --
            function KeybindHandler.UpdateCallback(Id, NewCallback) return KeybindHandler.Update(Id, "Callback", NewCallback) end
            --
            function KeybindHandler.RemoveBind(Id)
                -- // Get the bind
                local _, FoundI = KeybindHandler.Get(Id)
                if (not FoundI) then return false end
                -- // Remove
                table.remove(Binds, FoundI)
                return true
            end
            --
            function KeybindHandler.CreateConnection()
                -- // Connects to whenever we make an input
                KeybindHandler.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input, gameProcessedEvent)
                    -- // Loop through all binds
                    for _, Bind in ipairs(Binds) do
                        -- // Check
                        local Keybind = Bind.Keybind
                        Keybind = typeof(Keybind) == "function" and Keybind() or Keybind
                        local Property = tostring(Keybind.EnumType)
                        if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then continue end
                        -- // Fire
                        if (Bind.Hold) then Bind.State = true else Bind.State = not Bind.State end
                        Bind.Callback(Bind.State, Bind)
                    end
                end)
                -- // See whenever we lift up
                KeybindHandler.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input, gameProcessedEvent)
                    -- // Loop through all binds
                    for _, Bind in ipairs(Binds) do
                        -- // Make sure is a hold
                        if (not Bind.Hold) then continue end
                        -- // Check
                        local Keybind = Bind.Keybind
                        Keybind = typeof(Keybind) == "function" and Keybind() or Keybind
                        local Property = tostring(Keybind.EnumType)
                        if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then continue end
                        -- // Fire
                        Bind.State = false
                        Bind.Callback(Bind.State, Bind)
                    end
                end)
            end
            --
            function KeybindHandler.Destroy(KeepConnection)
                -- // Destroy connection
                if (not KeepConnection) then
                    if (KeybindHandler.InputBeganConnection) then
                        KeybindHandler.InputBeganConnection:Disconnect()
                        KeybindHandler.InputBeganConnection = nil
                    end
                    if (KeybindHandler.InputEndedConnection) then
                        KeybindHandler.InputEndedConnection:Disconnect()
                        KeybindHandler.InputEndedConnection = nil
                    end
                end
                -- // Empty binds
                Binds = {}
            end
            --
            --KeybindHandler.TestMode = true
            KeybindHandler.CreateConnection()
            if (KeybindHandler.TestMode) then
                KeybindHandler.CreateBind({
                    Keybind = Enum.KeyCode.X, ProcessedCheck = true,
                    Callback = function(State, Bind)
                    end
                })
                KeybindHandler.CreateBind({
                    Keybind = Enum.UserInputType.MouseButton2, ProcessedCheck = true,
                    Callback = function(State, Bind)
                    end
                })
                KeybindHandler.CreateBind({
                    Keybind = Enum.UserInputType.MouseButton2, ProcessedCheck = true,
                    Callback = function(State, Bind)
                        local Action = State and "pressed" or "released"
                        if State then
                            task.spawn(function()
                                while State do
                                    task.wait(0.1)
                                end
                            end)
                        end
                    end,
                    Hold = true
                })
            end
        end
        --
        function Modules.Get(Id)
            if not Modules.Cache[Id] then
                Modules.Cache[Id] = { c = Modules[Id](), }
            end
            return Modules.Cache[Id].c
        end
        --
        function Modules.Utility()
            local function ThreadLoop(Wait, Function)
                task.spawn(function()
                    while true do
                        if getgenv().PreyGeneration ~= MyGeneration then break end
                        local Delta = task.wait(Wait)
                        if getgenv().PreyGeneration ~= MyGeneration then break end
                        local Success, Error = pcall(Function, Delta)
                        if not Success then
                            warn("thread error " .. Error)
                        elseif Error == "break" then
                            --print("thread stopped")
                            break
                        end
                    end
                end)
            end
            local function GetTriggerBotFOVSize()
    -- Use shared FOV settings from Visuals config
    local fovConfig = getgenv().Prey and getgenv().Prey.Visuals and getgenv().Prey.Visuals.Fov
    local fovWidth = fovConfig and fovConfig['Width'] or 200; local fovHeight = fovConfig and fovConfig['Height'] or 150
    return fovWidth, fovHeight
end
            local function ThreadFunction(Func, Name, ...)
                local Func = Name and function()
                    local Passed, Statement = pcall(Func)
                    --
                    if not Passed then
                    end
                end or Func
                local Thread = coroutine.create(Func)
                --
                coroutine.resume(Thread, ...)
                return Thread
            end
            local function Connection(connectionType, connectionCallback)
                local wrappedCallback = function(...)
                    if getgenv().PreyGeneration ~= MyGeneration then return end
                    return connectionCallback(...)
                end
                local connection = connectionType:Connect(wrappedCallback)
                Mango.RBXConnections[#Mango.RBXConnections + 1] = connection
                return connection
            end
            return { ThreadFunction = ThreadFunction, ThreadLoop = ThreadLoop, Connection = Connection }
        end
        --
        function Modules.Engine()
            local function RayCast(Part, Origin, Ignore, Distance)
                local Ignore = Ignore or {}
                local Distance = Distance or 2000
                local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance); local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
                return (Hit and Hit:IsDescendantOf(Part.Parent)) == true, Hit
            end
            return { RayCast = RayCast }
        end
        --
        local Gui
        function Modules.ScreenGui()
            local function Setup()
                if not Gui then
                    Gui = Instance.new("ScreenGui")
                    Gui.ResetOnSpawn = false
                    Gui.Parent = game:GetService("CoreGui")
                end
            end
            local function GetParentInstance() return Gui end
            local function DrawText(Parent)
                Setup()
                Parent = Parent or GetParentInstance()
                local Text = Instance.new("TextLabel", Parent)
                Text.Text = "Label"
                Text.BackgroundTransparency = 1
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.Font = Enum.Font.SourceSansBold
                Text.TextSize = 42
                Text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                Text.TextStrokeTransparency = 0.85
                Text.Visible = false
                Text.TextXAlignment = Enum.TextXAlignment.Left
                task.wait()
                local Width = Text.TextBounds.X
                Text.Size = UDim2.new(0, Width + 10, 0, Text.TextSize)
                return Text
            end
            local function UpdateDrawings()
                Setup()
                if not Mango.Visuals then Mango.Visuals = {} end
                if not Mango.Visuals.Triggerbot then Mango.Visuals.Triggerbot = DrawText(Gui) end
                if not Mango.Visuals.WalkSpeed then Mango.Visuals.WalkSpeed = DrawText(Gui) end
                if not Mango.Visuals.DoubleTap then Mango.Visuals.DoubleTap = DrawText(Gui) end
            end
            return { Setup = Setup, DrawText = DrawText, UpdateDrawings = UpdateDrawings }
        end
        --
        function Modules.Player()
            local Engine = Modules.Get("Engine")
            local function ValidateClient(Player)
                if not Player then return false, false, false end
                local Object = Player.Character
                local Humanoid = (Object and Object:FindFirstChildOfClass("Humanoid")) or false
                local RootPart = (Object and (Object:FindFirstChild("HumanoidRootPart") or (Humanoid and Humanoid.RootPart) or Object:FindFirstChild("Torso") or Object:FindFirstChild("UpperTorso"))) or false
                return Object, Humanoid, RootPart
            end
            --[[
                   local function IsDesynced(Player, X, Y, Z, UseMagnitude, Magnitude, Force)
				X = X or 70
				Y = Y or 100
				Z = Z or 53
				UseMagnitude = UseMagnitude or true
				Magnitude = Magnitude or 80
				Force = Force or false
				--
				local Object, Humanoid, RootPart = ValidateClient(Player)
				--
				if (Object and Humanoid and RootPart) then
					local Velocity = RootPart.Velocity; local Cap = Vector3.new(X, Y, Z)
					--
					if Velocity.X >= Cap.X or Velocity.Y >= Cap.Y or Velocity.Z >= Cap.Z then return true end
					--
					if Velocity.Magnitude >= 75 then return true end
					--
					if UseMagnitude and Velocity.Magnitude > Magnitude then return true end
					--
					if Force then return true end
				end
			end]]
            local function GetOrigin(Origin)
                if Origin == 'Head' then
                    local Object, Humanoid, RootPart = ValidateClient(Self); local Head = Object:FindFirstChild('Head')
                    if Head and Head:IsA('RootPart') then return Head.CFrame.Position end
                elseif Origin == 'Torso' then
                    local Object, Humanoid, RootPart = ValidateClient(Self)
                    if RootPart then return RootPart.CFrame.Position end
                end
                return Workspace.CurrentCamera.CFrame.Position
            end
            local function IsKnocked(Character)
                if (Character) and Character:FindFirstChild('BodyEffects') then return Character:FindFirstChild("BodyEffects")['K.O'].Value end
                return false
            end
            local function IsGrabbed(Character)
                if Character then
                    if Character:FindFirstChild('GRABBING_CONSTRAINT') then return true else return false end
                else
                    return false
                end
            end
            local function GetClosestPlayerToCursor()
                local CurrentCamera = workspace.CurrentCamera; local MousePosition = UserInputService:GetMouseLocation()
                local Closest
                local Distance = 1/0
                for _, Player in ipairs(Players:GetPlayers()) do
                    if (Player == Self) then continue end
                    local Character = Player.Character
                    if (not Character) then continue end
                    if Player.Character then
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        if (not HumanoidRootPart) then continue end
                        -- Get current mode and checks from OLD config
                        local selectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'; local checks = getgenv().Prey.Main.Target.Unlock
                        if checks and checks['Through Walls'] == false then
                            if IsBehindWall(CurrentCamera.CFrame.Position, HumanoidRootPart, Character) then continue end
                        end
                        if checks.Forcefield then
                            if Character:FindFirstChild("ForceField") then continue end
                        end
                        if checks.Knocked then
                            if IsKnocked(Character) then continue end
                        end
                        if checks.Grabbed then
                            if IsGrabbed(Character) then continue end
                        end
                        local vCheck = checks and (checks.Vehicle ~= nil and checks.Vehicle or checks['Vehicle Check'])
                        if vCheck == false and IsOnVehicle(Character) then continue end
                        local Position, OnScreen = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position)
                        if checks.Visible then
                            if not OnScreen then continue end
                        end
                        local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                        if (Magnitude < Distance) then
                            Closest = Player
                            Distance = Magnitude
                        end
                    end
                end
                return Closest
            end
            -- Simplified version for Aim Assist (less strict checks)
            local function GetClosestPlayerToCursorAimAssist()
                local char = Self and Self.Character or (game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character)
                if not char then return nil end
                local tool = char:FindFirstChildOfClass("Tool")
                if not tool or not IsGunAllowed('Combat', 'Aim Assist', tool.Name) then return nil end
                local CurrentCamera = workspace.CurrentCamera; local MousePosition = UserInputService:GetMouseLocation()
                local Closest
                local Distance = 1/0
                for _, Player in ipairs(Players:GetPlayers()) do
                    if (Player == Self) then continue end
                    local Character = Player.Character
                    if (not Character) then continue end
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if (not HumanoidRootPart) then continue end
                    -- Only basic checks for Aim Assist
                    local checks = getgenv().Prey.Main.Target.Unlock
                    if checks.Knocked then
                        if IsKnocked(Character) then continue end
                    end
                    if checks.Grabbed then
                        if IsGrabbed(Character) then continue end
                    end
                    local vCheck = checks and (checks.Vehicle ~= nil and checks.Vehicle or checks['Vehicle Check'])
                    if vCheck == false and IsOnVehicle(Character) then continue end
                    -- Strict Wall Check for Aim Assist: ALWAYS verify line-of-sight regardless of 'Through Walls'
                    if IsBehindWall(CurrentCamera.CFrame.Position, HumanoidRootPart, Character) then continue end
                    local Position, OnScreen = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position)
                    if not OnScreen then continue end
                    local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                    if (Magnitude < Distance) then
                        Closest = Player
                        Distance = Magnitude
                    end
                end
                return Closest
            end
            local function GetClosestPartToCursor(Character)
                local CurrentCamera = Workspace.CurrentCamera; local MousePosition = UserInputService:GetMouseLocation()
                local saCfg = getgenv().Prey.Combat['Silent Aim']; local hitPartMode = saCfg and saCfg.HitPart or 'ClosestPart'
                local ClosestPart = nil; local ClosestDistance = 1/0
                if hitPartMode == 'ClosestPart' then
                    -- Find closest part to cursor among all parts
                    for _, Part in ipairs(Character:GetChildren()) do
                        if Part:IsA("BasePart") then
                            local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                            if Position.Z > 0 then
                                local Distance = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                                if Distance < ClosestDistance then
                                    ClosestPart = Part
                                    ClosestDistance = Distance
                                end
                            end
                        end
                    end
                else
                    -- Use specific part (Head or HumanoidRootPart)
                    local Part = Character:FindFirstChild(hitPartMode)
                    if Part and Part:IsA("BasePart") then
                        local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                        if Position.Z > 0 then ClosestPart = Part end
                    end
                end
                return ClosestPart
            end
            local function GetClosestPartToCursorFilter(Character, PointSetting)
                local CurrentCamera = workspace.CurrentCamera
                local Closest
                local Distance = math.huge
                local AllowedParts = nil
                if typeof(PointSetting) == "string" then
                    if PointSetting ~= "Nearest Point" then AllowedParts = { PointSetting } end
                elseif typeof(PointSetting) == "table" then
                    AllowedParts = PointSetting
                end
                for _, Part in ipairs(Character:GetChildren()) do
                    if not Part:IsA("BasePart") then continue end
                    if AllowedParts and not table.find(AllowedParts, Part.Name) then continue end
                    local screenPos = CurrentCamera:WorldToViewportPoint(Part.Position)
                    local mousePos = UserInputService:GetMouseLocation(); local mag = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if mag < Distance then
                        Closest = Part
                        Distance = mag
                    end
                end
                return Closest
            end
            local function GetClosestPointOnPart(Part, Scale)
                if not Part then return nil end
                Scale = Scale or 1.0
                -- Pure math: project mouse ray onto part, clamp to bounding box
                -- No Mouse.Target or Raycast calls — guaranteed result at any target speed
                local MousePos = UserInputService:GetMouseLocation()
                local Ray = Camera:ViewportPointToRay(MousePos.X, MousePos.Y)
                local Intersection = Ray.Origin + Ray.Direction * Ray.Direction:Dot(Part.Position - Ray.Origin)
                local LocalPos = Part.CFrame:PointToObjectSpace(Intersection); local Half = (Part.Size * Scale) / 2
                return Part.CFrame * Vector3.new(
                    math.clamp(LocalPos.X, -Half.X, Half.X), math.clamp(LocalPos.Y, -Half.Y, Half.Y),
                    math.clamp(LocalPos.Z, -Half.Z, Half.Z)
                )
            end
            local function GetClosestPointOnPartBasic(Part)
                if not Part then return nil end
                -- Same pure-math approach for consistency
                local MousePos = UserInputService:GetMouseLocation()
                local Ray = Camera:ViewportPointToRay(MousePos.X, MousePos.Y)
                local Intersection = Ray.Origin + Ray.Direction * Ray.Direction:Dot(Part.Position - Ray.Origin)
                local LocalPos = Part.CFrame:PointToObjectSpace(Intersection); local Half = Part.Size / 2
                return Part.CFrame * Vector3.new(
                    math.clamp(LocalPos.X, -Half.X, Half.X), math.clamp(LocalPos.Y, -Half.Y, Half.Y),
                    math.clamp(LocalPos.Z, -Half.Z, Half.Z)
                )
            end
            local function Resolve(RootPart)
                if not RootPart then return Vector3.new(0, 0, 0) end
                local Suppression = 1; local Aggression = 1; local Position = RootPart.Position; local Tick = tick()
                --
                State.Tracked = State.Tracked or {}
                State.Previous = State.Previous or {}
                --
                table.insert(State.Tracked, Position)
                table.insert(State.Previous, Tick)
                --
                if #State.Tracked >= 3 then
                    local Indexes = #State.Tracked
                    --
                    local TimeData = State.Previous; local PositionEntries = State.Tracked
                    --
                    local IndexOne = PositionEntries[Indexes - 2]
                    local IndexTwo = PositionEntries[Indexes - 1]
                    local LastIndex = PositionEntries[Indexes]; local TimeOne = TimeData[Indexes - 2]; local TimeTwo = TimeData[Indexes - 1]; local LastTime = TimeData[Indexes]
                    --
                    if (TimeTwo - TimeOne) ~= 0 and (LastTime - TimeTwo) ~= 0 then
                        local StartVelocity = (IndexTwo - IndexOne) / (TimeTwo - TimeOne); local EndVelocity = (LastIndex - IndexTwo) / (LastTime - TimeTwo)
                        --
                        local ResolvedVelocity = (Aggression - Suppression) * StartVelocity + Suppression * EndVelocity
                        --
                        return ResolvedVelocity
                    else
                        return RootPart.Velocity
                    end
                else
                    return RootPart.Velocity
                end
            end
            local function GetBodySize(Character)
                local Part = GetClosestPartToCursor(Character)
                if (Part) then
                    local l = workspace.CurrentCamera:WorldToScreenPoint(Part.Position - Part.Size / 2)
                    local r = workspace.CurrentCamera:WorldToScreenPoint(Part.Position + Part.Size / 2); local w = math.abs(l.X - r.X); local h = math.abs(l.Y - r.Y)
                    --
                    return w, h
                end
                --
                return 0, 0
            end
            local function get_quad(a, b, c)
                local s = b^2 - 4 * a * c
                if s < 0 then return nil end
                local d = math.sqrt(s); local t1 = (-b + d) / (2 * a); local t2 = (-b - d) / (2 * a)
                --
                if t1 >= 0 and t2 >= 0 then
                    return math.min(t1, t2)
                elseif t1 >= 0 then
                    return t1
                elseif t2 >= 0 then
                    return t2
                end
                --
                return nil
            end
            --
            local function get_interception(A, B0, v_t, v_b)
                local function getCoefficients(A_comp, B_comp, v_t_comp)
                    local a = v_t_comp * v_t_comp - v_b^2; local b = 2 * (A_comp - B_comp) * v_t_comp; local c = (A_comp - B_comp) * (A_comp - B_comp)
                    return a, b, c
                end
                local function solveDimension(A_comp, B_comp, v_t_comp)
                    local a, b, c = getCoefficients(A_comp, B_comp, v_t_comp)
                    return get_quad(a, b, c)
                end
                local t_x, err_x = solveDimension(A.x, B0.x, v_t.x); local t_y, err_y = solveDimension(A.y, B0.y, v_t.y); local t_z, err_z = solveDimension(A.z, B0.z, v_t.z)
                if not t_x or not t_y or not t_z then return nil, 'how did we end up here' end
                local t = math.max(t_x, t_y, t_z)
                local Bt = B0 + v_t * t
                return Bt, t_x, t_y, t_z
            end
            --
            local function get_ground(position)
                local ray = Ray.new(position, Vector3.new(0, -1000, 0)); local hitPart, hitPosition = workspace:FindPartOnRay(ray)
                --
                if hitPart then return hitPosition.Y else return position.Y end
            end
            --
            local function backup_velocity(t, width, height)
                local average_size = (width + height) / 2; local base_size = 100; local size_factor = (average_size / base_size) - 1
                size_factor = math.clamp(size_factor, -1, 1)
                local min_adjustment = 0.05
                local max_adjustment = 0.145; local adjustment_range = max_adjustment - min_adjustment; local adjusted_t = min_adjustment + (size_factor ^ 2) * adjustment_range
                return adjusted_t
            end
            --
            local function get_velocity(t, width, height)
                local average_size = (width + height) / 2; local base_size = 100; local size_factor = (average_size / base_size) - 1
                size_factor = math.clamp(size_factor, -1, 1)
                local min_adjustment = 0.05; local max_adjustment = 0.145; local adjustment_range = max_adjustment - min_adjustment
                local adjustment = min_adjustment + (size_factor ^ 2) * adjustment_range
                return Vector3.new(adjustment, adjustment, adjustment) * t
            end
            local function m_wait()
                local t = tick()
                game.ReplicatedStorage.DefaultChatSystemChatEvents.MutePlayerRequest:InvokeServer()
                return (tick() - t) * 1000 / 0.5
            end
            local function AutomatedPrediction()
                local silentAimSettings = getgenv().Prey; local TargetPlayerData = Mango.Locals.SilentAimTarget
                local silentAimTarget = TargetPlayerData; local playerCharacter = Self.Character
                if silentAimTarget and silentAimTarget.Character and playerCharacter and silentAimSettings.Automated then
                    local tool = playerCharacter:FindFirstChildOfClass('Tool')
                    local handle = tool and tool:FindFirstChild('Handle'); local shootBBGUI = handle and handle:FindFirstChild('ShootBBGUI')
                    if not silentAimTarget.Character:FindFirstChild("Humanoid") then return end
                    if handle and shootBBGUI then
                        local humanoidRootPart = TargetPlayerData.Character.HumanoidRootPart
                        local Velocity = IsDesynced(humanoidRootPart) and Resolve(humanoidRootPart) or humanoidRootPart.Velocity
                        local handlePosition = handle.Position; local origin = handlePosition + handle.CFrame:VectorToWorldSpace(shootBBGUI.StudsOffsetWorldSpace)
                        Velocity_Data.Recorded = {
                            Alpha = origin, B_0 = humanoidRootPart.Position, V_T = Velocity,
                            V_B = m_wait() * silentAimSettings.SilentAim.Prediction.Stabilize
                        }
                        local Bt, t_x, t_y, t_z = get_interception(
                            origin, humanoidRootPart.Position, Velocity,
                            Velocity_Data.Recorded.V_B
                        )
                        if Bt then
                            local predictionVector = Vector3.new(t_x, t_y, t_z)
                            local width, height = GetBodySize(silentAimTarget); local predVal = backup_velocity(predictionVector.Magnitude, width, height)
                            silentAimSettings.SilentAim.Prediction.X = predVal
                            silentAimSettings.SilentAim.Prediction.Y = predVal
                            silentAimSettings.SilentAim.Prediction.Z = predVal
                            local adjustedPrediction = get_velocity(predictionVector, width, height)
                            if adjustedPrediction then
                                local groundLevel = get_ground(Bt)
                                Bt = Vector3.new(Bt.X, math.max(Bt.Y, groundLevel), Bt.Z)
                                local heightAdjustment = math.max(0, Bt.Y - humanoidRootPart.Position.Y)
                                Velocity_Data.Y = adjustedPrediction.Y * (heightAdjustment / (Bt.Y - humanoidRootPart.Position.Y + 1))
                                Velocity_Data.State = TargetPlayerData.Character.Humanoid:GetState()
                            end
                        end
                    end
                end
            end
            local function GetClosestPartToCursorAimAssist(Character)
                local CurrentCamera = Workspace.CurrentCamera; local MousePosition = UserInputService:GetMouseLocation()
                -- Get hitpart from NEW config structure
                local hitPartMode = getgenv().Prey.Combat['HitPart'] or 'Head'
                local closestPointCfg = getgenv().Prey.Combat['Closest Point'] or {}
                local ClosestPart = nil; local ClosestDistance = 1/0
                if hitPartMode == 'ClosestPart' then
                    -- Find closest part to cursor among all parts
                    for _, Part in ipairs(Character:GetChildren()) do
                        if Part:IsA("BasePart") then
                            local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                            if Position.Z > 0 then
                                local Distance = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                                if Distance < ClosestDistance then
                                    ClosestPart = Part
                                    ClosestDistance = Distance
                                end
                            end
                        end
                    end
                elseif hitPartMode == 'ClosestPoint' then
                    -- Find closest part to cursor, then get closest point on that part
                    local closestPartForPoint = nil; local closestDistForPoint = 1/0
                    for _, Part in ipairs(Character:GetChildren()) do
                        if Part:IsA("BasePart") then
                            local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                            if Position.Z > 0 then
                                local Distance = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                                if Distance < closestDistForPoint then
                                    closestPartForPoint = Part
                                    closestDistForPoint = Distance
                                end
                            end
                        end
                    end
                    if closestPartForPoint then
                        local scale = closestPointCfg.Scale or 1; local closestPoint = GetClosestPointOnPart(closestPartForPoint, scale)
                        if closestPoint then
                            local screenPos = CurrentCamera:WorldToViewportPoint(closestPoint)
                            if screenPos.Z > 0 then ClosestPart = closestPartForPoint end
                        end
                    end
                else
                    -- Use specific part (Head or HumanoidRootPart)
                    local Part = Character:FindFirstChild(hitPartMode)
                    if Part and Part:IsA("BasePart") then
                        local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                        if Position.Z > 0 then ClosestPart = Part end
                    end
                end
                return ClosestPart
            end
            local function GetHitPosition(Mode)
    if Mode == 'Assist' then
        if not Mango.Locals.AimAssistTarget then return Vector3.new(0, 0, 0) end
        if not Mango.Locals.AimAssistTarget.Character then return Vector3.new(0, 0, 0) end
        local targetChar = Mango.Locals.AimAssistTarget.Character; local rootPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head")
        if not rootPart or not IsCursorInTargetBox(rootPart, rootPart.Position, 'Aimbot') then return Vector3.new(0, 0, 0) end
        local TargetPart
        if IsOnVehicle(targetChar) then TargetPart = targetChar:FindFirstChild("Head") or rootPart else TargetPart = GetClosestPartToCursorAimAssist(targetChar) end
        if not TargetPart then return Vector3.new(0, 0, 0) end
        local TargetPosition = TargetPart.Position
        if IsOnVehicle(targetChar) and targetChar:FindFirstChild("Head") then TargetPosition = targetChar.Head.Position + Vector3.new(0, 0.1, 0) end
        -- Apply Closest Point scale if needed
        local closestPointCfg = getgenv().Prey.Combat['Closest Point'] or {}
        if not IsOnVehicle(targetChar) and getgenv().Prey.Combat['HitPart'] == 'ClosestPoint' then
            local scale = closestPointCfg.Scale or 1
            TargetPosition = GetClosestPointOnPart(TargetPart, scale) or TargetPosition
        end
        -- Apply prediction (Future or standard prediction)
        local currentTool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
        local toolName = currentTool and currentTool.Name or ""; local futureCfg = GetFutureConfigFor('Aim Assist') or GetFutureConfigFor('Silent Aim')
        if futureCfg then
            return ApplyFuture(TargetPosition, Mango.Locals.AimAssistTarget, toolName, futureCfg)
        else
            local triggerbotCfg = getgenv().Prey.Combat['Triggerbot'] or {}
            local prediction = triggerbotCfg['Prediction'] or {}
            if prediction.X or prediction.Y or prediction.Z then
                local RootPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head"); local hum = targetChar:FindFirstChildOfClass("Humanoid")
                local Velocity
                if hum and hum.SeatPart then
                    Velocity = hum.SeatPart.AssemblyLinearVelocity
                elseif RootPart then
                    if typeof(IsDesynced) == "function" and typeof(Resolve) == "function" then
                        Velocity = IsDesynced(RootPart) and Resolve(RootPart) or (RootPart.AssemblyLinearVelocity or RootPart.Velocity)
                    else
                        Velocity = RootPart.AssemblyLinearVelocity or RootPart.Velocity
                    end
                else
                    Velocity = Vector3.zero
                end
                local px = prediction.X or 0.135; local py = prediction.Y or 0; local pz = prediction.Z or prediction.X or 0.135; local PredictionVector = Vector3.new(px, py, pz)
                return TargetPosition + Velocity * PredictionVector
            else
                return TargetPosition
            end
        end
    end
    if Mode == 'Silent' then
        if not Mango.Locals.SilentAimTarget or not Mango.Locals.SilentAimTarget.Character then return nil end
        local tChar = Mango.Locals.SilentAimTarget.Character
        local rootPart = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head")
        local isTriggerFiring = Mango.Locals.TriggerbotActive or (getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot and getgenv().Prey.Combat.Triggerbot.Enabled == true)
        local isInsideTargetBox = IsCursorInTargetBox(rootPart, rootPart.Position, 'Silent') or (isTriggerFiring and IsCursorInTargetBox(rootPart, rootPart.Position, 'Triggerbot'))
        if not rootPart or not isInsideTargetBox then
            Mango.Locals.HitPosition = nil
            return nil
        end
        local silentAimConfig = getgenv().Prey.Combat['Silent Aim']; local hitPartMode = silentAimConfig and silentAimConfig.HitPart or 'ClosestPart'
        local TargetPart
        if IsOnVehicle(tChar) then
            TargetPart = tChar:FindFirstChild("Head") or rootPart
        elseif hitPartMode == 'ClosestPart' then
            TargetPart = GetClosestPartToCursor(Mango.Locals.SilentAimTarget.Character)
        else
            TargetPart = Mango.Locals.SilentAimTarget.Character:FindFirstChild(hitPartMode)
        end
        if not TargetPart then return Vector3.new(0, 0, 0) end
        local TargetPosition = TargetPart.Position
        if IsOnVehicle(tChar) and tChar:FindFirstChild("Head") then TargetPosition = tChar.Head.Position + Vector3.new(0, 0.1, 0) end
        -- Closest Point Scale: use new config structure
        local cpScaleCfg = silentAimConfig and silentAimConfig['Closest Point Scale']
        if not IsOnVehicle(tChar) and cpScaleCfg and cpScaleCfg.Enabled then
            local scale = cpScaleCfg.Scale or 1.25
            TargetPosition = GetClosestPointOnPart(TargetPart, scale)
        end
        -- Prediction Check: Only run velocity prediction if Prediction.Enabled is true.
        -- When Prediction.Enabled is false (Da Hood default), lock DIRECTLY onto TargetPosition with ZERO prediction!
        local currentTool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
        local toolName = currentTool and currentTool.Name or ""
        local isPredEnabled = silentAimConfig and silentAimConfig.Prediction and silentAimConfig.Prediction.Enabled == true
        local futureCfg = isPredEnabled and (GetFutureConfigFor('Silent Aim') or GetFutureConfigFor('Triggerbot'))
        if isPredEnabled and futureCfg then
            Mango.Locals.HitPosition = ApplyFuture(TargetPosition, Mango.Locals.SilentAimTarget, toolName, futureCfg)
        elseif isPredEnabled then
            local RootPart = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head"); local hum = tChar:FindFirstChildOfClass("Humanoid")
            local Velocity
            if hum and hum.SeatPart then
                Velocity = hum.SeatPart.AssemblyLinearVelocity
            elseif RootPart then
                if typeof(IsDesynced) == "function" and typeof(Resolve) == "function" then
                    Velocity = IsDesynced(RootPart) and Resolve(RootPart) or (RootPart.AssemblyLinearVelocity or RootPart.Velocity)
                else
                    Velocity = RootPart.AssemblyLinearVelocity or RootPart.Velocity
                end
            else
                Velocity = Vector3.zero
            end
            local px = silentAimConfig.Prediction.X or 0.165
            local py = silentAimConfig.Prediction.Y or 0
            local pz = silentAimConfig.Prediction.Z or silentAimConfig.Prediction.X or 0.165; local PredictionVector = Vector3.new(px, py, pz)
            Mango.Locals.HitPosition = TargetPosition + Velocity * PredictionVector
        else
            -- Direct target locking (Zero prediction - Da Hood default)
            Mango.Locals.HitPosition = TargetPosition
        end
        return Mango.Locals.HitPosition
    end
end
            -- Easing functions for aim assist
            local EasingFunctions = PreyEasingFunctions
            -- Aim Assist Camera function with easing style support
            local function AimAssistCamera()
                local aimAssistCfg = getgenv().Prey.Combat['Aim Assist']
                if type(aimAssistCfg) ~= "table" then return end
                if aimAssistCfg.Enabled ~= true then return end
                if not AimAssistActive then return end
                local char = Self and Self.Character or (game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character)
                local currentTool = char and char:FindFirstChildOfClass("Tool")
                if not currentTool or not IsGunAllowed('Combat', 'Aim Assist', currentTool.Name) then
                    Mango.Locals.AimAssistTarget = nil
                    return
                end
                -- Resolve active target:
                local target = nil
                if Environment and Environment.Priority and #Environment.Priority > 0 then
                    target = GetPriorityTargetInFOV and GetPriorityTargetInFOV('Aimbot')
                else
                    target = Mango.Locals.AimAssistTarget or Mango.Locals.LockedTarget
                end
                if not target or not target.Character then
                    Mango.Locals.AimAssistTarget = nil
                    return
                end
                local targetChar = target.Character
                local checks = getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock or {}
                if IsDead(targetChar) or (checks.Knocked and IsKnocked(targetChar)) or (checks.Grabbed and IsGrabbed(targetChar)) then
                    Mango.Locals.AimAssistTarget = nil
                    return
                end
                -- STRICT FULL VISIBILITY CHECK: Target MUST be on screen and visible (not behind walls/buildings/mountains)
                if not IsTargetFullyVisible(targetChar) then
                    Mango.Locals.AimAssistTarget = nil
                    return
                end
                local rootPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head")
                if not rootPart then return end
                -- FOV Box Check: Must be inside 2D or 3D FOV box
                local isInsideFOV = IsCursorInTargetBox(rootPart, rootPart.Position, 'Aimbot')
                if not isInsideFOV then
                    Mango.Locals.AimAssistTarget = nil
                    return
                end
                Mango.Locals.AimAssistTarget = target
                local hitPos = GetHitPosition("Assist")
                if hitPos == Vector3.new(0, 0, 0) then return end
                local targetCF = CFrame.new(Camera.CFrame.Position, hitPos)
                -- Aim Assist Shake (0-10 intensity: 10 = heaviest shake, 0 = almost no shake)
                local shakeCfg = aimAssistCfg['Shake']; local shakeAmount = 0
                if type(shakeCfg) == "number" then
                    shakeAmount = shakeCfg
                elseif type(shakeCfg) == "table" and shakeCfg['Enabled'] ~= false then
                    shakeAmount = tonumber(shakeCfg['Amount'] or shakeCfg['Intensity'] or shakeCfg['Value']) or 0
                end
                if shakeAmount > 0 then
                    shakeAmount = math.clamp(shakeAmount, 0, 10)
                    local scale = (shakeAmount / 10) * 0.38
                    local rx = (math.random() * 2 - 1) * scale; local ry = (math.random() * 2 - 1) * scale; local rz = (math.random() * 2 - 1) * (scale * 0.5)
                    targetCF = targetCF * CFrame.Angles(rx, ry, rz)
                end
                local smoothing = aimAssistCfg.Smoothness or 0.45
                -- Get easing style config
                local easingCfg = getgenv().Prey.Combat['Easing Style'] or {}
                local easingStyle = easingCfg.Style or 'Circular'; local easingDirection = easingCfg.Direction or 'InOut'
                -- Apply easing. All styles now have In/Out/InOut variants.
                local easedSmoothing = smoothing
                local easingFunc = EasingFunctions[easingStyle] or EasingFunctions.Linear; local dirFunc = easingFunc[easingDirection] or easingFunc.In
                if dirFunc then easedSmoothing = dirFunc(smoothing) end
                Camera.CFrame = Camera.CFrame:Lerp(targetCF, easedSmoothing)
            end
            return {
                GetClosestPlayerToCursor = GetClosestPlayerToCursor, GetClosestPlayerToCursorAimAssist = GetClosestPlayerToCursorAimAssist,
                GetClosestPartToCursorFilter = GetClosestPartToCursorFilter, SelfMods = SelfMods, GetOrigin = GetOrigin, IsKnocked = IsKnocked, IsGrabbed = IsGrabbed,
                ValidateClient = ValidateClient, GetClosestPointOnPart = GetClosestPointOnPart, GetClosestPointOnPartBasic = GetClosestPointOnPartBasic,
                GetClosestPartToCursor = GetClosestPartToCursor, GetClosestPartToCursorAimAssist = GetClosestPartToCursorAimAssist, GetHitPosition = GetHitPosition,
                AutomatedPrediction = AutomatedPrediction,
                AimAssistCamera = AimAssistCamera
            }
        end
        --
        function Modules.DaHood()
            if CurrentGame.Name == "Da Hood" then
                local IsClient = RunService:IsClient(); local PlaceIDCheck = game.PlaceId == 88976059384565
                local function CanShoot(Character)
                    if Character then
                        local Humanoid = Character:FindFirstChild("Humanoid")
                        if Humanoid and (Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) then
                            local BodyEffects = Character:FindFirstChild("BodyEffects")
                            if BodyEffects then
                                local Tool = Character:FindFirstChildWhichIsA("Tool")
                                if Tool and (Tool:FindFirstChild("Handle") and Tool:FindFirstChild("Ammo")) then
                                    if not PlaceIDCheck and IsClient then
                                        if BodyEffects:FindFirstChild("Block") then
                                            shared.playerShot(Tool.Handle)
                                            Tool.Handle.NoAmmo:Play()
                                            return
                                        end
                                        if Tool.Ammo.Value == 0 then
                                            Tool.Handle.NoAmmo:Play()
                                            return
                                        end
                                    end
                                    if Character:FindFirstChild("FULLY_LOADED_CHAR") == nil then
                                        return
                                    elseif Character:FindFirstChild("FORCEFIELD") then
                                        return
                                    elseif Character:FindFirstChild("GRABBING_CONSTRAINT") then
                                        return
                                    elseif Character:FindFirstChild("Christmas_Sock") then
                                        return
                                    elseif BodyEffects.Cuff.Value == true then
                                        return
                                    elseif BodyEffects.Attacking.Value == true then
                                        return
                                    elseif BodyEffects["K.O"].Value == true then
                                        return
                                    elseif BodyEffects.Grabbed.Value then
                                        return
                                    elseif BodyEffects.Reload.Value == true then
                                        return
                                    elseif BodyEffects.Dead.Value == true then
                                        return
                                    elseif not Tool:GetAttribute("Cooldown") then
                                        local LastShot = Character:GetAttribute("LastGunShot")
                                        Character:SetAttribute("LastGunShot", Tool.Name)
                                        if not IsClient or (LastShot == Tool.Name or not Character:GetAttribute("ShotgunDebounce")) then
                                            if not IsClient and (not Character:GetAttribute("ShotgunDebounce") and (Tool.Name == "[Shotgun]" or (Tool.Name == "[Double-Barrel SG]" or (Tool.Name == "TacticalShotgun" or Tool.Name == "Drum-Shotgun")))) then
                                                Character:SetAttribute("ShotgunDebounce", true)
                                                task.delay(0.65, function() Character:SetAttribute("ShotgunDebounce", nil) end)
                                                --Character:SetAttribute("ShotgunDebounce", nil)
                                            end
                                            return true
                                        end
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end
                local function ColorTransform(p14, p15)
                    if p15 == 0 then return p14.Keypoints[1].Value end
                    if p15 == 1 then return p14.Keypoints[#p14.Keypoints].Value end
                    for v16 = 1, #p14.Keypoints - 1 do
                        local v17 = p14.Keypoints[v16]; local v18 = p14.Keypoints[v16 + 1]
                        if v17.Time <= p15 and p15 < v18.Time then
                            local v19 = (p15 - v17.Time) / (v18.Time - v17.Time)
                            return Color3.new((v18.Value.R - v17.Value.R) * v19 + v17.Value.R, (v18.Value.G - v17.Value.G) * v19 + v17.Value.G, (v18.Value.B - v17.Value.B) * v19 + v17.Value.B)
                        end
                    end
                end
                local weaponNames = { "[Shotgun]", "[Drum-Shotgun]", "[Rifle]", "[TacticalShotgun]", "[AR]", "[AUG]", "[AK47]", "[LMG]", "[SilencerAR]", }
                local replicatedStorage = game:GetService("ReplicatedStorage")
                local playersService = game:GetService("Players")
                local localPlayer = playersService.LocalPlayer
                local playerCharacter = Self.Character or Self.CharacterAdded:Wait(); local shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(
                    replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("Shoot")
                )
                local aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(
                    replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("AimShoot")
                )
                local v_u_14 = {}
                local function changefunc()
                    local v_u_38 = {
                        ["functions"] = {},
                    }
                    function v_u_38.connect(_, p36)
                        local v37 = v_u_38.functions
                        table.insert(v37, p36)
                    end
                    local v_u_39 = nil
                    function v_u_38.updatechanges(_, p_u_40)
                        -- upvalues: (copy) v_u_38, (ref) v_u_39
                        for _, v_u_41 in pairs(v_u_38.functions) do
                            spawn(function()
                                -- upvalues: (copy) v_u_41, (copy) p_u_40, (ref) v_u_39
                                v_u_41(p_u_40.Press, p_u_40.Time, v_u_39)
                            end)
                        end
                        v_u_39 = p_u_40.Time
                    end
                    return v_u_38
                end
                setmetatable(v_u_14, {
                    ["__index"] = function(_, p42)
                        -- upvalues: (copy) v_u_14
                        local v43 = v_u_14
                        if getmetatable(v43)[p42] == nil then v_u_14[p42] = {} end
                        local v44 = v_u_14
                        return getmetatable(v44)[p42]
                    end,
                    ["__newindex"] = function(_, p45, p46)
                        -- upvalues: (copy) v_u_14
                        local v47 = v_u_14
                        if getmetatable(v47)[p45] == nil then
                            local v48 = v_u_14
                            getmetatable(v48)[p45] = { ["val"] = p46, ["changed"] = changefunc() }
                        else
                            local v49 = v_u_14
                            getmetatable(v49)[p45].val = p46
                            local v50 = v_u_14
                            getmetatable(v50)[p45].changed:updatechanges(p46)
                        end
                    end
                })
                UserInputService.InputBegan:connect(function(p51, p52)
                    if not p52 or p51.UserInputType == Enum.UserInputType.Keyboard and p51.KeyCode == Enum.KeyCode.LeftShift or p51.UserInputType == Enum.UserInputType.Gamepad1 and p51.KeyCode == Enum.KeyCode.ButtonL2 then
                        if p51.UserInputType == Enum.UserInputType.Keyboard or p51.UserInputType == Enum.UserInputType.Gamepad1 then
                            v_u_14[p51.KeyCode.Name] = { ["Press"] = true, ["Time"] = tick() }
                            return
                        end
                        if p51.UserInputType == Enum.UserInputType.MouseButton2 then
                            v_u_14[Enum.UserInputType.MouseButton2.Name] = { ["Press"] = true, ["Time"] = tick() }
                        end
                    end
                end)
                UserInputService.InputEnded:connect(function(p53, p54)
                    if not p54 or p53.UserInputType == Enum.UserInputType.Keyboard and p53.KeyCode == Enum.KeyCode.LeftShift or p53.UserInputType == Enum.UserInputType.Gamepad1 and p53.KeyCode == Enum.KeyCode.ButtonL2 then
                        if p53.UserInputType == Enum.UserInputType.Keyboard or p53.UserInputType == Enum.UserInputType.Gamepad1 then
                            v_u_14[p53.KeyCode.Name] = { ["Press"] = false, ["Time"] = tick() }
                            return
                        end
                        if p53.UserInputType == Enum.UserInputType.MouseButton2 then
                            v_u_14[Enum.UserInputType.MouseButton2.Name] = { ["Press"] = false, ["Time"] = tick() }
                        end
                    end
                end)
                local v_u_70 = true
                v_u_14.MouseButton2.changed:connect(function(p71, _, _)
                    -- upvalues: (ref) v_u_70, (ref) v_u_20
                    if v_u_70 ~= false then
                        Mango.Locals.IsAimed = p71
                        if Mango.Locals.IsAimed == false then
                            v_u_70 = false
                            wait(0.1)
                            v_u_70 = true
                        end
                    end
                end)
                local function Animate(target)
                    playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                    if playerCharacter and playerCharacter:FindFirstChild("Humanoid") and playerCharacter.Humanoid:FindFirstChild("Animator") then
                        shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.Shoot)
                        aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.AimShoot)
                        if Mango.Locals.IsAimed or table.find(weaponNames, target.Parent.Name) then aimShootAnimation:Play() else shootAnimation:Play() end
                    end
                end
                shared.playerShot = Animate
                local v3 = game:GetService("Players"); local v_u_5 = game:GetService("TweenService"); local v_u_7 = v3.LocalPlayer; local v_u_9 = ReplicatedStorage.SkinAssets
                local v_u_13 = workspace:GetServerTimeNow(); local _ = game.PlaceId == 88976059384565
                local SoundsPlaying = {}
                local function GetAim(Position)
                    if _G.MobileShiftLock then return (Camera.CFrame.p + Camera.CFrame.LookVector * 60 - Position).unit end
                    local v24
                    if Mouse.Target then
                        v24 = Mouse.Hit.p
                    else
                        local v25 = Camera.CFrame; local v26 = v25.p + v25.LookVector * 60; local v27 = v25.LookVector; local v28 = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
                        local v29 = v28.Direction; local v30 = v28.Origin
                        v24 = v30 + v29 * ((v26 - v30):Dot(v27) / v29:Dot(v27))
                    end
                    return (v24 - Position).Unit, (v24 - Position).Magnitude
                end
                local function ShootGun(p34)
                    local v35 = p34.Shooter; local v_u_36 = p34.Handle; local v37 = p34.AimPosition; local v38 = p34.BeamColor
                    local v39 = p34.isReflecting; local v40 = p34.Hit; local v41 = p34.Range or 200; local LegitPosition = p34.LegitPosition
                    local v_u_42
                    if v_u_36 then v_u_42 = v_u_36:GetAttribute("SkinName") else v_u_42 = v_u_36 end
                    local _, v43 = GetAim(v_u_36.Position)
                    local v_u_44 = p34.ForcedOrigin or v_u_36.Muzzle.WorldPosition; local v45 = (v37 - v_u_44).Unit; local v46 = RaycastParams.new()
                    local v47 = {}
                    local function set_list(targetTable, index, values)
                        for i, v in ipairs(values) do
                            targetTable[index + i - 1] = v
                        end
                    end
                    local v48 = { workspace:WaitForChild("Bush"), workspace:WaitForChild("Ignored") }
                    set_list(v47, 1, {v35, unpack(v48)})
                    v46.FilterDescendantsInstances = v47
                    v46.FilterType = Enum.RaycastFilterType.Exclude
                    v46.IgnoreWater = true
                    local v_u_49, v_u_50, v_u_51
                    if v40 then
                        v_u_49 = p34.Hit
                        v_u_50 = p34.AimPosition
                        v_u_51 = p34.Normal
                    else
                        local v52 = workspace:Raycast(v_u_44, v45 * v41, v46)
                        if v52 then
                            v_u_49 = v52.Instance
                            v_u_50 = v52.Position
                            v_u_51 = v52.Normal
                        else
                            v_u_50 = v_u_44 + v45 * math.min(v43, v41)
                            v_u_51 = nil
                            v_u_49 = nil
                        end
                    end
                    local v_u_53 = Instance.new("Part")
                    v_u_53:SetAttribute("OwnerCharacter", v35.Name)
                    v_u_53.Name = "BULLET_RAYS"
                    v_u_53.Anchored = true
                    v_u_53.CanCollide = false
                    v_u_53.Size = Vector3.new(0, 0, 0)
                    v_u_53.Transparency = 1
                    game.Debris:AddItem(v_u_53, 1)
                    -- Client Redirection removed - use default
                    v_u_53.CFrame = CFrame.new(v_u_44, v_u_50)
                    v_u_53.Material = Enum.Material.SmoothPlastic
                    v_u_53.Parent = workspace.Ignored.Siren.Radius
                    local v54 = Instance.new("Attachment")
                    v54.Position = Vector3.new(0, 0, 0)
                    v54.Parent = v_u_53
                    local v55 = Instance.new("Attachment"); local v56 = -(v_u_50 - v_u_44).magnitude
                    v55.Position = Vector3.new(0, 0, v56)
                    v55.Parent = v_u_53
                    local v_u_57 = false; local v_u_58 = nil
                    local v59
                    if v_u_36 then
                        local v60 = v_u_36.Parent.Name
                        if v_u_42 and v_u_42 ~= "" then
                            if v_u_9.GunSkinMuzzleParticle:FindFirstChild(v_u_42) then
                                if not v39 then
                                    if v_u_9.GunSkinMuzzleParticle[v_u_42]:FindFirstChild("Muzzle") then
                                        if v_u_36.Parent:FindFirstChild("Default") and (v_u_36.Parent.Default:FindFirstChild("Mesh") and v_u_36.Parent.Default.Mesh:FindFirstChild("Muzzle")) then
                                            local v61
                                            if v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle:FindFirstChild("Different_GunMuzzle") then
                                                v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle.Different_GunMuzzle[v60]
                                            else
                                                v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle
                                            end
                                            for _, v62 in pairs(v61:GetChildren()) do
                                                local v63 = v62:GetAttribute("EmitCount") or 1; local v_u_64 = v62:Clone()
                                                v_u_64.Parent = v_u_36.Parent.Default.Mesh.Muzzle
                                                v_u_64:Emit(v63)
                                                task.delay(v_u_64.Lifetime.Max, function()
                                                    -- upvalues: (copy) v_u_64
                                                    v_u_64:Destroy()
                                                end)
                                            end
                                        end
                                    else
                                        local v65 = v_u_9.GunSkinMuzzleParticle[v_u_42]:GetChildren(); local v66 = v65[math.random(#v65)]:Clone()
                                        v66.Parent = v54
                                        v66:Emit(v66.Rate)
                                    end
                                end
                                v_u_57 = true
                            end
                            if v_u_9.GunBeam:FindFirstChild(v_u_42) then
                                if v_u_9.GunBeam[v_u_42].GunBeam:IsA("BasePart") then
                                    v59 = { ["Parent"] = nil, ["Attachment0"] = nil, ["Attachment1"] = nil }
                                    if v_u_9.GunBeam[v_u_42].GunBeam:FindFirstChild("Different_GunBeam") then
                                        if v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:IsA("BasePart") then
                                            v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone()
                                        else
                                            v59 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone()
                                        end
                                    else
                                        v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam:Clone()
                                    end
                                else
                                    v59 = v_u_9.GunBeam[v_u_42].GunBeam:Clone()
                                end
                            else
                                v59 = game.ReplicatedStorage.GunBeam:Clone()
                                v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                            end
                        else
                            v59 = game.ReplicatedStorage.GunBeam:Clone()
                            v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                        end
                    else
                        v59 = nil
                    end
                    task.spawn(function()
                        -- upvalues: (ref) v_u_58, (ref) v_u_50, (copy) v_u_44, (ref) v_u_21, (ref) v_u_49, (ref) v_u_51, (copy) v_u_42, (ref) v_u_9, (copy) v_u_53, (copy) v_u_36, (ref) v_u_57, (ref) v_u_5
                        if v_u_58 then
                            local v67 = (v_u_50 - v_u_44).magnitude; local v68 = v67 / 725
                            v_u_58.Anchored = true
                            v_u_58.CanCollide = false
                            v_u_58.CanQuery = false
                            v_u_58.CFrame = CFrame.new(v_u_44, v_u_50)
                            local v69 = v_u_58.CFrame * CFrame.new(0, 0, -v67)
                            v_u_58.Parent = workspace.Ignored.Siren.Radius
                            task.delay(v68 + 5, function()
                                -- upvalues: (ref) v_u_58
                                v_u_58:Destroy()
                                v_u_58 = nil
                            end)
                            if v_u_58:GetAttribute("SpecialEffects") then
                                for _, v70 in pairs(v_u_58:GetDescendants()) do
                                    if v70:IsA("Trail") and v70:GetAttribute("ColorRandom") then
                                        local v71 = v70:GetAttribute("ColorRandom")
                                        v70.Color = ColorSequence.new(ColorTransform(v71, math.random()))
                                    end
                                end
                            end
                            local v72 = game:GetService("TweenService"):Create(v_u_58, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                                ["CFrame"] = v_u_58.CFrame * CFrame.new(0, 0, -0.1)
                            })
                            v72:Play()
                            task.wait(0.05)
                            if v72.PlaybackState ~= Enum.PlaybackState.Completed then v72:Pause() end
                            local v73 = nil
                            if _G.Reduce_Lag and not v_u_58:GetAttribute("NoSlow") or v_u_58:GetAttribute("LOWGFX") then
                                v_u_58.CFrame = v69
                            else
                                v73 = game:GetService("TweenService"):Create(v_u_58, TweenInfo.new(v68, Enum.EasingStyle.Linear), { ["CFrame"] = v69 })
                                v73:Play()
                                task.wait(v68)
                            end
                            if v_u_58:FindFirstChild("Impact") and (v_u_49 and (v_u_51 and not v_u_49.Parent:FindFirstChild("Humanoid"))) then
                                if v73 and v73.PlaybackState ~= Enum.PlaybackState.Completed then task.wait(0.05) end
                                if not v_u_58:FindFirstChild("NoNormal") then v_u_58.CFrame = CFrame.new(v_u_50, v_u_50 - v_u_51) end
                                for _, v74 in pairs(v_u_58.Impact:GetChildren()) do
                                    if v74:IsA("ParticleEmitter") then v74:Emit(v74:GetAttribute("EmitCount") or 1) end
                                end
                            else
                                for _, v75 in pairs(v_u_58:GetChildren()) do
                                    if v75:IsA("BasePart") then v75.Transparency = 1 end
                                end
                            end
                            if v_u_58 then
                                for _, v76 in pairs(v_u_58:GetDescendants()) do
                                    if v76:IsA("ParticleEmitter") then v76.Enabled = false end
                                end
                            end
                        elseif v_u_49 and (v_u_49:IsDescendantOf(workspace.MAP) and (v_u_42 and (v_u_9.GunBeam:FindFirstChild(v_u_42) and v_u_9.GunBeam[v_u_42]:FindFirstChild("Impact")))) then
                            local v_u_77 = v_u_9.GunBeam[v_u_42].Impact:Clone()
                            v_u_77.Parent = workspace.Ignored
                            v_u_77:PivotTo(CFrame.new(v_u_50, v_u_50 + v_u_51 * 5) * CFrame.Angles(-1.5707963267948966, 0, 0))
                            for _, v78 in pairs(v_u_77:GetDescendants()) do
                                if v78:IsA("ParticleEmitter") then v78:Emit(v78:GetAttribute("EmitCount") or 1) end
                            end
                            task.delay(1.5, function()
                                -- upvalues: (ref) v_u_77
                                v_u_77:Destroy()
                                v_u_77 = nil
                            end)
                        end
                        local v79 = Instance.new("PointLight")
                        v79.Brightness = 0.5
                        v79.Range = 15
                        v79.Shadows = true
                        v79.Color = Color3.new(1, 1, 1)
                        v79.Parent = v_u_53
                        local v80 = v_u_36:FindFirstChild("ShootBBGUI"); local v81 = v80 and (not v_u_57 and v80:FindFirstChild("Shoot"))
                        if v81 then
                            v81.Size = UDim2.new(0, 0, 0, 0)
                            v81.ImageTransparency = 1
                            v81.Visible = true
                            v_u_5:Create(v81, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Size"] = UDim2.new(1, 0, 1, 0),
                                ["ImageTransparency"] = 0.4
                            }):Play()
                            v_u_5:Create(v79, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Range"] = 0
                            }):Play()
                            wait(0.4)
                            v_u_53:Destroy()
                            v_u_5:Create(v81, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Size"] = UDim2.new(1, 0, 1, 0),
                                ["ImageTransparency"] = 1
                            }):Play()
                            wait(0.2)
                            v81.Visible = false
                        end
                    end)
                    v59.Attachment0 = v54
                    v59.Attachment1 = v55
                    v59.Name = "NewGunBeam"
                    v59.Parent = v_u_53
                    if v35 == v_u_7.Character and workspace:GetServerTimeNow() - v_u_13 > 0.95 then Animate(v_u_36) end
                    local playsound = function(p1, p2)
                        local v3 = p1.ShootSound:GetAttribute("SequenceSFX")
                        if v3 then
                            if p1.ShootSound:GetAttribute("CurrentSequence") == nil then
                                p1.ShootSound:SetAttribute("CurrentSequence", 1)
                            else
                                p1.ShootSound:SetAttribute("CurrentSequence", p1.ShootSound:GetAttribute("CurrentSequence") + 1)
                            end
                            local v4 = p1.ShootSound:GetAttribute("CurrentSequence")
                            local v5 = {}
                            for v6 in string.gmatch(v3, "%d+") do
                                table.insert(v5, v6)
                            end
                            p1.ShootSound.SoundId = "rbxassetid://" .. v5[v4 % #v5 + 1]
                        end
                        if p2 then
                            local v_u_7 = p1.ShootSound:Clone()
                            v_u_7.Name = "MG"
                            v_u_7.Parent = p1
                            v_u_7:Play()
                            delay(1, function()
                                -- upvalues: (copy) v_u_7
                                v_u_7:Destroy()
                            end)
                        else
                            p1.ShootSound:Play()
                        end
                    end
                    if not SoundsPlaying[v_u_36] then
                        task.spawn(playsound, v_u_36, true)
                        SoundsPlaying[v_u_36] = true
                        task.delay(0.021, function()
                            -- upvalues: (ref) SoundsPlaying, (copy) v_u_36
                            SoundsPlaying[v_u_36] = nil
                        end)
                    end
                    if game.Lighting:GetAttribute("printhits") then
                        local v82 = print; local v83 = v_u_49
                        if v83 then v83 = v_u_49:GetFullName() end
                        v82(v83)
                    end
                    return v_u_50, v_u_49, v_u_51
                end
                return { CanShoot = CanShoot, Animate = Animate, GetAim = GetAim, ColorTransform = ColorTransform, ShootGun = ShootGun, }
            else
                return {}
            end
        end
        --
        function Modules.Main()
            local Engine = Modules.Get("Engine"); local Player = Modules.Get("Player"); local DaHood = Modules.Get("DaHood"); local Current_t = 0
            local function GetGunCategory()
                if Self and Self.Character then
                    local Tool = Self.Character:FindFirstChildWhichIsA("Tool")
                    if Tool then
                        if table.find(WeaponInfo.Weapons.Shotguns, Tool.Name) then return "Shotgun" end
                        if table.find(WeaponInfo.Weapons.Pistols, Tool.Name) then return "Pistol" end
                        if table.find(WeaponInfo.Weapons.Rifles, Tool.Name) then return "Rifle" end
                        if table.find(WeaponInfo.Weapons.Bursts, Tool.Name) then return "Burst" end
                        if table.find(WeaponInfo.Weapons.SMG, Tool.Name) then return "SMG" end
                        if table.find(WeaponInfo.Weapons.Snipers, Tool.Name) then return "Sniper" end
                        if table.find(WeaponInfo.Weapons.AutoShotguns, Tool.Name) then return "Auto" end
                    end
                end
                return nil
            end
                        -- Distance check helper: returns true if target is within configured max distance
                        local function IsWithinDistance(target)
                            local distanceConfig = getgenv().Prey.Combat['Distance Check']
                            if not distanceConfig or not distanceConfig.Enabled then return true end
                            local maxDistance = distanceConfig['Max Distance'] or 300; local tool = Self.Character and Self.Character:FindFirstChildOfClass('Tool')
                            if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                                maxDistance = distanceConfig.Guns[tool.Name]
                            end
                            local selfHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart')
                            local targetHRP = target.Character and target.Character:FindFirstChild('HumanoidRootPart')
                            if selfHRP and targetHRP then return (selfHRP.Position - targetHRP.Position).Magnitude <= maxDistance end
                            return true
                        end
            local fovBoxes = {}
            local function getOrCreateFOVBox(feat)
                local container = fovBoxes[feat]
                if not container then
                    container = {}
                    fovBoxes[feat] = container
                end
                local fovGui = (UtilityUI and UtilityUI:IsA("ScreenGui") and UtilityUI)
                    or game:GetService("CoreGui"):FindFirstChild("PreyFOVGui")
                    or (gethui and gethui():FindFirstChild("PreyFOVGui"))
                if not fovGui then
                    local parent = (gethui and gethui()) or game:GetService("CoreGui"); local newGui = Instance.new("ScreenGui")
                    newGui.Name = "PreyFOVGui"
                    newGui.ResetOnSpawn = false
                    newGui.IgnoreGuiInset = true
                    newGui.Parent = parent
                    fovGui = newGui
                else
                    fovGui.IgnoreGuiInset = true
                end
                if not container.Box2D or not container.Box2D._frame or not container.Box2D._frame.Parent then
                    local fovFrame = Instance.new('Frame')
                    fovFrame.Name = feat .. 'BoxFOV'
                    fovFrame.BorderSizePixel = 0
                    fovFrame.BackgroundTransparency = 1
                    fovFrame.Parent = fovGui
                    local uiStroke = Instance.new('UIStroke')
                    uiStroke.Thickness = 1
                    uiStroke.Color = Color3.fromRGB(255, 255, 255)
                    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    uiStroke.Parent = fovFrame
                    local box2D = { _frame = fovFrame, _stroke = uiStroke, }
                    setmetatable(box2D, {
                        __newindex = function(t, k, v)
                            if k == 'Position' then t._frame.Position = UDim2.fromOffset(v.X, v.Y)
                            elseif k == 'Size' then t._frame.Size = UDim2.fromOffset(v.X, v.Y)
                            elseif k == 'Color' then t._stroke.Color = v
                            elseif k == 'Visible' then t._frame.Visible = v
                            elseif k == 'Thickness' then t._stroke.Thickness = v
                            elseif k == 'Transparency' then t._frame.BackgroundTransparency = v
                            end
                        end,
                        __index = function(t, k)
                            if k == 'Position' then local p = t._frame.Position; return Vector2.new(p.X.Offset, p.Y.Offset)
                            elseif k == 'Size' then local s = t._frame.Size; return Vector2.new(s.X.Offset, s.Y.Offset)
                            elseif k == 'Color' then return t._stroke.Color
                            elseif k == 'Visible' then return t._frame.Visible
                            elseif k == 'Thickness' then return t._stroke.Thickness
                            elseif k == 'Transparency' then return t._frame.BackgroundTransparency
                            end
                        end,
                    })
                    container.Box2D = box2D
                end
                local target3DParent = (gethui and gethui()) or game:GetService("CoreGui") or workspace.CurrentCamera; local is3DValid = false
                pcall(function()
                    if container.Box3D and container.Box3D.Parent and container.Box3D:IsDescendantOf(game) then is3DValid = true end
                end)
                if not is3DValid then
                    local box3D = Instance.new("BoxHandleAdornment")
                    box3D.Name = feat .. "3DBox"
                    box3D.AlwaysOnTop = true
                    box3D.ZIndex = 10
                    box3D.Adornee = nil
                    box3D.Transparency = 0.77
                    box3D.Visible = false
                    box3D.Parent = target3DParent
                    container.Box3D = box3D
                end
                return container
            end
            local function updateSingleFeatureFOV(feat, targetPlayer)
                local container = getOrCreateFOVBox(feat); local box2D = container.Box2D; local box3D = container.Box3D
                local fovCfg = getFeatureFOVConfig(feat)
                -- Hide everything if Visualize is false or no target player is active
                if not fovCfg.VisualizeEnabled or not targetPlayer or not targetPlayer.Character then
                    box2D.Visible = false
                    box3D.Visible = false
                    box3D.Adornee = nil
                    return
                end
                local Object, Humanoid, RootPart = Player.ValidateClient(targetPlayer)
                if not RootPart or not Object or not Humanoid or Humanoid.Health <= 0 then
                    box2D.Visible = false
                    box3D.Visible = false
                    box3D.Adornee = nil
                    return
                end
                local head = Object:FindFirstChild('Head')
                if not head then
                    box2D.Visible = false
                    box3D.Visible = false
                    box3D.Adornee = nil
                    return
                end
                local Pos = RootPart.Position
                local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position); local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(Pos)
                -- MUST be directly on player's screen and in front of camera (Z > 0)
                if not headOnScreen or not hrpOnScreen or headPos.Z <= 0 or hrpPos.Z <= 0 then
                    box2D.Visible = false
                    box3D.Visible = false
                    box3D.Adornee = nil
                    return
                end
                -- Hide 2D/3D FOV boxes immediately whenever target is behind walls/buildings or obstructed
                local isWallBlocked = not IsTargetFullyVisible(Object)
                if isWallBlocked then
                    box2D.Visible = false
                    box3D.Visible = false
                    box3D.Adornee = nil
                    return
                end
                local is3D = string.lower(tostring(fovCfg.Options)) == '3d'
                local rawMouse = UserInputService:GetMouseLocation()
                local guiInset = game:GetService("GuiService"):GetGuiInset()
                local mouseX = rawMouse.X - guiInset.X; local mouseY = rawMouse.Y - guiInset.Y; local fovFocusColor = fovCfg.FocusColor
                if not fovFocusColor or fovFocusColor == Color3.fromRGB(255, 0, 0) or fovFocusColor == Color3.fromRGB(255, 30, 60) then
                    fovFocusColor = Color3.fromRGB(255, 20, 147)
                end
                if is3D then
                    -- 3D Box Mode: Attached to target RootPart
                    local isFocused = IsPointInTarget3DBox(RootPart, mouseX, mouseY, feat)
                    box3D.Size = Vector3.new(fovCfg.Width3D, fovCfg.Height3D, fovCfg.Depth3D)
                    box3D.Color3 = isFocused and fovFocusColor or fovCfg.Color
                    box3D.Transparency = 0.77
                    box3D.Visible = true
                    box3D.Adornee = RootPart
                    box2D.Visible = false
                else
                    -- 2D Box Mode: Centered perfectly around target player character
                    local isFocused = IsPointInTarget2DBox(Pos, rawMouse.X, rawMouse.Y, feat, Object); local boxX, boxY, boxW, boxH = GetTarget2DBoxBounds(Pos, feat, Object)
                    if boxX then
                        box2D.Position = Vector2.new(boxX, boxY)
                        box2D.Size = Vector2.new(boxW, boxH)
                        box2D.Color = isFocused and fovFocusColor or fovCfg.Color
                        box2D.Visible = true
                    else
                        box2D.Visible = false
                    end
                    box3D.Visible = false
                    box3D.Adornee = nil
                end
            end
            local function UpdateBox()
                if Mango.Visuals.AimAssistFOV then Mango.Visuals.AimAssistFOV.Visible = false end
                if Mango.Visuals.TriggerbotFOV then Mango.Visuals.TriggerbotFOV.Visible = false end
                local mainTarget = Mango.Locals.SilentAimTarget or Mango.Locals.AimAssistTarget or Mango.Locals.LockedTarget
                if not mainTarget and PlayerModule and PlayerModule.GetClosestPlayerToCursor then
                    pcall(function() mainTarget = PlayerModule.GetClosestPlayerToCursor() end)
                end
                local silentTarget = Mango.Locals.SilentAimTarget or mainTarget; local aimTarget = Mango.Locals.AimAssistTarget or mainTarget; local triggerTarget = mainTarget
                updateSingleFeatureFOV('Silent', silentTarget)
                updateSingleFeatureFOV('Aimbot', aimTarget)
                updateSingleFeatureFOV('Triggerbot', triggerTarget)
                if fovBoxes['Silent'] then
                    Mango.Visuals.BoxFOV = fovBoxes['Silent'].Box2D
                    Mango.Visuals.BoxFOV3D = fovBoxes['Silent'].Box3D
                end
            end
            local Ticks = {}
            local SGTick = tick()
            local function SilentAim(Tool)
                local silentCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Silent Aim']
                local triggerCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot
                local isSilentOn = silentCfg and silentCfg.Enabled == true; local isTriggerOn = Mango.Locals.TriggerbotActive or (triggerCfg and triggerCfg.Enabled == true)
                if (isSilentOn or isTriggerOn) and Tool:FindFirstChild("Ammo") then
                    if IsHoodCustoms() then return end
                    if CurrentGame.Name == "Da Hood" then
                        if not Ticks[Tool.Name] then Ticks[Tool.Name] = 0 end
                        local WeaponOffset = WeaponInfo.Offsets[Tool.Name]; local Gun = GetGunCategory()
                        local Check
                        local ToolHandle = Tool:WaitForChild("Handle"); local LocalCharacter = Self.Character
                        local Cooldown
                        local NoClueWhatThisIs = game.PlaceId == 88976059384565 and {
                            ["Value"] = 5
                        } or Tool.Ammo
                        local Time = workspace:GetServerTimeNow()
                        local ToolEvent = Tool:WaitForChild("RemoteEvent", 2) or {
                            ["FireServer"] = function(_, _) end
                        }
                        --[[
                        local function GetSpread()
                            local Spread = 0.05
                            if Gun == "Shotgun" then
                                Spread = 0.05
                            elseif Gun == "Pistol" then
                                Spread = 0.05
                            elseif Gun == "Auto" then
                                Spread = 0.05
                            elseif Gun == "Burst" then
                                Spread = 0.05
                            elseif Gun == "Rifle" then
                                Spread = 0.05
                            elseif Gun == "SMG" then
                                Spread = 0.05
                            elseif Gun == "Sniper" then
                                Spread = 0.05
                            end
                            return Spread
                        end
                        ]]
                        Cooldown = Tool:WaitForChild("ShootingCooldown").Value
                        --[[
                        local function GetSpread()
                            local Spread = 0.05
                            if Gun == "Shotgun" then
                                Spread = 0.05
                            elseif Gun == "Pistol" then
                                Spread = 0.05
                            elseif Gun == "Auto" then
                                Spread = 0.05
                            elseif Gun == "Burst" then
                                Spread = 0.05
                            elseif Gun == "Rifle" then
                                Spread = 0.05
                            elseif Gun == "SMG" then
                                Spread = 0.05
                            elseif Gun == "Sniper" then
                                Spread = 0.05
                            end
                            return Spread
                        end
                        ]]
                        local function GetWeaponDelay(baseDelay) return GetToolFireDelay(Tool, baseDelay) end
                        -- Ammo Conservation: if shot will miss, don't fire the remote (no ammo consumed)
                        local function ShouldConserveAmmo(hitPart)
                            -- Universal Ammo Conservation: applies to ALL shots
                            local uaCfg = getgenv().Prey.Combat['Universal Ammo Conservation']
                            if uaCfg and uaCfg['Enabled'] then
                                if not Mango.Locals.SilentAimTarget then return true end
                                local tChar = Mango.Locals.SilentAimTarget.Character
                                if not tChar or not hitPart or not hitPart:IsDescendantOf(tChar) then return true end
                                return false
                            end
                            return false
                        end
                        local function CalculateSpreadMultiplier(toolName)
                            if not toolName then return nil end
                            local cleanName = toolName:gsub("^%[", ""):gsub("%]$", "")
                            -- Check top-level 'Spread Modifications'
                            local smCfg = getgenv().Prey and getgenv().Prey['Spread Modifications']
                            if smCfg and smCfg.Enabled then
                                local mode = smCfg.Mode or "Normal"; local gunData = smCfg[toolName] or smCfg['[' .. cleanName .. ']'] or smCfg[cleanName]
                                if gunData then
                                    local val
                                    if mode == "Randomizer" then
                                        local randRange = gunData.Randomizer or gunData.randomizer
                                        if type(randRange) == "table" and randRange[1] and randRange[2] then
                                            local minVal = tonumber(randRange[1]) or 0; local maxVal = tonumber(randRange[2]) or 100
                                            if minVal > maxVal then minVal, maxVal = maxVal, minVal end
                                            val = math.random(minVal, maxVal)
                                        elseif type(randRange) == "number" then
                                            val = randRange
                                        end
                                    end
                                    if val == nil then val = gunData.Normal or gunData.normal end
                                    if val ~= nil and type(val) == "number" then return math.clamp((val - 1) / 99, 0, 1) end
                                end
                            end
                            -- Fallback to Prey['Tools']['Mods']['Spread']
                            local spreadConfig = getgenv().Prey and getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Mods'] and getgenv().Prey['Tools']['Mods']['Spread']
                            if spreadConfig and spreadConfig.Enabled and IsGunAllowed('Gun', 'Spread', toolName) and spreadConfig.Guns then
                                local val = spreadConfig.Guns[toolName] or spreadConfig.Guns['[' .. cleanName .. ']'] or spreadConfig.Guns[cleanName]
                                if val ~= nil then
                                    if type(val) == "table" then
                                        if val.Randomizer then
                                            local rand = val.Randomizer
                                            if type(rand) == "table" and rand[1] and rand[2] then
                                                val = math.random(rand[1], rand[2])
                                            end
                                        elseif val.Normal then
                                            val = val.Normal
                                        end
                                    end
                                    if type(val) == "number" then return math.clamp((val - 1) / 99, 0, 1) end
                                end
                            end
                            return nil
                        end
                        local function ShootFunc(GunType, SilentAim)
                            if SilentAim and not IsGunAllowed('Combat', 'Silent Aim', Tool.Name) then return end
                            -- Distance Check: block shot if locked target is beyond configured range
                            if Mango.Locals.SilentAimTarget and not IsWithinDistance(Mango.Locals.SilentAimTarget) then return end
                            -- Hit Chance: percentage chance to actually fire when locked on (1-100)
                            if SilentAim and Mango.Locals.SilentAimTarget then
                                local saCfg = getgenv().Prey.Combat['Silent Aim']; local chance = saCfg and saCfg['Hit Chance']
                                if chance and chance > 0 and chance < 100 then
                                    if math.random(1, 100) > chance then return end
                                end
                            end
                            local baseDelay = Cooldown + (WeaponInfo.Delays[Tool.Name] or 0)
                            local weaponDelay = GetWeaponDelay(baseDelay); local canShootNow = tick() - Ticks[Tool.Name] >= weaponDelay
                            if GunType == "Shotgun" then
                                local cooldownCheck = canShootNow
                                if cooldownCheck and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                                    Ticks[Tool.Name] = tick()
                                    ToolEvent:FireServer("Shoot")
                                    for _ = 1, 5 do
                                        local HitPosition = Mango.Locals.HitPosition
                                        local SpreadX
                                        local SpreadY
                                        local SpreadZ
                                        -- Default spread without Enhancements
                                        SpreadX = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                        SpreadY = math.random() > 0.5 and math.random() * 0.1 or -math.random() * 0.1
                                        SpreadZ = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                        -- Apply Spread Modification (Normal or Randomizer)
                                        local spreadMultiplier = CalculateSpreadMultiplier(Tool.Name)
                                        if spreadMultiplier ~= nil then
                                            SpreadX = SpreadX * spreadMultiplier
                                            SpreadY = SpreadY * spreadMultiplier
                                            SpreadZ = SpreadZ * spreadMultiplier
                                        end
                                        local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                            ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                        }
                                        local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ)
                                        local AimPosition
                                        if SilentAim and Mango.Locals.SilentAimTarget then
                                            AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * 200
                                        else
                                            AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * 200
                                        end
                                        local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                            ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle, ["AimPosition"] = AimPosition, ["BeamColor"] = Color3.new(1, 0.545098, 0.14902),
                                            ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                            ["LegitPosition"] = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * 200,
                                            ["Range"] = 200
                                        })
                                        Arg0, Arg1, Arg2 = ApplyDamageOverride(Arg0, Arg1, Arg2)
                                        if not ShouldConserveAmmo(Arg1) then
                                            -- Sync mouse position with server before firing so bullet registers
                                            if SilentAim and Mango.Locals.SilentAimTarget and HitPosition then
                                                local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                                pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, HitPosition) end)
                                            end
                                            ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, Time)
                                        end
                                    end
                                    ToolEvent:FireServer()
                                end
                            elseif Gun == "Pistol" then
                                local cooldownCheck = canShootNow
                                if cooldownCheck and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                                    Ticks[Tool.Name] = tick()
                                    local HitPosition = Mango.Locals.HitPosition
                                    ToolEvent:FireServer("Shoot")
                                    local AimPosition
                                    local WeaponRange = Tool:WaitForChild("Range")
                                    local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                        ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                    }
                                    if SilentAim and Mango.Locals.SilentAimTarget then
                                        AimPosition = HitPosition
                                    else
                                        AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                    end
                                    local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                        ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle,
                                        ["ForcedOrigin"] = (ForcedOrigin and ForcedOrigin.WorldPosition) or (ToolHandle.CFrame * WeaponOffset).Position,
                                        ["AimPosition"] = AimPosition, ["BeamColor"] = Color3.new(1, 0.545098, 0.14902),
                                        ["LegitPosition"] = (ForcedOrigin and ForcedOrigin.WorldPosition) or (ToolHandle.CFrame * WeaponOffset).Position + DaHood.GetAim((ForcedOrigin and ForcedOrigin.WorldPosition) or (ToolHandle.CFrame * WeaponOffset).Position) * 200,
                                        ["Range"] = WeaponRange.Value
                                    })
                                    Arg0, Arg1, Arg2 = ApplyDamageOverride(Arg0, Arg1, Arg2)
                                    if not ShouldConserveAmmo(Arg1) then
                                        -- Sync mouse position with server before firing so bullet registers
                                        if SilentAim and Mango.Locals.SilentAimTarget and HitPosition then
                                            local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                            pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, HitPosition) end)
                                        end
                                        ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2)
                                    end
                                    ToolEvent:FireServer()
                                end
                            elseif Gun == "Auto" then
                                local cooldownCheck = canShootNow
                                if cooldownCheck and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                    Ticks[Tool.Name] = tick()
                                    ToolEvent:FireServer("Shoot")
                                    local Flag = true
                                    task.spawn(function()
                                        while Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter))) do
                                            local CurrentTime = workspace:GetServerTimeNow()
                                            for _ = 1, 5 do
                                                -- Refresh HitPosition per pellet for freshest aim data at rapid fire rates
                                                local HitPosition = Mango.Locals.HitPosition
                                                local SpreadX
                                                local SpreadY
                                                local SpreadZ
                                                -- Default spread without Enhancements
                                                SpreadX = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                                SpreadY = math.random() > 0.5 and math.random() * 0.1 or -math.random() * 0.1
                                                SpreadZ = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                                -- Apply Spread Modification (Normal or Randomizer)
                                                local spreadMultiplier = CalculateSpreadMultiplier(Tool.Name)
                                                if spreadMultiplier ~= nil then
                                                    SpreadX = SpreadX * spreadMultiplier
                                                    SpreadY = SpreadY * spreadMultiplier
                                                    SpreadZ = SpreadZ * spreadMultiplier
                                                end
                                                local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                                    ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                                }
                                                local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ)
                                                local AimPosition
                                                if SilentAim and Mango.Locals.SilentAimTarget then
                                                    AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * 200
                                                else
                                                    AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * 200
                                                end
                                                local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                                    ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle, ["AimPosition"] = AimPosition,
                                                    ["BeamColor"] = Color3.new(1, 0.545098, 0.14902), ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                                    ["LegitPosition"] = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * 200,
                                                    ["Range"] = 200
                                                })
                                                Arg0, Arg1, Arg2 = ApplyDamageOverride(Arg0, Arg1, Arg2)
                                                if not ShouldConserveAmmo(Arg1) then
                                                    -- Sync mouse position with server before firing so bullet registers
                                                    local _HitPos = Mango.Locals.HitPosition or HitPosition
                                                    if SilentAim and Mango.Locals.SilentAimTarget and _HitPos then
                                                        local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                                        pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, _HitPos) end)
                                                    end
                                                    ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, CurrentTime)
                                                end
                                            end
                                            task.wait(GetWeaponDelay(Cooldown + 0.0095))
                                            Ticks[Tool.Name] = tick()
                                        end
                                        ToolEvent:FireServer()
                                    end)
                                    Tool.Deactivated:Wait()
                                    Flag = false
                                end
                            elseif Gun == "Burst" then
                                local Tolerance = Tool:WaitForChild("ToleranceCooldown").Value
                                local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value; local toleranceCheck = tick() - Ticks[Tool.Name] >= GetWeaponDelay(Tolerance)
                                if toleranceCheck and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                    Ticks[Tool.Name] = tick()
                                    ToolEvent:FireServer("Shoot")
                                    workspace:GetServerTimeNow()
                                    task.spawn(function()
                                        for _ = 1, NoClueWhatThisIs.Value > 3 and 3 or NoClueWhatThisIs.Value do
                                            local HitPosition = Mango.Locals.HitPosition
                                            local v17
                                            local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                                ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                            }
                                            if SilentAim and Mango.Locals.SilentAimTarget then
                                                v17 = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                                --v17 = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                            else
                                                v17 = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                            end
                                            local v18, v19, v20 = DaHood.ShootGun({
                                                ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle, ["ForcedOrigin"] = ForcedOrigin.WorldPosition, ["AimPosition"] = v17,
                                                ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,
                                                ["BeamColor"] = Color3.new(1, 0.545098, 0.14902),
                                                ["Range"] = 200
                                            })
                                            v18, v19, v20 = ApplyDamageOverride(v18, v19, v20)
                                            if not ShouldConserveAmmo(v19) then
                                                -- Sync mouse position with server before firing so bullet registers
                                                if SilentAim and Mango.Locals.SilentAimTarget and HitPosition then
                                                    local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                                    pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, HitPosition) end)
                                                end
                                                ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                            end
                                            task.wait(GetWeaponDelay(ShootingCool + 0.0095))
                                        end
                                        ToolEvent:FireServer()
                                    end)
                                end
                            elseif Gun == "Rifle" or GunType == "SMG" then
                                local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value; local cooldownCheck = canShootNow
                                if cooldownCheck and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                    Ticks[Tool.Name] = tick()
                                    ToolEvent:FireServer("Shoot")
                                    local Flag = true
                                    task.spawn(function()
                                        while task.wait(GetWeaponDelay(ShootingCool + 0.0095)) and (Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter)))) do
                                            local HitPosition = Mango.Locals.HitPosition
                                            local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                                ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                            }
                                            local AimPosition
                                            if SilentAim and Mango.Locals.SilentAimTarget then
                                                AimPosition =  ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                            else
                                                AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                            end
                                            local v18, v19, v20 = DaHood.ShootGun({
                                                ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle, ["ForcedOrigin"] = ForcedOrigin.WorldPosition, ["AimPosition"] = AimPosition,
                                                ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,
                                                ["BeamColor"] = Color3.new(1, 0.545098, 0.14902),
                                                ["Range"] = 200
                                            })
                                            v18, v19, v20 = ApplyDamageOverride(v18, v19, v20)
                                            if not ShouldConserveAmmo(v19) then
                                                -- Sync mouse position with server before firing so bullet registers
                                                if SilentAim and Mango.Locals.SilentAimTarget and HitPosition then
                                                    local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                                    pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, HitPosition) end)
                                                end
                                                ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                            end
                                            Ticks[Tool.Name] = tick()
                                        end
                                        ToolEvent:FireServer()
                                    end)
                                    Tool.Deactivated:Wait()
                                    Flag = false
                                end
                            elseif Gun == "Sniper" then
                                local cooldownCheck = canShootNow
                                if cooldownCheck and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                    Ticks[Tool.Name] = tick()
                                    ToolEvent:FireServer("Shoot")
                                    local HitPosition = Mango.Locals.HitPosition; local WeaponRange = Tool:WaitForChild("Range")
                                    local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                        ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                    }
                                    local AimPosition
                                    if SilentAim and Mango.Locals.SilentAimTarget then
                                        AimPosition =  ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 50
                                    else
                                        AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50
                                    end
                                    local v16, v17, v18 = DaHood.ShootGun({
                                        ["Shooter"] = LocalCharacter, ["Handle"] = ToolHandle, ["ForcedOrigin"] = ForcedOrigin.WorldPosition, ["AimPosition"] = AimPosition,
                                        ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50,
                                        ["BeamColor"] = Color3.new(1, 0.545098, 0.14902),
                                        ["Range"] = WeaponRange.Value
                                    })
                                    v16, v17, v18 = ApplyDamageOverride(v16, v17, v18)
                                    if ShouldConserveAmmo(v17) then return end
                                    -- Sync mouse position with server before firing so bullet registers
                                    if SilentAim and Mango.Locals.SilentAimTarget and HitPosition then
                                        local _Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                                        pcall(function() ReplicatedStorage.MainEvent:FireServer(_Updater, HitPosition) end)
                                    end
                                    ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v16, v17, v18)
                                    ToolEvent:FireServer()
                                end
                            end
                        end
                        local function shouldShoot(target)
                            local allConditionsPassed = true
                            -- Get current mode and checks from OLD config
                            local selectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'; local conditions = getgenv().Prey.Main.Target.Unlock
                            -- In OLD config, Unlock only has Knocked and Grabbed
                            if conditions.Knocked and Player.IsKnocked(target) then allConditionsPassed = false end
                            if conditions.Grabbed and Player.IsGrabbed(target) then allConditionsPassed = false end
                            -- Distance Check
                            local distanceConfig = getgenv().Prey.Combat['Distance Check']
                            if distanceConfig and distanceConfig.Enabled then
                                local maxDistance = distanceConfig['Max Distance'] or 300; local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                                if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                                    maxDistance = distanceConfig.Guns[tool.Name]
                                end
                                local selfHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart'); local targetHRP = target:FindFirstChild('HumanoidRootPart')
                                if selfHRP and targetHRP then
                                    local playerDistance = (selfHRP.Position - targetHRP.Position).Magnitude
                                    if playerDistance > maxDistance then allConditionsPassed = false end
                                end
                            end
                            -- Silent Aim requires 2D box focus
                            return allConditionsPassed
                        end
                        if Mango.Locals.SilentAimTarget and Mango.Locals.SilentAimTarget.Character then
                            local target = Mango.Locals.SilentAimTarget.Character
                            ShootFunc(Gun, shouldShoot(target) and (Mango.Locals.IsBoxFocused or Mango.Locals.TriggerbotActive))
                        else
                            ShootFunc(Gun, false)
                        end
                    else
                        local function shouldShoot(target)
                            local allConditionsPassed = true
                            -- Get current mode and checks from OLD config
                            local selectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'; local conditions = getgenv().Prey.Main.Target.Unlock
                            -- In OLD config, Unlock only has Knocked and Grabbed
                            if conditions.Knocked and Player.IsKnocked(target) then allConditionsPassed = false end
                            if conditions.Grabbed and Player.IsGrabbed(target) then allConditionsPassed = false end
                            -- Distance Check
                            local distanceConfig = getgenv().Prey.Combat['Distance Check']
                            if distanceConfig and distanceConfig.Enabled then
                                local maxDistance = distanceConfig['Max Distance'] or 300; local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                                if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                                    maxDistance = distanceConfig.Guns[tool.Name]
                                end
                                local selfHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart'); local targetHRP = target:FindFirstChild('HumanoidRootPart')
                                if selfHRP and targetHRP then
                                    local playerDistance = (selfHRP.Position - targetHRP.Position).Magnitude
                                    if playerDistance > maxDistance then allConditionsPassed = false end
                                end
                            end
                            -- Silent Aim requires 2D box focus
                            return allConditionsPassed
                        end
                        if Mango.Locals.SilentAimTarget and Mango.Locals.SilentAimTarget.Character then
                            local target = Mango.Locals.SilentAimTarget.Character
                            -- Try to use CurrentGame if available, otherwise use fallback
                            local Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                            local Remote = CurrentGame and CurrentGame.Functions.RemotePath() or game.ReplicatedStorage.MainEvent
                            local canFireGeneric = Mango.Locals.IsBoxFocused or Mango.Locals.TriggerbotActive
                            if Updater and Remote and shouldShoot(target) and canFireGeneric then
                                -- Use standard Da Hood format
                                local Send = { [1] = Updater, [2] = Mango.Locals.HitPosition }
                                Remote:FireServer(unpack(Send))
                            end
                        end
                    end
                end
            end
            local function ActivateTool()
                local Tool = Self.Character:FindFirstChildOfClass("Tool")
                if Tool ~= nil and Tool:IsDescendantOf(Self.Character) then Tool:Activate() end
            end
            local function CheckMagnitudeFromMouse(Position, HitScan)
                local Resume = true
                local MagnitudeY = (Vector2.new(0, Mouse.Y + 35)-Vector2.new(0, Position.Y)).Magnitude
                local MagnitudeX = (Vector2.new(Mouse.X, 0)-Vector2.new(Position.X, 0)).Magnitude
                if (MagnitudeX > HitScan.X or MagnitudeY > HitScan.Y) then Resume = false end
                return Resume
            end
--[[
local function CamlockChecksPassed()
    local checks = getgenv().Prey.Combat.Camlock.Checks
    local camera = workspace.CurrentCamera; local rightClickHeld = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    -- zoom distance between camera and its focus
    local zoomDistance = (camera.CFrame.Position - camera.Focus.Position).Magnitude; local isFirstPerson = zoomDistance < 1; local isThirdPerson = zoomDistance >= 1
    -- Apply checks
    local firstPersonOk = (not checks["First Person"]) or (checks["First Person"] and isFirstPerson)
    local thirdPersonOk = (not checks["Third Person"]) or (checks["Third Person"] and isThirdPerson)
    local rightClickOk = (not checks["Right Clicking"]) or (checks["Right Clicking"] and rightClickHeld)
    return firstPersonOk and thirdPersonOk and rightClickOk
end
]]
local function IsPriority(Player)
    for _, Client in ipairs(Environment.Priority) do
        if Client == Player then return true end
    end
    return false
end
--
local function AddPriority(Player)
    if not IsPriority(Player) then table.insert(Environment.Priority, Player) end
end
--
local function RemovePriority(Player)
    for i, p in ipairs(Environment.Priority) do
        if p == Player then
            table.remove(Environment.Priority, i)
            return
        end
    end
end
--
local Players = game:GetService("Players"); local Workspace = game:GetService("Workspace"); local Camera = Workspace.CurrentCamera; local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
--
local function GetPriorityTargetInFOV(featureName)
    if not Environment or not Environment.Priority or #Environment.Priority == 0 then return nil end
    local feat = featureName or 'Aimbot'
    for _, plr in ipairs(Environment.Priority) do
        if plr and plr.Parent and plr.Character then
            local char = plr.Character
            local checks = getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock or {}
            if not IsDead(char) and not (checks.Knocked and IsKnocked(char)) and not (checks.Grabbed and IsGrabbed(char)) then
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                if root then
                    -- Target MUST be fully visible (Head, Torso, and HRP not behind walls/buildings/mountains)
                    if not IsTargetFullyVisible(char) then continue end
                    -- Mouse cursor MUST be inside target's 2D or 3D FOV box
                    if IsCursorInTargetBox(root, root.Position, feat) then return plr end
                end
            end
        end
    end
    return nil
end
local function GetBestPriorityTarget()
    local targetInFOV = GetPriorityTargetInFOV('Aimbot')
    if targetInFOV then return targetInFOV end
    if not Environment or not Environment.Priority or #Environment.Priority == 0 then return nil end
    local closestPlayer = nil; local closestDist = math.huge; local mousePos = Vector2.new(Mouse.X, Mouse.Y)
    for _, plr in ipairs(Environment.Priority) do
        if plr and plr.Parent and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head")
            if root then
                local worldPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local dist = (mousePos - Vector2.new(worldPos.X, worldPos.Y)).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestPlayer = plr
                    end
                end
            end
        end
    end
    return closestPlayer or Environment.Priority[1]
end
local function SelectPriority()
    local ClosestPlayer = nil; local ClosestDistance = math.huge; local SelectionRadius = 350
    local checks = getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock
    local allowThroughWalls = checks and checks['Through Walls'] == true
    for _, PossiblePriority in pairs(Players:GetPlayers()) do
        if PossiblePriority == LocalPlayer then continue end
        if IsPlayerProtected and IsPlayerProtected(PossiblePriority) then continue end
        local Character = PossiblePriority.Character; local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if RootPart and Character:IsDescendantOf(Workspace) then
            if checks and checks.Knocked and Player.IsKnocked(Character) then continue end
            if checks and checks.Grabbed and Player.IsGrabbed(Character) then continue end
            -- If Through Walls is strictly false, don't lock onto targets behind walls
            if not allowThroughWalls and IsBehindWall(Camera.CFrame.Position, RootPart, Character) then continue end
            local WorldPos, onScreen = Camera:WorldToViewportPoint(RootPart.Position)
            if onScreen then
                local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(WorldPos.X, WorldPos.Y)).Magnitude
                if Distance < ClosestDistance and Distance < SelectionRadius then
                    ClosestDistance = Distance
                    ClosestPlayer = PossiblePriority
                end
            end
        end
    end
    if ClosestPlayer then
        -- Multi-target lock toggle logic:
        if IsPriority(ClosestPlayer) then RemovePriority(ClosestPlayer) else AddPriority(ClosestPlayer) end
    else
        -- Clicking/pressing lock keybind in open space untoggles ALL locked targets
        Environment.Priority = {}
    end
    if #Environment.Priority > 0 then
        AimAssistActive = true
        Mango.Locals.LockedTarget = Environment.Priority[1]
        local activeInFOV = GetPriorityTargetInFOV('Aimbot')
        if activeInFOV then
            Mango.Locals.AimAssistTarget = activeInFOV
            Mango.Locals.SilentAimTarget = activeInFOV
        else
            Mango.Locals.AimAssistTarget = nil
            Mango.Locals.SilentAimTarget = nil
        end
    else
        Mango.Locals.AimAssistTarget = nil
        Mango.Locals.LockedTarget = nil
        Mango.Locals.SilentAimTarget = nil
        AimAssistActive = false
    end
end
--
local function ClearPriority() Environment.Priority = {} end
            local function Clean(tbl)
                for player, element in pairs(tbl) do
                    if not IsPriority(player) or not player.Parent then
                        element:Remove()
                        tbl[player] = nil
                    end
                end
            end
            local function IsFriendly(Player)
                if Player:IsFriendsWith(Self.UserId) then return false else return true end
            end
            --[[
                        local function DrawESP()
                local Script = shared["F​F​l​a​g​A​X​C​o​m​b​i​n​e​G​e​t​O​u​t​f​i​t​D​i​s​p​a​t​c​h​e​s​I​X​P​2"]
                local RAID_Enabled = Script["Raid Awareness"].Enabled; local Priority = Environment.Priority; local CanDraw = true
                --
                if RAID_Enabled then
                    for i = #Priority, 1, -1 do
                        local Player = Priority[i]
                        if not Player or not Player.Character then
                            Lithium:ClearPlayerData(Player)
                        else
                            local RootPart = Player.Character and Player.Character:FindFirstChild('HumanoidRootPart')
                            if not RootPart then return end
                            --
                            if not Client or not Client.Character then return end
                            --
                            local Distance = Client.Character.HumanoidRootPart and (RootPart.Position - Client.Character.HumanoidRootPart.Position).Magnitude or 0
                            local HeadInst = Player.Character and Player.Character:FindFirstChild("Head")
                            local HeadPos = HeadInst and (HeadInst.Position + Vector3new(0, 0.8, 0)) or (RootPart.Position + Vector3new(0, 2.6, 0))
                            local FeetPos = RootPart.Position - Vector3new(0, 3.0, 0)
                            local Top2D, TopVis = Camera:WorldToViewportPoint(HeadPos)
                            local Bot2D, BotVis = Camera:WorldToViewportPoint(FeetPos); local Position, Visible = Camera:WorldToViewportPoint(RootPart.Position)
                            local Flag = not Lithium:IsFriendly(Player) and getgenv().Script.Visuals['Specific ESP'].AllyColor or getgenv().Script.Visuals['Specific ESP'].EnemyColor
                            local Box = true
                            if Box and Visible and TopVis and BotVis and Position.Z > 0 and Top2D.Z > 0 and Bot2D.Z > 0 then
                                if not Table.Corners[Player] then
                                    Table.Corners[Player] = {}
                                    for i = 1, 8 do
                                        Table.Corners[Player][i] = Overlay.new('Line')
                                        Table.Corners[Player][i].Thickness = 1
                                        Table.Corners[Player][i].Transparency = 1
                                        Table.Corners[Player][i].Color = Flag
                                    end
                                end
                                local rawH = math.abs(Bot2D.Y - Top2D.Y)
                                local BoxHeight = rawH; local BoxWidth = rawH * 0.6; local BoxPosition = Vector2new(Position.X - BoxWidth / 2, math.min(Top2D.Y, Bot2D.Y))
                                local L_Width = (BoxWidth / 5); local L_Height = (BoxHeight / 6); local L_T = 2
                                -- Top left
                                Table.Corners[Player][1].From = Vector2new(BoxPosition.X - L_T, BoxPosition.Y - L_T)
                                Table.Corners[Player][1].To = Vector2new(BoxPosition.X + L_Width, BoxPosition.Y - L_T)
                                Table.Corners[Player][2].From = Vector2new(BoxPosition.X - L_T, BoxPosition.Y - L_T)
                                Table.Corners[Player][2].To = Vector2new(BoxPosition.X - L_T, BoxPosition.Y + L_Height)
                                -- Top right
                                Table.Corners[Player][3].From = Vector2new(BoxPosition.X + BoxWidth - L_Width, BoxPosition.Y - L_T)
                                Table.Corners[Player][3].To = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y - L_T)
                                Table.Corners[Player][4].From = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y - L_T)
                                Table.Corners[Player][4].To = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y + L_Height)
                                -- Bottom left
                                Table.Corners[Player][5].From = Vector2new(BoxPosition.X - L_T, BoxPosition.Y + BoxHeight - L_Height)
                                Table.Corners[Player][5].To = Vector2new(BoxPosition.X - L_T, BoxPosition.Y + BoxHeight + L_T)
                                Table.Corners[Player][6].From = Vector2new(BoxPosition.X - L_T, BoxPosition.Y + BoxHeight + L_T)
                                Table.Corners[Player][6].To = Vector2new(BoxPosition.X + L_Width, BoxPosition.Y + BoxHeight + L_T)
                                -- Bottom right
                                Table.Corners[Player][7].From = Vector2new(BoxPosition.X + BoxWidth - L_Width, BoxPosition.Y + BoxHeight + L_T)
                                Table.Corners[Player][7].To = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y + BoxHeight + L_T)
                                Table.Corners[Player][8].From = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y + BoxHeight + L_T)
                                Table.Corners[Player][8].To = Vector2new(BoxPosition.X + BoxWidth + L_T, BoxPosition.Y + BoxHeight - L_Height)
                                local mainUnlock = getgenv().Prey and getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock
                                local isWallBlocked = (mainUnlock and mainUnlock['Through Walls'] == false and IsBehindWall(Camera.CFrame.Position, RootPart, Player.Character))
                                for _, Line in ipairs(Table.Corners[Player]) do
                                    Line.Visible = CanDraw and Visible and not isWallBlocked
                                    Line.Color = Flag
                                    Line.Transparency = getgenv().Script.Visuals['Specific ESP'].Transparency
                                    Line.Thickness = getgenv().Script.Visuals['Specific ESP'].Thickness
                                end
                            end
                            --
                            if Modules.Name.Visible then
                                local Text = Table.Texts[Player]
                                if not Text then
                                    Text = Overlay.new('Text')
                                    Text.Size = Modules.Name.Size
                                    Text.Outline = Modules.Name.Outline
                                    Text.OutlineColor = Modules.Name.OutlineColor
                                    Text.Color = Flag
                                    Text.Center = true
                                    Text.Transparency = Modules.Name.Transparency
                                    Table.Texts[Player] = Text
                                end
                                local boxSize = Vector2new(Floor(CharacterSize * 1.8), Floor(CharacterSize * 1.9))
                                local boxPosition = Vector2new(Floor(Position.X - CharacterSize * 1.8 / 2), Floor(Position.Y - CharacterSize * 1.6 / 2))
                                Text.Visible = CanDraw and Visible or false
                                Text.Text = Player.DisplayName
                                Text.Position = Vector2new(boxPosition.X + boxSize.X / 2, boxPosition.Y + boxSize.Y + 5)
                            end
                            --
                            if Modules.Distance.Visible then
                                local Text = Table.Distance[Player]
                                if not Text then
                                    Text = Overlay.new('Text')
                                    Text.Size = Modules.Distance.Size
                                    Text.Outline = Modules.Distance.Outline
                                    Text.OutlineColor = Modules.Distance.OutlineColor
                                    Text.Color = Flag
                                    Text.Center = true
                                    Text.Transparency = Modules.Distance.Transparency
                                    Table.Distance[Player] = Text
                                end
                                local boxSize = Vector2new(Floor(CharacterSize * 1.8), Floor(CharacterSize * 1.9))
                                local boxPosition = Vector2new(Floor(Position.X - CharacterSize * 1.8 / 2), Floor(Position.Y - CharacterSize * 1.6 / 2))
                                Text.Visible = CanDraw and Visible or false
                                Text.Text = tostring(Floor(Distance)) .. ' std'
                                Text.Position = Vector2new(boxPosition.X + boxSize.X / 2, boxPosition.Y + boxSize.Y + 15)
                            end
                        end
                    end
                else
                    for _, lines in pairs(Table.Corners) do
                        for _, Line in ipairs(lines) do
                            Line:Remove()
                        end
                    end
                    for _, lines in pairs(Table.Outlines) do
                        for _, Line in ipairs(lines) do
                            Line:Remove()
                        end
                    end
                    Table.Outlines = {}
                    Table.Corners = {}
                    Table.Distance = {}
                    Table.Texts = {}
                    Raid.Players = {}
                end
            end]]
            return {
                UpdateBox = UpdateBox, IsPointInTarget2DBox = IsPointInTarget2DBox, SilentAim = SilentAim, GetGunCategory = GetGunCategory, SelectPriority = SelectPriority,
                ClearPriority = ClearPriority
            }
        end
    end
end)()
--
local Main = Modules.Get("Main"); local Player = Modules.Get("Player"); local Utility = Modules.Get("Utility"); local ScreenGui = Modules.Get("ScreenGui")
local function IsSilentAimWeaponAllowed(toolName)
    if not toolName then return true end
    local saCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Silent Aim']; local weaponCfg = saCfg and saCfg['Weapon Configuration']
    if type(weaponCfg) == 'table' and weaponCfg[toolName] ~= nil then return weaponCfg[toolName] == true end
    return IsGunAllowed('Combat', 'Silent Aim', toolName)
end
if IsHoodCustoms() then
    local HCPositionCache = {}
    local HCPositionHistorySize = 8; local HCPositionSampleInterval = 0.03; local HCLastPositionCacheUpdate = 0
    local function HCUpdatePositionCache()
        local now = tick()
        if (now - HCLastPositionCacheUpdate) < HCPositionSampleInterval then return end
        HCLastPositionCacheUpdate = now
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Self then continue end
            local char = plr.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                if not HCPositionCache[plr] then HCPositionCache[plr] = {} end
                local cache = HCPositionCache[plr]; local lastEntry = cache[1]
                if not lastEntry or (now - lastEntry.Time) >= HCPositionSampleInterval then
                    table.insert(cache, 1, { Position = root.Position, Time = now })
                    if #cache > HCPositionHistorySize then cache[#cache] = nil end
                end
            end
        end
        for plr in pairs(HCPositionCache) do
            if not plr.Parent then HCPositionCache[plr] = nil end
        end
    end
    local function HCGetDeltaVelocity(plr)
        local cache = HCPositionCache[plr]
        if not cache or #cache < 2 then return Vector3.zero end
        local newest = cache[1]; local older = cache[2]; local deltaTime = newest.Time - older.Time
        if deltaTime <= 0.001 then return Vector3.zero end
        local velocity = (newest.Position - older.Position) / deltaTime; local magnitude = velocity.Magnitude
        if magnitude > 300 then velocity = (velocity / magnitude) * 300 end
        return velocity
    end
    local function HCSmoothedVelocity(plr)
        local cache = HCPositionCache[plr]
        if not cache or #cache < 3 then return HCGetDeltaVelocity(plr) end
        local totalVel = Vector3.zero; local weights = 0
        for i = 1, math.min(#cache - 1, 5) do
            local newer = cache[i]; local older = cache[i + 1]; local dt = newer.Time - older.Time
            if dt > 0.001 then
                local w = 1 / i
                totalVel = totalVel + ((newer.Position - older.Position) / dt) * w
                weights = weights + w
            end
        end
        if weights == 0 then return Vector3.zero end
        local vel = totalVel / weights; local mag = vel.Magnitude
        if mag > 300 then vel = (vel / mag) * 300 end
        return vel
    end
    local function HCGetSilentAimCfg()
        local sa = getgenv().Prey.Combat["Silent Aim"] or {}
        local hitPart = sa.HitPart or "ClosestPart"
        local partMap = { ClosestPart = "Closest Part", ClosestPoint = "Closest Point", Head = "Head", HumanoidRootPart = "HumanoidRootPart", }
        local cpScale = sa["Closest Point Scale"] or {}
        return { ["Hit Location"] = { ["Part"] = partMap[hitPart] or hitPart, ["Closest Point"] = { ["Scale"] = { cpScale.Enabled == true, cpScale.Scale or 0.32, },
                }, },
            ["Prediction"] = {
                ["Enabled"] = sa.Prediction and sa.Prediction.Enabled or false,
                ["Values"] = {
                    ["X"] = sa.Prediction and sa.Prediction.X or 0.135, ["Y"] = sa.Prediction and sa.Prediction.Y or 0.135,
                    ["Z"] = sa.Prediction and (sa.Prediction.Z or sa.Prediction.X) or 0.135, }, },
        }
    end
    local function HCGetClosestPartToCursor(character)
        local mousePos = UserInputService:GetMouseLocation(); local closest = nil; local bestDist = math.huge
        for _, part in ipairs(character:GetChildren()) do
            if not part:IsA("BasePart") then continue end
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if not onScreen then continue end
            local dist = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
            if dist < bestDist then
                bestDist = dist
                closest = part
            end
        end
        return closest
    end
    local function HCGetNearestPointOnPart(part, plane, offset)
        local mousePos = UserInputService:GetMouseLocation()
        local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local intersection = ray.Origin + (ray.Direction * ray.Direction:Dot(part.Position - ray.Origin))
        local transform = part.CFrame:PointToObjectSpace(intersection); local reduction = offset or 0; local reducedSize = part.Size - (part.Size * reduction)
        if plane == "Vertical" then reducedSize = reducedSize * Vector3.new(1, 1, 0) end
        local half = reducedSize / 2
        return part.CFrame * Vector3.new(
            math.clamp(transform.X, -half.X, half.X), math.clamp(transform.Y, -half.Y, half.Y),
            math.clamp(transform.Z, -half.Z, half.Z)
        )
    end
    local function HCResolveHitPosition(targetChar, featureCfg)
        local hitLocCfg = featureCfg["Hit Location"]; local partSetting = hitLocCfg["Part"] or "Head"; local closestPointCfg = hitLocCfg["Closest Point"]
        if partSetting == "Closest Part" then
            local part = HCGetClosestPartToCursor(targetChar)
            if part then
                local scaleCfg = closestPointCfg and closestPointCfg["Scale"]
                if scaleCfg and scaleCfg[1] then
                    local offset = scaleCfg[2] or 0.7
                    return HCGetNearestPointOnPart(part, "Vertical", offset), part
                end
                return part.Position, part
            end
        elseif partSetting == "Closest Point" then
            local part = HCGetClosestPartToCursor(targetChar)
            if part then
                local scaleCfg = closestPointCfg and closestPointCfg["Scale"]; local useScale = scaleCfg and scaleCfg[1] or false; local offset = useScale and scaleCfg[2] or 0.7
                return HCGetNearestPointOnPart(part, "Vertical", offset), part
            end
        else
            local part = targetChar:FindFirstChild(partSetting)
            if part then return part.Position, part end
            for _, partName in ipairs({ "Head", "UpperTorso", "Torso", "HumanoidRootPart" }) do
                if partName ~= partSetting then
                    local fallbackPart = targetChar:FindFirstChild(partName)
                    if fallbackPart then return fallbackPart.Position, fallbackPart end
                end
            end
        end
        local hrp = targetChar:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp.Position, hrp end
        return nil, nil
    end
    local function HCApplyPrediction(position, target, featureCfg)
        if not target or not target.Character then return position end
        local predCfg = featureCfg["Prediction"]
        if not predCfg or not predCfg["Enabled"] then return position end
        local currentTool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
        local toolName = currentTool and currentTool.Name or ""; local futureCfg = GetFutureConfigFor('Silent Aim')
        if futureCfg then return ApplyFuture(position, target, toolName, futureCfg) end
        local vel = HCSmoothedVelocity(target)
        if vel.Magnitude < 5 then return position end
        local predValues = predCfg["Values"] or { X = 0.135, Y = 0.135, Z = 0.135 }
        local px = predValues.X or predValues["X"] or 0.135
        local py = predValues.Y or predValues["Y"] or 0.135; local pz = predValues.Z or predValues["Z"] or px; local predPos = position + vel * Vector3.new(px, py, pz)
        local maxPredDist = 15
        if (predPos - position).Magnitude > maxPredDist then predPos = position + (predPos - position).Unit * maxPredDist end
        return predPos
    end
    local function HCPassesConditions(targetPlayer)
        if not targetPlayer or not targetPlayer.Character then return false end
        local char = targetPlayer.Character; local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false end
        local unlock = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock or {}
        if unlock.Knocked and Player.IsKnocked(char) then return false end
        if unlock.Grabbed and Player.IsGrabbed(char) then return false end
        return true
    end
    local function HCIsSilentActive()
        local saCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat["Silent Aim"]
        local isTriggerOn = Mango.Locals.TriggerbotActive or TriggerbotActive or (getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot and getgenv().Prey.Combat.Triggerbot.Enabled == true)
        local target = Mango.Locals.SilentAimTarget
        if not ((saCfg and saCfg.Enabled or isTriggerOn) and target and target.Parent and target.Character) then return false end
        if not (Mango.Locals.IsBoxFocused or isTriggerOn) then return false end
        local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
        if tool and not IsSilentAimWeaponAllowed(tool.Name) then return false end
        return true
    end
    local function HCGetSpoofedHit()
        local target = Mango.Locals.SilentAimTarget
        if not target or not HCPassesConditions(target) then return nil end
        local saCfg = HCGetSilentAimCfg(); local pos = HCResolveHitPosition(target.Character, saCfg)
        if not pos then return nil end
        return HCApplyPrediction(pos, target, saCfg)
    end
    Utility.Connection(RunService.Heartbeat, function() HCUpdatePositionCache() end)
    pcall(function()
        local Mt = getrawmetatable(game); local OldIndex = Mt.__index
        setreadonly(Mt, false)
        Mt.__index = function(self, key)
            if (key == "MAP" or key == "Map") and (self == workspace or self == game:GetService("Workspace")) then
                local mapInst = nil
                pcall(function() mapInst = OldIndex(self, key) end)
                if mapInst then return mapInst end
                local ignoredFolder = workspace:FindFirstChild("Ignored")
                if ignoredFolder then
                    local mapInIgnored = ignoredFolder:FindFirstChild("MAP") or ignoredFolder:FindFirstChild("Map")
                    if mapInIgnored then return mapInIgnored end
                end
            end
            if checkcaller() or self ~= Mouse then return OldIndex(self, key) end
            if key ~= "Hit" and key ~= "Target" then return OldIndex(self, key) end
            if not HCIsSilentActive() then return OldIndex(self, key) end
            local target = Mango.Locals.SilentAimTarget
            if not HCPassesConditions(target) then return OldIndex(self, key) end
            local saCfg = getgenv().Prey.Combat['Silent Aim']; local chance = saCfg and saCfg['Hit Chance']
            if chance and chance > 0 and chance < 100 then
                if math.random(1, 100) > chance then return OldIndex(self, key) end
            end
            local rootPart = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Head")
            local isTargetLocked = (Mango.Locals.LockedTarget ~= nil) or (Environment and Environment.Priority and #Environment.Priority > 0)
            local isTriggerFiring = Mango.Locals.TriggerbotActive or TriggerbotActive or (getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot and getgenv().Prey.Combat.Triggerbot.Enabled == true)
            local isInsideTargetBox = IsCursorInTargetBox(rootPart, rootPart.Position, 'Silent') or (isTriggerFiring and IsCursorInTargetBox(rootPart, rootPart.Position, 'Triggerbot'))
            if not rootPart or (not isTargetLocked and not isInsideTargetBox) then return OldIndex(self, key) end
            local pos, hitPart = HCResolveHitPosition(target.Character, HCGetSilentAimCfg())
            if not pos then return OldIndex(self, key) end
            pos = HCApplyPrediction(pos, target, HCGetSilentAimCfg())
            if key == "Hit" then return CFrame.new(pos) end
            if hitPart then return hitPart end
            return OldIndex(self, key)
        end
        setreadonly(Mt, true)
    end)
    pcall(function()
        local MainEvent = ReplicatedStorage:FindFirstChild("MainEvent"); local Mt = getrawmetatable(game); local OldNamecall = Mt.__namecall
        setreadonly(Mt, false)
        Mt.__namecall = function(self, ...)
            local method = getnamecallmethod()
            if (self == workspace or self == game:GetService("Workspace")) and (method == "FindFirstChild" or method == "findFirstChild" or method == "WaitForChild") then
                local args = { ... }
                local arg1 = args[1]
                if arg1 == "MAP" or arg1 == "Map" then
                    local mapInst = nil
                    pcall(function() mapInst = OldNamecall(self, unpack(args)) end)
                    if mapInst then return mapInst end
                    local ignoredFolder = workspace:FindFirstChild("Ignored")
                    if ignoredFolder then
                        local mapInIgnored = ignoredFolder:FindFirstChild("MAP") or ignoredFolder:FindFirstChild("Map")
                        if mapInIgnored then return mapInIgnored end
                    end
                end
            end
            if not checkcaller() and method == "FireServer" and MainEvent and self == MainEvent then
                local args = { ... }
                local remoteArg = args[1]
                if remoteArg == "MousePosUpdate" or remoteArg == "GetMousePos" or remoteArg == "UpdateMousePos" or remoteArg == "UpdateMousePosI2" then
                    local target = Mango.Locals.SilentAimTarget
                    if target and target.Character then
                        local root = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            args[2] = root.Position
                            return OldNamecall(self, unpack(args))
                        end
                    end
                elseif remoteArg == "ShootGun" then
                    local target = Mango.Locals.SilentAimTarget
                    if target and target.Character then
                        local root = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            -- Spoof AimPosition / HitPosition parameter directly to target location
                            args[4] = root.Position
                            return OldNamecall(self, unpack(args))
                        end
                    end
                end
            end
            return OldNamecall(self, ...)
        end
        setreadonly(Mt, true)
    end)
    Mango.HCSilentAim = {
        ResolveHitPosition = HCResolveHitPosition, ApplyPrediction = HCApplyPrediction, GetSilentAimCfg = HCGetSilentAimCfg, PassesConditions = HCPassesConditions,
        IsActive = HCIsSilentActive,
    }
end
-- SP is already declared at top of script (always true for Auto mode)
local SP2 = false; local TriggerbotActive = false
Mango.Locals.TriggerbotActive = false
local AimAssistActive = false; local LastTriggerbotShot = 0; local TriggerBurstCount = 0; local TriggerBurstCooldownUntil = 0
local DoubleTap = false; local SpeedEnabled = false; local AntiGravityActive = false
local function getWeaponRange(tool)
    if not tool then return nil end
    local rangeProps = {"Range", "MaxRange", "FireRange", "Distance", "MaxDistance", "BulletDistance"}
    for _, propName in ipairs(rangeProps) do
        local obj = tool:FindFirstChild(propName)
        if obj and (obj:IsA("NumberValue") or obj:IsA("IntValue")) then return obj.Value end
    end
    local config = tool:FindFirstChild("Configuration") or tool:FindFirstChild("GunConfig") or tool:FindFirstChild("Values")
    if config then
        for _, propName in ipairs(rangeProps) do
            local obj = config:FindFirstChild(propName)
            if obj and (obj:IsA("NumberValue") or obj:IsA("IntValue")) then return obj.Value end
        end
    end
    return nil
end
local function GetDaHoodAimAccuracy()
    local lp = game:GetService("Players").LocalPlayer
    if not lp then return 100 end
    -- 1. EXACT DA HOOD FORMULA: Calculate dynamically from DataFolder.ShotLand / DataFolder.ShotTotal
    local okData, valData = pcall(function()
        local dataFolder = lp:FindFirstChild("DataFolder") or lp:FindFirstChild("Information") or lp:FindFirstChild("leaderstats")
        if dataFolder then
            local shotLand = dataFolder:FindFirstChild("ShotLand") or dataFolder:FindFirstChild("ShotsLanded") or dataFolder:FindFirstChild("Hits")
            local shotTotal = dataFolder:FindFirstChild("ShotTotal") or dataFolder:FindFirstChild("ShotsTotal") or dataFolder:FindFirstChild("Shots")
            if shotLand and shotTotal then
                local landVal = tonumber(shotLand.Value) or 0; local totalVal = tonumber(shotTotal.Value) or 0
                if totalVal > 0 then
                    local rawAcc = (landVal / totalVal) * 100; local roundedAcc = math.floor(rawAcc + 0.5)
                    return math.clamp(roundedAcc, 0, 100)
                end
            end
        end
        return nil
    end)
    if okData and valData ~= nil then return valData end
    -- 2. UI Fallback: Parse visible text labels if DataFolder stats are not populated
    local okUI, valUI = pcall(function()
        local pGui = lp:FindFirstChildOfClass("PlayerGui")
        if not pGui then return nil end
        for _, desc in ipairs(pGui:GetDescendants()) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                local txt = desc.Text or ""
                if txt ~= "" and (txt:lower():find("aim accuracy") or txt:lower():find("accuracy") or desc.Name:lower():find("aimaccuracy")) then
                    local numStr = txt:match(":%s*(%d+%.?%d*)") or txt:match("(%d+%.?%d*)%%"); local num = tonumber(numStr)
                    if num and num > 0 and num <= 100 then return num end
                end
            end
        end
        return nil
    end)
    if okUI and valUI ~= nil then return valUI end
    return 100
end
-- Settings & Stats Button Click Re-Scan Listener
task.spawn(function()
    local lp = game:GetService("Players").LocalPlayer
    if not lp then return end
    local pGui = lp:WaitForChild("PlayerGui", 5)
    if not pGui then return end
    local function attachButtonListeners()
        for _, desc in ipairs(pGui:GetDescendants()) do
            if desc:IsA("TextButton") or desc:IsA("ImageButton") then
                local nLower = desc.Name:lower()
                if nLower:find("setting") or nLower:find("stat") or desc.Text:lower():find("stat") or desc.Text:lower():find("setting") then
                    if not desc:GetAttribute("PreyAccuracyHooked") then
                        desc:SetAttribute("PreyAccuracyHooked", true)
                        desc.MouseButton1Click:Connect(function()
                            task.wait(0.15)
                            GetDaHoodAimAccuracy()
                        end)
                    end
                end
            end
        end
    end
    pGui.DescendantAdded:Connect(function(desc)
        if desc:IsA("TextButton") or desc:IsA("ImageButton") then
            local nLower = desc.Name:lower()
            if nLower:find("setting") or nLower:find("stat") or (desc:IsA("TextButton") and (desc.Text:lower():find("stat") or desc.Text:lower():find("setting"))) then
                desc.MouseButton1Click:Connect(function()
                    task.wait(0.15)
                    GetDaHoodAimAccuracy()
                end)
            end
        end
    end)
    pcall(attachButtonListeners)
end)
--// Connections
;(function()
    ScreenGui.Setup()
    Utility.Connection(RunService.RenderStepped, function()
        if Main and Main.AimAssistCamera then Main.AimAssistCamera() end
    end)
    local function IsBehindWall(origin, targetPart, targetChar)
        if not origin or not targetPart or not targetChar then return false end
        local rayDirection = (targetPart.Position - origin); local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local ignore = {Camera}
        if Self.Character then table.insert(ignore, Self.Character) end
        rayParams.FilterDescendantsInstances = ignore
        local result = workspace:Raycast(origin, rayDirection, rayParams)
        if result and result.Instance then
            if result.Instance:IsDescendantOf(targetChar) then return false else return true end
        end
        return false
    end
    local function IsTargetFullyVisible(targetChar)
        if not targetChar then return false end
        local head = targetChar:FindFirstChild("Head"); local root = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso")
        if head and not IsBehindWall(Camera.CFrame.Position, head, targetChar) then return true end
        if root and not IsBehindWall(Camera.CFrame.Position, root, targetChar) then return true end
        for _, part in ipairs(targetChar:GetChildren()) do
            if part:IsA("BasePart") and not IsBehindWall(Camera.CFrame.Position, part, targetChar) then return true end
        end
        return false
    end
    Utility.ThreadLoop(0, function()
        local triggerbotCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot
        if not triggerbotCfg or not triggerbotCfg.Enabled then return end
        if not TriggerbotActive then return end
        local SelectionMode = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Mode or 'Auto'; local targetPlayer = nil; local targetChar = nil
        local checks = (getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock) or {}
        local hitPartCfg = triggerbotCfg['Hit Part']; local hitPartName = (hitPartCfg and hitPartCfg.Enabled and hitPartCfg.Part) or nil
        local useCrosshairMode = triggerbotCfg['Use Crosshair'] == true or triggerbotCfg['UseCrosshair'] == true or triggerbotCfg['Crosshair Only'] == true
        local function isTargetingChar(char)
            if not char then return false end
            local rawMouse = UserInputService:GetMouseLocation()
            -- 1. Direct 3D raycast from camera mouse position
            local ray = Camera:ViewportPointToRay(rawMouse.X, rawMouse.Y); local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Blacklist
            local ignoreList = {Camera}
            if Self.Character then table.insert(ignoreList, Self.Character) end
            rayParams.FilterDescendantsInstances = ignoreList
            local rayRes = workspace:Raycast(ray.Origin, ray.Direction * 1000, rayParams); local hitInst = rayRes and rayRes.Instance or (Mouse and Mouse.Target)
            if hitInst then
                if hitInst:IsDescendantOf(char) or (hitInst.Parent and (hitInst.Parent == char or hitInst.Parent.Parent == char)) then return true end
            end
            -- 2. Native Mouse.Target fallback check
            if Mouse and Mouse.Target and (Mouse.Target:IsDescendantOf(char) or Mouse.Target.Parent == char) then return true end
            -- 3. Screen point distance check for body parts (handles fast movement & anti-lag)
            local guiInset = game:GetService("GuiService"):GetGuiInset(); local mouseVec = Vector2.new(rawMouse.X - guiInset.X, rawMouse.Y - guiInset.Y)
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen and screenPos.Z > 0 then
                        local partScreenVec = Vector2.new(screenPos.X, screenPos.Y)
                        local dist = (partScreenVec - mouseVec).Magnitude; local partRadius = (part.Name == "Head" and 18) or (part.Name:find("Torso") and 24) or 15
                        if dist <= partRadius then return true end
                    end
                end
            end
            -- If NOT strict Use Crosshair mode, fallback to tight 2D bounding box
            if not useCrosshairMode then
                local mouseX = rawMouse.X - guiInset.X; local mouseY = rawMouse.Y - guiInset.Y; local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
                if hrp then
                    local head = char:FindFirstChild("Head")
                    local rootPos = hrp.Position
                    local headPos = head and (head.Position + Vector3.new(0, 0.8, 0)) or (rootPos + Vector3.new(0, 2.6, 0)); local feetPos = rootPos - Vector3.new(0, 3.0, 0)
                    local top2D, topVis = Camera:WorldToViewportPoint(headPos)
                    local bot2D, botVis = Camera:WorldToViewportPoint(feetPos); local root2D, rootVis = Camera:WorldToViewportPoint(rootPos)
                    if topVis and botVis and rootVis and top2D.Z > 0 and bot2D.Z > 0 and root2D.Z > 0 then
                        local boxH = math.abs(bot2D.Y - top2D.Y); local boxW = boxH * 0.60; local boxX = root2D.X - (boxW / 2); local boxY = math.min(top2D.Y, bot2D.Y)
                        if mouseX >= boxX and mouseX <= boxX + boxW and mouseY >= boxY and mouseY <= boxY + boxH then return true end
                    end
                end
            end
            return false
        end
        -- First check active locked/selected target (Target Mode or Silent Aim target)
        local lockedTarget = Mango.Locals.SilentAimTarget or Mango.Locals.LockedTarget or Mango.Locals.AimAssistTarget
        if lockedTarget and lockedTarget.Character then
            local char = lockedTarget.Character
            local hum = char:FindFirstChildOfClass('Humanoid'); local root = char:FindFirstChild('HumanoidRootPart'); local head = char:FindFirstChild('Head')
            if hum and root and hum.Health > 0 then
                local isKnocked = char:FindFirstChild('BodyEffects') and char.BodyEffects:FindFirstChild('K.O') and char.BodyEffects['K.O'].Value
                local isGrabbed = char:FindFirstChild('GRABBING_CONSTRAINT') ~= nil
                local headBehind = head and IsBehindWall(Camera.CFrame.Position, head, char)
                local rootBehind = IsBehindWall(Camera.CFrame.Position, root, char); local isBehindWall = headBehind and rootBehind
                local maxDistance = 300; local distanceConfig = getgenv().Prey.Combat['Distance Check']
                if distanceConfig then
                    if distanceConfig['Max Distance'] then maxDistance = distanceConfig['Max Distance'] end
                    local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                    if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                        maxDistance = distanceConfig.Guns[tool.Name]
                    end
                end
                local selfHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart')
                local distOk = not selfHRP or ((selfHRP.Position - root.Position).Magnitude <= maxDistance)
                if not (checks.Knocked and isKnocked) and not (checks.Grabbed and isGrabbed) and not isBehindWall and distOk then
                    if useCrosshairMode then
                        if isTargetingChar(char) then
                            targetPlayer = lockedTarget
                            targetChar = char
                        end
                    else
                        if IsCursorInTargetBox(root, root.Position, 'Triggerbot') then
                            targetPlayer = lockedTarget
                            targetChar = char
                        end
                    end
                end
            end
        end
        -- In Target mode, only fire at the locked/selected target (do not scan other players)
        if SelectionMode == 'Target' and not targetPlayer then return end
        -- If no target yet and in Auto mode, scan players whose character is targeted by mouse
        if not targetPlayer then
            local closestDist = math.huge
            for _, player in ipairs(Players:GetPlayers()) do
                if player == Self or not player.Character then continue end
                local char = player.Character
                local hum = char:FindFirstChildOfClass('Humanoid'); local root = char:FindFirstChild('HumanoidRootPart'); local head = char:FindFirstChild('Head')
                if not hum or not root or hum.Health <= 0 then continue end
                local isKnocked = char:FindFirstChild('BodyEffects') and char.BodyEffects:FindFirstChild('K.O') and char.BodyEffects['K.O'].Value
                local isGrabbed = char:FindFirstChild('GRABBING_CONSTRAINT') ~= nil
                if checks.Knocked and isKnocked then continue end
                if checks.Grabbed and isGrabbed then continue end
                local headBehind = head and IsBehindWall(Camera.CFrame.Position, head, char); local rootBehind = IsBehindWall(Camera.CFrame.Position, root, char)
                if headBehind and rootBehind then continue end
                -- Distance check
                local maxDistance = 300; local distanceConfig = getgenv().Prey.Combat['Distance Check']
                if distanceConfig then
                    if distanceConfig['Max Distance'] then maxDistance = distanceConfig['Max Distance'] end
                    local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                    if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                        maxDistance = distanceConfig.Guns[tool.Name]
                    end
                end
                local selfHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart')
                if selfHRP and (selfHRP.Position - root.Position).Magnitude > maxDistance then continue end
                if useCrosshairMode then
                    if isTargetingChar(char) then
                        targetPlayer = player
                        targetChar = char
                        break
                    end
                else
                    -- Check if crosshair/mouse is inside Triggerbot FOV box
                    if IsCursorInTargetBox(root, root.Position, 'Triggerbot') then
                        local rootScreen, onScreen = Camera:WorldToViewportPoint(root.Position)
                        if onScreen and rootScreen.Z > 0 then
                            local guiInset = game:GetService("GuiService"):GetGuiInset()
                            local mousePos = UserInputService:GetMouseLocation()
                            local viewportMouse = Vector2.new(mousePos.X - guiInset.X, mousePos.Y - guiInset.Y)
                            local dist = (Vector2.new(rootScreen.X, rootScreen.Y) - viewportMouse).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                targetPlayer = player
                                targetChar = char
                            end
                        end
                    end
                end
            end
        end
        -- Validate target and fire weapon
        if targetPlayer and targetChar then
            local humanoid = targetChar:FindFirstChildOfClass('Humanoid'); local rootPart = targetChar:FindFirstChild('HumanoidRootPart')
            if not humanoid or humanoid.Health <= 0 or not rootPart then return end
            -- Strict Full Visibility Check (forces true line-of-sight raycast)
            if not IsTargetFullyVisible(targetChar, true) then return end
            -- Check targeting requirement (Use Crosshair raycast hit vs FOV box)
            if useCrosshairMode then
                if not isTargetingChar(targetChar) then return end
            else
                local isInsideTriggerbot = IsCursorInTargetBox(rootPart, rootPart.Position, 'Triggerbot')
                if not isInsideTriggerbot then return end
            end
            -- Check if self is crouching if disabled on crouch
            local selfChar = Self.Character; local selfHum = selfChar and selfChar:FindFirstChildOfClass('Humanoid')
            if triggerbotCfg and triggerbotCfg['Disable On Crouch'] == true and selfHum then
                local isSelfCrouching = selfHum.Crouch or (selfChar:FindFirstChild('BodyEffects') and selfChar.BodyEffects:FindFirstChild('Crouch') and selfChar.BodyEffects.Crouch.Value == true)
                if isSelfCrouching then return end
            end
            -- Shoot equipped tool with delay check
            local Tool = Self.Character and Self.Character:FindFirstChildWhichIsA('Tool')
            if Tool and (Tool:FindFirstChild('Ammo') or Tool:FindFirstChild('Handle')) then
                if not IsGunAllowed('Combat', 'Triggerbot', Tool.Name) then return end
                local weaponConfig = getgenv().Prey.Combat.Triggerbot['Weapon Configuration']
                if weaponConfig and weaponConfig['Enabled'] == true and weaponConfig[Tool.Name] == false then return end
                local fireDelay = GetToolFireDelay(Tool, 0.05)
                if (tick() - LastTriggerbotShot) < fireDelay then return end
                LastTriggerbotShot = tick()
                -- Shot Accuracy gate: 'Percentage' (Da Hood Aim Accuracy stat) or 'Chance' (Custom hit chance)
                local shotAccCfg = triggerbotCfg and triggerbotCfg['Shot Accuracy']
                if shotAccCfg and shotAccCfg['Enabled'] == true then
                    local saMode = shotAccCfg['Mode'] or 'Percentage'; local hitChance = 100
                    if saMode == 'Percentage' then
                        -- Grabs the user's Da Hood "Aim Accuracy" stat from settings / stats UI
                        hitChance = GetDaHoodAimAccuracy()
                    elseif saMode == 'Chance' then
                        -- Custom triggerbot hit chance %
                        hitChance = shotAccCfg['Chance'] or 85
                    end
                    -- Apply Accuracy Scale multiplier (0.85 = ~52% pass rate for 61% accuracy)
                    local scale = shotAccCfg['Scale'] or 0.85; local effectiveChance = math.clamp(math.floor(hitChance * scale), 5, 100)
                    local roll = math.random(1, 100)
                    if roll > effectiveChance then return end
                end
                -- Connect Triggerbot directly to Silent Aim Engine & Mouse Update Remotes
                -- When triggerbot fires inside its FOV, force silent aim to redirect bullets to target
                Mango.Locals.SilentAimTarget = targetPlayer
                Mango.Locals.IsBoxFocused = true
                if IsHoodCustoms() then
                    if Mango.HCSilentAim then
                        local hcCfg = Mango.HCSilentAim.GetSilentAimCfg(); local pos = select(1, Mango.HCSilentAim.ResolveHitPosition(targetChar, hcCfg))
                        if pos then Mango.Locals.HitPosition = Mango.HCSilentAim.ApplyPrediction(pos, targetPlayer, hcCfg) end
                    end
                else
                    -- Try standard silent aim hit resolution first
                    local resolvedHitPos = nil
                    if Player and Player.GetHitPosition then resolvedHitPos = Player.GetHitPosition("Silent") end
                    -- FALLBACK: If GetHitPosition returned nil (cursor is inside Triggerbot FOV
                    -- but NOT inside Silent FOV), directly resolve hit position from target character
                    -- so the triggerbot shots actually connect via silent aim redirection
                    if not resolvedHitPos and targetChar then
                        local silentAimConfig = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Silent Aim']
                        local hitPartMode = silentAimConfig and silentAimConfig.HitPart or 'ClosestPart'
                        local TargetPart = nil
                        if hitPartMode == 'ClosestPart' then
                            -- Find closest body part to cursor
                            local CurrentCamera = workspace.CurrentCamera; local mousePos = UserInputService:GetMouseLocation(); local closestDist = math.huge
                            for _, part in ipairs(targetChar:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local screenPos = CurrentCamera:WorldToViewportPoint(part.Position)
                                    if screenPos.Z > 0 then
                                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                                        if dist < closestDist then
                                            closestDist = dist
                                            TargetPart = part
                                        end
                                    end
                                end
                            end
                        else
                            TargetPart = targetChar:FindFirstChild(hitPartMode)
                        end
                        if TargetPart then
                            local targetPos = TargetPart.Position
                            -- Apply Closest Point Scale if configured
                            if silentAimConfig and silentAimConfig['Closest Point Scale'] then
                                local cpCfg = silentAimConfig['Closest Point Scale']
                                if cpCfg.Enabled and typeof(GetClosestPointOnPart) == "function" then
                                    local scale = cpCfg.Scale or 1.25
                                    targetPos = GetClosestPointOnPart(TargetPart, scale) or targetPos
                                end
                            end
                            -- Apply prediction: Check Future prediction system first, fallback to standard prediction
                            local currentTool = Self.Character and Self.Character:FindFirstChildOfClass("Tool"); local toolName = currentTool and currentTool.Name or ""
                            local futureCfg = (typeof(GetFutureConfigFor) == "function") and (GetFutureConfigFor('Triggerbot') or GetFutureConfigFor('Silent Aim'))
                            if futureCfg and typeof(ApplyFuture) == "function" then
                                targetPos = ApplyFuture(targetPos, targetPlayer, toolName, futureCfg)
                            elseif silentAimConfig and silentAimConfig.Prediction and silentAimConfig.Prediction.Enabled then
                                local RootPart = targetChar:FindFirstChild("HumanoidRootPart")
                                if RootPart then
                                    local Velocity
                                    if typeof(IsDesynced) == "function" and typeof(Resolve) == "function" then
                                        Velocity = IsDesynced(RootPart) and Resolve(RootPart) or (RootPart.AssemblyLinearVelocity or RootPart.Velocity)
                                    else
                                        Velocity = RootPart.AssemblyLinearVelocity or RootPart.Velocity
                                    end
                                    local px = silentAimConfig.Prediction.X or 0.142
                                    local py = silentAimConfig.Prediction.Y or 0; local pz = silentAimConfig.Prediction.Z or silentAimConfig.Prediction.X or 0.142
                                    targetPos = targetPos + Velocity * Vector3.new(px, py, pz)
                                end
                            end
                            resolvedHitPos = targetPos
                        end
                    end
                    Mango.Locals.HitPosition = resolvedHitPos
                end
                -- Send mouse position update remote directly so the server redirects shots to HitPosition
                if Mango.Locals.HitPosition then
                    local Updater = CurrentGame and CurrentGame.Updater or "UpdateMousePosI2"
                    local Remote = CurrentGame and CurrentGame.Functions and CurrentGame.Functions.RemotePath() or game.ReplicatedStorage:FindFirstChild("MainEvent")
                    if Updater and Remote then
                        pcall(function() Remote:FireServer(Updater, Mango.Locals.HitPosition) end)
                    end
                end
                pcall(function()
                    if SilentAim then SilentAim(Tool) end
                end)
                pcall(function() Tool:Activate() end)
                pcall(function()
                    local vim = game:GetService("VirtualInputManager")
                    if vim then
                        vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.01)
                        vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end
                end)
            end
        end
    end)
    -- Handle Aim Assist / Select Keybind
    Utility.Connection(UserInputService.InputBegan, function(Input, Processed)
        if Processed then return end
        local mainCfg = getgenv().Prey and getgenv().Prey.Main
        local keybinds = mainCfg and mainCfg.Keybind; local aaKey = (keybinds and (keybinds['Aim Assist'] or keybinds['Select'])) or 'C'
        if Input.KeyCode == Enum.KeyCode[aaKey:upper()] then
            local doSelect = (typeof(SelectPriority) == "function" and SelectPriority) or (Environment and typeof(Environment.SelectPriority) == "function" and Environment.SelectPriority)
            if doSelect then pcall(doSelect) end
            AimAssistActive = (Mango.Locals.LockedTarget ~= nil or (Environment and Environment.Priority and #Environment.Priority > 0))
        end
    end)
    Utility.Connection(UserInputService.InputEnded, function(Input, Processed)
        local mainCfg = getgenv().Prey and getgenv().Prey.Main
        local keybinds = mainCfg and mainCfg.Keybind
        local aaKey = (keybinds and (keybinds['Aim Assist'] or keybinds['Select'])) or 'C'
        local mode = getgenv().Prey.Combat and getgenv().Prey.Combat['Aim Assist'] and getgenv().Prey.Combat['Aim Assist']['Mode'] or 'Toggle'
        if Input.KeyCode == Enum.KeyCode[aaKey:upper()] and mode == 'Hold' then
            local doClear = (typeof(ClearPriority) == "function" and ClearPriority) or (Environment and typeof(Environment.ClearPriority) == "function" and Environment.ClearPriority)
            if doClear then pcall(doClear) end
            Mango.Locals.AimAssistTarget = nil
            Mango.Locals.LockedTarget = nil
            AimAssistActive = false
        end
    end)
    -- Hitbox Expander - Make enemy hitboxes bigger (undetected, invisible, no freezing or giant heads)
    -- Expands HumanoidRootPart ONLY for 100% invisible shot registration without deformities
    local HitboxOriginalSizes = {}
    Utility.ThreadLoop(0.5, function()
        local hitboxConfig = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Mods'] and getgenv().Prey['Tools']['Mods']['Hitbox Expander']
        local enabled = hitboxConfig and hitboxConfig.Enabled == true
        local expandX = enabled and (hitboxConfig.X or hitboxConfig.Width or hitboxConfig['X'] or hitboxConfig['Width'] or 2) or 2
        local expandY = enabled and (hitboxConfig.Y or hitboxConfig.Height or hitboxConfig['Y'] or hitboxConfig['Height'] or 2) or 2
        local expandZ = enabled and (hitboxConfig.Z or hitboxConfig.Depth or hitboxConfig['Z'] or hitboxConfig['Depth'] or 2) or 2
        local hrpSize = Vector3.new(expandX, expandY, expandZ)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Self and player.Character then
                local char = player.Character
                local humanoid = char:FindFirstChildOfClass('Humanoid'); local hrp = char:FindFirstChild('HumanoidRootPart'); local head = char:FindFirstChild('Head')
                if hrp and hrp:IsA('BasePart') then
                    local isKnocked = char:FindFirstChild('BodyEffects') and char.BodyEffects:FindFirstChild('K.O') and char.BodyEffects['K.O'].Value
                    local isDead = (humanoid and humanoid.Health <= 0) or (char:FindFirstChild('BodyEffects') and char.BodyEffects:FindFirstChild('Dead') and char.BodyEffects.Dead.Value)
                    if enabled and humanoid and humanoid.Health > 0 and not isKnocked and not isDead then
                        if not HitboxOriginalSizes[player] then
                            HitboxOriginalSizes[player] = {}
                            HitboxOriginalSizes[player].HRP = hrp.Size
                        end
                        hrp.Size = hrpSize
                        hrp.Transparency = 1
                        hrp.CanCollide = false
                    else
                        -- Reset HRP size & restore normal Head size when knocked, dead, or disabled
                        local saved = HitboxOriginalSizes[player]
                        if saved then
                            if hrp.Size ~= (saved.HRP or Vector3.new(2, 2, 1)) then hrp.Size = saved.HRP or Vector3.new(2, 2, 1) end
                            hrp.Transparency = 1
                            HitboxOriginalSizes[player] = nil
                        else
                            if hrp.Size ~= Vector3.new(2, 2, 1) then hrp.Size = Vector3.new(2, 2, 1) end
                            hrp.Transparency = 1
                        end
                        -- Guarantee head is strictly normal size when knocked or dead
                        if head and head:IsA('BasePart') then
                            local isR6 = char:FindFirstChild("Torso") ~= nil; local normHead = isR6 and Vector3.new(2, 1, 1) or Vector3.new(1.2, 1.2, 1.2)
                            if head.Size ~= normHead then head.Size = normHead end
                            if not (type(isCosmeticOptionEnabled) == "function" and isCosmeticOptionEnabled('Headless')) then head.Transparency = 0 end
                        end
                    end
                end
            end
        end
        -- Clean up saved sizes for players who left
        for plr in next, HitboxOriginalSizes do
            if not plr.Parent then HitboxOriginalSizes[plr] = nil end
        end
    end)
    -- PREY SKIN CHANGER + TRACERS + BULLET FX (adapted from source 8)
    local isHoodCustoms = ReplicatedStorage:FindFirstChild("Wraps") ~= nil
    local Wraps  = isHoodCustoms and ReplicatedStorage:FindFirstChild("Wraps")  or nil; local Knives = isHoodCustoms and ReplicatedStorage:FindFirstChild("Knives") or nil
    local hcActiveSkins  = {}
    local hcKnifeRef     = nil; local hcCurrentTool  = nil; local hcCurrentSkin  = nil; local hcActiveEquipSound = nil
    local hcRainbowHue   = 0
    local function GetSkinConfig()
        if isHoodCustoms then
            -- For Hood Customs, use the Hood Customs config
            local hcSkins = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Hood Customs'] and getgenv().Prey['Tools']['Hood Customs']['skins']
            if hcSkins and hcSkins['enabled'] then return hcSkins end
        else
            -- For Da Hood, use the Skin Changer config
            local skinChanger = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Skin Changer']
            if skinChanger and skinChanger['enabled'] then return skinChanger end
        end
        -- Fallback to old Visual Mods structure
        local vmSkins = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Visual Mods'] and getgenv().Prey['Tools']['Visual Mods']['skins']
        if vmSkins and vmSkins['enabled'] then return vmSkins end
        return nil
    end
    local function GetSkinNameForTool(toolName, skinsCfg)
        if not skinsCfg then return nil end
        local weapons = skinsCfg['weapons'] or skinsCfg['Skins'] or skinsCfg['skins']
        if not weapons then return nil end
        -- Try direct lookup first
        local skinName = weapons[toolName]
        if skinName then return skinName end
        -- Try mapped names for Hood Customs
        local toolNameMap = {
            ["[Double-Barrel SG]"] = "[DoubleBarrel]", ["[DoubleBarrel]"] = "[DoubleBarrel]", ["[Revolver]"] = "Revolver", ["Revolver"] = "Revolver",
            ["[TacticalShotgun]"] = "[SMG]", ["[Shotgun]"] = "[SMG]", ["[SMG]"] = "[SMG]", ["SMG"] = "[SMG]",
        }
        local mappedName = toolNameMap[toolName]
        if mappedName then
            skinName = weapons[mappedName]
            if skinName then return skinName end
        end
        -- Try without brackets for Revolver
        if toolName == "[Revolver]" then
            skinName = weapons["Revolver"]
            if skinName then return skinName end
        end
        return nil
    end
    local function GetTracersConfig()
        -- Try to read from Hood Customs Bullet Beams structure
        local hcConfig = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Hood Customs']
        if hcConfig and hcConfig['Bullet Beams'] then
            return { ['mode'] = hcConfig['Bullet Beams']['mode'] or 'Skin', ['bullet fx'] = true, }
        end
        -- Fallback to old Visual Mods structure
        return getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Visual Mods'] and getgenv().Prey['Tools']['Visual Mods']['tracers']
    end
    local function GetHCBeamMode()
        local tc = GetTracersConfig()
        return (tc and tc['mode']) or "Skin"
    end
    local function GetHCBulletFx()
        local tc = GetTracersConfig()
        return tc and tc['bullet fx']
    end
    local HC_SKIN_COLORS = {
        ["Hell Hound"]           = Color3.fromRGB(255, 60,  0), ["Hell Dragon"]          = Color3.fromRGB(255, 20,  0), ["Deathbringer"]         = Color3.fromRGB(180, 0,   0),
        ["Crimson Fangs"]        = Color3.fromRGB(200, 0,   30), ["Ember"]                = Color3.fromRGB(255, 130, 0), ["Volcanic Ashes"]       = Color3.fromRGB(255, 100, 20),
        ["Hallows"]              = Color3.fromRGB(255, 90,  0), ["Phoenix"]              = Color3.fromRGB(255, 160, 0), ["Snow Dragon"]          = Color3.fromRGB(80,  200, 255),
        ["Arctic"]               = Color3.fromRGB(160, 230, 255), ["Black Ice"]            = Color3.fromRGB(0,   210, 255),
        ["Poseidon"]             = Color3.fromRGB(0,   120, 255), ["Shiryus Breath"]       = Color3.fromRGB(0,   160, 255),
        ["Void Dragon"]          = Color3.fromRGB(130, 0,   255), ["Void"]                 = Color3.fromRGB(80,  0,   200),
        ["Amethyst"]             = Color3.fromRGB(180, 80,  255), ["Voxel"]                = Color3.fromRGB(0,   255, 255),
        ["Black Cat"]            = Color3.fromRGB(140, 0,   255), ["Kirumi"]               = Color3.fromRGB(190, 90,  255),
        ["Blacksteel Dragon"]    = Color3.fromRGB(80,  80,  100), ["Lovestruck"]           = Color3.fromRGB(255, 80,  180),
        ["Heartbringer"]         = Color3.fromRGB(255, 40,  100), ["Kitty"]                = Color3.fromRGB(255, 170, 210),
        ["Hello Kitty"]          = Color3.fromRGB(255, 140, 170), ["Cupid"]                = Color3.fromRGB(255, 70,  140), ["Strawberry Shortcake"] = Color3.fromRGB(255, 70,  90),
        ["Floral"]               = Color3.fromRGB(255, 140, 190), ["Candy Cane"]           = Color3.fromRGB(255, 40,  60), ["Radiation"]            = Color3.fromRGB(80,  255, 0),
        ["Green Tint"]           = Color3.fromRGB(40,  255, 70), ["Binary"]               = Color3.fromRGB(0,   255, 90), ["Hexagram"]             = Color3.fromRGB(255, 210, 0),
        ["Lightbringer"]         = Color3.fromRGB(255, 255, 120), ["Ascension"]            = Color3.fromRGB(255, 255, 255), ["Adurite"]              = Color3.fromRGB(255, 195, 0),
        ["Arsenic"]              = Color3.fromRGB(160, 160, 160), ["Paper"]                = Color3.fromRGB(220, 210, 190),
        ["Fishbone"]             = Color3.fromRGB(100, 200, 255), ["Golden Age Tanto"]     = Color3.fromRGB(255, 200, 50), ["Beta"]                 = Color3.fromRGB(80,  160, 255),
        ["Galaxy"]               = Color3.fromRGB(120, 80,  255), ["Golden Age"]           = Color3.fromRGB(255, 200, 50), ["Nightblade"]           = Color3.fromRGB(60,  0,   255),
    }
    local KNIFE_EQUIP_SOUNDS = { ["Beta"] = "rbxassetid://15861815360", }
    local KNIFE_EQUIP_ANIMS = { ["Beta"] = "rbxassetid://15861294915", }
    local KNIFE_SWING_ANIMS = { ["Beta"] = "", }
    local function hcGetBeamColor()
        if GetHCBeamMode() == "Rainbow" then return Color3.fromHSV(hcRainbowHue, 1, 1) end
        -- Hood Customs Bullet Beams from message.txt structure - PRIORITY
        local hcConfig = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Hood Customs']
        if hcConfig and hcConfig['Bullet Beams'] and hcCurrentTool then
            -- Map tool names to config keys
            local toolNameMap = {
                ["[Double-Barrel SG]"] = "DoubleBarrel", ["[DoubleBarrel]"] = "DoubleBarrel", ["[Revolver]"] = "Revolver", ["Revolver"] = "Revolver",
                ["[TacticalShotgun]"] = "Shotgun", ["[Shotgun]"] = "Shotgun", ["[SMG]"] = "SMG", ["SMG"] = "SMG",
            }
            local configKey = toolNameMap[hcCurrentTool.Name] or hcCurrentTool.Name; local beamName = hcConfig['Bullet Beams'][configKey]
            if beamName and beamName ~= "None" then
                -- Get the actual beam from ReplicatedStorage
                local BulletBeams = ReplicatedStorage:FindFirstChild("Bullet Beams")
                -- Try alternative folder names
                if not BulletBeams then BulletBeams = ReplicatedStorage:FindFirstChild("BulletBeams") end
                if not BulletBeams then BulletBeams = ReplicatedStorage:FindFirstChild("Bullet_Beams") end
                if BulletBeams then
                    local beam = BulletBeams:FindFirstChild(beamName)
                    if beam then
                        -- If it's a Model, search inside for the actual Beam
                        if beam:IsA("Model") then
                            local actualBeam = beam:FindFirstChildWhichIsA("Beam", true)
                            if actualBeam and actualBeam.Color then return actualBeam.Color.Keypoints[1].Value end
                            -- Try to get color from Parts instead
                            for _, child in ipairs(beam:GetDescendants()) do
                                if child:IsA("BasePart") and child.Color then return child.Color end
                            end
                        elseif beam:IsA("Beam") and beam.Color then
                            return beam.Color.Keypoints[1].Value
                        end
                    end
                end
            end
        end
        -- Per-gun custom beam color override (RGB) - SECONDARY
        local tc = GetTracersConfig()
        if tc and tc['Beam Color'] and tc['Beam Color']['Enabled'] and hcCurrentTool then
            local gunColor = tc['Beam Color']['Guns'] and tc['Beam Color']['Guns'][hcCurrentTool.Name]
            if gunColor then return gunColor end
        end
        return (hcCurrentSkin and HC_SKIN_COLORS[hcCurrentSkin]) or Color3.new(1,1,1)
    end
    local function hcGetBeamObject()
        -- Hood Customs Bullet Beams from message.txt structure
        local hcConfig = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Hood Customs']
        if hcConfig and hcConfig['Bullet Beams'] and hcCurrentTool then
            -- Map tool names to config keys
            local toolNameMap = {
                ["[Double-Barrel SG]"] = "DoubleBarrel", ["[DoubleBarrel]"] = "DoubleBarrel", ["[Revolver]"] = "Revolver", ["Revolver"] = "Revolver",
                ["[TacticalShotgun]"] = "Shotgun", ["[Shotgun]"] = "Shotgun", ["[SMG]"] = "SMG", ["SMG"] = "SMG",
            }
            local configKey = toolNameMap[hcCurrentTool.Name] or hcCurrentTool.Name; local beamName = hcConfig['Bullet Beams'][configKey]
            if beamName and beamName ~= "None" then
                -- Get the actual beam from ReplicatedStorage
                local BulletBeams = ReplicatedStorage:FindFirstChild("Bullet Beams")
                if BulletBeams then
                    -- Try exact match first
                    local beam = BulletBeams:FindFirstChild(beamName)
                    if beam and beam:IsA("Beam") then return beam end
                    -- Try case-insensitive match
                    for _, child in ipairs(BulletBeams:GetChildren()) do
                        if child.Name:lower() == beamName:lower() and child:IsA("Beam") then return child end
                    end
                end
            end
        end
        return nil
    end
    local function hcGetSkinParticles()
        if not hcCurrentTool or not hcCurrentSkin or hcCurrentSkin == "None" then return {} end
        local wf = Wraps and Wraps:FindFirstChild(hcCurrentTool.Name)
        if not wf then return {} end
        local sm = wf:FindFirstChild(hcCurrentSkin)
        if not sm then return {} end
        local out = {}
        for _, v in ipairs(sm:GetDescendants()) do
            if v:IsA("ParticleEmitter") then table.insert(out, v) end
        end
        return out
    end
    RunService.RenderStepped:Connect(function(dt) hcRainbowHue = (hcRainbowHue + dt * 0.5) % 1 end)
    if isHoodCustoms then
        game.Workspace.DescendantAdded:Connect(function(v)
            if v:IsA("Beam") and v.Name == "GunBeam" then
                task.spawn(function()
                    local beamObj = hcGetBeamObject(); local color = hcGetBeamColor()
                    if not color then return end
                    -- Apply beam properties from ReplicatedStorage beam object
                    if beamObj then
                        pcall(function()
                            v.Color = beamObj.Color
                            v.Transparency = beamObj.Transparency
                            v.Width0 = beamObj.Width0
                            v.Width1 = beamObj.Width1
                            v.FaceCamera = beamObj.FaceCamera
                        end)
                    else
                        pcall(function() v.Color = ColorSequence.new(color) end)
                    end
                    -- 3D PHYSICAL TRACER PROJECTILE
                    pcall(function()
                        local att0 = v.Attachment0; local att1 = v.Attachment1
                        if att0 and att1 then
                            local p0 = att0.WorldPosition; local p1 = att1.WorldPosition
                            local proj = Instance.new("Part")
                            proj.Size = Vector3.new(0.1, 0.1, 0.1)
                            proj.Transparency = 1
                            proj.Anchored = true
                            proj.CanCollide = false
                            proj.CFrame = CFrame.new(p0, p1)
                            proj.Parent = workspace.Terrain
                            local pe = Instance.new("ParticleEmitter")
                            pe.Color = ColorSequence.new(color)
                            pe.LightEmission = 1
                            pe.ZOffset = 1
                            pe.EmissionDirection = Enum.NormalId.Back
                            pe.Speed = NumberRange.new(2, 5)
                            pe.SpreadAngle = Vector2.new(10, 10)
                            if hcCurrentSkin then
                                local nameLow = hcCurrentSkin:lower()
                                if nameLow:find("phoenix") or nameLow:find("hell") or nameLow:find("ember") or nameLow:find("crimson") then
                                    pe.Texture = "rbxassetid://256191768"
                                    pe.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
                                    pe.Rate = 400
                                    pe.Lifetime = NumberRange.new(0.3, 0.5)
                                    pe.Speed = NumberRange.new(5, 10)
                                elseif nameLow:find("ascension") or nameLow:find("galaxy") or nameLow:find("cupid") or nameLow:find("lovestruck") then
                                    pe.Texture = "rbxassetid://170940560"
                                    pe.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.5), NumberSequenceKeypoint.new(1, 0)})
                                    pe.Rate = 200
                                    pe.Rotation = NumberRange.new(0, 360)
                                    pe.RotSpeed = NumberRange.new(-100, 100)
                                    pe.Lifetime = NumberRange.new(0.5, 0.8)
                                elseif nameLow:find("nightblade") or nameLow:find("void") or nameLow:find("smoke") then
                                    pe.Texture = "rbxassetid://221711200"
                                    pe.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 0)})
                                    pe.Rate = 300
                                    pe.Lifetime = NumberRange.new(0.4, 0.8)
                                    pe.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
                                else
                                    pe.Texture = "rbxassetid://243660364"
                                    pe.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0)})
                                    pe.Rate = 200
                                    pe.Lifetime = NumberRange.new(0.2, 0.4)
                                end
                            end
                            pe.Parent = proj
                            local dist = (p1 - p0).Magnitude; local flyDur = dist / 600
                            if flyDur < 0.05 then flyDur = 0.05 end
                            local tw = TweenService:Create(proj, TweenInfo.new(flyDur, Enum.EasingStyle.Linear), {CFrame = CFrame.new(p1, p1 + (p1 - p0).Unit)})
                            tw:Play()
                            task.delay(flyDur, function()
                                if pe then pe.Enabled = false end
                                game.Debris:AddItem(proj, 1.5)
                            end)
                        end
                    end)
                    for i = 1, 20 do
                        pcall(function() v.Color = ColorSequence.new(color) end) task.wait() end
                end)
                return
            end
            if GetHCBulletFx() and v.Name == "BULLET_RAYS" and v:IsA("BasePart") then
                task.spawn(function()
                    task.wait()
                    local color = hcGetBeamColor(); local light = v:FindFirstChildOfClass("PointLight")
                    if light and color then light.Color = color end
                    for _, pe in ipairs(hcGetSkinParticles()) do
                        local clone = pe:Clone()
                        clone.Parent = v
                        pcall(function()
                            clone.Enabled = true
                            clone:Emit(5)
                        end)
                    end
                end)
            end
        end)
    end
    local function hcWeldClone(clone, toolHandle)
        local skinHandle = clone:FindFirstChild("Handle") or clone:FindFirstChildWhichIsA("MeshPart", true) or clone:FindFirstChildWhichIsA("BasePart", true)
        if not skinHandle then return false end
        for _, v in ipairs(clone:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
                v.Massless = true
                v.Anchored = false
            end
        end
        for _, w in ipairs(skinHandle:GetChildren()) do
            if (w:IsA("Weld") or w:IsA("WeldConstraint")) and w.Name == "HC_Link" then w:Destroy() end
        end
        local link = Instance.new("WeldConstraint")
        link.Name = "HC_Link"
        link.Part0 = toolHandle
        link.Part1 = skinHandle
        link.Parent = skinHandle
        pcall(function() clone:SetPrimaryPartCFrame(toolHandle.CFrame) end)
        if not clone.PrimaryPart then pcall(function() skinHandle.CFrame = toolHandle.CFrame end) end
        return true
    end
    local function setupFlappingWings(clone)
        local wings = {}
        for _, v in ipairs(clone:GetDescendants()) do
            if v:IsA("BasePart") and string.find(string.lower(v.Name), "wing") then
                local joint
                for _, j in ipairs(clone:GetDescendants()) do
                    if (j:IsA("Weld") or j:IsA("Motor6D")) and (j.Part0 == v or j.Part1 == v) then
                        joint = j
                        break
                    end
                end
                if joint then
                    local isLeft = string.find(string.lower(v.Name), "left") or string.find(string.lower(v.Name), "l_"); local mult = isLeft and -1 or 1
                    table.insert(wings, {joint = joint, origC0 = joint.C0, mult = mult})
                end
            end
        end
        if #wings > 0 then
            local flapConn
            flapConn = game:GetService("RunService").RenderStepped:Connect(function()
                if not clone or not clone.Parent then flapConn:Disconnect(); return end
                local angle = math.sin(tick() * 4) * 0.4
                for _, wing in ipairs(wings) do
                    wing.joint.C0 = wing.origC0 * CFrame.Angles(angle * 0.2, angle * wing.mult, angle * wing.mult)
                end
            end)
        end
    end
    local function hcRemoveGunSkin(tool)
        local skin = hcActiveSkins[tool]
        if skin and skin.Parent then skin:Destroy() end
        hcActiveSkins[tool] = nil
        local handle = tool:FindFirstChild("Handle")
        if handle then handle.Transparency = 0 end
    end
    local function hcApplyGunSkin(tool)
        if not tool or not tool:IsA("Tool") then return end
        local skinsCfg = GetSkinConfig(); local skinName = GetSkinNameForTool(tool.Name, skinsCfg)
        if not skinName or skinName == "" or skinName == "None" then return end
        if not Wraps then return end
        local weaponFolder = Wraps:FindFirstChild(tool.Name)
        if not weaponFolder then return end
        local skinModel = weaponFolder:FindFirstChild(skinName)
        if not skinModel then return end
        local toolHandle = tool:FindFirstChild("Handle")
        if not toolHandle or not toolHandle:IsA("BasePart") then return end
        hcRemoveGunSkin(tool)
        local clone = skinModel:Clone(); clone.Name = "BrightsideGunSkin"
        if not hcWeldClone(clone, toolHandle) then clone:Destroy(); return end
        toolHandle.Transparency = 1
        clone.Parent = tool
        hcActiveSkins[tool] = clone
        hcCurrentTool = tool
        hcCurrentSkin = skinName
        setupFlappingWings(clone)
    end
    local function hcRemoveKnifeSkin(tool)
        if hcKnifeRef and hcKnifeRef.Parent then hcKnifeRef:Destroy() end
        hcKnifeRef = nil
        local handle = tool and tool:FindFirstChild("Handle")
        if handle then handle.Transparency = 0 end
    end
    local function hcApplyKnifeSkin(tool)
        if not tool then return end
        local skinsCfg = GetSkinConfig()
        local weapons = skinsCfg and (skinsCfg['weapons'] or skinsCfg['Skins'] or skinsCfg['skins'])
        local skinName = GetSkinNameForTool(tool.Name, skinsCfg) or (weapons and weapons['[Knife]_HC'])
        if not skinName or skinName == "" or skinName == "None" then return end
        if not Knives then return end
        local skinModel = Knives:FindFirstChild(skinName)
        if not skinModel then return end
        local toolHandle = tool:FindFirstChild("Handle")
        if not toolHandle then return end
        hcRemoveKnifeSkin(tool)
        local clone = skinModel:Clone(); clone.Name = "BrightsideKnifeSkin"
        if not hcWeldClone(clone, toolHandle) then clone:Destroy(); return end
        toolHandle.Transparency = 1
        clone.Parent = tool
        hcKnifeRef = clone
        hcCurrentSkin = skinName
        setupFlappingWings(clone)
        -- Equip sound
        local char = Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid"); local animator = hum and hum:FindFirstChildOfClass("Animator")
        if KNIFE_EQUIP_SOUNDS[skinName] then
            if hcActiveEquipSound then
                pcall(function() hcActiveEquipSound:Stop(); hcActiveEquipSound:Destroy() end) hcActiveEquipSound = nil end
            local snd = Instance.new("Sound")
            snd.SoundId = KNIFE_EQUIP_SOUNDS[skinName]
            snd.Volume = 1
            snd.Parent = toolHandle
            hcActiveEquipSound = snd
            snd:Play()
            snd.Ended:Connect(function()
                if hcActiveEquipSound == snd then hcActiveEquipSound = nil end
                snd:Destroy()
            end)
        end
        -- Equip animation
        if animator and KNIFE_EQUIP_ANIMS[skinName] then
            task.spawn(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = KNIFE_EQUIP_ANIMS[skinName]
                animator:LoadAnimation(anim):Play()
            end)
        end
        -- Swing animation
        if KNIFE_SWING_ANIMS[skinName] and KNIFE_SWING_ANIMS[skinName] ~= "" then
            local swingConn
            swingConn = tool.Activated:Connect(function()
                local curChar = Self.Character
                local curHum = curChar and curChar:FindFirstChildOfClass("Humanoid"); local curAnimator = curHum and curHum:FindFirstChildOfClass("Animator")
                if curAnimator then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = KNIFE_SWING_ANIMS[skinName]
                    curAnimator:LoadAnimation(anim):Play()
                end
            end)
            tool.Unequipped:Once(function() if swingConn then swingConn:Disconnect() end end)
        end
        -- Trail + Particle wiring
        local nbHandle = skinModel:FindFirstChild("Handle")
        if nbHandle and toolHandle then
            pcall(function()
                for _, v in ipairs(toolHandle:GetChildren()) do
                    if v.Name == "BrightsideAtt0" or v.Name == "BrightsideAtt1" or v.Name == "BrightsideTrail" or v.Name == "BrightsideParticle" then v:Destroy() end
                end
                local atts = {}
                for _, v in ipairs(nbHandle:GetChildren()) do
                    if v:IsA("Attachment") then table.insert(atts, v) end
                end
                for _, obj in ipairs(nbHandle:GetChildren()) do
                    if obj:IsA("Trail") and #atts >= 2 then
                        local att0 = atts[1]:Clone()
                        att0.Name = "BrightsideAtt0"; att0.Parent = toolHandle
                        local att1 = atts[2]:Clone()
                        att1.Name = "BrightsideAtt1"; att1.Parent = toolHandle
                        local trailClone = obj:Clone()
                        trailClone.Name = "BrightsideTrail"
                        trailClone.Attachment0 = att0
                        trailClone.Attachment1 = att1
                        trailClone.Enabled = true
                        trailClone.Parent = toolHandle
                        tool.Unequipped:Once(function()
                            pcall(function() att0:Destroy() end)
                            pcall(function() att1:Destroy() end)
                            pcall(function() trailClone:Destroy() end)
                        end)
                        break
                    end
                end
                local function wireParticles(source)
                    for _, obj in ipairs(source:GetChildren()) do
                        if obj:IsA("ParticleEmitter") then
                            local p = obj:Clone()
                            p.Name = "BrightsideParticle"
                            p.Parent = toolHandle
                            tool.Unequipped:Once(function()
                                pcall(function() p:Destroy() end) end) end
                    end
                end
                wireParticles(nbHandle)
                for _, v in ipairs(nbHandle:GetChildren()) do
                    if v:IsA("MeshPart") then wireParticles(v) end
                end
            end)
        end
    end
    -- DA HOOD SKIN CHANGER (Gun + Knife)
    local knifedata = {}
    local knifeskins = {
        ["Golden"]             = {soundid="", animationid="", positionoffset=Vector3.new(0,-0.20,-1.2), rotationoffset=Vector3.new(90,178.70001220703125,180)},
        ["Golden Age Tanto"]   = {soundid="rbxassetid://5917819099",  animationid="rbxassetid://13473404819", positionoffset=Vector3.new(0,-0.20,-1.2),    rotationoffset=Vector3.new(90,263.7,180)},
        ["GPO-Knife"]          = {soundid="rbxassetid://4604390759",  animationid="rbxassetid://14014278925", positionoffset=Vector3.new(0.00,-0.32,-1.07), rotationoffset=Vector3.new(90,-97.4,90)},
        ["GPO-Knife Prestige"] = {soundid="rbxassetid://4604390759",  animationid="rbxassetid://14014278925", positionoffset=Vector3.new(0.00,-0.32,-1.07), rotationoffset=Vector3.new(90,-97.4,90)},
        ["Heaven"]             = {soundid="rbxassetid://14489860007", animationid="rbxassetid://14500266726", positionoffset=Vector3.new(-0.02,-0.82,0.20),  rotationoffset=Vector3.new(64.42,3.79,0.00)},
        ["Love Kukri"]         = {soundid="",animationid="",          positionoffset=Vector3.new(-0.14,0.14,-1.62),  rotationoffset=Vector3.new(-90.00,180.00,-4.97), particle=true, textureid="rbxassetid://12124159284"},
        ["Purple Dagger"]      = {soundid="rbxassetid://17822743153", animationid="rbxassetid://17824999722", positionoffset=Vector3.new(-0.13,-0.24,-1.80), rotationoffset=Vector3.new(89.05,96.63,180.00)},
        ["Blue Dagger"]        = {soundid="rbxassetid://17822737046", animationid="rbxassetid://17824995184", positionoffset=Vector3.new(-0.13,-0.24,-1.80), rotationoffset=Vector3.new(89.05,96.63,180.00)},
        ["Green Dagger"]       = {soundid="rbxassetid://17822741762", animationid="rbxassetid://17825004320", positionoffset=Vector3.new(-0.13,-0.24,-1.07), rotationoffset=Vector3.new(89.05,96.63,180.00)},
        ["Red Dagger"]         = {soundid="rbxassetid://17822952417", animationid="rbxassetid://17825008844", positionoffset=Vector3.new(-0.13,-0.24,-1.07), rotationoffset=Vector3.new(89.05,96.63,180.00)},
        ["Portal"]             = {soundid="rbxassetid://16058846352", animationid="rbxassetid://16058633881", positionoffset=Vector3.new(-0.13,-0.35,-0.57), rotationoffset=Vector3.new(89.05,96.63,180.00)},
        ["Emerald Butterfly"]  = {soundid="rbxassetid://14931902491", animationid="rbxassetid://14918231706", positionoffset=Vector3.new(-0.02,-0.30,-0.65), rotationoffset=Vector3.new(180.00,90.95,180.00)},
        ["Boy"]                = {soundid="rbxassetid://18765078331", animationid="rbxassetid://18789158908", positionoffset=Vector3.new(-0.02,-0.09,-0.73), rotationoffset=Vector3.new(89.05,-88.11,180.00)},
        ["Girl"]               = {soundid="rbxassetid://18765078331", animationid="rbxassetid://18789162944", positionoffset=Vector3.new(-0.02,-0.16,-0.73), rotationoffset=Vector3.new(89.05,-88.11,180.00)},
        ["Dragon"]             = {soundid="rbxassetid://14217789230", animationid="rbxassetid://14217804400", positionoffset=Vector3.new(-0.02,-0.32,-0.98), rotationoffset=Vector3.new(89.05,90.95,180.00)},
        ["Void"]               = {soundid="rbxassetid://14756591763", animationid="rbxassetid://14774699952", positionoffset=Vector3.new(-0.02,-0.22,-0.85), rotationoffset=Vector3.new(180.00,90.95,180.00)},
        ["Wild West"]          = {soundid="rbxassetid://16058689026", animationid="rbxassetid://16058148839", positionoffset=Vector3.new(-0.02,-0.24,-1.15), rotationoffset=Vector3.new(-91.89,90.95,180.00)},
        ["Iced Out"]           = {soundid="rbxassetid://14924261405", animationid="rbxassetid://18465353361", positionoffset=Vector3.new(0.02,-0.08,0.99),   rotationoffset=Vector3.new(180.00,-90.95,-180.00)},
        ["Reptile"]            = {soundid="rbxassetid://18765103349", animationid="rbxassetid://18788955930", positionoffset=Vector3.new(-0.03,-0.06,-0.92), rotationoffset=Vector3.new(168.63,90.00,-180.00)},
        ["Emerald"]            = {soundid="",animationid="",          positionoffset=Vector3.new(-0.03,-0.06,-0.92), rotationoffset=Vector3.new(168.63,90.00,108.00)},
        ["Ribbon"]             = {soundid="rbxassetid://130974579277249", animationid="rbxassetid://124102609796063", positionoffset=Vector3.new(0.02,-0.25,-0.05), rotationoffset=Vector3.new(90.00,0.00,180.00)},
    }
    local function clearmesh(tool, exclude)
        for _, v in pairs(tool:GetChildren()) do
            if v:IsA("MeshPart") and v ~= exclude then v:Destroy() end
        end
    end
    local function applygun(tool, name)
        local orig = tool:FindFirstChildOfClass("MeshPart"); if not orig then return end
        local skinmodules = ReplicatedStorage:FindFirstChild("SkinModules"); if not skinmodules then return end
        local ok, smreq = pcall(function() return require(skinmodules) end)
        if not ok or not smreq then return end
        local info = smreq[tool.Name] and smreq[tool.Name][name]; if not info then return end
        clearmesh(tool, orig)
        local skinpart = info.TextureID
        if typeof(skinpart) == "Instance" then
            local clone = skinpart:Clone(); clone.Parent = tool; clone.CFrame = orig.CFrame; clone.Name = "CurrentSkin"
            local w = Instance.new("Weld"); w.Part0 = clone; w.Part1 = orig; w.C0 = info.CFrame:Inverse(); w.Parent = clone
            orig.Transparency = 1
        else
            orig.TextureID = skinpart; orig.Transparency = 0
        end
        local handle = tool:FindFirstChild("Handle"); if not handle then return end; local shoot = handle:FindFirstChild("ShootSound")
        if shoot then
            local sa = ReplicatedStorage:FindFirstChild("SkinAssets")
            if sa then
                local gs = sa:FindFirstChild("GunShootSounds")
                if gs then
                    local s = gs:FindFirstChild(tool.Name); local o = s and s:FindFirstChild(name)
                    if o then shoot.SoundId = o.Value end
                end
            end
        end
        local sa2 = ReplicatedStorage:FindFirstChild("SkinAssets")
        if sa2 then
            local pf = sa2:FindFirstChild("GunHandleParticle")
            if pf then
                local ps = pf:FindFirstChild(name)
                if ps then
                    local pe = ps:FindFirstChild("ParticleEmitter")
                    if pe then
                        for _, ex in pairs(handle:GetChildren()) do
                            if ex:IsA("ParticleEmitter") then ex:Destroy() end
                        end
                        pe:Clone().Parent = handle
                    end
                end
            end
        end
        handle:SetAttribute("SkinName", name)
    end
    local function cleanknife(tool)
        local data = knifedata[tool]
        if data then
            if data.track then pcall(function() data.track:Stop(); data.track:Destroy() end); data.track = nil end
            if data.equipSound then pcall(function() data.equipSound:Stop(); data.equipSound:Destroy() end); data.equipSound = nil end
            if data.welds then for _, w in pairs(data.welds) do pcall(function() w:Destroy() end) end end
            if data.sounds then
                -- let sounds finish playing
                for _, s in pairs(data.sounds) do end
            end
        end
        local mesh = tool:FindFirstChild("Default")
        if mesh then
            for _, v in pairs(mesh:GetChildren()) do
                if v.Name == "Handle.R" or v:IsA("Model") or (v:IsA("BasePart") and v.Name ~= "Default") or v:IsA("SurfaceAppearance") or v:IsA("ParticleEmitter") then v:Destroy() end
            end
            mesh.Transparency = 0
        end
        knifedata[tool] = nil
    end
    local function applyknife(char, tool, skin)
        local skincfg = knifeskins[skin]; if not skincfg then return end
        local hum = char:FindFirstChild("Humanoid"); if not hum then return end; local rhand = char:FindFirstChild("RightHand"); if not rhand then return end
        cleanknife(tool)
        knifedata[tool] = {track = nil, welds = {}, equipSound = nil, sounds = {}}
        local data = knifedata[tool]; local mesh = tool:FindFirstChild("Default"); if not mesh then return end
        mesh.Transparency = 1
        local skinmodules = ReplicatedStorage:FindFirstChild("SkinModules"); if not skinmodules then return end
        local knives = skinmodules:FindFirstChild("Knives"); if not knives then return end
        local skinmodel = knives:FindFirstChild(skin)
        local clone
        if skinmodel then
            clone = skinmodel:Clone(); clone.Name = skin
        elseif skin == "Golden" then
            -- Fallback if not found in ReplicatedStorage: copy Default mesh and apply golden SurfaceAppearance
            clone = mesh:Clone()
            clone.Name = "Golden"
            clone.Transparency = 0
            clone:ClearAllChildren()
            local sa = Instance.new("SurfaceAppearance")
            sa.ColorMap = "rbxassetid://10252983136"
            sa.MetalnessMap = "rbxassetid://10252987122"
            sa.NormalMap = "rbxassetid://10252988522"
            sa.RoughnessMap = "rbxassetid://10252991234"
            sa.Parent = clone
        else
            return
        end
        local handr = Instance.new("Part"); handr.Name = "Handle.R"; handr.Transparency = 1; handr.CanCollide = false
        handr.Anchored = false; handr.Size = Vector3.new(0.001, 0.001, 0.001); handr.Massless = true; handr.Parent = mesh
        local m6d = Instance.new("Motor6D"); m6d.Name = "Handle.R"; m6d.Part0 = rhand; m6d.Part1 = handr; m6d.Parent = handr
        local pos = skincfg.positionoffset; local rot = skincfg.rotationoffset
        -- Allow dynamic customization via getgenv().Prey['CustomOffsets']
        local customOffsets = getgenv().Prey and getgenv().Prey['CustomOffsets']
        if customOffsets and customOffsets[skin] then
            local co = customOffsets[skin]
            if co.Position then pos = co.Position end
            if co.Rotation then rot = co.Rotation end
        end
        local offset = CFrame.new(pos) * CFrame.Angles(math.rad(rot.X), math.rad(rot.Y), math.rad(rot.Z))
        if clone:IsA("Model") then
            if not clone.PrimaryPart then for _, c in pairs(clone:GetChildren()) do if c:IsA("BasePart") then clone.PrimaryPart = c; break end end end
            if clone.PrimaryPart then
                for _, p in pairs(clone:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false; p.Massless = true; p.Anchored = false
                        local w = Instance.new("Weld"); w.Part0 = handr; w.Part1 = p; w.C0 = offset; w.C1 = p.CFrame:ToObjectSpace(clone.PrimaryPart.CFrame); w.Parent = p
                        table.insert(data.welds, w)
                    end
                end
            end
            clone.Parent = mesh
        elseif clone:IsA("BasePart") then
            clone.CanCollide = false; clone.Massless = true; clone.Anchored = false
            if clone:IsA("MeshPart") and skincfg.textureid then clone.TextureID = skincfg.textureid end
            if skincfg.particle then
                local sa = ReplicatedStorage:FindFirstChild("SkinAssets")
                if sa then
                    local pf = sa:FindFirstChild("GunHandleParticle")
                    if pf then
                        local ps = pf:FindFirstChild(skin)
                        if ps then
                            local pe = ps:FindFirstChild("ParticleEmitter")
                            if pe then pe:Clone().Parent = clone end
                        end
                    end
                end
            end
            clone.Parent = mesh
            local w = Instance.new("Weld"); w.Part0 = handr; w.Part1 = clone; w.C0 = offset; w.Parent = clone
            table.insert(data.welds, w)
        end
        local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
        if skincfg.animationid and skincfg.animationid ~= "" then
            local anim = Instance.new("Animation"); anim.AnimationId = skincfg.animationid; local track = animator:LoadAnimation(anim); track.Looped = false; track:Play()
            data.track = track; anim:Destroy()
            track.Ended:Once(function() if data.track == track then data.track = nil end; track:Destroy() end)
        end
        if skincfg.soundid and skincfg.soundid ~= "" then
            local snd = Instance.new("Sound"); snd.SoundId = skincfg.soundid; snd.Parent = Workspace; snd:Play()
            data.equipSound = snd
            snd.Ended:Connect(function() if data.equipSound == snd then data.equipSound = nil end; snd:Destroy() end)
        end
        tool:SetAttribute("CurrentKnifeSkin", skin)
    end
    local watchedTools = {}
    local function watchTool(tool)
        if not tool:IsA("Tool") then return end
        if watchedTools[tool] then return end
        watchedTools[tool] = true
        tool.Equipped:Connect(function()
            local skinsCfg = GetSkinConfig()
            if not skinsCfg or not skinsCfg['enabled'] then return end
            if tool.Name == "[Knife]" then
                if isHoodCustoms then task.spawn(hcApplyKnifeSkin, tool)
                else
                    local skin = GetSkinNameForTool("[Knife]", skinsCfg)
                    if skin and skin ~= "" then task.spawn(applyknife, Self.Character, tool, skin) end
                end
            else
                if isHoodCustoms then task.spawn(hcApplyGunSkin, tool)
                else
                    local skin = GetSkinNameForTool(tool.Name, skinsCfg)
                    if skin and skin ~= "" then task.spawn(applygun, tool, skin) end
                end
            end
        end)
        tool.Unequipped:Connect(function()
            if tool.Name == "[Knife]" then
                if isHoodCustoms then hcRemoveKnifeSkin(tool)
                else
                    local data = knifedata[tool]; if not data then return end
                    if data.welds then for _, w in pairs(data.welds) do if w then w:Destroy() end end; data.welds = {} end
                    if data.sounds then data.sounds = {} end
                    local mesh = tool:FindFirstChild("Default")
                    if mesh then
                        for _, v in pairs(mesh:GetChildren()) do
                            if v.Name == "Handle.R" or v:IsA("Model") or (v:IsA("MeshPart") and v.Name ~= "Default") then v:Destroy() end
                        end
                        mesh.Transparency = 0
                    end
                end
            else
                if isHoodCustoms then
                    hcRemoveGunSkin(tool)
                    hcCurrentTool = nil
                    hcCurrentSkin = nil
                end
            end
        end)
        if tool.Parent == Self.Character then
            task.spawn(function()
                task.wait(0.15)
                if tool.Parent ~= Self.Character then return end
                local skinsCfg = GetSkinConfig()
                if not skinsCfg or not skinsCfg['enabled'] then return end
                if tool.Name == "[Knife]" then
                    if isHoodCustoms then hcApplyKnifeSkin(tool)
                    else
                        local skin = GetSkinNameForTool("[Knife]", skinsCfg)
                        if skin and skin ~= "" then task.spawn(applyknife, Self.Character, tool, skin) end
                    end
                else
                    if isHoodCustoms then hcApplyGunSkin(tool)
                    else
                        local skin = GetSkinNameForTool(tool.Name, skinsCfg)
                        if skin and skin ~= "" then task.spawn(applygun, tool, skin) end
                    end
                end
            end)
        end
    end
    local function adjustKnifeRotation(axis, amount)
        local char = Self.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool or tool.Name ~= "[Knife]" then return end
        local skin = tool:GetAttribute("CurrentKnifeSkin")
        if not skin or skin == "" then return end
        local skincfg = knifeskins[skin]
        if not skincfg then return end
        if not getgenv().Prey then getgenv().Prey = {} end
        if not getgenv().Prey.CustomOffsets then getgenv().Prey.CustomOffsets = {} end
        if not getgenv().Prey.CustomOffsets[skin] then
            getgenv().Prey.CustomOffsets[skin] = { Position = skincfg.positionoffset, Rotation = skincfg.rotationoffset }
        end
        local co = getgenv().Prey.CustomOffsets[skin]
        if axis == "X" then
            co.Rotation = co.Rotation + Vector3.new(amount, 0, 0)
        elseif axis == "Y" then
            co.Rotation = co.Rotation + Vector3.new(0, amount, 0)
        elseif axis == "Z" then
            co.Rotation = co.Rotation + Vector3.new(0, 0, amount)
        end
        applyknife(char, tool, skin)
    end
    -- Rotation keybinds disabled - knife will always use correct offsets from knifeskins table
    -- Utility.Connection(UserInputService.InputBegan, function(input, processed)
    --     if processed then return end
    --     if input.KeyCode == Enum.KeyCode.LeftBracket then
    --         adjustKnifeRotation("Y", -5)
    --     elseif input.KeyCode == Enum.KeyCode.RightBracket then
    --         adjustKnifeRotation("Y", 5)
    --     elseif input.KeyCode == Enum.KeyCode.Semicolon then
    --         adjustKnifeRotation("Z", -5)
    --     elseif input.KeyCode == Enum.KeyCode.Quote then
    --         adjustKnifeRotation("Z", 5)
    --     elseif input.KeyCode == Enum.KeyCode.Minus then
    --         adjustKnifeRotation("X", -5)
    --     elseif input.KeyCode == Enum.KeyCode.Equals then
    --         adjustKnifeRotation("X", 5)
    --     end
    -- end)
    local function watchchar(char)
        if not char then return end
        watchedTools = {}
        hcActiveSkins = {}
        hcKnifeRef = nil
        hcCurrentTool = nil
        hcCurrentSkin = nil
        for _, v in pairs(char:GetChildren()) do watchTool(v) end
        char.ChildAdded:Connect(function(v) watchTool(v) end)
    end
    local function watchBackpack()
        local bp = Self:WaitForChild("Backpack", 10)
        if not bp then return end
        for _, v in pairs(bp:GetChildren()) do watchTool(v) end
        bp.ChildAdded:Connect(function(v) watchTool(v) end)
    end
    Self.CharacterAdded:Connect(watchchar)
    if Self.Character then watchchar(Self.Character) end
    task.spawn(watchBackpack)
    -- EXTRA FEATURES (Headless, Korblox, Remove Accessories)
    local originalHeadData = setmetatable({}, { __mode = "k" })
    local function updateHeadless(char)
        if not char then return end
        local head = char:FindFirstChild("Head")
        if not head or not (head:IsA("BasePart") or head:IsA("MeshPart")) then return end
        local extraCfg = (getgenv().Prey and getgenv().Prey['Extra']) or {}
        local charCosmetics = (getgenv().Prey and getgenv().Prey['Char'] and getgenv().Prey['Char']['Cosmetics']) or {}
        local cosmeticsEnabled = charCosmetics['Enabled'] ~= false
        local headlessEnabled = (extraCfg['Headless'] == true) or (cosmeticsEnabled and charCosmetics['Headless'] == true) or (type(isCosmeticOptionEnabled) == "function" and isCosmeticOptionEnabled('Headless'))
        if headlessEnabled then
            -- Apply headless (transparency = 1, hide decals) - stays invisible even when knocked!
            if head.Transparency ~= 1 then head.Transparency = 1 end
            -- Ensure normal head size so physics joints don't freeze and body falls naturally when knocked
            if head.Size == Vector3.new(2, 0.5, 1) then
                local isR6 = char:FindFirstChild("Torso") ~= nil
                head.Size = isR6 and Vector3.new(2, 1, 1) or Vector3.new(1.2, 1.2, 1.2)
            end
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("Decal") then
                    if child.Transparency ~= 1 then child.Transparency = 1 end
                end
            end
        else
            -- Restore visible head if headless is disabled
            if head.Transparency == 1 or head.Size == Vector3.new(2, 0.5, 1) then
                local isR6 = char:FindFirstChild("Torso") ~= nil
                head.Transparency = 0
                head.Size = isR6 and Vector3.new(2, 1, 1) or Vector3.new(1.2, 1.2, 1.2)
                for _, child in ipairs(head:GetChildren()) do
                    if child:IsA("Decal") then
                        if child.Transparency ~= 0 then child.Transparency = 0 end
                    end
                end
            end
        end
    end
    local function applyKorblox(char)
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLeg")
        if rightLeg then
            rightLeg.Transparency = 1
            local korblox = ReplicatedStorage:FindFirstChild("Korblox") or ReplicatedStorage:FindFirstChild("KorbloxLeg")
            if korblox then
                local clone = korblox:Clone()
                clone.Parent = char
                for _, part in ipairs(clone:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local weld = Instance.new("Weld")
                        weld.Part0 = rightLeg
                        weld.Part1 = part
                        weld.Parent = part
                    end
                end
            end
        end
    end
    local function removeAccessories(char)
        if not char then return end
        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") then acc:Destroy() end
        end
    end
    applyExtras = function(char)
        if not char then return end
        local extraCfg = (getgenv().Prey and getgenv().Prey['Extra']) or {}
        local charCosmetics = (getgenv().Prey and getgenv().Prey['Char'] and getgenv().Prey['Char']['Cosmetics']) or {}
        local cosmeticsEnabled = charCosmetics['Enabled'] ~= false
        local wantsHeadless = extraCfg['Headless'] == true or (cosmeticsEnabled and charCosmetics['Headless'] == true) or (type(isCosmeticOptionEnabled) == "function" and isCosmeticOptionEnabled('Headless'))
        local wantsKorblox = extraCfg['Korblox'] == true or (cosmeticsEnabled and charCosmetics['Korblox'] == true) or (type(isCosmeticOptionEnabled) == "function" and isCosmeticOptionEnabled('Korblox'))
        local wantsRemoveAcc = extraCfg['Remove Accessories'] == true or (cosmeticsEnabled and (charCosmetics['Remove Accessories'] == true or charCosmetics['RemoveAccessories'] == true)) or (type(isCosmeticOptionEnabled) == "function" and (isCosmeticOptionEnabled('Remove Accessories') or isCosmeticOptionEnabled('RemoveAccessories')))
        if wantsHeadless then updateHeadless(char) end
        if wantsKorblox then applyKorblox(char) end
        if wantsRemoveAcc then removeAccessories(char) end
    end
    -- AUTO ARMOR SYSTEM (Zero-Teleport Across-The-Map Engine)
    local autoArmorBuying = false
    local function findShopItem(itemType)
        local shopFolder = (workspace:FindFirstChild("Ignored") and workspace.Ignored:FindFirstChild("Shop"))
            or workspace:FindFirstChild("Shop")
            or workspace:FindFirstChild("Shops")
            or (workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Shop"))
        local candidates = {}
        if shopFolder then
            for _, child in ipairs(shopFolder:GetChildren()) do
                table.insert(candidates, child)
            end
        end
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name ~= "Ignored" and (child:IsA("Model") or child:IsA("BasePart") or child:IsA("Folder")) then table.insert(candidates, child) end
        end
        if workspace:FindFirstChild("Ignored") then
            for _, child in ipairs(workspace.Ignored:GetChildren()) do
                if child:IsA("Model") or child:IsA("BasePart") then table.insert(candidates, child) end
            end
        end
        local lowerType = string.lower(itemType or "")
        if lowerType == "armor" then
            -- TIER 1 (STRICT HIGH-MEDIUM ARMOR $3377 / $2589)
            for _, obj in ipairs(candidates) do
                local name = string.lower(obj.Name or "")
                if string.find(name, "high-medium") or string.find(name, "high medium") or string.find(name, "3377") or string.find(name, "2589") then return obj end
            end
            for _, obj in ipairs(workspace:GetDescendants()) do
                local name = string.lower(obj.Name or "")
                if string.find(name, "high-medium") or string.find(name, "high medium") or string.find(name, "3377") or string.find(name, "2589") then return obj end
            end
            -- TIER 2 (HIGH ARMOR)
            for _, obj in ipairs(candidates) do
                local name = string.lower(obj.Name or "")
                if string.find(name, "high") and string.find(name, "armor") then return obj end
            end
            for _, obj in ipairs(workspace:GetDescendants()) do
                local name = string.lower(obj.Name or "")
                if string.find(name, "high") and string.find(name, "armor") then return obj end
            end
            -- TIER 3 (FALLBACK MEDIUM ARMOR / GENERIC ARMOR)
            for _, obj in ipairs(candidates) do
                local name = string.lower(obj.Name or "")
                if string.find(name, "armor") then return obj end
            end
        end
        return nil
    end
    local function doAutoArmor(force, isManual)
        local cfg = getgenv().Prey and getgenv().Prey['Auto Armor']
        if cfg and cfg['Enabled'] == false and not force then return end
        if autoArmorBuying then return end
        local initialChar = Self.Character
        if not initialChar then return end
        autoArmorBuying = true
        task.spawn(function()
            pcall(function()
                -- Wait for spawn-protection / initial ForceField to fade before buying
                local ff = initialChar:FindFirstChildOfClass("ForceField") or initialChar:FindFirstChild("ForceField")
                if ff then
                    local ffStart = os.clock()
                    repeat
                        task.wait(0.2)
                        local c = Self.Character
                        ff = c and (c:FindFirstChildOfClass("ForceField") or c:FindFirstChild("ForceField"))
                    until not ff or (os.clock() - ffStart > 6)
                end
                -- Helper to execute purchase clicks on a shop item
                local function purchaseShopItem(item, clicks, category)
                    clicks = math.max(1, tonumber(clicks) or 1)
                    local char = Self.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    -- Wait if a ForceField is active before proceeding with purchase action
                    local actionFF = char:FindFirstChildOfClass("ForceField") or char:FindFirstChild("ForceField")
                    if actionFF then
                        local actionFFStart = os.clock()
                        repeat
                            task.wait(0.2)
                            local c = Self.Character
                            actionFF = c and (c:FindFirstChildOfClass("ForceField") or c:FindFirstChild("ForceField"))
                        until not actionFF or (os.clock() - actionFFStart > 6)
                    end
                    local cd = nil; local head = nil
                    if item then
                        cd = item:FindFirstChildWhichIsA("ClickDetector", true)
                            or item:FindFirstChildOfClass("ClickDetector")
                            or (item.Parent and item.Parent:FindFirstChildWhichIsA("ClickDetector", true))
                        head = (item:IsA("BasePart") and item)
                            or item.PrimaryPart
                            or item:FindFirstChild("Head")
                            or item:FindFirstChild("Handle")
                            or item:FindFirstChildWhichIsA("BasePart", true)
                            or (item.Parent and item.Parent:IsA("BasePart") and item.Parent or nil)
                    end
                    pcall(function()
                        local camera = workspace.CurrentCamera; local originalCF = hrp.CFrame; local originalCamCF = camera and camera.CFrame
                        local camConnection
                        -- Lock camera to current orientation so view doesn't change
                        if camera and originalCamCF then
                            camConnection = RunService.RenderStepped:Connect(function() camera.CFrame = originalCamCF end)
                        end
                        if head then
                            hrp.CFrame = head.CFrame + Vector3.new(0, 2, 2)
                            task.wait(0.12)
                        end
                        for click = 1, clicks do
                            -- Method A: Firing clickdetector
                            if cd and typeof(fireclickdetector) == "function" then
                                pcall(function() fireclickdetector(cd) end)
                                pcall(function() fireclickdetector(cd, 0) end)
                                pcall(function() fireclickdetector(cd, 1) end)
                                pcall(function() fireclickdetector(cd, 0, "MouseClick") end)
                            end
                            -- Method B: VirtualInputManager Screen Click Simulation
                            if camera and head then
                                pcall(function()
                                    local pos, visible = camera:WorldToViewportPoint(head.Position)
                                    if visible then
                                        VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
                                        task.wait(0.03)
                                        VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
                                    end
                                end)
                            end
                            -- Method C: MainEvent Remotes
                            local mainEvent = game:GetService("ReplicatedStorage"):FindFirstChild("MainEvent")
                            if mainEvent then
                                pcall(function() mainEvent:FireServer("BuyArmor", "[High-Medium Armor] - $3377") end)
                                pcall(function() mainEvent:FireServer("BuyItem", "[High-Medium Armor] - $3377") end)
                                pcall(function() mainEvent:FireServer("BuyArmor", "[High-Medium Armor] - $2589") end)
                                pcall(function() mainEvent:FireServer("BuyItem", "[High-Medium Armor] - $2589") end)
                                pcall(function() mainEvent:FireServer("BuyArmor", "[High-Medium Armor]") end)
                                pcall(function() mainEvent:FireServer("BuyItem", "[High-Medium Armor]") end)
                                if cd then
                                    pcall(function() mainEvent:FireServer("ShopReplicate", cd) end)
                                end
                                if item then
                                    pcall(function() mainEvent:FireServer("ShopReplicate", item) end)
                                    pcall(function() mainEvent:FireServer("BuyArmor", item.Name) end)
                                    pcall(function() mainEvent:FireServer("BuyItem", item.Name) end) end end
                            if click < clicks then task.wait(0.14) end
                        end
                        task.wait(0.12)
                        -- Restore position & disconnect camera lock
                        if hrp and hrp.Parent then hrp.CFrame = originalCF end
                        if camConnection then camConnection:Disconnect() end
                        if camera and originalCamCF then camera.CFrame = originalCamCF end
                    end)
                end
                -- Retry loop after spawn/respawn
                for attempt = 1, (force and 1 or 4) do
                    local char = Self.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if not char or not hrp or not hum or hum.Health <= 0 then
                        task.wait(0.5)
                        continue
                    end
                    -- Wait if ForceField is active during retry attempt
                    local retryFF = char:FindFirstChildOfClass("ForceField") or char:FindFirstChild("ForceField")
                    if retryFF then
                        local retryFFStart = os.clock()
                        repeat
                            task.wait(0.2)
                            local c = Self.Character
                            retryFF = c and (c:FindFirstChildOfClass("ForceField") or c:FindFirstChild("ForceField"))
                        until not retryFF or (os.clock() - retryFFStart > 6)
                    end
                    -- AUTO ARMOR PURCHASE (STRICT: ONLY IF ARMOR < 130)
                    local bodyFx = char:FindFirstChild("BodyEffects")
                    local armorVal = bodyFx and (bodyFx:FindFirstChild("Armor") or bodyFx:FindFirstChild("Armour")); local curArm = armorVal and tonumber(armorVal.Value) or 0
                    -- Read armor value from alternate locations if BodyEffects wasn't found
                    if not armorVal then
                        local charArmor = char:FindFirstChild("Armor") or char:FindFirstChild("Armour")
                        if charArmor and charArmor:IsA("ValueBase") then curArm = tonumber(charArmor.Value) or curArm end
                    end
                    if curArm < 130 then
                        local armorShopItem = findShopItem("Armor")
                        purchaseShopItem(armorShopItem, 1, "armor")
                    end
                    task.wait(0.5)
                end
            end)
            autoArmorBuying = false
        end)
    end
    Self.CharacterAdded:Connect(function(char)
        task.wait(0.6)
        applyExtras(char)
        doAutoArmor()
    end)
    if Self.Character then
        task.spawn(function()
            task.wait(0.6)
            applyExtras(Self.Character)
            doAutoArmor()
        end)
    end
    -- ============================================================
    -- UNDETECTED HOLD NOCLIP SYSTEM
    -- Configurable ONLY in getgenv().Prey['Noclip']['Key']
    -- ============================================================
    local NoclipActive = false
    RunService.Stepped:Connect(function()
        if getgenv().PreyGeneration ~= MyGeneration then return end
        local cfg = getgenv().Prey and getgenv().Prey['Noclip']
        if cfg and cfg['Enabled'] == false then
            if NoclipActive then
                NoclipActive = false
                local char = Self.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = true end
                    end
                end
            end
            return
        end
        if NoclipActive then
            local char = Self.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                end
            end
        end
    end)
    -- PANIC GROUND
    local panicGroundTween = nil
    local function doPanicGround()
        local cfg = getgenv().Prey['Panic Ground']
        if cfg and cfg['Enabled'] == false then return end
        local char = Self.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp then return end
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {char}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        -- Raycast straight down to find ground level from ANY height (up to 999,999 studs high)
        local res = Workspace:Raycast(hrp.Position, Vector3.new(0, -999999, 0), params)
        if not res then return end
        local groundPos = res.Position + Vector3.new(0, 3, 0); local _, yAngle = hrp.CFrame:ToEulerAnglesYXZ(); local targetCF = CFrame.new(groundPos) * CFrame.Angles(0, yAngle, 0)
        if panicGroundTween then
            panicGroundTween:Cancel()
            panicGroundTween = nil
        end
        local mode = (cfg and cfg['Mode']) or 'Instant'
        if mode == 'Instant' then
            hrp.CFrame = targetCF
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            if humanoid then
                humanoid.Jump = false
                humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            end
        else
            local speed = (cfg and cfg['Smooth Speed']) or 400; local dist = (hrp.Position - groundPos).Magnitude; local t = math.clamp(dist / speed, 0.05, 0.5)
            panicGroundTween = TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { CFrame = targetCF })
            panicGroundTween:Play()
            panicGroundTween.Completed:Connect(function()
                if hrp and hrp.Parent then
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    if humanoid then
                        humanoid.Jump = false
                        humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                    end
                end
            end)
        end
        -- Anti-bounce: Continuously clamp upward velocity and force Landed state for 12 Heartbeat frames
        task.spawn(function()
            for _ = 1, 12 do
                if hrp and hrp.Parent then
                    local currentVel = hrp.AssemblyLinearVelocity
                    if currentVel.Y > 0 then hrp.AssemblyLinearVelocity = Vector3.new(currentVel.X, 0, currentVel.Z) end
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    if humanoid then
                        local st = humanoid:GetState()
                        if st == Enum.HumanoidStateType.Freefall or st == Enum.HumanoidStateType.FallingDown or st == Enum.HumanoidStateType.Physics then
                            humanoid.Jump = false
                            humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                        end
                    end
                end
                RunService.Heartbeat:Wait()
            end
        end)
    end
    -- SPIDERMAN (Wall Jump)
    local lastJumpTime     = 0; local lastWallJumpTime = 0; local jumpCount        = 0
    local function getWallNormal()
        local char = Self.Character; local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local cfg = getgenv().Prey['Spiderman']
        if not cfg then return nil end
        local wallDist = cfg['Wall Distance'] or 6; local params = RaycastParams.new()
        params.FilterDescendantsInstances = {char}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local heights = {Vector3.new(0,-2,0),Vector3.new(0,0,0),Vector3.new(0,2,0)}
        local dirs = {hrp.CFrame.LookVector,-hrp.CFrame.LookVector,hrp.CFrame.RightVector,-hrp.CFrame.RightVector}
        for _, h in ipairs(heights) do
            for _, d in ipairs(dirs) do
                local res = Workspace:Raycast(hrp.Position + h, d * wallDist, params)
                if res and res.Instance and res.Instance.CanCollide then return res.Normal end
            end
        end
        return nil
    end
    local isWallJumping = false
    local function doWallJump()
        local cfg = getgenv().Prey['Spiderman']
        if not cfg or not cfg['Enabled'] then return end
        local char = Self.Character; local hum  = char and char:FindFirstChildOfClass("Humanoid"); local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or not hum or hum.Health <= 0 then return end
        if tick() - lastWallJumpTime < (cfg['Cooldown'] or 0.1) then return end
        local wallNormal = getWallNormal()
        if not wallNormal then return end
        local tool = char:FindFirstChildOfClass("Tool")
        local isKnife = tool and tool.Name:lower():match("knife"); local power = isKnife and (cfg['Knife Jump Power'] or 75) or (cfg['Jump Power'] or 75)
        lastWallJumpTime = tick()
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
        -- Direct launch vector: propels you strongly UP into the air and away/up walls
        local jumpDir = (Vector3.new(0, 1.45, 0) + wallNormal * 0.35).Unit
        hrp.AssemblyLinearVelocity = jumpDir * (power * 1.35)
    end
    -- MOD DETECTOR
    local function checkMod(player)
        local cfg = getgenv().Prey['Global']
        if not cfg then return false end
        local modDetector = cfg["Mod Detector"]
        -- Missing config -> not enabled, never error
        if not modDetector or not modDetector["Enabled"] then return false end
        -- Group id is now configurable (falls back to the Da Hood community)
        local communityId = modDetector["Group Id"] or 17215700; local matchRole = modDetector["Role"]; local notifyDuration = modDetector["Notify Duration"] or 6
        -- Only work in real Da Hood, ignore Hood Customs
        if CurrentGame.Name ~= "Da Hood" then return false end
        if player == Self then return false end
        -- IsInGroup / GetRankInGroup can throw on web errors, guard it
        local okInGroup, inGroup = pcall(function() return player:IsInGroup(communityId) end)
        if not okInGroup or not inGroup then return false end
        -- Optional role filter
        if matchRole then
            local okRank, rankName = pcall(function() return player:GetRoleInGroup(communityId) end)
            if not okRank or rankName ~= matchRole then return false end
        end
        local action = modDetector["Action"] or "Notify"; local label = player.DisplayName .. " (@" .. player.Name .. ")"
        if action == "Kick" then
            pcall(function() Self:Kick("[Prey] " .. (modDetector["Kick Message"] or "A moderator has joined the game!")) end)
        elseif action == "Notify" then
            warn("[Prey] Group member joined: " .. label)
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Mod Detector", Text = "Group member joined: " .. label, Duration = notifyDuration, })
            end)
        end
        return true
    end
    Players.PlayerAdded:Connect(function(player) checkMod(player) end)
    for _, player in ipairs(Players:GetPlayers()) do
        checkMod(player)
    end
    -- BINDS INPUT HANDLING
    local speedenabled = false; local infammoenabled = false; local nocooldownenabled = false
    -- espAllowed: permanently set at startup from config. If false at startup, ESP is fully disabled (no keybind works).
    -- If true at startup, the keybind freely toggles it on/off for as long as the user wants.
    local espAllowed = getgenv().Prey.Visuals and getgenv().Prey.Visuals.Esp and getgenv().Prey.Visuals.Esp.Enabled or false
    local espConfigDefault = espAllowed; local espenabled = espAllowed
    Mango.Locals.ESPEnabled = espenabled
    local infiniteRangeEnabled = false; local camlockEnabled = false; local triggerbotEnabled = false
    -- state toggles
    local function toggleState(flag, key)
        if key == 'select' then
            SP = not SP
            if not SP then
                Mango.Locals.SilentAimTarget = nil
                Mango.Locals.LockedTarget = nil
            end
        elseif key == 'speed' then
            speedenabled = not speedenabled
            return speedenabled
        end
        return false
    end
    -- INVENTORY SORTER
    local function doInventorySort()
        local isCfg = getgenv().Prey['Inventory Sorter']
        if not isCfg or not isCfg['Enabled'] then return end
        local char = Self.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass('Humanoid')
        if not hum then return end
        local bp = Self:FindFirstChild('Backpack')
        if not bp then return end
        local foodKeywords = { "taco", "chicken", "lettuce", "burger", "donut", "pizza", "cranberry" }
        local function isFood(name)
            local lower = string.lower(tostring(name))
            for _, kw in ipairs(foodKeywords) do
                if string.find(lower, kw, 1, true) then return true end
            end
            return false
        end
        local function cleanName(name)
            local s = tostring(name):gsub("%[", ""):gsub("%]", "")
            return string.lower(s)
        end
        local order = isCfg['Order'] or {}
        local orderMap = {}
        for i, name in ipairs(order) do
            orderMap[cleanName(name)] = i
            orderMap[tostring(name)] = i
        end
        local allTools = {}
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA('Tool') then table.insert(allTools, t) end
        end
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA('Tool') then table.insert(allTools, t) end
        end
        local gunsList = {}
        local foodList = {}
        local eraseList = {}
        for _, tool in ipairs(allTools) do
            local cName = cleanName(tool.Name)
            if orderMap[cName] or orderMap[tool.Name] then
                table.insert(gunsList, tool)
            elseif isFood(tool.Name) then
                table.insert(foodList, tool)
            else
                table.insert(eraseList, tool)
            end
        end
        -- Erase unlisted useless tools (Fist, Cellphone, Wallet, Tipjar, etc.)
        for _, tool in ipairs(eraseList) do
            pcall(function() tool:Destroy() end)
        end
        -- Sort guns according to custom order list (Slots 1, 2, 3, 4...)
        table.sort(gunsList, function(a, b)
            local ai = orderMap[cleanName(a.Name)] or orderMap[a.Name] or 9999; local bi = orderMap[cleanName(b.Name)] or orderMap[b.Name] or 9999
            return ai < bi
        end)
        -- Sort food items (Slots 5, 6, 7...)
        table.sort(foodList, function(a, b) return a.Name < b.Name end)
        -- Combine into final ordered tool list: Guns first (1..4), Food second (5..N)
        local finalTools = {}
        for _, t in ipairs(gunsList) do table.insert(finalTools, t) end
        for _, t in ipairs(foodList) do table.insert(finalTools, t) end
        -- Unparent remaining tools then reparent in exact order
        for _, tool in ipairs(finalTools) do
            tool.Parent = nil
        end
        task.wait(0.05)
        for _, tool in ipairs(finalTools) do
            tool.Parent = bp
        end
        task.wait(0.05)
        if equippedName then
            local toEquip = bp:FindFirstChild(equippedName)
            if toEquip then hum:EquipTool(toEquip) end
        end
    end
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if getgenv().PreyGeneration ~= MyGeneration then return end
        if gameProcessed then return end
        -- Spiderman wall jump on Space
        if input.KeyCode == Enum.KeyCode.Space then
            local now = tick()
            if now - lastJumpTime < 0.4 then jumpCount = jumpCount + 1 else jumpCount = 1 end
            lastJumpTime = now
            local cfg = getgenv().Prey['Spiderman']
            if cfg and cfg['Enabled'] then
                if not cfg['Require Double Jump'] or jumpCount >= 2 then doWallJump() end
            end
        end
        -- Panic Ground keybind check: dynamically reads whatever key is configured in the config structure
        local pcfg = getgenv().Prey and getgenv().Prey['Panic Ground']
        local mainKey = getgenv().Prey and getgenv().Prey['Main'] and getgenv().Prey['Main']['Keybind'] and getgenv().Prey['Main']['Keybind']['Panic Ground']
        local configuredKey = mainKey or (pcfg and pcfg['Key'])
        if configuredKey and type(configuredKey) == "string" and #configuredKey > 0 and string.upper(input.KeyCode.Name) == string.upper(configuredKey) then
            if not pcfg or pcfg['Enabled'] ~= false then
                doPanicGround()
            end
        end
        -- AntiGravity Hold listener check (configured ONLY in getgenv().Prey['AntiGravity']['Key'])
        local agcfg = getgenv().Prey and getgenv().Prey['AntiGravity']; local agKey = agcfg and agcfg['Key']
        if agKey and type(agKey) == "string" and #agKey > 0 and string.upper(input.KeyCode.Name) == string.upper(agKey) then
            if not agcfg or agcfg['Enabled'] ~= false then AntiGravityActive = true end
        end
        local key = input.KeyCode.Name; local keybinds = getgenv().Prey['Main'] and getgenv().Prey['Main']['Keybind']
        if keybinds then
            -- Collect all feature bindings matching this key
            local matchingFeatures = {}
            for featureName, bindData in pairs(keybinds) do
                local bindKey, bindMode
                if type(bindData) == 'table' then
                    bindKey = bindData[1]
                    bindMode = bindData[2]
                elseif type(bindData) == 'string' then
                    bindKey = bindData
                    if featureName == 'Aim Assist' then
                        local cfg = getgenv().Prey['Combat']['Aim Assist']
                        bindMode = cfg and cfg.Mode or 'Toggle'
                        if bindMode == 'Always' then bindKey = nil end
                    elseif featureName == 'Triggerbot' then
                        local cfg = getgenv().Prey.Combat['Triggerbot']
                        local funcType = cfg and cfg['Functionality Type'] or {}
                        bindMode = funcType.Type or 'Toggle'
                    else
                        bindMode = 'Toggle'
                    end
                end
                if bindKey and bindKey == key then table.insert(matchingFeatures, { Name = featureName, Mode = bindMode }) end
            end
            if #matchingFeatures > 0 then
                -- Determine if any toggle feature on this key is currently active
                local anyActive = false
                for _, f in ipairs(matchingFeatures) do
                    if f.Mode ~= 'Hold' then
                        if f.Name == 'Select' and (getgenv().Prey.Main.Target.Mode or 'Auto') == 'Target' and SP then
                            anyActive = true
                        elseif f.Name == 'Aim Assist' and AimAssistActive then
                            local cfg = getgenv().Prey['Combat']['Aim Assist']
                            if not (cfg and cfg.Mode == 'Always') then anyActive = true end
                        elseif f.Name == 'Triggerbot' and TriggerbotActive then
                            anyActive = true
                        elseif f.Name == 'Silent Aim' and getgenv().Prey['Combat']['Silent Aim']['Enabled'] then
                            anyActive = true
                        elseif f.Name == 'Esp' and espenabled then
                            anyActive = true
                        end
                    end
                end
                -- Synchronized state: if any active, turn ALL off; if none active, turn ALL on
                local targetState = not anyActive
                for _, f in ipairs(matchingFeatures) do
                    local featureName = f.Name; local bindMode = f.Mode
                    if bindMode == 'Hold' then
                        if featureName == 'Silent Aim' then getgenv().Prey['Combat']['Silent Aim']['Enabled'] = true end
                        if featureName == 'Aim Assist' then
                            local aimAssistCfg = getgenv().Prey['Combat']['Aim Assist']
                            if aimAssistCfg and aimAssistCfg.Enabled == true then
                                AimAssistActive = true
                                local PlayerModule = Modules.Get("Player")
                                if PlayerModule and PlayerModule.GetClosestPlayerToCursorAimAssist then
                                    Mango.Locals.AimAssistTarget = PlayerModule.GetClosestPlayerToCursorAimAssist()
                                end
                            end
                        end
                        if featureName == 'Triggerbot' then
                            local triggerbotCfg = getgenv().Prey.Combat['Triggerbot']
                            if triggerbotCfg and triggerbotCfg.Enabled then
                                TriggerbotActive = true
                                Mango.Locals.TriggerbotActive = true
                            end
                        end
                        if featureName == 'Esp' then
                            local espConfig = getgenv().Prey.Visuals and getgenv().Prey.Visuals.Esp
                            if espConfig and espConfig['Enabled'] == true then
                                espenabled = true
                                Mango.Locals.ESPEnabled = true
                            end
                        end
                    else
                        -- Synchronized Toggle Mode
                        if featureName == 'Select' then
                            local SelectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'
                            if SelectionMode == 'Auto' then
                                SP = true
                            else
                                SP = targetState
                                if SP then
                                    local closest = nil; local closestDist = math.huge; local mousePos = UserInputService:GetMouseLocation()
                                    for _, plr in ipairs(Players:GetPlayers()) do
                                        if plr ~= Self and plr.Character and not IsPlayerProtected(plr) then
                                            local hrp = plr.Character:FindFirstChild('HumanoidRootPart')
                                            if hrp then
                                                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                                                if pos.Z > 0 then
                                                    local unlock = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock
                                                    if unlock and unlock['Through Walls'] == false then
                                                        if IsBehindWall(Camera.CFrame.Position, hrp, plr.Character) then continue end
                                                    end
                                                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                                                    if dist < closestDist then
                                                        closestDist = dist
                                                        closest = plr
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    if closest then
                                        Mango.Locals.SilentAimTarget = closest
                                        Mango.Locals.LockedTarget = closest
                                    end
                                else
                                    Mango.Locals.SilentAimTarget = nil
                                    Mango.Locals.LockedTarget = nil
                                end
                            end
                        elseif featureName == 'Silent Aim' then
                            local cfg = getgenv().Prey['Combat']['Silent Aim']
                            cfg['Enabled'] = targetState
                        elseif featureName == 'Aim Assist' then
                            local cfg = getgenv().Prey['Combat']['Aim Assist']
                            if cfg and cfg.Enabled == true then
                                AimAssistActive = targetState
                                if AimAssistActive then
                                     if not Mango.Locals.AimAssistTarget then Mango.Locals.AimAssistTarget = Mango.Locals.LockedTarget or Mango.Locals.SilentAimTarget end
                                     if Mango.Locals.AimAssistTarget and Mango.Locals.AimAssistTarget.Character then
                                         local root = Mango.Locals.AimAssistTarget.Character:FindFirstChild("HumanoidRootPart") or Mango.Locals.AimAssistTarget.Character:FindFirstChild("Head")
                                         if root and IsBehindWall(Camera.CFrame.Position, root, Mango.Locals.AimAssistTarget.Character) then Mango.Locals.AimAssistTarget = nil end
                                     end
                                     if not Mango.Locals.AimAssistTarget then
                                         local PlayerModule = Modules.Get("Player")
                                         if PlayerModule and PlayerModule.GetClosestPlayerToCursorAimAssist then
                                             Mango.Locals.AimAssistTarget = PlayerModule.GetClosestPlayerToCursorAimAssist()
                                         end
                                     end
                                else
                                    Mango.Locals.AimAssistTarget = nil
                                end
                            else
                                AimAssistActive = false
                                Mango.Locals.AimAssistTarget = nil
                            end
                        elseif featureName == 'Triggerbot' then
                            local cfg = getgenv().Prey.Combat['Triggerbot']
                            if cfg and cfg.Enabled then
                                TriggerbotActive = targetState
                                Mango.Locals.TriggerbotActive = targetState
                            else
                                TriggerbotActive = false
                                Mango.Locals.TriggerbotActive = false
                            end
                        elseif featureName == 'Esp' then
                            local espConfig = getgenv().Prey.Visuals and getgenv().Prey.Visuals.Esp
                            if espConfig and espConfig['Enabled'] == true then
                                espenabled = targetState
                                Mango.Locals.ESPEnabled = targetState
                            else
                                espenabled = false
                                Mango.Locals.ESPEnabled = false
                            end
                        elseif featureName == 'Speed' then
                            toggleState(nil, 'speed')
                        elseif featureName == 'Inventory Sorter' then
                            doInventorySort()
                        elseif featureName == 'Panic Ground' then
                            doPanicGround()
                        elseif featureName == 'Auto Armor' then
                            doAutoArmor(false, true)
                        end
                    end
                end
            end
        end
        -- Noclip Hold press check (configured ONLY in getgenv().Prey['Noclip']['Key'])
        local ncfg = getgenv().Prey and getgenv().Prey['Noclip']; local nKey = ncfg and ncfg['Key']
        if nKey and type(nKey) == "string" and #nKey > 0 and string.upper(input.KeyCode.Name) == string.upper(nKey) then NoclipActive = true end
    end)
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if getgenv().PreyGeneration ~= MyGeneration then return end
        if gameProcessed then return end
        -- AntiGravity Hold release check (configured ONLY in getgenv().Prey['AntiGravity']['Key'])
        local agcfg = getgenv().Prey and getgenv().Prey['AntiGravity']; local agKey = agcfg and agcfg['Key']
        if agKey and type(agKey) == "string" and #agKey > 0 and string.upper(input.KeyCode.Name) == string.upper(agKey) then AntiGravityActive = false end
        -- Noclip Hold release check (configured ONLY in getgenv().Prey['Noclip']['Key'])
        local ncfg = getgenv().Prey and getgenv().Prey['Noclip']; local nKey = ncfg and ncfg['Key']
        if nKey and type(nKey) == "string" and #nKey > 0 and string.upper(input.KeyCode.Name) == string.upper(nKey) then
            if NoclipActive then
                NoclipActive = false
                local char = Self.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = true end
                    end
                end
            end
        end
        local key = input.KeyCode.Name; local keybinds = getgenv().Prey['Main'] and getgenv().Prey['Main']['Keybind']
        if keybinds then
            for featureName, bindData in pairs(keybinds) do
                local bindKey, bindMode
                if type(bindData) == 'table' then
                    bindKey = bindData[1]
                    bindMode = bindData[2]
                elseif type(bindData) == 'string' then
                    bindKey = bindData
                    -- For Aim Assist and Triggerbot, use config Mode instead of defaulting to Toggle
                    if featureName == 'Aim Assist' then
                        local cfg = getgenv().Prey['Combat']['Aim Assist']
                        bindMode = cfg and cfg.Mode or 'Toggle'
                    elseif featureName == 'Triggerbot' then
                        local cfg = getgenv().Prey.Combat['Triggerbot']
                        local funcType = cfg and cfg['Functionality Type'] or {}
                        bindMode = funcType.Type or 'Toggle'
                    else
                        bindMode = 'Toggle'
                    end
                end
                if bindKey and bindKey == key and bindMode == 'Hold' then
                    if featureName == 'Silent Aim' then getgenv().Prey['Combat']['Silent Aim']['Enabled'] = false end
                    if featureName == 'Aim Assist' then
                        AimAssistActive = false
                        Mango.Locals.AimAssistTarget = nil
                    end
                    if featureName == 'Triggerbot' then
                        local triggerbotCfg = getgenv().Prey.Combat['Triggerbot']
                        TriggerbotActive = false
                        Mango.Locals.TriggerbotActive = false
                    end
                    if featureName == 'Esp' then
                            -- Hold mode release: only act if config allows ESP
                            local espConfig = getgenv().Prey.Visuals and getgenv().Prey.Visuals.Esp
                            if espConfig and espConfig['Enabled'] == true then
                                espenabled = false
                                Mango.Locals.ESPEnabled = false
                            end
                        end
                end
            end
        end
    end)
    -- RENDER LOOP (Heartbeat) for Movement & Character Modifications
    local function getCurrentSpeedState()
        local char = Self.Character
        if not char then return "Normal" end
        local hum = char:FindFirstChildOfClass("Humanoid"); local bodyEffects = char:FindFirstChild("BodyEffects"); local tool = char:FindFirstChildOfClass("Tool")
        -- Low health check (<= 30 health)
        if hum and hum.Health <= 30 then return "Low health" end
        -- Reloading check
        if bodyEffects and bodyEffects:FindFirstChild("Reload") and bodyEffects.Reload.Value == true then return "Reloading" end
        -- Knife check
        if tool and tool.Name == "[Knife]" then return "Knife" end
        -- Shooting check (mouse held + gun equipped)
        if tool and tool:FindFirstChild("Ammo") and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then return "Shooting" end
        return "Normal"
    end
    -- NOTE: Second triggerbot loop removed; first ThreadLoop handles all triggerbot logic with proper screen-center FOV
    Utility.Connection(RunService.Heartbeat, LPH_NO_VIRTUALIZE(function()
        -- Speed (state-based: Normal, Shooting, Reloading, Knife, Low health)
        local speedCfg = getgenv().Prey['Speed Modifications']
        if speedCfg and speedCfg['Enabled'] and speedenabled then
            local char = Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid"); local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local bodyEffects = char:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                local isKnocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                if not isDead and not isKnocked and not hum.Sit and not hum.PlatformStand then
                    local speeds = speedCfg['Speeds'] or { ["Shooting"] = 0.6, ["Low health"] = 2, ["Knife"] = 0.9, ["Reloading"] = 0.6, ["Normal"] = 0.9, }
                    local stateName = getCurrentSpeedState(); local targetMultiplier = speeds[stateName] or speeds["Normal"] or 0.9; local targetSpeed = targetMultiplier * 50
                    -- Pure native Roblox Humanoid WalkSpeed
                    hum.WalkSpeed = targetSpeed
                end
            end
        else
            pcall(function()
                local char = Self and Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed > 35 then hum.WalkSpeed = 16 end
            end)
        end
        -- AntiGravity Physics Engine (Heartbeat sync)
        local agCfg = getgenv().Prey and getgenv().Prey['AntiGravity']
        if agCfg and agCfg['Enabled'] ~= false then
            local char = Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid"); local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                if hum.FloorMaterial ~= Enum.Material.Air then
                    -- Touch floor: completely deactivate AntiGravity
                    AntiGravityActive = false
                else
                    local bodyEffects = char:FindFirstChild("BodyEffects")
                    local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                    local isKnocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                    if not isDead and not isKnocked then
                        local floatSpeed = tonumber(agCfg['Float Speed']) or 15
                        if AntiGravityActive then
                            -- Float UP gently / hover at floatSpeed when active in air
                            local curVel = hrp.AssemblyLinearVelocity
                            hrp.AssemblyLinearVelocity = Vector3.new(curVel.X, floatSpeed, curVel.Z)
                        else
                            -- Slow down fall speed gently when inactive in air
                            local curVel = hrp.AssemblyLinearVelocity; local slowFallVel = math.max(curVel.Y, -floatSpeed)
                            hrp.AssemblyLinearVelocity = Vector3.new(curVel.X, slowFallVel, curVel.Z)
                        end
                    end
                end
            end
        end
        -- Inf Ammo / No Cooldown helpers
        local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
        if tool then
            if infammoenabled then
                local ammo = tool:FindFirstChild("Ammo"); local maxAmmo = tool:FindFirstChild("MaxAmmo")
                if ammo and maxAmmo then ammo.Value = maxAmmo.Value end
            end
            if nocooldownenabled then
                local values = tool:FindFirstChild("Values")
                if values then
                    local cooldown = values:FindFirstChild("Cooldown") or values:FindFirstChild("CooldownTime")
                    if cooldown then cooldown.Value = 0 end
                    local recoil = values:FindFirstChild("Recoil") or values:FindFirstChild("RecoilControl")
                    if recoil then recoil.Value = 0 end
                    local spread = values:FindFirstChild("Spread") or values:FindFirstChild("Accuracy")
                    if spread then spread.Value = 0 end
                end
            end
            if infiniteRangeEnabled then
                local values = tool:FindFirstChild("Values")
                if values then
                    local range = values:FindFirstChild("Range") or values:FindFirstChild("FireRate")
                    if range then range.Value = 9999 end
                end
            end
        end
        -- Anti Trip (undetected: corrects PlatformStand safely without floor-clipping or flinging on KO getup)
        local atcfg = getgenv().Prey['Anti Trip']
        if atcfg and atcfg['Enabled'] then
            local char = Self.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local bodyEffects = char:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                local isKnocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                if not isDead and not isKnocked and hum and hum.Health > 0 then
                    local state = hum:GetState()
                    if state ~= Enum.HumanoidStateType.GettingUp and state ~= Enum.HumanoidStateType.Ragdoll and state ~= Enum.HumanoidStateType.FallingDown then
                        if hum.PlatformStand then hum.PlatformStand = false end
                        if hum.Sit then hum.Sit = false end
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local rx, ry, rz = hrp.CFrame:ToEulerAnglesYXZ()
                            if math.abs(rx) > 0.4 or math.abs(rz) > 0.4 then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterDescendantsInstances = {char}
                                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                                local rayRes = workspace:Raycast(hrp.Position + Vector3.new(0, 2, 0), Vector3.new(0, -10, 0), rayParams); local targetY = hrp.Position.Y
                                if rayRes and (rayRes.Position.Y + 3.1) > targetY then targetY = rayRes.Position.Y + 3.1 end
                                hrp.CFrame = CFrame.new(hrp.Position.X, targetY, hrp.Position.Z) * CFrame.Angles(0, ry, 0)
                                pcall(function()
                                    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, math.clamp(hrp.AssemblyLinearVelocity.Y, -50, 50), hrp.AssemblyLinearVelocity.Z)
                                end)
                            end
                        end
                    end
                end
            end
        end
        -- Hitbox Expander (render-step sync — expands HumanoidRootPart only for undetected invisible hitboxes)
        local hbCfg = getgenv().Prey['Tools'] and getgenv().Prey['Tools']['Mods'] and getgenv().Prey['Tools']['Mods']['Hitbox Expander']
        if hbCfg and hbCfg['Enabled'] then
            local tool = Self.Character and Self.Character:FindFirstChildOfClass('Tool')
            if not tool or IsGunAllowed('Gun', 'Hitbox Expander', tool.Name) then
                local expandX = hbCfg['X'] or hbCfg['Width'] or 2
                local expandY = hbCfg['Y'] or hbCfg['Height'] or 2; local expandZ = hbCfg['Z'] or hbCfg['Depth'] or 2; local targetSize = Vector3.new(expandX, expandY, expandZ)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= Self and plr.Character then
                        local char = plr.Character
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        local isKnocked = char:FindFirstChild('BodyEffects') and char.BodyEffects:FindFirstChild('K.O') and char.BodyEffects['K.O'].Value
                        local hrp = char:FindFirstChild('HumanoidRootPart'); local head = char:FindFirstChild('Head')
                        if hrp and hum and hum.Health > 0 and not isKnocked then
                            if hrp.Size ~= targetSize then hrp.Size = targetSize end
                            hrp.Transparency = 1
                        else
                            if head and head:IsA('BasePart') then
                                local isR6 = char:FindFirstChild("Torso") ~= nil; local normHead = isR6 and Vector3.new(2, 1, 1) or Vector3.new(1.2, 1.2, 1.2)
                                if head.Size ~= normHead then head.Size = normHead end
                            end
                        end
                    end
                end
            end
        end
    end))
Utility.Connection(RunService.PreRender, LPH_NO_VIRTUALIZE(function()
    -- FULL AUTO UNTARGET ON DEATH / KNOCK / GRAB
    local function FullAutoUntarget()
        local function IsDead(char)
            local hum = char:FindFirstChild("Humanoid")
            return not hum or hum.Health <= 0
        end
        local function IsKnocked(char)
            local be = char:FindFirstChild("BodyEffects")
            return be and be:FindFirstChild("K.O") and be["K.O"].Value
        end
        local function IsGrabbed(char) return char:FindFirstChild("GRABBING_CONSTRAINT") ~= nil end
        local function ClearAll()
            Mango.Locals.SilentAimTarget  = nil
            Mango.Locals.LockedTarget     = nil
            Mango.Locals.HitPosition      = nil
            Mango.Locals.AimAssistTarget  = nil
            -- Clear 3D box if exists
            if Mango.Visuals.BoxFOV then Mango.Visuals.BoxFOV.Visible = false end
            local selectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'
            if selectionMode == 'Target' then
                SP = false
                AimAssistActive = false
                TriggerbotActive = false
                Mango.Locals.TriggerbotActive = false
            else
                SP = true
            end
        end
        -- Check main target (covers SilentAim & Target Mode and Multi-Target)
        if Environment and Environment.Priority and #Environment.Priority > 0 then
            for i = #Environment.Priority, 1, -1 do
                local p = Environment.Priority[i]
                if not p or not p.Parent then table.remove(Environment.Priority, i) end
            end
            local primaryTarget = Environment.Priority[1]
            Mango.Locals.LockedTarget = primaryTarget
            -- SilentAim target resolution:
            local checks = getgenv().Prey.Main.Target.Unlock or {}
            local allowThroughWalls = checks and checks['Through Walls'] == true
            if primaryTarget and primaryTarget.Character then
                local char = primaryTarget.Character
                local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Head')
                local isBehindWall = rootPart and IsBehindWall(Camera.CFrame.Position, rootPart, char)
                if allowThroughWalls or not isBehindWall then Mango.Locals.SilentAimTarget = primaryTarget else Mango.Locals.SilentAimTarget = nil end
                -- Aim Assist Camera Target: ONLY active when target is FULLY VISIBLE on screen AND cursor is inside FOV box AND whitelisted weapon is out
                local charTool = Self and Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                local isWeaponAllowed = charTool and IsGunAllowed('Combat', 'Aim Assist', charTool.Name)
                if AimAssistActive and isWeaponAllowed and IsTargetFullyVisible(char) and rootPart and IsCursorInTargetBox(rootPart, rootPart.Position, 'Aimbot') then
                    Mango.Locals.AimAssistTarget = primaryTarget
                else
                    Mango.Locals.AimAssistTarget = nil
                end
            else
                Mango.Locals.SilentAimTarget = nil
                Mango.Locals.AimAssistTarget = nil
            end
        else
            local mainTarget = Mango.Locals.LockedTarget or Mango.Locals.SilentAimTarget
            if mainTarget then
                local checks = getgenv().Prey.Main.Target.Unlock or {}
                local allowThroughWalls = checks and checks['Through Walls'] == true
                local vCheck = checks and (checks.Vehicle ~= nil and checks.Vehicle or checks['Vehicle Check'])
                -- If target player left game completely, clear lock completely
                if not mainTarget.Parent then
                    ClearAll()
                    return
                end
                local char = mainTarget.Character; local isInvalidChar = not char or not char.Parent or IsDead(char) or
                                     (checks.Knocked and IsKnocked(char)) or
                                     (checks.Grabbed and IsGrabbed(char)) or
                                     (vCheck == false and IsOnVehicle(char))
                if isInvalidChar then
                    Mango.Locals.SilentAimTarget = nil
                    Mango.Locals.AimAssistTarget = nil
                    Mango.Locals.HitPosition = nil
                    if Mango.Visuals.BoxFOV then Mango.Visuals.BoxFOV.Visible = false end
                    return
                end
                local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Head')
                local isBehindWall = rootPart and IsBehindWall(Camera.CFrame.Position, rootPart, char)
                local isInsideFOV = rootPart and IsCursorInTargetBox(rootPart, rootPart.Position, 'Aimbot')
                if allowThroughWalls or not isBehindWall then Mango.Locals.SilentAimTarget = mainTarget else Mango.Locals.SilentAimTarget = nil end
                -- Aim Assist Camera Target: ONLY active when target is FULLY VISIBLE on screen AND cursor is inside FOV box AND whitelisted weapon is out
                local charTool = Self and Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                local isWeaponAllowed = charTool and IsGunAllowed('Combat', 'Aim Assist', charTool.Name)
                if AimAssistActive and isWeaponAllowed and IsTargetFullyVisible(char) and isInsideFOV then
                    Mango.Locals.AimAssistTarget = mainTarget
                else
                    Mango.Locals.AimAssistTarget = nil
                end
            end
        end
    end
    FullAutoUntarget()
    -- Auto Mode: automatically acquire closest target (Da Hood only; Hood Customs uses lyric hooks)
    local SelectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'
    local silentCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Silent Aim']
    local triggerCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot
    local isSilentOn = silentCfg and silentCfg.Enabled == true; local isTriggerOn = Mango.Locals.TriggerbotActive or (triggerCfg and triggerCfg.Enabled == true)
    if SelectionMode == 'Auto' and (isSilentOn or isTriggerOn) and not IsHoodCustoms() then
        -- Nearest cursor: pick the player whose screen position is closest to the mouse
        local closest = nil; local minDist = math.huge; local myChar = Self.Character; local myHRP = myChar and myChar:FindFirstChild('HumanoidRootPart')
        local checks = getgenv().Prey.Main.Target.Unlock or {}
        local mousePos = UserInputService:GetMouseLocation()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Self then continue end
            if IsPlayerProtected(plr) then continue end
            if not plr.Character then continue end
            local char = plr.Character; local hrp = char:FindFirstChild('HumanoidRootPart'); local humanoid = char:FindFirstChildOfClass('Humanoid')
            if not hrp or not humanoid or humanoid.Health <= 0 then continue end
            if checks.Knocked and Player.IsKnocked(char) then continue end
            if checks.Grabbed and Player.IsGrabbed(char) then continue end
            local vCheck = checks and (checks.Vehicle ~= nil and checks.Vehicle or checks['Vehicle Check'])
            if vCheck == false and IsOnVehicle(char) then continue end
            -- Wall check (both head and root must be behind wall to exclude)
            local head = char:FindFirstChild('Head')
            local headBehind = head and IsBehindWall(Camera.CFrame.Position, head, char); local rootBehind = IsBehindWall(Camera.CFrame.Position, hrp, char)
            if checks['Through Walls'] ~= true and (headBehind and rootBehind) then continue end
            local maxDistance = 300; local distanceConfig = getgenv().Prey.Combat['Distance Check']
            if distanceConfig then
                if distanceConfig['Max Distance'] then maxDistance = distanceConfig['Max Distance'] end
                local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then maxDistance = distanceConfig.Guns[tool.Name] end
            end
            if myHRP and (myHRP.Position - hrp.Position).Magnitude > maxDistance then continue end
            -- Must be inside FOV Box (Silent FOV or Triggerbot FOV)
            local isInsideBox = IsCursorInTargetBox(hrp, hrp.Position, 'Silent') or IsCursorInTargetBox(hrp, hrp.Position, 'Triggerbot')
            if not isInsideBox then continue end
            local targetPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if not onScreen then continue end
            local dist = (Vector2.new(targetPos.X, targetPos.Y) - mousePos).Magnitude
            if dist < minDist then
                minDist = dist
                closest = plr
            end
        end
        if closest then
            Mango.Locals.SilentAimTarget = closest
            Mango.Locals.LockedTarget = closest
        else
            Mango.Locals.SilentAimTarget = nil
            Mango.Locals.LockedTarget = nil
        end
    end
    if IsHoodCustoms() and (isSilentOn or isTriggerOn) then
        local hcSelectionMode = getgenv().Prey.Main.Target.Mode or 'Auto'
        if hcSelectionMode == 'Auto' then
            local closest = nil; local minDist = math.huge; local mousePos = UserInputService:GetMouseLocation()
            local unlock = getgenv().Prey.Main.Target.Unlock or {}
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Self then continue end
                if IsPlayerProtected(plr) then continue end
                if not plr.Character then continue end
                local char = plr.Character; local hrp = char:FindFirstChild("HumanoidRootPart"); local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not hrp or not humanoid or humanoid.Health <= 0 then continue end
                if unlock.Knocked and Player.IsKnocked(char) then continue end
                if unlock.Grabbed and Player.IsGrabbed(char) then continue end
                if unlock["Through Walls"] ~= true then
                    if IsBehindWall(Camera.CFrame.Position, hrp, char) then continue end
                end
                local distanceConfig = getgenv().Prey.Combat['Distance Check']
                if distanceConfig and distanceConfig.Enabled then
                    local maxDistance = distanceConfig['Max Distance'] or 300; local tool = Self.Character and Self.Character:FindFirstChildOfClass("Tool")
                    if tool and distanceConfig.Guns and distanceConfig.Guns[tool.Name] ~= nil and not distanceConfig['Universal'] then
                        maxDistance = distanceConfig.Guns[tool.Name]
                    end
                    local myHRP = Self.Character and Self.Character:FindFirstChild('HumanoidRootPart')
                    if myHRP and (myHRP.Position - hrp.Position).Magnitude > maxDistance then continue end
                end
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if not onScreen or screenPos.Z <= 0 then continue end
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = plr
                end
            end
            Mango.Locals.SilentAimTarget = closest
            Mango.Locals.LockedTarget = closest
        end
        if Mango.Locals.SilentAimTarget and Mango.Locals.SilentAimTarget.Character then
            local tChar = Mango.Locals.SilentAimTarget.Character
            local rootPart = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head")
            local isTargetLocked = (Mango.Locals.LockedTarget ~= nil) or (Environment and Environment.Priority and #Environment.Priority > 0)
            local isTriggerFiring = Mango.Locals.TriggerbotActive or TriggerbotActive or (getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot and getgenv().Prey.Combat.Triggerbot.Enabled == true)
            local isInsideFOV = rootPart and (isTargetLocked or IsCursorInTargetBox(rootPart, rootPart.Position, 'Silent') or (isTriggerFiring and IsCursorInTargetBox(rootPart, rootPart.Position, 'Triggerbot')))
            if isInsideFOV then
                if Mango.HCSilentAim then
                    local hcCfg = Mango.HCSilentAim.GetSilentAimCfg(); local pos = select(1, Mango.HCSilentAim.ResolveHitPosition(tChar, hcCfg))
                    if pos then Mango.Locals.HitPosition = Mango.HCSilentAim.ApplyPrediction(pos, Mango.Locals.SilentAimTarget, hcCfg) end
                end
            else
                Mango.Locals.HitPosition = nil
            end
        end
    end
    -- Normal aimbot logic (runs when target is locked, cursor inside Silent FOV box, or Triggerbot FOV box)
    if not IsHoodCustoms() and Mango.Locals.SilentAimTarget and Mango.Locals.SilentAimTarget.Character then
        local tChar = Mango.Locals.SilentAimTarget.Character
        local rootPart = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head")
        local isTargetLocked = (Mango.Locals.LockedTarget ~= nil) or (Environment and Environment.Priority and #Environment.Priority > 0)
        local isTriggerFiring = Mango.Locals.TriggerbotActive or TriggerbotActive or (getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat.Triggerbot and getgenv().Prey.Combat.Triggerbot.Enabled == true)
        local isInsideTargetBox = IsCursorInTargetBox(rootPart, rootPart.Position, 'Silent') or (isTriggerFiring and IsCursorInTargetBox(rootPart, rootPart.Position, 'Triggerbot'))
        if rootPart and (isTargetLocked or isInsideTargetBox) then Mango.Locals.HitPosition = Player.GetHitPosition("Silent") else Mango.Locals.HitPosition = nil end
    elseif not IsHoodCustoms() then
        Mango.Locals.HitPosition = nil
    end
    -- Aim Assist handling for 'Always', 'Hold', and 'Toggle' modes
    local aimAssistCfg2 = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Aim Assist']
    if type(aimAssistCfg2) == "table" and aimAssistCfg2.Enabled == true then
        local aaMode = aimAssistCfg2.Mode or 'Hold'
        local currentTool = (Self and Self.Character or (game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character)) and (Self and Self.Character or game:GetService("Players").LocalPlayer.Character):FindFirstChildOfClass("Tool")
        local isWeaponAllowed = currentTool and IsGunAllowed('Combat', 'Aim Assist', currentTool.Name)
        if aaMode == 'Always' then
            if isWeaponAllowed then
                local PlayerModule = Modules.Get("Player")
                local candidateTarget = PlayerModule and PlayerModule.GetClosestPlayerToCursorAimAssist and PlayerModule.GetClosestPlayerToCursorAimAssist()
                if candidateTarget and candidateTarget.Character then
                    local targetRoot = candidateTarget.Character:FindFirstChild("HumanoidRootPart") or candidateTarget.Character:FindFirstChild("Head")
                    local checks = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock; local wallCheckPassed = true
                    if targetRoot then
                        if IsBehindWall(Camera.CFrame.Position, targetRoot, candidateTarget.Character) then wallCheckPassed = false end
                    end
                    if wallCheckPassed then
                        AimAssistActive = true
                        Mango.Locals.AimAssistTarget = candidateTarget
                    else
                        AimAssistActive = false
                        Mango.Locals.AimAssistTarget = nil
                    end
                else
                    AimAssistActive = false
                    Mango.Locals.AimAssistTarget = nil
                end
            else
                AimAssistActive = false
                Mango.Locals.AimAssistTarget = nil
            end
        else
            if AimAssistActive then
                if isWeaponAllowed then
                    local mainTarget = Mango.Locals.LockedTarget
                    if mainTarget and mainTarget.Parent and mainTarget.Character then
                        local char = mainTarget.Character
                        local hum = char:FindFirstChild("Humanoid"); local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                        local checks = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock or {}
                        local isDead = not hum or hum.Health <= 0
                        local isKnocked = checks.Knocked and char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("K.O") and char.BodyEffects["K.O"].Value
                        local isGrabbed = checks.Grabbed and char:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
                        local behindWall = root and IsBehindWall(Camera.CFrame.Position, root, char)
                        if not isDead and not isKnocked and not isGrabbed and not behindWall then
                            Mango.Locals.AimAssistTarget = mainTarget
                        else
                            Mango.Locals.AimAssistTarget = nil
                        end
                    else
                        Mango.Locals.AimAssistTarget = nil
                    end
                else
                    Mango.Locals.AimAssistTarget = nil
                end
            else
                Mango.Locals.AimAssistTarget = nil
            end
        end
    else
        AimAssistActive = false
        Mango.Locals.AimAssistTarget = nil
    end
    -- ============================================================
    -- HEALTH/ARMOR BAR BUILDER (tactical HUD style)
    -- Builds once per player, then updated in-place every frame.
    -- ============================================================
    if not Mango.HudBars then
        Mango.HudBars = {}
        -- Dedicated ScreenGui for the HUD bars (so we don't depend on local scopes
        -- from the Overlay module). ResetOnSpawn keeps bars alive across respawns.
        local HudGui = Instance.new('ScreenGui')
        HudGui.Name = 'PreyHudBars'
        HudGui.IgnoreGuiInset = true
        HudGui.ResetOnSpawn = false
        HudGui.DisplayOrder = 9999
        HudGui.Parent = game:GetService('CoreGui')
        Mango.HudBars._gui = HudGui
        -- Smooth color spectrum from full health (neon green) -> critical (deep red).
        local function healthSpectrum(pct)
            pct = math.clamp(pct, 0, 1)
            if pct >= 0.75 then
                local t = (pct - 0.75) / 0.25
                return Color3.fromRGB(
                    50  + math.floor((1 - t) * 130), 255,
                    79  - math.floor((1 - t) * 79)
                )
            elseif pct >= 0.50 then
                local t = (pct - 0.50) / 0.25
                return Color3.fromRGB(
                    180 + math.floor((1 - t) * 0), 255 - math.floor((1 - t) * 25),
                    0   + math.floor(t * 79)
                )
            elseif pct >= 0.30 then
                local t = (pct - 0.30) / 0.20
                return Color3.fromRGB(
                    255, 180 - math.floor((1 - t) * 75),
                    0   + math.floor(t * 79)
                )
            elseif pct >= 0.15 then
                local t = (pct - 0.15) / 0.15
                return Color3.fromRGB(
                    255 - math.floor((1 - t) * 75), 105 - math.floor((1 - t) * 105),
                    0   + math.floor((1 - t) * 20)
                )
            else
                return Color3.fromRGB(180, 0, 20)
            end
        end
        -- Creates a single bar: a matte-black frame with a dark outline,
        -- a soft-glow layer, and a fill frame carrying a vertical gradient.
        local function createBar()
            local bar = Instance.new('Frame')
            bar.Name = 'HudBar'
            bar.BorderSizePixel = 0
            bar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            bar.BackgroundTransparency = 0.05
            bar.Visible = false
            bar.Parent = HudGui
            -- Dark gray outline (1-2px)
            local stroke = Instance.new('UIStroke')
            stroke.Name = 'Outline'
            stroke.Color = Color3.fromRGB(26, 26, 26)
            stroke.Thickness = 1.5
            stroke.Transparency = 0
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = bar
            -- Subtle inner shadow for depth
            local pad = Instance.new('UIPadding')
            pad.PaddingTop = UDim.new(0, 1)
            pad.PaddingBottom = UDim.new(0, 1)
            pad.PaddingLeft = UDim.new(0, 1)
            pad.PaddingRight = UDim.new(0, 1)
            pad.Parent = bar
            -- Fill frame (left-to-right, vertical edge cut)
            local fill = Instance.new('Frame')
            fill.Name = 'Fill'
            fill.BorderSizePixel = 0
            fill.BackgroundColor3 = Color3.fromRGB(50, 255, 79)
            fill.BackgroundTransparency = 0
            fill.ClipsDescendants = true
            fill.Position = UDim2.fromOffset(1, 1)
            fill.Size = UDim2.new()
            fill.Parent = bar
            -- Vertical gradient on the fill (top brighter, bottom darker).
            -- Using offset (0..1) tint so the fill's BackgroundColor3 drives the hue.
            local grad = Instance.new('UIGradient')
            grad.Name = 'VGrad'
            grad.Rotation = 90
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(120, 120, 120)),
            })
            grad.Parent = fill
            -- Faint soft glow around only the filled portion
            local glow = Instance.new('UIStroke')
            glow.Name = 'Glow'
            glow.Color = Color3.fromRGB(50, 255, 79)
            glow.Thickness = 1
            glow.Transparency = 1
            glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
            glow.Parent = fill
            return { bar = bar, fill = fill, grad = grad, glow = glow, }
        end
        -- Per-player container: { health = {...}, armor = {...} }
        Mango.HudBars.getOrCreate = function(player)
            local entry = Mango.HudBars[player]
            if not entry then
                entry = { health = createBar(), armor = createBar() }
                Mango.HudBars[player] = entry
            end
            return entry
        end
        Mango.HudBars.healthSpectrum = healthSpectrum
    end
    -- Hide ALL HudBars at the start of every frame.
    -- They are only made visible again below when all conditions pass.
    -- This fixes: bars staying visible when ESP is toggled off, when you
    -- turn away from the player, and when the player dies/resets.
    if Mango.HudBars then
        for plr, hud in pairs(Mango.HudBars) do
            if type(plr) == 'userdata' and hud then
                if hud.health then hud.health.bar.Visible = false end
                if hud.armor  then hud.armor.bar.Visible  = false end
            end
        end
    end
    -- Cider Drawing API Health & Armor ESP System
    local HealthBarDrawings = getgenv().Prey_HealthBarDrawings or {}
    getgenv().Prey_HealthBarDrawings = HealthBarDrawings
    local HealthBarValueCache = getgenv().Prey_HealthBarValueCache or {}
    getgenv().Prey_HealthBarValueCache = HealthBarValueCache
    local function GetHealthBarArmor(Player)
        local Character = Player and Player.Character; local BodyEffects = Character and Character:FindFirstChild('BodyEffects'); local ArmorObject = BodyEffects and (
            BodyEffects:FindFirstChild('Armor')
            or BodyEffects:FindFirstChild('Armour')
            or BodyEffects:FindFirstChild('Defense')
        )
        if ArmorObject and tonumber(ArmorObject.Value) then return tonumber(ArmorObject.Value), true end
        local Leaderstats = Player and Player:FindFirstChild('leaderstats'); local LeaderArmor = Leaderstats and (
            Leaderstats:FindFirstChild('Armor')
            or Leaderstats:FindFirstChild('Armour')
            or Leaderstats:FindFirstChild('Defense')
            or Leaderstats:FindFirstChild('Vest')
        )
        if LeaderArmor and tonumber(LeaderArmor.Value) then return tonumber(LeaderArmor.Value), true end
        return 0, false
    end
    local function GetStableHealthBarValues(Player, Humanoid)
        local Now = tick(); local Cache = HealthBarValueCache[Player]
        if not Cache or Cache.Character ~= Player.Character then
            Cache = {
                Character = Player.Character, Health = tonumber(Humanoid.Health) or 0, MaxHealth = tonumber(Humanoid.MaxHealth) or 100, Armor = 0, ZeroSince = nil,
                ArmorMissingSince = nil,
            }
            HealthBarValueCache[Player] = Cache
        end
        local RawMaxHealth = tonumber(Humanoid.MaxHealth)
        if RawMaxHealth and RawMaxHealth > 0 and RawMaxHealth == RawMaxHealth then Cache.MaxHealth = RawMaxHealth end
        local MaxHealth = Cache.MaxHealth > 0 and Cache.MaxHealth or 100
        local RawHealth = tonumber(Humanoid.Health); local IsDead = Humanoid:GetState() == Enum.HumanoidStateType.Dead or not Humanoid.Parent
        if RawHealth and RawHealth == RawHealth and RawHealth > 0 then
            Cache.Health = math.clamp(RawHealth, 0, MaxHealth)
            Cache.ZeroSince = nil
        elseif IsDead then
            Cache.Health = 0
            Cache.ZeroSince = Now
        else
            Cache.ZeroSince = nil
        end
        local RawArmor, HasArmorValue = GetHealthBarArmor(Player)
        if HasArmorValue then
            Cache.Armor = math.max(tonumber(RawArmor) or 0, 0)
            Cache.ArmorMissingSince = nil
        else
            Cache.ArmorMissingSince = Cache.ArmorMissingSince or Now
            if Now - Cache.ArmorMissingSince >= 0.3 then Cache.Armor = 0 end
        end
        return Cache.Health, MaxHealth, Cache.Armor, IsDead
    end
    local function HideHealthBarSet(Set)
        if not Set then return end
        for _, Sq in pairs(Set) do
            if Sq and Sq.Visible ~= nil then Sq.Visible = false end
        end
    end
    -- ESP Logic (moved before camera modifications to ensure boxes stay on player center)
    -- Two conditions: config master switch (espConfig.Enabled) AND runtime toggle (Mango.Locals.ESPEnabled).
    local espConfig = getgenv().Prey.Visuals and getgenv().Prey.Visuals.Esp
    if espConfig and espConfig.Enabled and Mango.Locals.ESPEnabled then
        -- ESP storage
        if not Mango.Locals.ESPData then
            Mango.Locals.ESPData = { NameTexts = {}, BoxLines = {}, HealthBars = {}, }
        end
        local espData = Mango.Locals.ESPData
        -- Clean up old ESP elements
        for player, text in pairs(espData.NameTexts) do
            if not player or not player.Parent or not player.Character then
                if text then text:Remove() end
                espData.NameTexts[player] = nil
            end
        end
        for player, lines in pairs(espData.BoxLines) do
            if not player or not player.Parent or not player.Character then
                if lines then
                    for _, line in ipairs(lines) do
                        if line then line:Remove() end
                    end
                end
                espData.BoxLines[player] = nil
            end
        end
        for player, bars in pairs(espData.HealthBars) do
            if not player or not player.Parent or not player.Character then
                if bars then
                    for _, bar in ipairs(bars) do
                        if bar then bar:Remove() end
                    end
                end
                espData.HealthBars[player] = nil
            end
        end
        -- Track character references so we can detect reset/respawn.
        -- When a player resets, player.Character changes to a NEW object.
        -- Any ESP drawing referencing the OLD character must be cleared.
        if not espData.CharacterRefs then espData.CharacterRefs = {} end
        for player, oldChar in pairs(espData.CharacterRefs) do
            local currentChar = player.Parent and player.Character
            -- Hide all ESP when character changes (reset/respawn/avatar morph)
            if currentChar ~= oldChar then
                if espData.NameTexts[player] then espData.NameTexts[player].Visible = false end
                if espData.BoxLines[player] then
                    for _, line in ipairs(espData.BoxLines[player]) do line.Visible = false end
                end
                local hud = Mango.HudBars[player]
                if hud then
                    hud.health.bar.Visible = false
                    hud.armor.bar.Visible  = false
                end
                -- Update ref (nil if player left, new char if reset)
                espData.CharacterRefs[player] = currentChar
                if not currentChar then espData.CharacterRefs[player] = nil end
            end
        end
        -- Update ESP for all players
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Self and player.Character then
                -- Record current character so we detect future resets
                espData.CharacterRefs[player] = player.Character
                local char = player.Character; local hrp = char:FindFirstChild('HumanoidRootPart'); local head = char:FindFirstChild('Head')
                if hrp and head then
                    -- Check if player is valid (not knocked, etc)
                    local isKnocked = false; local isDead = false
                    -- Safely check for knocked state (may not exist in all games)
                    local bodyEffects = char:FindFirstChild('BodyEffects')
                    if bodyEffects then
                        local koValue = bodyEffects:FindFirstChild('K.O')
                        if koValue and koValue:IsA('BoolValue') then isKnocked = koValue.Value end
                    end
                    -- Safely check for dead state
                    local humanoid = char:FindFirstChild('Humanoid')
                    if humanoid then isDead = humanoid.Health <= 0 end
                    if not isKnocked and not isDead then
                        local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        -- pos.Z > 0 required: WorldToViewportPoint returns onScreen=true
                        -- even for players directly behind the camera without this check.
                        onScreen = onScreen and pos.Z > 0
                        if onScreen then
                            -- Name ESP
                            local function resolveFont(fontInput)
                                if typeof(fontInput) == "EnumItem" then
                                    return fontInput
                                elseif type(fontInput) == "string" then
                                    pcall(function()
                                        for _, f in ipairs(Enum.Font:GetEnumItems()) do
                                            if string.lower(f.Name) == string.lower(fontInput) then
                                                fontInput = f
                                                return
                                            end
                                        end
                                    end)
                                    if typeof(fontInput) == "EnumItem" then return fontInput end
                                    local lower = string.lower(fontInput)
                                    if lower == 'ui' then return 0 end
                                    if lower == 'system' then return 1 end
                                    if lower == 'plex' then return 2 end
                                    if lower == 'monospace' then return 3 end
                                end
                                if type(fontInput) == "number" then return fontInput end
                                return Enum.Font.SourceSansBold
                            end
                            if espConfig.Name and espConfig.Name.Enabled then
                                local text = espData.NameTexts[player]
                                if not text then
                                    text = Overlay.new('Text')
                                    text.Size = espConfig.Name['Size'] or 14
                                    text.Font = resolveFont(espConfig.Name['Font'])
                                    text.Outline = true
                                    text.Center = true
                                    espData.NameTexts[player] = text
                                end
                                -- Live-update font & size if changed in the config table
                                text.Font = resolveFont(espConfig.Name['Font'])
                text.Size = espConfig.Name['Size'] or 14
                                text.Visible = true
                                local nameTextStr = getCleanBaseDisplayName and getCleanBaseDisplayName(player) or player.DisplayName
                                text.Text = nameTextStr
                                -- Change color if this player is the current target
                                if Mango.Locals.SilentAimTarget == player then
                                    text.Color = espConfig.Name['Target Color'] or Color3.fromRGB(255, 0, 0)
                                else
                                    text.Color = espConfig.Name.Color or Color3.fromRGB(255, 255, 255)
                                end
                                -- Position based on config
                                local textPos
                                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)); local hrpPos = Camera:WorldToViewportPoint(hrp.Position)
                                if espConfig.Name.Position == 'Top' then
                                    textPos = Vector2.new(headPos.X, headPos.Y - 20)
                                elseif espConfig.Name.Position == 'Bottom' then
                                    textPos = Vector2.new(hrpPos.X, hrpPos.Y + 20)
                                else
                                    textPos = Vector2.new(headPos.X, headPos.Y - 20)
                                end
                                text.Position = textPos
                            elseif espData.NameTexts[player] then
                                espData.NameTexts[player].Visible = false
                            end
                            -- 2D Corner Box ESP
                            if espConfig.Box and espConfig.Box.Enabled then
                                local lines = espData.BoxLines[player]
                                if not lines then
                                    lines = {}
                                    for i = 1, 8 do
                                        lines[i] = Overlay.new('Line')
                                        lines[i].Thickness = espConfig.Box.Thickness or 1
                                        lines[i].Transparency = espConfig.Box.Transparency or 1
                                        lines[i].Color = espConfig.Box.Color or Color3.fromRGB(255, 255, 255)
                                    end
                                    espData.BoxLines[player] = lines
                                end
                                local rootPos = hrp.Position
                                local headPos = head and (head.Position + Vector3.new(0, 0.8, 0)) or (rootPos + Vector3.new(0, 2.6, 0))
                                local feetPos = rootPos - Vector3.new(0, 3.0, 0)
                                local top2D, topVis = Camera:WorldToViewportPoint(headPos)
                                local bot2D, botVis = Camera:WorldToViewportPoint(feetPos); local pos, visible = Camera:WorldToViewportPoint(rootPos)
                                if visible and topVis and botVis and pos.Z > 0 and top2D.Z > 0 and bot2D.Z > 0 then
                                    local rawH = math.abs(bot2D.Y - top2D.Y)
                                    local boxH = math.floor(rawH)
                                    local boxW = math.floor(boxH * 0.60); local boxX = math.floor(pos.X - boxW / 2); local boxY = math.floor(math.min(top2D.Y, bot2D.Y))
                                    if boxH >= 1 then
                                        local lw = math.floor(boxW / 5); local lh = math.floor(boxH / 6); local lt = 1
                                        -- Top left
                                        lines[1].From = Vector2.new(boxX - lt, boxY - lt)
                                        lines[1].To = Vector2.new(boxX + lw, boxY - lt)
                                        lines[2].From = Vector2.new(boxX - lt, boxY - lt)
                                        lines[2].To = Vector2.new(boxX - lt, boxY + lh)
                                        -- Top right
                                        lines[3].From = Vector2.new(boxX + boxW - lw, boxY - lt)
                                        lines[3].To = Vector2.new(boxX + boxW + lt, boxY - lt)
                                        lines[4].From = Vector2.new(boxX + boxW + lt, boxY - lt)
                                        lines[4].To = Vector2.new(boxX + boxW + lt, boxY + lh)
                                        -- Bottom left
                                        lines[5].From = Vector2.new(boxX - lt, boxY + boxH - lh)
                                        lines[5].To = Vector2.new(boxX - lt, boxY + boxH + lt)
                                        lines[6].From = Vector2.new(boxX - lt, boxY + boxH + lt)
                                        lines[6].To = Vector2.new(boxX + lw, boxY + boxH + lt)
                                        -- Bottom right
                                        lines[7].From = Vector2.new(boxX + boxW - lw, boxY + boxH + lt)
                                        lines[7].To = Vector2.new(boxX + boxW + lt, boxY + boxH + lt)
                                        lines[8].From = Vector2.new(boxX + boxW + lt, boxY + boxH + lt)
                                        lines[8].To = Vector2.new(boxX + boxW + lt, boxY + boxH - lh)
                                        local boxColor = espConfig.Box.Color or Color3.fromRGB(255, 255, 255)
                                        if Mango.Locals.SilentAimTarget == player then boxColor = espConfig.Box['Target Color'] or Color3.fromRGB(255, 0, 0) end
                                        local mainUnlock = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock
                                        local isEspWallBlocked = (mainUnlock and mainUnlock['Through Walls'] == false and IsBehindWall(Camera.CFrame.Position, hrp, char))
                                        for _, line in ipairs(lines) do
                                            line.Visible = visible and not isEspWallBlocked
                                            line.Color = boxColor
                                        end
                                    else
                                        for _, line in ipairs(lines) do line.Visible = false end
                                    end
                                else
                                    for _, line in ipairs(lines) do line.Visible = false end
                                end
                            elseif espData.BoxLines[player] then
                                for _, line in ipairs(espData.BoxLines[player]) do
                                    line.Visible = false
                                end
                            end
                            -- Cider's Exact Drawing.new("Square") Health & Armor ESP
                            local healthCfg = espConfig.Health or {}
                            local armorCfg = espConfig.Armor or {}
                            local showHealth = (healthCfg.Enabled ~= false)
                            local showArmor = (armorCfg.Enabled ~= false); local healthColor = Color3.fromRGB(15, 130, 40); local armorColor = Color3.fromRGB(25, 90, 195)
                            if espConfig.Health then espConfig.Health['Color'] = healthColor end
                            if espConfig.Armor then espConfig.Armor['Color'] = armorColor end
                            local targetPlayer = Mango.Locals.SilentAimTarget or Mango.Locals.AimAssistTarget or Mango.Locals.LockedTarget
                            local healthMode = string.lower(tostring(healthCfg.Mode or 'Selected')); local armorMode = string.lower(tostring(armorCfg.Mode or 'Selected'))
                            local targetList = {}
                            if healthMode == 'all' or armorMode == 'all' then
                                for _, p in ipairs(Players:GetPlayers()) do
                                    if p ~= Self and p.Character then
                                        local pHrp = p.Character:FindFirstChild("HumanoidRootPart"); local pHead = p.Character:FindFirstChild("Head")
                                        if pHrp and pHead then
                                            local pPos, pOn = Camera:WorldToViewportPoint(pHrp.Position)
                                            if pOn and pPos.Z > 0 then
                                                local rayParams = RaycastParams.new()
                                                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                                                rayParams.FilterDescendantsInstances = {Self.Character, p.Character, Camera}
                                                local camPos = Camera.CFrame.Position; local hitWall = workspace:Raycast(camPos, pHrp.Position - camPos, rayParams)
                                                if not hitWall then table.insert(targetList, p) end
                                            end
                                        end
                                    end
                                end
                            end
                            if targetPlayer and not table.find(targetList, targetPlayer) then table.insert(targetList, targetPlayer) end
                            for p, set in pairs(HealthBarDrawings) do
                                if not table.find(targetList, p) then HideHealthBarSet(set) end
                            end
                            local isHealthTarget = (healthMode == 'all') or (player == targetPlayer); local isArmorTarget = (armorMode == 'all') or (player == targetPlayer)
                            if (isHealthTarget or isArmorTarget) and not isKnocked and not isDead then
                                local rootPos = hrp.Position; local rootScreenPos, rootOnScreen = Camera:WorldToViewportPoint(rootPos)
                                if rootOnScreen and rootScreenPos.Z > 0 then
                                    if not HealthBarDrawings[player] then
                                        local set = {}
                                        for _, key in ipairs({'HealthBack', 'HealthFill', 'ArmorBack', 'ArmorFill'}) do
                                            local sq = Overlay.new('Square')
                                            sq.Filled = true
                                            sq.Visible = false
                                            set[key] = sq
                                        end
                                        HealthBarDrawings[player] = set
                                    end
                                    local set = HealthBarDrawings[player]
                                    local hpVal, maxHp, armorVal, dead = GetStableHealthBarValues(player, humanoid)
                                    local hpFrac = math.clamp(hpVal / maxHp, 0, 1)
                                    local armorFrac = math.clamp(armorVal / 100, 0, 1); local drawArmor = showArmor and isArmorTarget
                                    set.HealthBack.Color = Color3.fromRGB(8, 8, 12)
                                    set.HealthFill.Color = healthColor
                                    set.ArmorBack.Color = Color3.fromRGB(8, 8, 12)
                                    set.ArmorFill.Color = armorColor
                                    -- Calculate character 2D bounding box (exactly matches 2D Corner Box ESP)
                                    local headPos = head and (head.Position + Vector3.new(0, 0.8, 0)) or (rootPos + Vector3.new(0, 2.6, 0))
                                    local feetPos = rootPos - Vector3.new(0, 3.0, 0)
                                    local top2D = Camera:WorldToViewportPoint(headPos); local bot2D = Camera:WorldToViewportPoint(feetPos)
                                    local rawH = math.abs(bot2D.Y - top2D.Y)
                                    local boxH = math.floor(rawH)
                                    local boxW = math.floor(boxH * 0.60); local boxX = math.floor(rootScreenPos.X - boxW / 2); local boxY = math.floor(math.min(top2D.Y, bot2D.Y))
                                    local headY = boxY; local feetY = boxY + boxH; local centerX = rootScreenPos.X; local boxRightX = boxX + boxW
                                    local hpTrackH = 1; local armTrackH = 1; local border = 1; local gap = 1
                                    local fixedLen = 35
                                    local function parsePos(val, defaultVal)
                                         local s = string.lower(tostring(val or ''))
                                         if string.find(s, "left") then return "left" end
                                         if string.find(s, "right") then return "right" end
                                         if string.find(s, "top") then return "top" end
                                         if string.find(s, "bottom") then return "bottom" end
                                         return defaultVal
                                     end
                                     local hPos = parsePos(healthCfg.Position or healthCfg.Pos or healthCfg.Mode, 'left')
                                     local aPos = parsePos(armorCfg.Position or armorCfg.Pos or armorCfg.Mode, 'bottom')
                                     local showHpAct = showHealth and isHealthTarget and not dead
                                     local showArmAct = showArmor and isArmorTarget and not dead; local isArmSecond = (aPos == hPos) and showHpAct
                                     local hasBottom = (hPos == 'bottom' and showHpAct) or (aPos == 'bottom' and showArmAct)
                                     local hasTop = (hPos == 'top' and showHpAct) or (aPos == 'top' and showArmAct)
                                     local hasLeft = (hPos == 'left' and showHpAct) or (aPos == 'left' and showArmAct)
                                     local hasRight = (hPos == 'right' and showHpAct) or (aPos == 'right' and showArmAct)
                                     local function calcBarDrawInfo(posMode, isSecond, frac, isArmor)
                                         local tH = isArmor and armTrackH or hpTrackH
                                         local barThickness = tH + border * 2; local offset = isSecond and (hpTrackH + border * 2 + gap) or 0
                                         if posMode == 'left' then
                                             local barW = barThickness; local barH = fixedLen; local barX = math.floor(boxX - barW - 3 - offset + 0.5)
                                             local barY
                                             if hasBottom and not hasTop then
                                                 barY = math.floor(feetY - barH + 0.5)
                                             elseif hasTop and not hasBottom then
                                                 barY = math.floor(headY + 0.5)
                                             else
                                                 barY = math.floor((headY + feetY) / 2 - barH / 2 + 0.5)
                                             end
                                             local fillH = math.clamp(math.floor((barH - border * 2) * frac + 0.5), 0, barH - border * 2)
                                             local fillY = barY + barH - border - fillH
                                             return Vector2.new(barW, barH), Vector2.new(barX, barY), Vector2.new(tH, fillH),
                                                    Vector2.new(barX + border, fillY)
                                         elseif posMode == 'right' then
                                             local barW = barThickness; local barH = fixedLen; local barX = math.floor(boxRightX + 3 + offset + 0.5)
                                             local barY
                                             if hasBottom and not hasTop then
                                                 barY = math.floor(feetY - barH + 0.5)
                                             elseif hasTop and not hasBottom then
                                                 barY = math.floor(headY + 0.5)
                                             else
                                                 barY = math.floor((headY + feetY) / 2 - barH / 2 + 0.5)
                                             end
                                             local fillH = math.clamp(math.floor((barH - border * 2) * frac + 0.5), 0, barH - border * 2)
                                             local fillY = barY + barH - border - fillH
                                             return Vector2.new(barW, barH), Vector2.new(barX, barY), Vector2.new(tH, fillH),
                                                    Vector2.new(barX + border, fillY)
                                         elseif posMode == 'top' then
                                             local barW = fixedLen; local barH = barThickness
                                             local barX
                                             if hasLeft and not hasRight then
                                                 barX = math.floor(boxX + 0.5)
                                             elseif hasRight and not hasLeft then
                                                 barX = math.floor(boxRightX - barW + 0.5)
                                             else
                                                 barX = math.floor(centerX - barW / 2 + 0.5)
                                             end
                                             local barY = math.floor(headY - barH - 3 - offset + 0.5)
                                             local fillW = math.clamp(math.floor((barW - border * 2) * frac + 0.5), 0, barW - border * 2)
                                             return Vector2.new(barW, barH), Vector2.new(barX, barY), Vector2.new(fillW, tH),
                                                    Vector2.new(barX + border, barY + border)
                                         else
                                             local barW = fixedLen; local barH = barThickness
                                             local barX
                                             if hasLeft and not hasRight then
                                                 barX = math.floor(boxX + 0.5)
                                             elseif hasRight and not hasLeft then
                                                 barX = math.floor(boxRightX - barW + 0.5)
                                             else
                                                 barX = math.floor(centerX - barW / 2 + 0.5)
                                             end
                                             local barY = math.floor(feetY + 3 + offset + 0.5)
                                             local fillW = math.clamp(math.floor((barW - border * 2) * frac + 0.5), 0, barW - border * 2)
                                             return Vector2.new(barW, barH), Vector2.new(barX, barY), Vector2.new(fillW, tH),
                                                    Vector2.new(barX + border, barY + border)
                                         end
                                     end
                                     local hpBackSize, hpBackPos, hpFillSize, hpFillPos = calcBarDrawInfo(hPos, false, hpFrac, false)
                                     local armBackSize, armBackPos, armFillSize, armFillPos = calcBarDrawInfo(aPos, isArmSecond, armorFrac, true)
                                    set.HealthBack.Size = hpBackSize
                                    set.HealthBack.Position = hpBackPos
                                    set.HealthFill.Size = hpFillSize
                                    set.HealthFill.Position = hpFillPos
                                    set.ArmorBack.Size = armBackSize
                                    set.ArmorBack.Position = armBackPos
                                    set.ArmorFill.Size = armFillSize
                                    set.ArmorFill.Position = armFillPos
                                    local mainUnlock = getgenv().Prey.Main and getgenv().Prey.Main.Target and getgenv().Prey.Main.Target.Unlock
                                    local isEspWallBlocked = (mainUnlock and mainUnlock['Through Walls'] == false and IsBehindWall(Camera.CFrame.Position, hrp, char))
                                    local canShowHp = showHealth and isHealthTarget and hpFrac > 0 and not dead and not isEspWallBlocked
                                    local canShowArm = showArmor and (isArmorTarget or isHealthTarget) and not dead and not isEspWallBlocked
                                    set.HealthBack.Visible = canShowHp
                                    set.HealthFill.Visible = canShowHp
                                    set.ArmorBack.Visible = canShowArm
                                    set.ArmorFill.Visible = canShowArm and armorFrac > 0
                                else
                                    HideHealthBarSet(HealthBarDrawings[player])
                                end
                            else
                                HideHealthBarSet(HealthBarDrawings[player])
                            end
                        else
                            -- Player off screen, hide ESP
                            if espData.NameTexts[player] then espData.NameTexts[player].Visible = false end
                            if espData.BoxLines[player] then
                                for _, line in ipairs(espData.BoxLines[player]) do
                                    line.Visible = false
                                end
                            end
                            HideHealthBarSet(HealthBarDrawings[player])
                            local hud = Mango.HudBars[player]
                            if hud then
                                hud.health.bar.Visible = false
                                hud.armor.bar.Visible = false
                            end
                        end
                    else
                        -- Player knocked/dead, hide ESP
                        if espData.NameTexts[player] then espData.NameTexts[player].Visible = false end
                        if espData.BoxLines[player] then
                            for _, line in ipairs(espData.BoxLines[player]) do
                                line.Visible = false
                            end
                        end
                        HideHealthBarSet(HealthBarDrawings[player])
                        local hud = Mango.HudBars[player]
                        if hud then
                            hud.health.bar.Visible = false
                            hud.armor.bar.Visible = false
                        end
                    end
                end
            end
        end
    else
        -- ESP is disabled: hide all existing elements
        if Mango.Locals.ESPData then
            local espData = Mango.Locals.ESPData
            for _, text in pairs(espData.NameTexts) do
                if text then text.Visible = false end
            end
            for _, lines in pairs(espData.BoxLines) do
                if lines then
                    for _, line in ipairs(lines) do
                        if line then line.Visible = false end
                    end
                end
            end
            if espData.HealthBars then
                for _, bars in pairs(espData.HealthBars) do
                    if bars then
                        for _, bar in ipairs(bars) do
                            if bar then bar.Visible = false end
                        end
                    end
                end
            end
        end
        -- Hide Cider Drawing API health & armor drawings when ESP is off
        for _, set in pairs(HealthBarDrawings) do
            HideHealthBarSet(set)
        end
        -- Hide tactical HUD bars when ESP is off
        if Mango.HudBars then
            for plr, hud in pairs(Mango.HudBars) do
                if type(plr) == 'userdata' and hud and hud.health and hud.armor then
                    hud.health.bar.Visible = false
                    hud.armor.bar.Visible = false
                end
            end
        end
    end
    -- Camera modifications (Aim Assist and Camlock) - applied FIRST so ESP boxes render on finalized camera
    Player.AutomatedPrediction()
    local aimAssistCfg = getgenv().Prey.Combat['Aim Assist']
    local currentTool = (Self and Self.Character or (game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character)) and (Self and Self.Character or game:GetService("Players").LocalPlayer.Character):FindFirstChildOfClass("Tool")
    local isWeaponAllowed = currentTool and IsGunAllowed('Combat', 'Aim Assist', currentTool.Name)
    if type(aimAssistCfg) == "table" and aimAssistCfg.Enabled == true and AimAssistActive and isWeaponAllowed then
        -- Direct, self-contained camera track. We do NOT rely on the cached module's
        -- AimAssistCamera() because that can return early / fail silently. Instead we
        -- resolve the target's hit part right here and lerp the camera toward it.
        local target = Mango.Locals.AimAssistTarget
        if target and target.Character then
            local tChar = target.Character
            -- STRICT AIM ASSIST VISIBILITY CHECK:
            -- Aim assist will NEVER track through walls, buildings, mountains, or off-screen, regardless of 'Through Walls' setting!
            if not IsTargetFullyVisible(tChar) then
                Mango.Locals.AimAssistTarget = nil
            else
                -- Resolve which part to aim at from the HitPart config
                local hitPartMode = getgenv().Prey.Combat['HitPart'] or 'ClosestPart'; local aimPart = nil
                if hitPartMode == 'ClosestPart' then
                    -- Find the part closest to the cursor/center of screen
                    local mousePos = UserInputService:GetMouseLocation(); local bestDist = math.huge
                    for _, p in ipairs(tChar:GetChildren()) do
                        if p:IsA("BasePart") then
                            local pos, onScreen = Camera:WorldToViewportPoint(p.Position)
                            if onScreen and pos.Z > 0 then
                                local d = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                                if d < bestDist then bestDist = d; aimPart = p end
                            end
                        end
                    end
                elseif hitPartMode == 'ClosestPoint' then
                    -- Aim at the root part (ClosestPoint resolves to root for camera tracking)
                    aimPart = tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head")
                else
                    -- Named part: 'Head', 'HumanoidRootPart', 'UpperTorso', etc.
                    aimPart = tChar:FindFirstChild(hitPartMode) or tChar:FindFirstChild("HumanoidRootPart") or tChar:FindFirstChild("Head")
                end
                if aimPart then
                    local aimPos = aimPart.Position; local targetCF = CFrame.new(Camera.CFrame.Position, aimPos)
                    -- Aim Assist Shake (0-10 intensity: 10 = heaviest shake, 0 = almost no shake)
                    local shakeCfg = aimAssistCfg['Shake']; local shakeAmount = 0
                    if type(shakeCfg) == "number" then
                        shakeAmount = shakeCfg
                    elseif type(shakeCfg) == "table" and shakeCfg['Enabled'] ~= false then
                        shakeAmount = tonumber(shakeCfg['Amount'] or shakeCfg['Intensity'] or shakeCfg['Value']) or 0
                    end
                    if shakeAmount > 0 then
                        shakeAmount = math.clamp(shakeAmount, 0, 10)
                        local scale = (shakeAmount / 10) * 0.38
                        local rx = (math.random() * 2 - 1) * scale; local ry = (math.random() * 2 - 1) * scale; local rz = (math.random() * 2 - 1) * (scale * 0.5)
                        targetCF = targetCF * CFrame.Angles(rx, ry, rz)
                    end
                    local smoothing = aimAssistCfg.Smoothness or 0.45
                    if smoothing <= 0 then smoothing = 0.45 end
                    if smoothing > 1 then smoothing = 1 end
                    -- Apply easing style/direction
                    local easingCfg = getgenv().Prey.Combat['Easing Style'] or {}
                    local easingStyle = easingCfg.Style or 'Linear'
                    local easingDirection = easingCfg.Direction or 'In'
                    local easedSmoothing = smoothing
                    local styleTable = PreyEasingFunctions[easingStyle] or PreyEasingFunctions.Linear; local dirFunc = styleTable[easingDirection] or styleTable.In
                    if dirFunc then easedSmoothing = dirFunc(smoothing) end
                    if easedSmoothing <= 0 then easedSmoothing = 0.001 end
                    if easedSmoothing > 1 then easedSmoothing = 1 end
                    Camera.CFrame = Camera.CFrame:Lerp(targetCF, easedSmoothing)
                end
            end
        end
    end
    -- Camera Aimbot (Camlock) toggle integration
    if camlockEnabled and Mango.Locals.LockedTarget and Mango.Locals.LockedTarget.Character then
        local targetChar = Mango.Locals.LockedTarget.Character; local targetHead = targetChar:FindFirstChild("Head")
        if targetHead then Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position) end
    end
    -- Update ESP Box AFTER camera is updated so box renders attached to player
    Main.UpdateBox()
end))
Utility.Connection(RunService.PreRender, LPH_NO_VIRTUALIZE(function()
    if getgenv().Prey.Combat['Silent Aim'].Enabled and CurrentGame.Name == "Da Hood" then
        local GunType = Main.GetGunCategory(); local Tool = Self.Character:FindFirstChildWhichIsA("Tool")
        if Tool then
            if GunType == "Pistol" or GunType == "Sniper" then
                for I, v in pairs(Tool:GetChildren()) do
                    if v.Name == "GunClient" then
                        v:Destroy()
                        --v.Disabled = Mango.Locals.GunScriptDisabled
                    end
                end
            elseif GunType == "Shotgun" then
                for I, v in pairs(Tool:GetChildren()) do
                    if v.Name == "GunClientShotgun" then
                        v:Destroy()
                        --v.Disabled = Mango.Locals.GunScriptDisabled
                    end
                end
            elseif GunType == "Auto" then
                for I, v in pairs(Tool:GetChildren()) do
                    if v.Name == "GunClientAutomaticShotgun" then
                        v:Destroy()
                        --v.Disabled = Mango.Locals.GunScriptDisabled
                    end
                end
            elseif GunType == "Burst" then
                for I, v in pairs(Tool:GetChildren()) do
                    if v.Name == "GunClientBurst" then
                        v:Destroy()
                        --v.Disabled = Mango.Locals.GunScriptDisabled
                    end
                end
            elseif GunType == "Rifle" or GunType == "SMG" then
                for I, v in pairs(Tool:GetChildren()) do
                    if v.Name == "GunClientAutomatic" then
                        v:Destroy()
                        --v.Disabled = Mango.Locals.GunScriptDisabled
                    end
                end
            end
        end
    end
end))
if CurrentGame.Name == 'Dee Hood' and CurrentGame.Updater == nil then
    local function GetArgument()
        for _, Player in next, game:GetService("Players"):GetPlayers() do
            if Player.Backpack:GetAttribute(string.upper("muv")) then return Player.Backpack:GetAttribute(string.upper("muv")) end
        end
        return nil
    end
    local Argument = GetArgument()
    if Argument then CurrentGame.Updater = Argument end
end
    ;(function()
    local preyCombat = getgenv().Prey and getgenv().Prey.Combat
    if preyCombat and preyCombat['Silent Aim'] and preyCombat['Silent Aim'].Enabled then
        local Connections = {}
        local function connectTool(tool)
            if tool and tool:IsA("Tool") and not Connections[tool] then
                Connections[tool] = tool.Activated:Connect(function() Main.SilentAim(tool) end)
            end
        end
        if Self and Self.Backpack then
            local bpChildren = Self.Backpack:GetChildren()
            for i = 1, #bpChildren do
                connectTool(bpChildren[i])
            end
        end
        if Self and Self.Character then
            local charChildren = Self.Character:GetChildren()
            for i = 1, #charChildren do
                connectTool(charChildren[i])
            end
            Self.Character.ChildAdded:Connect(connectTool)
        end
        if Self then
            Self.CharacterAdded:Connect(function(character)
                for tool, connection in pairs(Connections) do
                    pcall(function() connection:Disconnect() end) Connections[tool] = nil end
                character.ChildAdded:Connect(connectTool)
            end)
        end
        task.spawn(function()
            while task.wait() do
                if getgenv().PreyGeneration ~= MyGeneration then break end
                local char = Self and Self.Character; local Tool = char and char:FindFirstChildWhichIsA("Tool")
                if Tool and CurrentGame and CurrentGame.Name == "Da Hood" then
                    Tool:GetPropertyChangedSignal("Grip"):Connect(function() game.ReplicatedStorage:WaitForChild("MainEvent"):FireServer("CHECKER_4") end)
                end
            end
        end)
    end
end)()
-- prey.cc WATERMARK
    local preyGui = Instance.new("ScreenGui")
    preyGui.Name = "PreyWatermarkGui"
    pcall(function() preyGui.Parent = game.CoreGui end)
    if not preyGui.Parent then preyGui.Parent = Self:WaitForChild("PlayerGui") end
    local preyText = Instance.new("TextLabel")
    preyText.Name = "WatermarkLabel"
    preyText.Parent = preyGui
    preyText.AnchorPoint = Vector2.new(0.5, 1)
    preyText.Position = UDim2.new(0.5, 0, 0.9, 0)
    preyText.Size = UDim2.new(0, 260, 0, 60)
    preyText.BackgroundTransparency = 1
    preyText.TextXAlignment = Enum.TextXAlignment.Center
    preyText.TextYAlignment = Enum.TextYAlignment.Bottom
    preyText.Font = Enum.Font.ArimoBold or Enum.Font.Arimo
    pcall(function() preyText.FontFace = Font.new('rbxasset://fonts/families/Arimo.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal) end)
    preyText.TextSize = 11
    preyText.RichText = true
    preyText.TextColor3 = Color3.fromRGB(255, 255, 255)
    preyText.TextStrokeTransparency = 0.2
    preyText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    -- Color normalization helper
    local function ToColor3(c, defaultColor)
        if typeof(c) == "Color3" then return c end
        if type(c) == "table" then
            local r = c.R or c.r or c[1] or 255; local g = c.G or c.g or c[2] or 115; local b = c.B or c.b or c[3] or 0
            if r <= 1 and g <= 1 and b <= 1 then return Color3.new(r, g, b) else return Color3.fromRGB(r, g, b) end
        end
        return defaultColor or Color3.fromRGB(255, 115, 0)
    end
    -- Dynamic Customizable Animated Gradient Generator for "prey.wtf"
    local function GetCustomGradientPreyWtfText(t, color1, color2, speed)
        local letters = {"p", "r", "e", "y", ".", "w", "t", "f"}
        local c1 = ToColor3(color1, Color3.fromRGB(255, 115, 0)); local c2 = ToColor3(color2, Color3.fromRGB(255, 130, 200)); local spd = tonumber(speed) or 3.5
        local result = ""
        for i, char in ipairs(letters) do
            -- Sinusoidal interpolation between Color 1 and Color 2
            local factor = (math.sin(t * spd + (i * 0.55)) + 1) / 2
            local r = math.clamp(math.floor((c1.R + (c2.R - c1.R) * factor) * 255 + 0.5), 0, 255)
            local g = math.clamp(math.floor((c1.G + (c2.G - c1.G) * factor) * 255 + 0.5), 0, 255)
            local b = math.clamp(math.floor((c1.B + (c2.B - c1.B) * factor) * 255 + 0.5), 0, 255)
            result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, char)
        end
        return result
    end
    local lastStopGlideVel = nil
    RunService.RenderStepped:Connect(function()
        -- Speed (state-based: Normal, Shooting, Reloading, Knife, Low health)
        local speedCfg = getgenv().Prey['Speed Modifications']
        if speedCfg and speedCfg['Enabled'] and speedenabled then
            local char = Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid"); local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local bodyEffects = char:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                local isKnocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                if not isDead and not isKnocked and not hum.Sit and not hum.PlatformStand then
                    local speeds = speedCfg['Speeds'] or { ["Shooting"] = 0.6, ["Low health"] = 2, ["Knife"] = 0.9, ["Reloading"] = 0.6, ["Normal"] = 0.9, }
                    local stateName = getCurrentSpeedState(); local targetMultiplier = speeds[stateName] or speeds["Normal"] or 0.9; local targetSpeed = targetMultiplier * 50
                    hum.WalkSpeed = targetSpeed
                end
            end
        end
        pcall(function()
                local char = Self and Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid")
        -- AntiGravity Physics Engine (RenderStepped sync)
        local agCfg = getgenv().Prey and getgenv().Prey['AntiGravity']
        if agCfg and agCfg['Enabled'] ~= false then
            local char = Self.Character; local hum = char and char:FindFirstChildOfClass("Humanoid"); local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                if hum.FloorMaterial ~= Enum.Material.Air then
                    -- Touch floor: completely deactivate AntiGravity
                    AntiGravityActive = false
                else
                    local bodyEffects = char:FindFirstChild("BodyEffects")
                    local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                    local isKnocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                    if not isDead and not isKnocked then
                        local floatSpeed = tonumber(agCfg['Float Speed']) or 15
                        if AntiGravityActive then
                            -- Float UP gently / hover at floatSpeed when active in air
                            local curVel = hrp.AssemblyLinearVelocity
                            hrp.AssemblyLinearVelocity = Vector3.new(curVel.X, floatSpeed, curVel.Z)
                        else
                            -- Slow down fall speed gently when inactive in air
                            local curVel = hrp.AssemblyLinearVelocity; local slowFallVel = math.max(curVel.Y, -floatSpeed)
                            hrp.AssemblyLinearVelocity = Vector3.new(curVel.X, slowFallVel, curVel.Z)
                        end
                    end
                end
            end
        end
        local wmCfg = getgenv().Prey and getgenv().Prey['Watermark']
        if not wmCfg or not wmCfg['Enabled'] then
            if preyText.Visible then preyText.Visible = false end
            return
        end
        if not preyText.Visible then preyText.Visible = true end
        -- Apply customizable layout position (Presets & custom X/Y coordinates)
        local posCfg = wmCfg['Positioning'] or wmCfg['Position'] or wmCfg['Layout']
        local preset = type(posCfg) == "string" and posCfg or (wmCfg['Position'] and type(wmCfg['Position']) == "string" and wmCfg['Position'] or nil)
        local posX, posY = 0.5, 0.9; local szWidth = 260; local txtSz = 9.5
        if type(posCfg) == "table" then
            posX = posCfg['X'] or posCfg['x'] or 0.5
            posY = posCfg['Y'] or posCfg['y'] or 0.9
            preset = posCfg['Preset'] or posCfg['Mode'] or preset
            local szVal = posCfg['Size'] or posCfg['Width'] or posCfg['Text Size'] or posCfg['TextSize']
            if type(szVal) == "number" then
                if szVal <= 50 then txtSz = szVal else szWidth = szVal end
            end
            if type(posCfg['Text Size']) == "number" then txtSz = posCfg['Text Size'] end
            if type(posCfg['TextSize']) == "number" then txtSz = posCfg['TextSize'] end
        elseif type(wmCfg['Size']) == "number" then
            if wmCfg['Size'] <= 50 then txtSz = wmCfg['Size'] else szWidth = wmCfg['Size'] end
        end
        if preset then
            local pLower = tostring(preset):lower():gsub("%s+", "")
            if pLower == "center" or pLower == "original" or pLower == "default" then
                posX, posY = 0.5, 0.9
            elseif pLower == "left" or pLower == "farleft" or pLower == "midleft" then
                posX, posY = 0.015, 0.5
            elseif pLower == "right" or pLower == "farright" or pLower == "midright" then
                posX, posY = 0.985, 0.5
            elseif pLower == "top" or pLower == "topcenter" then
                posX, posY = 0.5, 0.02
            elseif pLower == "bottom" or pLower == "bottomcenter" then
                posX, posY = 0.5, 0.98
            elseif pLower == "topleft" then
                posX, posY = 0.015, 0.02
            elseif pLower == "topright" then
                posX, posY = 0.985, 0.02
            elseif pLower == "bottomleft" then
                posX, posY = 0.015, 0.98
            elseif pLower == "bottomright" then
                posX, posY = 0.985, 0.98
            end
        end
        -- Compute AnchorPoint & Alignment based on position coordinates
        local anchorX = posX <= 0.35 and 0 or (posX >= 0.65 and 1 or 0.5)
        local anchorY = posY <= 0.35 and 0 or (posY >= 0.65 and 1 or 0.5)
        local alignX = posX <= 0.35 and Enum.TextXAlignment.Left or (posX >= 0.65 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center)
        local alignY = posY <= 0.35 and Enum.TextYAlignment.Top or (posY >= 0.65 and Enum.TextYAlignment.Bottom or Enum.TextYAlignment.Center)
        preyText.AnchorPoint = Vector2.new(anchorX, anchorY)
        preyText.Position = UDim2.new(posX, 0, posY, 0)
        preyText.Size = UDim2.new(0, szWidth, 0, math.floor(txtSz * 14))
        preyText.TextSize = txtSz
        preyText.LineHeight = 1.35
        preyText.TextXAlignment = alignX
        preyText.TextYAlignment = alignY
        preyText.TextStrokeTransparency = 0
        preyText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        -- Theme colors (supports Glow Theme, Theme, Glow, and Prey Color/Wtf Color)
        local glowCfg = wmCfg['Glow Theme'] or wmCfg['Glow'] or wmCfg['Theme'] or wmCfg['Colors']
        local c1 = (glowCfg and (glowCfg['Color 1'] or glowCfg['Color1'] or glowCfg['Prey Color'] or glowCfg['Primary Color']))
                   or wmCfg['Color 1'] or wmCfg['Color1'] or wmCfg['Prey Color'] or wmCfg['Primary Color']
                   or Color3.fromRGB(255, 115, 0)
        local c2 = (glowCfg and (glowCfg['Color 2'] or glowCfg['Color2'] or glowCfg['Wtf Color'] or glowCfg['Secondary Color']))
                   or wmCfg['Color 2'] or wmCfg['Color2'] or wmCfg['Wtf Color'] or wmCfg['Secondary Color']
                   or Color3.fromRGB(255, 130, 200)
        local spd = (glowCfg and (glowCfg['Shift Speed'] or glowCfg['Speed'])) or wmCfg['Shift Speed'] or wmCfg['Speed'] or 3.5
        local function BoostVibrancy(col)
            local h, s, v = col:ToHSV()
            return Color3.fromHSV(h, math.clamp(s * 1.15, 0.5, 1), math.clamp(math.max(v, 0.90), 0.9, 1))
        end
        local c1Obj = BoostVibrancy(ToColor3(c1, Color3.fromRGB(255, 115, 0)))
        local c2Obj = BoostVibrancy(ToColor3(c2, Color3.fromRGB(255, 130, 200)))
        local c1Rgb = string.format("rgb(%d,%d,%d)", math.floor(c1Obj.R * 255 + 0.5), math.floor(c1Obj.G * 255 + 0.5), math.floor(c1Obj.B * 255 + 0.5))
        local c2Rgb = string.format("rgb(%d,%d,%d)", math.floor(c2Obj.R * 255 + 0.5), math.floor(c2Obj.G * 255 + 0.5), math.floor(c2Obj.B * 255 + 0.5))
        local lines = {}
        local now = tick()
        table.insert(lines, GetCustomGradientPreyWtfText(now, c1, c2, spd))
        -- Target & Active Features Sentence Formatting (Bright Light Colors + Red Target & Soft Lavender Commas)
        local targetPlr = Mango.Locals.SilentAimTarget or Mango.Locals.LockedTarget
        if targetPlr and targetPlr.Character then
            local tChar = targetPlr.Character
            local tName = targetPlr.DisplayName or targetPlr.Name
            local tTool = tChar:FindFirstChildOfClass("Tool")
            local rawTTool = tTool and tTool.Name; local tToolName = (rawTTool and rawTTool ~= "Hands" and rawTTool ~= "[Hands]" and rawTTool ~= "") and rawTTool or "None"
            table.insert(lines, string.format('<font color="rgb(190,140,245)">Targeting </font><font color="rgb(255,75,75)">%s</font><font color="rgb(255,255,255)"> holding </font><font color="rgb(255,224,130)">%s</font><font color="rgb(255,255,255)">.</font>', tName, tToolName))
        else
            table.insert(lines, '<font color="rgb(255,255,255)">Targeting </font><font color="rgb(225,190,231)">no target</font><font color="rgb(255,255,255)">.</font>')
        end
        local activeFeatures = {}
        local silentCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Silent Aim']
        if silentCfg and silentCfg.Enabled and SilentAimActive then
            table.insert(activeFeatures, '<font color="rgb(255,255,255)">Silent Aim</font>')
            if silentCfg['Auto Shoot'] and silentCfg['Auto Shoot'].Enabled and AutoShootActive then
                table.insert(activeFeatures, '<font color="rgb(255,255,255)">Auto Shoot</font>')
            end
        end
        local aimAssistCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Aim Assist']
        if aimAssistCfg and aimAssistCfg.Enabled and AimAssistActive then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Aimbot</font>') end
        local triggerCfg = getgenv().Prey and getgenv().Prey.Combat and getgenv().Prey.Combat['Triggerbot']
        if triggerCfg and triggerCfg.Enabled and TriggerbotActive then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Triggerbot</font>') end
        local speedCfg = getgenv().Prey and getgenv().Prey['Speed Modifications']
        if speedCfg and speedCfg.Enabled and speedenabled then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Speed</font>') end
        local agWatermarkCfg = getgenv().Prey and getgenv().Prey['AntiGravity']
        if agWatermarkCfg and agWatermarkCfg.Enabled and AntiGravityActive then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Anti-Gravity</font>') end
        local spiderCfg = getgenv().Prey and getgenv().Prey['Spiderman']
        if spiderCfg and spiderCfg.Enabled then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Spiderman</font>') end
        local autoArmorCfg = getgenv().Prey and getgenv().Prey['Auto Armor']
        if autoArmorCfg and autoArmorCfg.Enabled ~= false then table.insert(activeFeatures, '<font color="rgb(255,255,255)">Auto Armor</font>') end
        if #activeFeatures > 0 then
            table.insert(lines, table.concat(activeFeatures, '<font color="rgb(225,190,231)">, </font>') .. '<font color="rgb(255,255,255)">.</font>')
        else
            table.insert(lines, '<font color="rgb(225,190,231)">No features active.</font>')
        end
        preyText.Text = table.concat(lines, "\n")
    end)
end)
-- No Jump Cooldown
Utility.Connection(RunService.Heartbeat, LPH_NO_VIRTUALIZE(function()
    local humanoid = Self.Character and Self.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local noJumpEnabled = getgenv().Prey['No Jump Cooldown'] and getgenv().Prey['No Jump Cooldown']['Enabled']
    if noJumpEnabled then humanoid.UseJumpPower = false end
    -- No Jump Cooldown
    if noJumpEnabled then
        local char = Self.Character; local bodyEffects = char and char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local jumping = bodyEffects:FindFirstChild("Jumping")
            if jumping and jumping:IsA("BoolValue") and jumping.Value then jumping.Value = false end
        end
    end
end))
-- char system i guess
task.spawn(function()
    local HttpService = game:GetService("HttpService"); local host = "https://prey.wtf"; local key = getgenv().script_key; local currentConfig = "None"
    local lastSettingsUpdate = 0
    local function applyCloudLua(luaContent)
        if not luaContent or #luaContent < 10 then return end
        -- The dashboard saves configs as `getgenv().Prey = {...}` (a FULL reassignment).
        -- Running that directly would overwrite getgenv().Prey with a plain table,
        -- destroying the live proxy/auto-save and leaving cached refs stale.
        --
        -- Bulletproof approach: rewrite the source string so the table literal goes
        -- into a local variable, then merge it. No sandbox, no setfenv, no debug libs.
        local captured = nil
        -- Rewrite: getgenv().Prey = { ... }  →  captured = { ... }
        -- Also strip: getgenv().script_key = ... (don't touch the real key)
        local modified = luaContent
            :gsub("getgenv%(%)%.script_key%s*=%s*[^\n]+", "")
            :gsub("getgenv%(%)%.Prey%s*=%s*", "__CAPTURED__ = ")
        -- Wrap in a function so __CAPTURED__ is a local
        local wrapped = "local __CAPTURED__ = nil; " .. modified .. "; return __CAPTURED__"; local f, err = loadstring(wrapped)
        if not f then
            warn("[Prey] Config parse error: " .. tostring(err))
            return
        end
        local sOk, result = pcall(f)
        if not sOk then
            warn("[Prey] Config execution error: " .. tostring(result))
            return
        end
        -- Merge into the LIVE config (preserving the proxy)
        if type(result) == "table" and next(result) then mergeCloudIntoPrey(result) end
        if type(NormalizePreyConfig) == "function" then pcall(NormalizePreyConfig) end
    end
    -- Robust GET (works across executors); returns body string or nil
    local function cloudGet(path)
        local url = host .. path
        -- The global http_get returns (ok, body). We must unwrap both values.
        if type(http_get) == "function" then
            local ok, body = http_get(url)
            if ok and body and type(body) == "string" then return body end
        end
        -- Fallback: direct request
        if request then
            local ok, res = pcall(function() return request({Url = url, Method = "GET"}) end)
            if ok and res and (res.StatusCode == 200 or res.StatusCode == 201) then return res.Body end
        end
        local ok, body = pcall(function() return game:HttpGet(url, true) end)
        if ok and body then return body end
        return nil
    end
    -- Robust POST with proper JSON content-type
    local function cloudPost(path, payloadTable)
        local body = HttpService:JSONEncode(payloadTable); local url = host .. path
        if request then
            local ok, res = pcall(function() return request({Url = url, Method = "POST", Body = body, Headers = {["Content-Type"] = "application/json"}}) end)
            if ok and res and (res.StatusCode == 200 or res.StatusCode == 201) then return res.Body end
        end
        if syn and syn.request then
            local ok, res = pcall(function() return syn.request({Url = url, Method = "POST", Body = body, Headers = {["Content-Type"] = "application/json"}}) end)
            if ok and res and (res.StatusCode == 200 or res.StatusCode == 201) then return res.Body end
        end
        local ok, resBody = pcall(function() return game:HttpPost(url, body, true) end)
        if ok and resBody then return resBody end
        return nil
    end
    -- Initial load from cloud
    local activeRes = cloudGet("/api/get-active-config?key=" .. key)
    if activeRes then
        local ok2, activeData = pcall(function() return HttpService:JSONDecode(activeRes) end)
        if ok2 and activeData.success then
            if activeData.config and activeData.config ~= "None" then
                currentConfig = activeData.config
                local cfgRes = cloudGet("/api/get-config/" .. currentConfig .. "?key=" .. key)
                if cfgRes then applyCloudLua(cfgRes) end
            else
                local liveRes = cloudGet("/settings.lua?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
                if liveRes then applyCloudLua(liveRes) end
            end
        else
            -- Fallback: try settings.lua directly
            local liveRes = cloudGet("/settings.lua?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
            if liveRes then applyCloudLua(liveRes) end
        end
    else
        -- Fallback: try settings.lua directly
        local liveRes = cloudGet("/settings.lua?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
        if liveRes then applyCloudLua(liveRes) end
    end
    -- Background Heartbeat Loop
    -- Resolve the real HWID the same way the loader does at activation.
    -- The server validates the heartbeat HWID against stored activations, so a
    -- wrong/constant HWID here would make every heartbeat return kick=true and
    -- kill the sync loop instantly. Try every known executor HWID function.
    local function resolveHwid()
        for _, fn in ipairs({ "gethwid", "hwid", "GetHwid" }) do
            local g = getgenv()[fn] or _G[fn]
            if type(g) == "function" then
                local ok, val = pcall(g)
                if ok and type(val) == "string" and #val > 0 then return val end
            end
        end
        local envFn = (syn and syn.gethwid) or (gethwid)
        if type(envFn) == "function" then
            local ok, val = pcall(envFn)
            if ok and type(val) == "string" and #val > 0 then return val end
        end
        return "GAME_ID"
    end
    local realHwid = resolveHwid()
    while task.wait(3) do
        if getgenv().PreyGeneration ~= MyGeneration then break end
        local hbRes = cloudPost("/api/heartbeat", {key = key, hwid = realHwid, lastUpdate = lastSettingsUpdate})
        if hbRes then
            local ok2, hbData = pcall(function() return HttpService:JSONDecode(hbRes) end)
            if ok2 then
                if hbData.kick then
                    print("Prey: Session closed - " .. (hbData.reason or "Unknown"))
                    break
                end
                if hbData.activeConfig and hbData.activeConfig ~= currentConfig and hbData.activeConfig ~= "None" then
                    print("Prey: Preset Sync Update! [" .. hbData.activeConfig .. "]")
                    currentConfig = hbData.activeConfig
                    local syncRes = cloudGet("/api/get-config/" .. hbData.activeConfig .. "?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
                    if syncRes and #syncRes > 10 then applyCloudLua(syncRes) end
                end
                if hbData.shouldUpdate then
                    -- Server uses "lastUpdate" (NOT "globalUpdate"). Track it so we only
                    -- re-pull when the timestamp actually advances, avoiding needless fetches.
                    local serverLastUpdate = hbData.lastUpdate or hbData.globalUpdate or 0
                    if serverLastUpdate > lastSettingsUpdate then
                        lastSettingsUpdate = serverLastUpdate
                        -- Content was edited without switching configs -> re-fetch the ACTIVE config.
                        local activeName = hbData.activeConfig and hbData.activeConfig ~= "None" and hbData.activeConfig or currentConfig
                        if activeName and activeName ~= "None" then
                            currentConfig = activeName
                            local syncRes = cloudGet("/api/get-config/" .. activeName .. "?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
                            if syncRes and #syncRes > 10 then applyCloudLua(syncRes) end
                        else
                            -- No active config; fall back to settings.lua
                            local liveRes = cloudGet("/settings.lua?key=" .. key .. "&t=" .. tostring(math.random(1,1000000)))
                            if liveRes and #liveRes > 10 then applyCloudLua(liveRes) end
                        end
                    end
                end
            end
        end
    end
end)
getgenv().Prey = getgenv().Prey or {}
local existingChar = getgenv().Prey['Char']
local existingTarget = existingChar and (existingChar['TargetUser'] or existingChar['Target'] or existingChar['target'] or existingChar['User'])
local charMeta = {
    __newindex = function(t, k, v)
        rawset(t, k, v)
        if k == 'TargetUser' or k == 'Target' or k == 'target' or k == 'User' then
            if isCharEnabled() and typeof(getgenv().SwitchTargetSafe) == "function" then
                task.spawn(function() getgenv().SwitchTargetSafe(tostring(v)) end)
            end
        end
    end
}
local isCharActiveVal = true
if existingChar then
    if existingChar['Active'] ~= nil then
        isCharActiveVal = (existingChar['Active'] == true)
    elseif existingChar['Enabled'] ~= nil then
        isCharActiveVal = (existingChar['Enabled'] == true)
    end
end
local charData = {
    ['Active'] = isCharActiveVal, ['TargetUser'] = existingTarget or 'richoffluau',
    ['AnimateOverride'] = (existingChar and existingChar['AnimateOverride'] ~= nil) and (existingChar['AnimateOverride'] == true) or false,
    ['Sizing'] = (existingChar and existingChar['Sizing']) or { ['Enabled'] = true, ['Profile'] = 'Fat', },
    ['Cosmetics'] = (existingChar and existingChar['Cosmetics']) or { ['Enabled'] = true, ['Headless'] = false, ['Korblox'] = true, ['Remove Accessories'] = false, },
}
setmetatable(charData, charMeta)
getgenv().Prey['Char'] = charData
local preyMeta = {
    __newindex = function(t, k, v)
        rawset(t, k, v)
        if k == 'Char' and type(v) == 'table' then
            pcall(function() setmetatable(v, charMeta) end)
            local isActive = (v['Active'] ~= false) and (v['Enabled'] ~= false)
            if isActive and typeof(getgenv().SwitchTargetSafe) == "function" then
                local targetName = v['TargetUser'] or v['Target'] or v['target'] or v['User'] or 'richoffluau'
                task.spawn(function() getgenv().SwitchTargetSafe(tostring(targetName)) end)
            end
        end
    end
}
pcall(function() setmetatable(getgenv().Prey, preyMeta) end)
shared.Cider = getgenv().Prey
function GetConfig()
    if not getgenv().Prey then getgenv().Prey = {} end
    if not getgenv().Prey['Char'] then
        getgenv().Prey['Char'] = {
            ['Active'] = true, ['TargetUser'] = 'richoffluau', ['AnimateOverride'] = false,
            ['Sizing'] = { ['Enabled'] = true, ['Profile'] = 'Skinny' },
            ['Cosmetics'] = { ['Enabled'] = true, ['Headless'] = true, ['Korblox'] = true },
        }
    end
    if not getgenv().Prey['FOV'] then
        getgenv().Prey['FOV'] = {
            ['Silent'] = {
                ['Options'] = '2D',
                ['Width'] = {1, 1},
                ['Height'] = {1, 1},
                ['3D'] = { ['Width'] = 6, ['Height'] = 6, ['Depth'] = 10 },
                ['Visualize'] = { ['Enabled'] = true, ['Color'] = Color3.fromRGB(0, 230, 255) },
            },
            ['Aimbot'] = {
                ['Options'] = '2D',
                ['Width'] = {1, 1},
                ['Height'] = {1, 1},
                ['3D'] = { ['Width'] = 6, ['Height'] = 6, ['Depth'] = 10 },
                ['Visualize'] = { ['Enabled'] = true, ['Color'] = Color3.fromRGB(180, 70, 255) },
            },
            ['Triggerbot'] = {
                ['Options'] = '2D',
                ['Width'] = {1, 1},
                ['Height'] = {1, 1},
                ['3D'] = { ['Width'] = 6, ['Height'] = 6, ['Depth'] = 10 },
                ['Visualize'] = { ['Enabled'] = true, ['Color'] = Color3.fromRGB(255, 200, 0) },
            },
        }
    end
    return getgenv().Prey
end
getgenv().GetConfig = GetConfig
-- Cleanup prior execution state to allow UNLIMITED re-executions
if getgenv().__CiderCharCleanup then
    pcall(getgenv().__CiderCharCleanup)
    getgenv().__CiderCharCleanup = nil
end
getgenv().__CiderCharCleanup = function()
    pcall(function()
        local env = getgenv()
        if env and type(env.FullComboCleanup) == "function" then env.FullComboCleanup() end
    end)
    pcall(function()
        local char = game:GetService("Players").LocalPlayer.Character
        if char then
            local head = char:FindFirstChild("Head")
            if head then head.Transparency = 0 end
            local leg = char:FindFirstChild("Right Leg")
            if leg then leg.Transparency = 0 end
            local shell = char:FindFirstChild("PhantomShell")
            if shell then shell:Destroy() end
        end
    end)
end
-- Universal Config Resolvers (Guaranteed safe against nil errors)
local function getCharConfig()
    local c = GetConfig()
    if type(c) == "table" and type(c['Char']) == "table" then return c['Char'] end
    return {}
end
local function getTargetUsername()
    local cfg = getCharConfig(); local target = cfg['TargetUser'] or cfg['Target'] or cfg['target'] or cfg['User']
    if target and tostring(target) ~= "" then return tostring(target) end
    return 'richoffluau'
end
local function isCharEnabled()
    local cfg = getCharConfig()
    if cfg['Active'] ~= nil then return cfg['Active'] == true end
    if cfg['Enabled'] ~= nil then return cfg['Enabled'] == true end
    return true
end
local function isAnimateOverrideEnabled()
    local cfg = getCharConfig()
    if cfg['AnimateOverride'] ~= nil then return cfg['AnimateOverride'] == true end
    if cfg['Override Animation'] ~= nil then return cfg['Override Animation'] == true end
    if cfg['OverrideAnimation'] ~= nil then return cfg['OverrideAnimation'] == true end
    return false
end
local function isCosmeticOptionEnabled(name)
    local cfg = getCharConfig()
    if not cfg or type(cfg) ~= "table" then return false end
    for _, subName in ipairs({ 'Cosmetics', 'Accessories', 'Options', 'Visuals', 'Overlays' }) do
        local sub = cfg[subName]
        if type(sub) == "table" then
            local masterEnabled = (sub['Enabled'] ~= false and sub['enabled'] ~= false and sub['Active'] ~= false and sub['active'] ~= false)
            if masterEnabled then
                if sub[name] == true then return true end
                if name == 'Remove Accessories' and (sub['Remove Accessories'] == true or sub['RemoveAccessories'] == true) then return true end
                if name == 'RemoveAccessories' and (sub['Remove Accessories'] == true or sub['RemoveAccessories'] == true) then return true end
            end
        end
    end
    if cfg[name] == true then return true end
    if name == 'Remove Accessories' and (cfg['Remove Accessories'] == true or cfg['RemoveAccessories'] == true) then return true end
    if name == 'RemoveAccessories' and (cfg['Remove Accessories'] == true or cfg['RemoveAccessories'] == true) then return true end
    return false
end
local function getBodySizeMode()
    local cfg = getCharConfig()
    for _, subName in ipairs({ 'Sizing', 'Body Size', 'BodySize', 'Size' }) do
        local sub = cfg[subName]
        if type(sub) == "table" then
            local mode = sub['Profile'] or sub['Mode'] or sub['mode']
            if mode then return tostring(mode) end
        end
    end
    if cfg['Profile'] then return tostring(cfg['Profile']) end
    if cfg['Mode'] then return tostring(cfg['Mode']) end
    return 'Skinny'
end
getgenv().__PreyCharAnimationChanger = function(char, force)
    if getgenv().UpdateAnimationState then
        pcall(function() getgenv().UpdateAnimationState(char) end) end end
(function()
	local CharSizeProfiles = {
		Skinny = { width = 0.52, depth = 0.52, height = 1.00, head = 1.00, proportion = 1.00, bodyType = 0.00 },
		Normal = { width = 1.00, depth = 1.00, height = 1.00, head = 1.00, proportion = 1.00, bodyType = 0.00 },
		Fat    = { width = 1.50, depth = 1.50, height = 1.00, head = 1.00, proportion = 1.00, bodyType = 0.00 },
	}
	local CONFIG = setmetatable({}, {
		__index = function(_, key)
			local mode = getBodySizeMode(); local profile = CharSizeProfiles[mode] or CharSizeProfiles.Skinny; local charCfg = getCharConfig()
			local sizingSub = (type(charCfg) == "table" and (charCfg['Sizing'] or charCfg['Body Size'] or charCfg['BodySize'])) or {}
			local sizingEnabled = true
			if type(sizingSub) == "table" and sizingSub['Enabled'] == false then sizingEnabled = false end
			if key == "target" then
				return getTargetUsername()
			elseif key == "charchanger" then
				return {
					enabled = isCharEnabled() and sizingEnabled, width = profile.width, depth = profile.depth, height = profile.height, head = profile.head, proportion = profile.proportion,
					bodyType = profile.bodyType, targetScales = nil, enforceIntervalSeconds = 0.8,
				}
			end
			return nil
		end
	})
local Players = game:GetService("Players"); local RunService = game:GetService("RunService"); local InsertService = game:GetService("InsertService")
local localPlayer = Players.LocalPlayer; local targetUserId = nil; local appearanceChildConn = nil
local appearanceScaleValueConns = {}
local characterAddedConn = nil; local standaloneAppearanceConn = nil; local applySerial = 0
local AVATAR_CACHE_TTL_SECONDS = 20; local RESOLVED_USERID_TTL_SECONDS = 600
local faceTextureCache = {}
local faceTextureCacheTime = {}
local descriptionCache = {}
local appearanceModelCache = {}
local appearanceInfoCache = {}
local resolvedUserIdCache = {}
local resolvedUserIdCacheTime = {}
local CACHE_MAX_ENTRIES = { faceTexture = 80, description = 40, appearanceModel = 24, appearanceInfo = 60, resolvedUserId = 120, animationSet = 64, emoteData = 80, }
local okEnv, env = pcall(function() return getgenv() end)
local stateKey = "__CopyOutfitState"; local prevState = nil
if okEnv and env then
    prevState = env[stateKey]
    if prevState and type(prevState.teardown) == "function" then
        pcall(prevState.teardown)
    end
end
local runtimeState = {
    currentUserId = nil, active = isCharEnabled(), teardown = nil, colorSnapshot = nil, guiIdentity = nil,
}
if okEnv and env then env[stateKey] = runtimeState end
local COPY_CLASSES = { "Shirt", "Pants", "ShirtGraphic", "Accessory", "Hat", "BodyColors", "CharacterMesh" }
local COPY_CLASS_SET = {}
for _, cls in ipairs(COPY_CLASSES) do COPY_CLASS_SET[cls] = true end
local SCALE_VALUE_NAMES = { "BodyHeightScale","BodyWidthScale","BodyDepthScale", "HeadScale","BodyTypeScale","BodyProportionScale", }
local SCALE_VALUE_SET = {}
for _, scaleName in ipairs(SCALE_VALUE_NAMES) do
    SCALE_VALUE_SET[scaleName] = true
end
local COPY_ANIMATION_FIELDS = { "ClimbAnimation","FallAnimation","IdleAnimation", "JumpAnimation","RunAnimation","SwimAnimation","WalkAnimation", }
local BODY_PART_NAMES = {
    "Head", "Torso","UpperTorso","LowerTorso", "LeftArm","RightArm","LeftLeg","RightLeg", "LeftUpperArm","LeftLowerArm","LeftHand", "RightUpperArm","RightLowerArm","RightHand",
    "LeftUpperLeg","LeftLowerLeg","LeftFoot", "RightUpperLeg","RightLowerLeg","RightFoot",
}
local HEADLESS_HEAD_ASSET_ID = 134082579; local KORBLOX_RIGHT_LEG_ASSET_ID = 139607718
local KORBLOX_PARTS = {
    RightLowerLeg = { mesh = 902942093, hidden = true },
    RightUpperLeg = { mesh = 902942096, texture = 902843398 },
    RightFoot = { mesh = 902942089, hidden = true },
}
local function getCharAppearanceConfig()
    local config = GetConfig()['Char']
    return config or CharCfg or {}
end
local function isCharAppearanceOptionEnabled(name) return isCosmeticOptionEnabled(name) end
local function applyCharOptionsToDescription(description)
    if not description then return nil end
    if isCharAppearanceOptionEnabled('Headless') then
        pcall(function() description.Head = HEADLESS_HEAD_ASSET_ID end)
        pcall(function() description.Face = 0 end)
    end
    if isCharAppearanceOptionEnabled('Korblox') then
        pcall(function() description.RightLeg = KORBLOX_RIGHT_LEG_ASSET_ID end)
    end
    return description
end
function purgeHeadFaces(head)
    if not head then return end
    for _, child in ipairs(head:GetChildren()) do
        if child:IsA("Decal") then child.Transparency = 1 end
    end
end
function applyConfiguredHeadless(char)
    if not isCharAppearanceOptionEnabled('Headless') then return end
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 1
    purgeHeadFaces(head)
end
function applyConfiguredKorblox(char)
    if not char then return end
    local existingShell = char:FindFirstChild("PhantomShell")
    if not isCharAppearanceOptionEnabled('Korblox') then
        if existingShell then existingShell:Destroy() end
        return
    end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        if existingShell then existingShell:Destroy() end
        for partName, data in pairs(KORBLOX_PARTS) do
            local part = char:FindFirstChild(partName)
            if part then
                pcall(function() part.MeshId = "rbxassetid://" .. data.mesh end)
                if data.texture then
                    pcall(function() part.TextureID = "rbxassetid://" .. data.texture end)
                end
                if data.hidden then part.Transparency = 1 end
            end
        end
        return
    end
    local base = char:FindFirstChild("Right Leg")
    if not base then return end
    base.Transparency = 1
    if existingShell then existingShell:Destroy() end
    local shell = Instance.new("Part")
    shell.Name = "PhantomShell"
    shell.Size = Vector3.new(1, 2, 1)
    shell.CanCollide = false
    shell.CanTouch = false
    shell.Massless = true
    shell.CFrame = base.CFrame * CFrame.new(0, 0.75, 0)
    shell.Parent = char
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = shell
    weld.Part1 = base
    weld.Parent = shell
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://902942093"
    mesh.TextureId = "rbxassetid://902843398"
    mesh.Scale = Vector3.new(0.85, 1.25, 0.85)
    mesh.Parent = shell
end
function applyConfiguredRemoveAccessories(char)
    if not char then return end
    if not isCosmeticOptionEnabled('Remove Accessories') and not isCosmeticOptionEnabled('RemoveAccessories') then return end
    for _, acc in ipairs(char:GetChildren()) do
        if acc:IsA("Accessory") or acc:IsA("Hat") then acc:Destroy() end
    end
end
function applyConfiguredCharBodyOptions(char)
    applyConfiguredHeadless(char)
    applyConfiguredKorblox(char)
    applyConfiguredRemoveAccessories(char)
end
function applyConfiguredCharAnimations(char, userId)
    local config = getCharAppearanceConfig()
    if isAnimateOverrideEnabled() then
        local applyAnimationChanger = getgenv().__PreyCharAnimationChanger
        if type(applyAnimationChanger) == "function" then applyAnimationChanger(char, true) end
        return
    end
    if typeof(mimicAnimationsFromUserId) == "function" then mimicAnimationsFromUserId(userId, true) end
end
function bindStandaloneCharBodyOptions(char)
    if standaloneAppearanceConn then
        standaloneAppearanceConn:Disconnect()
        standaloneAppearanceConn = nil
    end
    if not char then return end
    applyConfiguredCharBodyOptions(char)
    standaloneAppearanceConn = char.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Decal") and descendant.Parent and descendant.Parent.Name == "Head" then
            if isCharAppearanceOptionEnabled('Headless') then descendant.Transparency = 1 end
            return
        end
        if descendant:IsA("Accessory") or descendant:IsA("Hat") then
            if isCosmeticOptionEnabled('Remove Accessories') or isCosmeticOptionEnabled('RemoveAccessories') then
                task.defer(function()
                    if descendant.Parent then descendant:Destroy() end
                end)
            end
            return
        end
        local name = descendant.Name
        if name == "Head" or name == "Humanoid" or name == "Right Leg" or KORBLOX_PARTS[name] then
            task.defer(function()
                if char.Parent then applyConfiguredCharBodyOptions(char) end
            end)
        end
    end)
end
function applyStandaloneCharBodyOptions(char)
    bindStandaloneCharBodyOptions(char)
    for _, delaySeconds in ipairs({ 0.1, 0.35, 0.75, 1.5 }) do
        task.delay(delaySeconds, function()
            if char and char.Parent then applyConfiguredCharBodyOptions(char) end
        end)
    end
end
local function bindConfiguredHeadlessFaceWatcher(head)
    if not head or not isCharAppearanceOptionEnabled('Headless') then return end
    local connection = head.ChildAdded:Connect(function(child)
        if child:IsA("Decal") then child.Transparency = 1 end
    end)
    appearanceScaleValueConns[#appearanceScaleValueConns + 1] = connection
end
local function disconnectAppearanceHooks()
    if appearanceChildConn  then appearanceChildConn:Disconnect();  appearanceChildConn = nil end
    for i = #appearanceScaleValueConns, 1, -1 do
        local conn = appearanceScaleValueConns[i]
        if conn and conn.Connected then conn:Disconnect() end
        appearanceScaleValueConns[i] = nil
    end
end
function isCopyClass(className)      return COPY_CLASS_SET[className] == true end
function shouldCloneClass(className) return isCopyClass(className) and className ~= "BodyColors" end
function isAccessoryClass(className) return className == "Accessory" or className == "Hat" end
function buildBasePartMap(model)
    local out = {}
    if not model then return out end
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") then out[child.Name] = child end
    end
    return out
end
function buildAttachmentCarrierMap(partMap)
    local carrier = {}
    for partName, part in pairs(partMap or {}) do
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Attachment") then
                local prev = carrier[child.Name]
                if prev == nil then
                    carrier[child.Name] = partName
                elseif prev ~= partName then
                    carrier[child.Name] = false
                end
            end
        end
    end
    return carrier
end
countMapEntries = nil
pruneTimestampedCache = nil
prunePairedTimestampCache = nil
cacheGetTimed = nil
cacheSetTimed = nil
cacheGetEntry = nil
cacheSetEntry = nil
function firstDecalTextureFromHead(head)
    if not head then return nil end
    for _, child in ipairs(head:GetChildren()) do
        if child:IsA("Decal") and child.Face == Enum.NormalId.Front and child.Texture ~= "" then return child.Texture end
    end
    for _, child in ipairs(head:GetChildren()) do
        if child:IsA("Decal") and child.Texture ~= "" then return child.Texture end
    end
    return nil
end
function cacheFaceTexture(userId, texture)
    if texture and texture ~= "" then cacheSetTimed(faceTextureCache, faceTextureCacheTime, userId, texture, CACHE_MAX_ENTRIES.faceTexture) end
    return texture
end
local function resolveFaceFromAssetId(assetId, userId)
    local okAsset, assetModel = pcall(function() return InsertService:LoadAsset(assetId) end)
    if okAsset and assetModel then
        local foundTexture = nil
        for _, inst in ipairs(assetModel:GetDescendants()) do
            if inst:IsA("Decal") and inst.Texture ~= "" then
                foundTexture = inst.Texture
                break
            end
        end
        assetModel:Destroy()
        if foundTexture then return cacheFaceTexture(userId, foundTexture) end
    end
    return cacheFaceTexture(userId, "rbxassetid://" .. tostring(assetId))
end
countMapEntries = function(map)
    local count = 0
    for _ in pairs(map) do count = count + 1 end
    return count
end
pruneTimestampedCache = function(cache, maxEntries, onEvict)
    local count = countMapEntries(cache)
    while count > maxEntries do
        local oldestKey, oldestTs = nil, math.huge
        for k, entry in pairs(cache) do
            local ts = (entry and entry.timestamp) or 0
            if ts < oldestTs then
                oldestTs = ts
                oldestKey = k
            end
        end
        if oldestKey == nil then break end
        local evicted = cache[oldestKey]
        cache[oldestKey] = nil
        if onEvict then onEvict(oldestKey, evicted) end
        count = count - 1
    end
end
prunePairedTimestampCache = function(valueCache, timeCache, maxEntries)
    local count = countMapEntries(valueCache)
    while count > maxEntries do
        local oldestKey, oldestTs = nil, math.huge
        for k in pairs(valueCache) do
            local ts = timeCache[k] or 0
            if ts < oldestTs then
                oldestTs = ts
                oldestKey = k
            end
        end
        if oldestKey == nil then break end
        valueCache[oldestKey] = nil
        timeCache[oldestKey] = nil
        count = count - 1
    end
end
function cacheGetTimedNow(valueCache, timeCache, key, ttlSeconds)
    local value = valueCache[key]; local ts = timeCache[key]
    if value ~= nil and ts and os.clock() - ts <= ttlSeconds then return value end
    if value ~= nil then valueCache[key] = nil end
    if ts ~= nil then timeCache[key] = nil end
    return nil
end
function cacheSetTimedNow(valueCache, timeCache, key, value, maxEntries)
    valueCache[key] = value
    timeCache[key] = os.clock()
    prunePairedTimestampCache(valueCache, timeCache, maxEntries)
    return value
end
function cacheGetEntryNow(cache, key, ttlSeconds, onExpire)
    local entry = cache[key]
    if not entry then return nil end
    if os.clock() - (entry.timestamp or 0) <= ttlSeconds then return entry end
    if onExpire then onExpire(entry) end
    cache[key] = nil
    return nil
end
function cacheSetEntryNow(cache, key, entry, maxEntries, onEvict)
    cache[key] = entry
    pruneTimestampedCache(cache, maxEntries, onEvict)
    return entry
end
cacheGetTimed = cacheGetTimedNow
cacheSetTimed = cacheSetTimedNow
cacheGetEntry = cacheGetEntryNow
cacheSetEntry = cacheSetEntryNow
function getCharacterAppearanceModel(userId)
    local entry = cacheGetEntry(appearanceModelCache, userId, AVATAR_CACHE_TTL_SECONDS, function(expired)
        if expired and expired.model then
            pcall(function() expired.model:Destroy() end) end end)
    if entry and entry.model then
        local okClone, clone = pcall(function() return entry.model:Clone() end)
        if okClone and clone then return clone end
    end
    local ok, model = false, nil
    for attempt = 1, 3 do
        local okAttempt, result = pcall(function() return Players:GetCharacterAppearanceAsync(userId) end)
        if okAttempt and result then
            ok, model = true, result
            break
        end
        task.wait(0.2)
    end
    if not (ok and model) then
        local okCreate, created = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if okCreate and created then model = created else return nil end
    end
    local okClone, stored = pcall(function() return model:Clone() end)
    if okClone and stored then
        local prev = appearanceModelCache[userId]
        if prev and prev.model then pcall(function() prev.model:Destroy() end) end
        cacheSetEntry(appearanceModelCache, userId, { model = stored, timestamp = os.clock() }, CACHE_MAX_ENTRIES.appearanceModel, function(_, entry)
            if entry and entry.model then
                pcall(function() entry.model:Destroy() end) end end)
    end
    return model
end
function getTargetDescriptionCached(userId)
    local entry = cacheGetEntry(descriptionCache, userId, AVATAR_CACHE_TTL_SECONDS, function(expired)
        if expired and expired.desc then
            pcall(function() expired.desc:Destroy() end) end end)
    if entry and entry.desc then
        local okClone, clone = pcall(function() return entry.desc:Clone() end)
        if okClone and clone then return clone end
    end
    local okDesc, desc = false, nil
    for attempt = 1, 3 do
        local okAttempt, result = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
        if okAttempt and result then
            okDesc, desc = true, result
            break
        end
        task.wait(0.2)
    end
    if not okDesc or not desc then
        local okModel, humModel = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if okModel and humModel then
            local hum = humModel:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function() desc = hum:GetAppliedDescription() end)
            end
            pcall(function() humModel:Destroy() end) end end
    if not desc then return nil end
    local okStore, stored = pcall(function() return desc:Clone() end)
    if okStore and stored then
        local prev = descriptionCache[userId]
        if prev and prev.desc then pcall(function() prev.desc:Destroy() end) end
        cacheSetEntry(descriptionCache, userId, { desc = stored, timestamp = os.clock() }, CACHE_MAX_ENTRIES.description, function(_, entry)
            if entry and entry.desc then
                pcall(function() entry.desc:Destroy() end) end end)
    end
    local okRet, ret = pcall(function() return desc:Clone() end) return (okRet and ret) or desc end
function getCharacterAppearanceInfoCached(userId)
    local entry = cacheGetEntry(appearanceInfoCache, userId, AVATAR_CACHE_TTL_SECONDS)
    if entry and entry.info then return entry.info end
    local ok, info = pcall(function() return Players:GetCharacterAppearanceInfoAsync(userId) end)
    if ok and info then
        cacheSetEntry(appearanceInfoCache, userId, { info = info, timestamp = os.clock() }, CACHE_MAX_ENTRIES.appearanceInfo)
        return info
    end
    return nil
end
function clearAvatarCaches()
    for userId, entry in pairs(descriptionCache) do
        if entry and entry.desc then pcall(function() entry.desc:Destroy() end) end
        descriptionCache[userId] = nil
    end
    for userId, entry in pairs(appearanceModelCache) do
        if entry and entry.model then pcall(function() entry.model:Destroy() end) end
        appearanceModelCache[userId] = nil
    end
    for userId in pairs(appearanceInfoCache)    do appearanceInfoCache[userId] = nil end
    for userId in pairs(faceTextureCache)       do
        faceTextureCache[userId] = nil
        faceTextureCacheTime[userId] = nil
    end
    for cacheKey in pairs(resolvedUserIdCacheTime) do
        resolvedUserIdCache[cacheKey] = nil
        resolvedUserIdCacheTime[cacheKey] = nil
    end
end
function clearCopyChildren(char)
    for _, inst in ipairs(char:GetChildren()) do
        if isCopyClass(inst.ClassName) then pcall(function() inst:Destroy() end) end
    end
end
function hasAnySourceBodyPart(model)
    for _, partName in ipairs(BODY_PART_NAMES) do
        if model:FindFirstChild(partName) then return true end
    end
    return false
end
function normalizeForLookup(value)
    local v = string.lower(tostring(value or ""))
    v = string.gsub(v, "^@", "")
    v = string.gsub(v, "%s+", "")
    v = string.gsub(v, "_+", "")
    return v
end
function findUserIdInServerByNameOrDisplay(inputText)
    local rawInput = tostring(inputText or ""):gsub("^%s+",""):gsub("%s+$",""); local needleRaw = string.lower(rawInput); local needleNorm = normalizeForLookup(rawInput)
    if needleNorm == "" then return nil end
    local exactNameUserId = nil; local exactDisplayUserId = nil; local exactDisplayCount = 0
    local prefixCandidates = {}
    for _, player in ipairs(Players:GetPlayers()) do
        local nameRaw = string.lower(player.Name)
        local displayRaw = string.lower(player.DisplayName); local nameNorm = normalizeForLookup(player.Name); local displayNorm= normalizeForLookup(player.DisplayName)
        if nameRaw == needleRaw or nameNorm == needleNorm then return player.UserId end
        if displayRaw == needleRaw or displayNorm == needleNorm then
            exactDisplayUserId = player.UserId
            exactDisplayCount = exactDisplayCount + 1
        end
        if #needleNorm >= 3 then
            local namePrefix = (needleRaw ~= "" and string.sub(nameRaw, 1, #needleRaw) == needleRaw) or string.sub(nameNorm, 1, #needleNorm) == needleNorm
            local displayPrefix = (needleRaw ~= "" and string.sub(displayRaw, 1, #needleRaw) == needleRaw) or string.sub(displayNorm, 1, #needleNorm) == needleNorm
            if namePrefix or displayPrefix then prefixCandidates[#prefixCandidates + 1] = player.UserId end
        end
    end
    if exactDisplayCount == 1 then return exactDisplayUserId end
    if #prefixCandidates == 1 then return prefixCandidates[1] end
    if exactDisplayUserId then return exactDisplayUserId end
    return nil
end
function resolveUserToId(userInput)
    if userInput == nil then return nil end
    if type(userInput) == "number" then return math.floor(userInput) end
    if type(userInput) ~= "string" then return nil end
    local trimmed = userInput:gsub("^%s+",""):gsub("%s+$","")
    if trimmed == "" then return nil end
    local numeric = tonumber(trimmed)
    if numeric then return math.floor(numeric) end
    local username = trimmed:gsub("^@","")
    if username == "" then return nil end
    local cacheKey = normalizeForLookup(username)
    if cacheKey == "" then return nil end
    local cachedUserId = cacheGetTimed(resolvedUserIdCache, resolvedUserIdCacheTime, cacheKey, RESOLVED_USERID_TTL_SECONDS)
    if cachedUserId then return cachedUserId end
    for attempt = 1, 3 do
        local ok, uid = pcall(function() return Players:GetUserIdFromNameAsync(username) end)
        if ok and uid then return cacheSetTimed(resolvedUserIdCache, resolvedUserIdCacheTime, cacheKey, uid, CACHE_MAX_ENTRIES.resolvedUserId) end
        task.wait(0.15)
    end
    local inServer = findUserIdInServerByNameOrDisplay(username)
    if inServer then return cacheSetTimed(resolvedUserIdCache, resolvedUserIdCacheTime, cacheKey, inServer, CACHE_MAX_ENTRIES.resolvedUserId) end
    return nil
end
if okEnv and env then env.__ResolveUserToIdShared = resolveUserToId end
function getDefaultTargetUserId() return resolveUserToId(CONFIG.target) end
local guiSpoofState = {
    active = false, serial = 0, identity = nil,
    originals = setmetatable({}, { __mode = "k" }),
    identityCache = {},
    connections = {},
    boundObjects = setmetatable({}, { __mode = "k" }),
    boundRoots = setmetatable({}, { __mode = "k" }),
}
local inspectHookKey = "__CiderInspectTargetState"; local inspectHookState = okEnv and env and env[inspectHookKey] or nil
if type(inspectHookState) ~= "table" then
    inspectHookState = { active = false, targetUserId = nil, targetName = nil, targetDescription = nil, hookInstalled = false, hookVersion = 0, }
    if okEnv and env then env[inspectHookKey] = inspectHookState end
end
inspectHookState.refreshing = false
inspectHookState.lastRefresh = tonumber(inspectHookState.lastRefresh) or 0
local refreshAvatarVisualDescription = nil; local clearAvatarVisuals = nil
function destroyInspectDescription()
    local description = inspectHookState.targetDescription
    inspectHookState.targetDescription = nil
    inspectHookState.preferDescription = false
    if description then pcall(function() description:Destroy() end) end
end
function clearInspectTarget()
    inspectHookState.active = false
    inspectHookState.targetUserId = nil
    inspectHookState.targetName = nil
    inspectHookState.refreshing = false
    inspectHookState.lastRefresh = 0
    destroyInspectDescription()
end
function setInspectTarget(userId, targetName, targetDescription)
    local numericUserId = tonumber(userId)
    if not numericUserId then return end
    local changedTarget = inspectHookState.targetUserId ~= numericUserId
    if changedTarget then
        pcall(function() GuiService:CloseInspectMenu() end)
        destroyInspectDescription()
        inspectHookState.refreshing = false
        inspectHookState.lastRefresh = 0
    end
    inspectHookState.active = true
    inspectHookState.targetUserId = numericUserId
    if targetName ~= nil then inspectHookState.targetName = tostring(targetName) end
    if targetDescription then
        applyCharOptionsToDescription(targetDescription)
        destroyInspectDescription()
        inspectHookState.targetDescription = targetDescription
        inspectHookState.preferDescription = true
    end
end
function getInspectUserId(value)
    local numeric = tonumber(value)
    if numeric then return numeric end
    local okId, resolved = pcall(function() return value.Id or value.UserId end)
    if okId then return tonumber(resolved) end
    return nil
end
local INSPECT_HOOK_VERSION = 2
if inspectHookState.hookVersion ~= INSPECT_HOOK_VERSION then
    local hookMM = hookmetamethod or (okEnv and env and env.hookmetamethod); local getMethod = getnamecallmethod or (okEnv and env and env.getnamecallmethod)
    if type(hookMM) == "function" and type(getMethod) == "function" then
        local oldNamecall = nil
        local callback = function(self, ...)
            local method = getMethod(); local state = okEnv and env and env[inspectHookKey] or inspectHookState
            if state and state.active and self == GuiService then
                local args = { ... }
                if method == "InspectPlayerFromUserId" then
                    if getInspectUserId(args[1]) == localPlayer.UserId and state.targetUserId then
                        if state.preferDescription and state.targetDescription then
                            local description = state.targetDescription; local targetName = state.targetName or tostring(state.targetUserId)
                            task.defer(function()
                                pcall(function() GuiService:CloseInspectMenu() end)
                                pcall(function() GuiService:InspectPlayerFromHumanoidDescription(description, targetName) end)
                            end)
                            return nil
                        end
                        args[1] = state.targetUserId
                    end
                elseif method == "InspectPlayerFromHumanoidDescription" then
                    local requestedName = tostring(args[2] or "")
                    if (
                        requestedName == localPlayer.Name
                        or requestedName == localPlayer.DisplayName
                    ) and state.targetDescription then
                        args[1] = state.targetDescription
                        args[2] = state.targetName or requestedName
                    end
                end
                return oldNamecall(self, table.unpack(args))
            end
            return oldNamecall(self, ...)
        end
        local wrapped = type(newcclosure) == "function" and newcclosure(callback) or callback
        local okHook, originalNamecall = pcall(function() return hookMM(game, "__namecall", wrapped) end)
        if okHook and type(originalNamecall) == "function" then
            oldNamecall = originalNamecall
            inspectHookState.hookInstalled = true
            inspectHookState.hookVersion = INSPECT_HOOK_VERSION
        end
    end
end
function isLocalInspectTitle(value)
    if type(value) ~= "string" then return false end
    local lowered = string.lower(value)
    local names = { localPlayer.Name, localPlayer.DisplayName }
    for _, name in ipairs(names) do
        local loweredName = string.lower(tostring(name or ""))
        if loweredName ~= "" then
            if lowered == loweredName .. "'s avatar" or lowered == loweredName .. "’s avatar" then return true end
        end
    end
    return false
end
function requestTargetInspectRefresh()
    if not inspectHookState.active or not inspectHookState.targetUserId then return end
    local now = os.clock()
    if inspectHookState.refreshing or now - inspectHookState.lastRefresh < 1.5 then return end
    inspectHookState.refreshing = true
    inspectHookState.lastRefresh = now
    task.defer(function()
        if not inspectHookState.active or not inspectHookState.targetUserId then
            inspectHookState.refreshing = false
            return
        end
        pcall(function() GuiService:CloseInspectMenu() end)
        task.wait()
        local opened = false
        if inspectHookState.targetDescription then
            opened = pcall(function()
                GuiService:InspectPlayerFromHumanoidDescription(
                    inspectHookState.targetDescription,
                    inspectHookState.targetName or tostring(inspectHookState.targetUserId)
                )
            end)
        end
        if not opened then
            pcall(function() GuiService:InspectPlayerFromUserId(inspectHookState.targetUserId) end)
        end
        task.delay(1.25, function() inspectHookState.refreshing = false end)
    end)
end
function refreshStandaloneInspectDescription(char)
    if runtimeState.active then return end
    if not isCharAppearanceOptionEnabled('Headless') and not isCharAppearanceOptionEnabled('Korblox') then
        clearInspectTarget()
        if refreshAvatarVisualDescription then refreshAvatarVisualDescription(nil) end
        return
    end
    task.spawn(function()
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not humanoid and char then humanoid = char:WaitForChild("Humanoid", 10) end
        if not humanoid or not char.Parent or runtimeState.active then return end
        local description = nil
        pcall(function() description = humanoid:GetAppliedDescription() end)
        if not description then description = getTargetDescriptionCached(localPlayer.UserId) end
        if not description or runtimeState.active then return end
        applyCharOptionsToDescription(description)
        setInspectTarget(localPlayer.UserId, localPlayer.DisplayName, description)
        if refreshAvatarVisualDescription then refreshAvatarVisualDescription(description, localPlayer.UserId) end
    end)
end
function replacePlainText(value, from, to)
    if type(value) ~= "string" or type(from) ~= "string" or from == "" then return value end
    local pattern = from:gsub("([^%w])", "%%%1")
    return value:gsub(pattern, function() return tostring(to or "") end)
end
function isIdentityWordCharacter(character) return type(character) == "string" and character ~= "" and string.match(character, "[%w_]") ~= nil end
function replaceIdentityText(value, from, to)
    if type(value) ~= "string" or type(from) ~= "string" or from == "" then return value, false end
    local output = {}
    local cursor = 1
    local changed = false; local firstNeedsBoundary = isIdentityWordCharacter(string.sub(from, 1, 1)); local lastNeedsBoundary = isIdentityWordCharacter(string.sub(from, -1))
    while cursor <= #value do
        local startIndex, endIndex = string.find(value, from, cursor, true)
        if not startIndex then
            output[#output + 1] = string.sub(value, cursor)
            break
        end
        local before = startIndex > 1 and string.sub(value, startIndex - 1, startIndex - 1) or ""
        local after = endIndex < #value and string.sub(value, endIndex + 1, endIndex + 1) or ""
        local validBefore = not firstNeedsBoundary or not isIdentityWordCharacter(before); local validAfter = not lastNeedsBoundary or not isIdentityWordCharacter(after)
        if validBefore and validAfter then
            output[#output + 1] = string.sub(value, cursor, startIndex - 1)
            output[#output + 1] = tostring(to or "")
            cursor = endIndex + 1
            changed = true
        else
            output[#output + 1] = string.sub(value, cursor, startIndex)
            cursor = startIndex + 1
        end
    end
    return table.concat(output), changed
end
function addIdentityReplacement(list, seen, from, to)
    if type(from) ~= "string" or from == "" or seen[from] then return end
    seen[from] = true
    list[#list + 1] = { from = from, to = tostring(to or "") }
end
function buildIdentityReplacements(identity)
    local replacements = {}
    local seen = {}
    local function addVariants(from, to)
        addIdentityReplacement(replacements, seen, from, to)
        addIdentityReplacement(replacements, seen, string.lower(from), string.lower(to))
        addIdentityReplacement(replacements, seen, string.upper(from), string.upper(to))
    end
    addVariants("@" .. localPlayer.Name, "@" .. identity.username)
    addVariants(localPlayer.DisplayName, identity.displayName)
    addVariants(localPlayer.Name, identity.username)
    table.sort(replacements, function(a, b) return #a.from > #b.from end) return replacements end
function getThumbnailContent(userId, thumbnailType, thumbnailSize)
    local ok, content = pcall(function() return Players:GetUserThumbnailAsync(userId, thumbnailType, thumbnailSize) end)
    if ok and type(content) == "string" and content ~= "" then return content end
    return nil
end
local THUMBNAIL_SPECS = {
    { Enum.ThumbnailType.HeadShot, "Size48x48", "headshot" },
    { Enum.ThumbnailType.HeadShot, "Size60x60", "headshot" },
    { Enum.ThumbnailType.HeadShot, "Size100x100", "headshot" },
    { Enum.ThumbnailType.HeadShot, "Size150x150", "headshot" },
    { Enum.ThumbnailType.HeadShot, "Size420x420", "headshot" },
    { Enum.ThumbnailType.AvatarBust, "Size150x150", "bust" },
    { Enum.ThumbnailType.AvatarBust, "Size352x352", "bust" },
    { Enum.ThumbnailType.AvatarBust, "Size420x420", "bust" },
    { Enum.ThumbnailType.AvatarThumbnail, "Size150x150", "full" },
    { Enum.ThumbnailType.AvatarThumbnail, "Size352x352", "full" },
    { Enum.ThumbnailType.AvatarThumbnail, "Size420x420", "full" },
    { Enum.ThumbnailType.AvatarThumbnail, "Size720x720", "full" },
}
function buildThumbnailContentMap(userId)
    local map = {}
    for _, spec in ipairs(THUMBNAIL_SPECS) do
        local okSize, thumbnailSize = pcall(function() return Enum.ThumbnailSize[spec[2]] end)
        if okSize and thumbnailSize then
            local ownContent = getThumbnailContent(localPlayer.UserId, spec[1], thumbnailSize); local targetContent = getThumbnailContent(userId, spec[1], thumbnailSize)
            if ownContent and targetContent then map[ownContent] = targetContent end
        end
    end
    return map
end
do
local avatarVisualState = {
    serial = 0, active = false, userId = nil, description = nil, modelTemplate = nil,
    contentKinds = {},
    overlays = setmetatable({}, { __mode = "k" }),
    boundImages = setmetatable({}, { __mode = "k" }),
    boundRoots = setmetatable({}, { __mode = "k" }),
    connections = {},
}
local function disconnectAvatarVisualConnections()
    for i = #avatarVisualState.connections, 1, -1 do
        local connection = avatarVisualState.connections[i]
        avatarVisualState.connections[i] = nil
        if connection and connection.Connected then
            pcall(function() connection:Disconnect() end) end end
    avatarVisualState.boundImages = setmetatable({}, { __mode = "k" })
    avatarVisualState.boundRoots = setmetatable({}, { __mode = "k" })
end
local function removeAvatarVisualOverlay(image)
    local entry = avatarVisualState.overlays[image]
    if not entry then return end
    avatarVisualState.overlays[image] = nil
    if image and image.Parent then
        pcall(function()
            if image.ImageTransparency == 1 then image.ImageTransparency = entry.imageTransparency end
        end)
    end
    if entry.viewport then pcall(function() entry.viewport:Destroy() end) end
end
clearAvatarVisuals = function()
    avatarVisualState.active = false
    avatarVisualState.serial = avatarVisualState.serial + 1
    disconnectAvatarVisualConnections()
    for image in pairs(avatarVisualState.overlays) do
        removeAvatarVisualOverlay(image)
    end
    avatarVisualState.overlays = setmetatable({}, { __mode = "k" })
    avatarVisualState.contentKinds = {}
    avatarVisualState.userId = nil
    if avatarVisualState.modelTemplate then
        pcall(function() avatarVisualState.modelTemplate:Destroy() end) avatarVisualState.modelTemplate = nil end
    if avatarVisualState.description then
        pcall(function() avatarVisualState.description:Destroy() end) avatarVisualState.description = nil end
end
local function classifyAvatarVisualImage(image)
    if not avatarVisualState.active or not image then return nil end
    local okImage, value = pcall(function() return image.Image end)
    if not okImage or type(value) ~= "string" or value == "" then return nil end
    local kind = avatarVisualState.contentKinds[value]
    if not kind then
        local lowerValue = string.lower(value); local localId = tostring(localPlayer.UserId); local targetId = tostring(avatarVisualState.userId or "")
        if not string.find(value, localId, 1, true) and (targetId == "" or not string.find(value, targetId, 1, true)) then return nil end
        if string.find(lowerValue, "headshot", 1, true) then
            kind = "headshot"
        elseif string.find(lowerValue, "bust", 1, true) then
            kind = "bust"
        elseif string.find(lowerValue, "avatar", 1, true) or string.find(lowerValue, "thumbnail", 1, true) then
            kind = "full"
        end
    end
    if not kind then return nil end
    if kind == "full" then
        local ancestor = image
        for _ = 1, 8 do
            if not ancestor then break end
            local lowerName = string.lower(ancestor.Name or "")
            if string.find(lowerName, "playerlist", 1, true)
                or string.find(lowerName, "player_list", 1, true)
                or string.find(lowerName, "player list", 1, true)
                or string.find(lowerName, "playercard", 1, true)
                or string.find(lowerName, "playerprofile", 1, true) then
                return nil
            end
            local nearby = ancestor:GetDescendants()
            for i = 1, MathMin(#nearby, 100) do
                local item = nearby[i]
                if item:IsA("TextLabel") or item:IsA("TextButton") then
                    local okText, text = pcall(function() return string.lower(item.Text or "") end)
                    if okText and string.find(text, "in this server", 1, true) then return nil end
                end
            end
            ancestor = ancestor.Parent
        end
    end
    return kind
end
local function createAvatarVisualModel(description)
    local model = nil
    local okModel = pcall(function() model = Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15) end)
    if not okModel or not model then return nil end
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true
            descendant.CanCollide = false
            descendant.CanTouch = false
            descendant.CanQuery = false
        elseif descendant:IsA("Script") or descendant:IsA("LocalScript") then
            descendant:Destroy()
        end
    end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
    return model
end
local function getAvatarBodyFrame(model, fieldOfView)
    local minimum = nil; local maximum = nil
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") then
            local half = child.Size / 2; local partMinimum = child.Position - half; local partMaximum = child.Position + half
            minimum = minimum and Vector3New(
                MathMin(minimum.X, partMinimum.X), MathMin(minimum.Y, partMinimum.Y),
                MathMin(minimum.Z, partMinimum.Z)
            ) or partMinimum
            maximum = maximum and Vector3New(
                MathMax(maximum.X, partMaximum.X), MathMax(maximum.Y, partMaximum.Y),
                MathMax(maximum.Z, partMaximum.Z)
            ) or partMaximum
        end
    end
    if not minimum or not maximum then return nil, nil end
    local size = maximum - minimum
    local focus = (minimum + maximum) / 2; local bodySize = MathMax(size.Y, size.X * 1.35, 4); local distance = bodySize / (2 * math.tan(MathRad(fieldOfView) / 2)) * 1.08
    return focus, distance
end
local function frameAvatarVisualModel(viewport, model, kind)
    local camera = Instance.new("Camera")
    camera.FieldOfView = kind == "full" and 28 or 24
    camera.Parent = viewport
    viewport.CurrentCamera = camera
    local focus = nil; local distance = nil
    if kind == "headshot" or kind == "bust" then
        local head = model:FindFirstChild("Head"); local upperTorso = model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso")
        if head then
            focus = head.Position + Vector3New(0, kind == "bust" and -0.35 or -0.05, 0)
            distance = kind == "bust" and 6.2 or 4.3
        elseif upperTorso then
            focus = upperTorso.Position + Vector3New(0, 0.7, 0)
            distance = 5
        end
    end
    if not focus then focus, distance = getAvatarBodyFrame(model, camera.FieldOfView) end
    if not focus then
        local root = model:FindFirstChild("HumanoidRootPart")
        focus = root and root.Position + Vector3New(0, 0.25, 0) or Vector3Zero
        distance = 12
    end
    local root = model:FindFirstChild("HumanoidRootPart"); local front = root and root.CFrame.LookVector or Vector3New(0, 0, -1)
    camera.CFrame = CFrameNew(focus + front * distance, focus)
end
local function applyAvatarVisualToImage(image)
    if not avatarVisualState.active or not avatarVisualState.description or not image.Parent then return end
    local kind = classifyAvatarVisualImage(image)
    if not kind then
        removeAvatarVisualOverlay(image)
        return
    end
    local current = avatarVisualState.overlays[image]
    if current and current.kind == kind and current.viewport and current.viewport.Parent then return end
    removeAvatarVisualOverlay(image)
    local model = nil
    if avatarVisualState.modelTemplate then
        pcall(function() model = avatarVisualState.modelTemplate:Clone() end)
    end
    if not model then return end
    local viewport = Instance.new("ViewportFrame")
    viewport.Name = "CiderAvatarVisual"
    viewport.BackgroundTransparency = 1
    viewport.BorderSizePixel = 0
    viewport.Size = UDim2.fromScale(1, 1)
    viewport.Position = UDim2.fromScale(0, 0)
    viewport.AnchorPoint = Vector2New(0, 0)
    viewport.ZIndex = image.ZIndex + 1
    viewport.Active = false
    viewport.Ambient = Color3RGB(190, 190, 190)
    viewport.LightColor = Color3RGB(255, 255, 255)
    viewport.LightDirection = Vector3New(-1, -1, -1)
    local world = Instance.new("WorldModel")
    world.Parent = viewport
    model.Parent = world
    frameAvatarVisualModel(viewport, model, kind)
    local corner = image:FindFirstChildOfClass("UICorner")
    if corner then corner:Clone().Parent = viewport end
    local originalTransparency = image.ImageTransparency
    avatarVisualState.overlays[image] = { viewport = viewport, imageTransparency = originalTransparency, kind = kind, }
    viewport.Parent = image
    image.ImageTransparency = 1
end
local function bindAvatarVisualImage(image)
    if not image or avatarVisualState.boundImages[image] then return end
    if not image:IsA("ImageLabel") and not image:IsA("ImageButton") then return end
    avatarVisualState.boundImages[image] = true
    local connection = image:GetPropertyChangedSignal("Image"):Connect(function()
        if not avatarVisualState.active then return end
        task.defer(function()
            if image.Parent then applyAvatarVisualToImage(image) end
        end)
    end)
    avatarVisualState.connections[#avatarVisualState.connections + 1] = connection
    applyAvatarVisualToImage(image)
end
local function watchAvatarVisualRoot(root)
    if not root or avatarVisualState.boundRoots[root] then return end
    avatarVisualState.boundRoots[root] = true
    local connection = root.DescendantAdded:Connect(function(instance)
        if not avatarVisualState.active then return end
        bindAvatarVisualImage(instance)
    end)
    avatarVisualState.connections[#avatarVisualState.connections + 1] = connection
end
local function scanAvatarVisualGui()
    if not avatarVisualState.active then return end
    local roots = { CoreGui, localPlayer:FindFirstChildOfClass("PlayerGui") }
    for _, root in ipairs(roots) do
        if root then
            watchAvatarVisualRoot(root)
            for _, instance in ipairs(root:GetDescendants()) do
                bindAvatarVisualImage(instance)
            end
        end
    end
end
refreshAvatarVisualDescription = function(description, userId)
    clearAvatarVisuals()
    if not description then return end
    if not isCharAppearanceOptionEnabled('Headless') and not isCharAppearanceOptionEnabled('Korblox') then return end
    local clonedDescription = nil
    pcall(function() clonedDescription = description:Clone() end)
    if not clonedDescription then return end
    applyCharOptionsToDescription(clonedDescription)
    local modelTemplate = createAvatarVisualModel(clonedDescription)
    if not modelTemplate then
        clonedDescription:Destroy()
        return
    end
    avatarVisualState.description = clonedDescription
    avatarVisualState.modelTemplate = modelTemplate
    avatarVisualState.userId = tonumber(userId) or localPlayer.UserId
    avatarVisualState.active = true
    avatarVisualState.serial = avatarVisualState.serial + 1
    local visualToken = avatarVisualState.serial
    scanAvatarVisualGui()
    task.spawn(function()
        local userIds = { localPlayer.UserId }
        if avatarVisualState.userId ~= localPlayer.UserId then userIds[#userIds + 1] = avatarVisualState.userId end
        local contentKinds = {}
        for _, thumbnailUserId in ipairs(userIds) do
            for _, spec in ipairs(THUMBNAIL_SPECS) do
                if not avatarVisualState.active or visualToken ~= avatarVisualState.serial then return end
                local okSize, thumbnailSize = pcall(function() return Enum.ThumbnailSize[spec[2]] end)
                if okSize and thumbnailSize then
                    local content = getThumbnailContent(thumbnailUserId, spec[1], thumbnailSize)
                    if content then contentKinds[content] = spec[3] end
                end
            end
        end
        if not avatarVisualState.active or visualToken ~= avatarVisualState.serial then return end
        avatarVisualState.contentKinds = contentKinds
        scanAvatarVisualGui()
    end)
end
end
local function getTargetIdentity(userId)
    local cached = guiSpoofState.identityCache[userId]
    if cached and os.clock() - cached.timestamp <= 60 then return cached.identity end
    local targetPlayer = nil
    pcall(function() targetPlayer = Players:GetPlayerByUserId(userId) end)
    local username = targetPlayer and targetPlayer.Name or nil; local displayName = targetPlayer and targetPlayer.DisplayName or nil
    if not username or not displayName then
        local okUserService, userService = pcall(function() return game:GetService("UserService") end)
        if okUserService and userService then
            local okInfo, infos = pcall(function() return userService:GetUserInfosByUserIdsAsync({ userId }) end)
            local info = okInfo and type(infos) == "table" and infos[1] or nil
            if info then
                username = username or info.Username or info.Name
                displayName = displayName or info.DisplayName
            end
        end
    end
    if not username then
        local okName, name = pcall(function() return Players:GetNameFromUserIdAsync(userId) end)
        if okName then username = name end
    end
    username = tostring(username or userId)
    displayName = tostring(displayName or username)
    local identity = { userId = userId, username = username, displayName = displayName, thumbnailMap = {}, }
    identity.replacements = buildIdentityReplacements(identity)
    guiSpoofState.identityCache[userId] = { identity = identity, timestamp = os.clock(), }
    task.spawn(function()
        local thumbnailMap = buildThumbnailContentMap(userId); local entry = guiSpoofState.identityCache[userId]
        if entry and entry.identity == identity then identity.thumbnailMap = thumbnailMap end
    end)
    return identity
end
local function rememberGuiProperty(instance, property, originalValue, spoofedValue)
    local properties = guiSpoofState.originals[instance]
    if not properties then
        properties = {}
        guiSpoofState.originals[instance] = properties
    end
    local entry = properties[property]
    if not entry then
        entry = { original = originalValue, spoofed = spoofedValue }
        properties[property] = entry
    else
        entry.spoofed = spoofedValue
    end
end
local function disconnectGuiIdentityConnections()
    for i = #guiSpoofState.connections, 1, -1 do
        local connection = guiSpoofState.connections[i]
        guiSpoofState.connections[i] = nil
        if connection and connection.Connected then
            pcall(function() connection:Disconnect() end) end end
    guiSpoofState.boundObjects = setmetatable({}, { __mode = "k" })
    guiSpoofState.boundRoots = setmetatable({}, { __mode = "k" })
end
local function restoreGuiIdentity()
    guiSpoofState.active = false
    guiSpoofState.serial = guiSpoofState.serial + 1
    disconnectGuiIdentityConnections()
    for instance, properties in pairs(guiSpoofState.originals) do
        if instance then
            for property, entry in pairs(properties) do
                pcall(function()
                    if instance[property] == entry.spoofed then instance[property] = entry.original end
                end)
            end
        end
    end
    guiSpoofState.originals = setmetatable({}, { __mode = "k" })
    guiSpoofState.identity = nil
    runtimeState.guiIdentity = nil
end
local function spoofIdentityText(value, identity)
    if type(value) ~= "string" or value == "" then return value end
    local result = value
    local applied = {}
    for index, replacement in ipairs(identity.replacements) do
        local token = "\1CIDER_ID_" .. tostring(index) .. "\2"; local replaced, changed = replaceIdentityText(result, replacement.from, token)
        if changed then
            result = replaced
            applied[#applied + 1] = { token = token, value = replacement.to }
        end
    end
    for _, replacement in ipairs(applied) do
        result = replacePlainText(result, replacement.token, replacement.value)
    end
    return result
end
local function spoofIdentityImage(value, identity)
    if type(value) ~= "string" or value == "" then return value end
    local mapped = identity.thumbnailMap[value]
    if mapped then return mapped end
    local lowerValue = string.lower(value); local localId = tostring(localPlayer.UserId)
    if not string.find(value, localId, 1, true) then return value end
    if not (
        string.find(lowerValue, "rbxthumb", 1, true)
        or string.find(lowerValue, "thumbnail", 1, true)
        or string.find(lowerValue, "headshot", 1, true)
        or string.find(lowerValue, "avatar", 1, true)
        or string.find(lowerValue, "userid", 1, true)
        or string.find(lowerValue, "userids", 1, true)
    ) then
        return value
    end
    return replacePlainText(value, localId, tostring(identity.userId))
end
local function applyIdentityToGuiObject(instance, identity)
    if not instance then return end
    if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
        local okText, currentText = pcall(function() return instance.Text end)
        if okText then
            if isLocalInspectTitle(currentText) then requestTargetInspectRefresh() end
            local spoofedText = spoofIdentityText(currentText, identity)
            if spoofedText ~= currentText then
                local okSet = pcall(function() instance.Text = spoofedText end)
                if okSet then rememberGuiProperty(instance, "Text", currentText, spoofedText) end
            end
        end
    elseif instance:IsA("ImageLabel") or instance:IsA("ImageButton") then
        local okImage, currentImage = pcall(function() return instance.Image end)
        if okImage then
            local spoofedImage = spoofIdentityImage(currentImage, identity)
            if spoofedImage ~= currentImage then
                local okSet = pcall(function() instance.Image = spoofedImage end)
                if okSet then rememberGuiProperty(instance, "Image", currentImage, spoofedImage) end
            end
        end
    end
end
local function bindIdentityGuiObject(instance, identity)
    if not instance or guiSpoofState.boundObjects[instance] then return end
    local property = nil
    if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
        property = "Text"
    elseif instance:IsA("ImageLabel") or instance:IsA("ImageButton") then
        property = "Image"
    end
    if not property then return end
    local okConnection, connection = pcall(function()
        return instance:GetPropertyChangedSignal(property):Connect(function()
            if not guiSpoofState.active or guiSpoofState.identity ~= identity then return end
            applyIdentityToGuiObject(instance, identity)
        end)
    end)
    if okConnection and connection then
        guiSpoofState.boundObjects[instance] = true
        guiSpoofState.connections[#guiSpoofState.connections + 1] = connection
    end
end
local function watchIdentityRoot(root, identity)
    if not root or guiSpoofState.boundRoots[root] then return end
    local okConnection, connection = pcall(function()
        return root.DescendantAdded:Connect(function(instance)
            if not guiSpoofState.active or guiSpoofState.identity ~= identity then return end
            bindIdentityGuiObject(instance, identity)
            applyIdentityToGuiObject(instance, identity)
        end)
    end)
    if okConnection and connection then
        guiSpoofState.boundRoots[root] = true
        guiSpoofState.connections[#guiSpoofState.connections + 1] = connection
    end
end
local function scanIdentityGui(identity)
    local roots = { CoreGui, localPlayer:FindFirstChildOfClass("PlayerGui") }
    for _, root in ipairs(roots) do
        if root then
            watchIdentityRoot(root, identity)
            applyIdentityToGuiObject(root, identity)
            local okDescendants, descendants = pcall(function() return root:GetDescendants() end)
            if okDescendants then
                for _, instance in ipairs(descendants) do
                    bindIdentityGuiObject(instance, identity)
                    applyIdentityToGuiObject(instance, identity)
                end
            end
        end
    end
end
function startGuiIdentity(userId, applyToken)
    restoreGuiIdentity()
    clearAvatarVisuals()
    setInspectTarget(userId)
    guiSpoofState.active = true
    guiSpoofState.serial = guiSpoofState.serial + 1
    local guiToken = guiSpoofState.serial
    task.spawn(function()
        local identity = getTargetIdentity(userId)
        if not guiSpoofState.active or guiToken ~= guiSpoofState.serial then return end
        if not runtimeState.active or applyToken ~= applySerial then return end
        guiSpoofState.identity = identity
        runtimeState.guiIdentity = identity
        setInspectTarget(userId, identity.displayName)
        task.spawn(function()
            local targetDescription = getTargetDescriptionCached(userId)
            if not guiSpoofState.active or guiToken ~= guiSpoofState.serial then
                if targetDescription then pcall(function() targetDescription:Destroy() end) end
                return
            end
            if targetDescription then
                setInspectTarget(userId, identity.displayName, targetDescription)
                refreshAvatarVisualDescription(targetDescription, userId)
            end
        end)
        while guiSpoofState.active and guiToken == guiSpoofState.serial and runtimeState.active and applyToken == applySerial do
            scanIdentityGui(identity)
            task.wait(2)
        end
    end)
end
local function destroyColorSnapshot(snapshot)
    if not snapshot then return end
    if snapshot.bodyColors then
        pcall(function() snapshot.bodyColors:Destroy() end) snapshot.bodyColors = nil end
end
function teardown()
    local previousSnapshot = runtimeState.colorSnapshot
    runtimeState.active = false
    applySerial = applySerial + 1
    runtimeState.currentUserId = nil
    destroyColorSnapshot(previousSnapshot)
    runtimeState.colorSnapshot = nil
    targetUserId = nil
    disconnectAppearanceHooks()
    restoreGuiIdentity()
    clearInspectTarget()
    clearAvatarVisuals()
    if characterAddedConn then characterAddedConn:Disconnect(); characterAddedConn = nil end
    if standaloneAppearanceConn then standaloneAppearanceConn:Disconnect(); standaloneAppearanceConn = nil end
    clearAvatarCaches()
    if typeof(animCleanup) == "function" then animCleanup() end
    if okEnv and env then
        if env.__CopyOutfitColorSnapshot and env.__CopyOutfitColorSnapshot ~= previousSnapshot then destroyColorSnapshot(env.__CopyOutfitColorSnapshot) end
        env.__CopyOutfitColorSnapshot = nil
        if env[stateKey] == runtimeState then env[stateKey] = nil end
    end
end
runtimeState.teardown = teardown
function snapshotCharacterColors(char)
    if not char then return nil end
    local snapshot = { bodyColors = nil, partColors = {} }
    local bc = char:FindFirstChildOfClass("BodyColors")
    if bc then snapshot.bodyColors = bc:Clone() end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("BasePart") then snapshot.partColors[child.Name] = child.BrickColor end
    end
    return snapshot
end
local function publishColorSnapshot(char)
    destroyColorSnapshot(runtimeState.colorSnapshot)
    local snapshot = snapshotCharacterColors(char)
    runtimeState.colorSnapshot = snapshot
    if okEnv and env then env.__CopyOutfitColorSnapshot = snapshot end
end
function isApplyStillCurrent(applyToken, userId)
    if not runtimeState.active then return false end
    if applyToken == applySerial then return true end
    if userId and (runtimeState.currentUserId == userId or targetUserId == userId) then return true end
    return false
end
local function applyFaceTexture(char, texture)
    local head = char:FindFirstChild("Head")
    if not head then return end
    if isCharAppearanceOptionEnabled('Headless') then
        head.Transparency = 1
        purgeHeadFaces(head)
        return
    end
    for _, child in ipairs(head:GetChildren()) do
        if child:IsA("Decal") and (child.Name == "face" or child.Face == Enum.NormalId.Front) then child:Destroy() end
    end
    if head:IsA("MeshPart") then
        pcall(function() head.TextureID = "" end)
    end
    local mesh = head:FindFirstChildOfClass("SpecialMesh")
    if mesh then
        pcall(function() mesh.TextureId = "" end)
    end
    local sa = head:FindFirstChildOfClass("SurfaceAppearance")
    if sa then
        pcall(function() sa:Destroy() end)
    end
    if not texture or texture == "" then texture = "rbxassetid://0" end
    local decal = Instance.new("Decal")
    decal.Name = "face"
    decal.Face = Enum.NormalId.Front
    decal.Texture = texture
    decal.Parent = head
end
local function resolveFaceTexture(userId, appearanceModel, targetDesc)
    local cached = cacheGetTimed(faceTextureCache, faceTextureCacheTime, userId, AVATAR_CACHE_TTL_SECONDS)
    if cached then return cached end
    local appearanceHead = appearanceModel and appearanceModel:FindFirstChild("Head"); local direct = firstDecalTextureFromHead(appearanceHead)
    if direct then return cacheFaceTexture(userId, direct) end
    if targetDesc and targetDesc.Face and targetDesc.Face ~= 0 then return resolveFaceFromAssetId(targetDesc.Face, userId) end
    local info = getCharacterAppearanceInfoCached(userId)
    if info and info.assets then
        for _, asset in ipairs(info.assets) do
            if asset.assetType and asset.assetType.id == 18 and asset.id then return resolveFaceFromAssetId(asset.id, userId) end
        end
    end
    local okModel, tempModel = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
    if okModel and tempModel then
        local tempHead = tempModel:FindFirstChild("Head"); local tempTexture = firstDecalTextureFromHead(tempHead)
        tempModel:Destroy()
        if tempTexture then return cacheFaceTexture(userId, tempTexture) end
    end
    return nil
end
local function buildSourcePartSizeMap(srcModel)
    local sizes = {}
    for _, part in ipairs(srcModel:GetChildren()) do
        if part:IsA("BasePart") then sizes[part.Name] = part.Size end
    end
    return sizes
end
local function scaleAccessoryOnce(acc, char, sourcePartSizeMap, charPartMap, attachmentCarrierMap)
    local handle = acc:FindFirstChild("Handle")
    if not handle or not handle:IsA("BasePart") then return end
    local matchedPartName = nil
    for _, hChild in ipairs(handle:GetChildren()) do
        if hChild:IsA("Attachment") then
            local carrier = attachmentCarrierMap and attachmentCarrierMap[hChild.Name] or nil
            if type(carrier) == "string" then
                matchedPartName = carrier
                break
            end
            if carrier == false then
                local scanMap = charPartMap or buildBasePartMap(char)
                for partName, bodyPart in pairs(scanMap) do
                    if bodyPart and bodyPart:IsA("BasePart") and bodyPart:FindFirstChild(hChild.Name) then
                        matchedPartName = partName
                        break
                    end
                end
            end
        end
        if matchedPartName then break end
    end
    if not handle:GetAttribute("_cpBaseSizeX") then
        handle:SetAttribute("_cpBaseSizeX", handle.Size.X)
        handle:SetAttribute("_cpBaseSizeY", handle.Size.Y)
        handle:SetAttribute("_cpBaseSizeZ", handle.Size.Z)
        for _, hChild in ipairs(handle:GetChildren()) do
            if hChild:IsA("Attachment") then
                hChild:SetAttribute("_cpBasePosX", hChild.Position.X)
                hChild:SetAttribute("_cpBasePosY", hChild.Position.Y)
                hChild:SetAttribute("_cpBasePosZ", hChild.Position.Z)
            end
        end
        local sm0 = handle:FindFirstChildOfClass("SpecialMesh")
        if sm0 then
            sm0:SetAttribute("_cpBaseScaleX", sm0.Scale.X)
            sm0:SetAttribute("_cpBaseScaleY", sm0.Scale.Y)
            sm0:SetAttribute("_cpBaseScaleZ", sm0.Scale.Z)
        end
    end
    local scale = nil
    if matchedPartName then
        local srcSize = sourcePartSizeMap[matchedPartName]; local dstPart = char:FindFirstChild(matchedPartName)
        if srcSize and dstPart and dstPart:IsA("BasePart") then
            local sx = math.max(srcSize.X, 0.001); local sy = math.max(srcSize.Y, 0.001); local sz = math.max(srcSize.Z, 0.001)
            scale = (dstPart.Size.X/sx + dstPart.Size.Y/sy + dstPart.Size.Z/sz) / 3
        end
    end
    local function applyScale(s)
        local bx = handle:GetAttribute("_cpBaseSizeX"); local by = handle:GetAttribute("_cpBaseSizeY"); local bz = handle:GetAttribute("_cpBaseSizeZ")
        if bx and by and bz then
            pcall(function() handle.Size = Vector3.new(bx*s, by*s, bz*s) end)
        end
        for _, hChild in ipairs(handle:GetChildren()) do
            if hChild:IsA("Attachment") then
                local apx = hChild:GetAttribute("_cpBasePosX"); local apy = hChild:GetAttribute("_cpBasePosY"); local apz = hChild:GetAttribute("_cpBasePosZ")
                if apx and apy and apz then
                    pcall(function() hChild.Position = Vector3.new(apx*s, apy*s, apz*s) end) end end
        end
        local sm = handle:FindFirstChildOfClass("SpecialMesh")
        if sm then
            local msx = sm:GetAttribute("_cpBaseScaleX"); local msy = sm:GetAttribute("_cpBaseScaleY"); local msz = sm:GetAttribute("_cpBaseScaleZ")
            pcall(function()
                if msx and msy and msz then sm.Scale = Vector3.new(msx*s, msy*s, msz*s) else sm.Scale = sm.Scale * s end
            end)
        end
    end
    if scale and math.abs(scale - 1) > 0.01 then applyScale(scale) else applyScale(1) end
end
local function scaleAllAccessories(char, sourcePartSizeMap, charPartMap, attachmentCarrierMap)
    for _, child in ipairs(char:GetChildren()) do
        if isAccessoryClass(child.ClassName) then scaleAccessoryOnce(child, char, sourcePartSizeMap, charPartMap, attachmentCarrierMap) end
    end
end
local function applyBodyFromDescription(targetDesc, char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not targetDesc then return false end
    for _, fieldName in ipairs(COPY_ANIMATION_FIELDS) do
        pcall(function() targetDesc[fieldName] = 0 end)
    end
    local okApply = pcall(function() hum:ApplyDescription(targetDesc) end) return okApply end
local function toColor3(value)
    local kind = typeof(value)
    if kind == "Color3"    then return value end
    if kind == "BrickColor"then return value.Color end
    if kind == "number"    then
        local ok, brick = pcall(function() return BrickColor.new(value) end)
        if ok and brick then return brick.Color end
    end
    return nil
end
local function enforceSkinColorFromDescription(targetDesc, char, sourceModel, preferredSnapshot)
    if not char then return end
    local bodyColors = char:FindFirstChildOfClass("BodyColors")
    if not bodyColors then
        bodyColors = Instance.new("BodyColors")
        bodyColors.Parent = char
    end
    local preferredBodyColors = preferredSnapshot and preferredSnapshot.bodyColors or nil; local sourceBodyColors = sourceModel and sourceModel:FindFirstChildOfClass("BodyColors")
    local headColor = (preferredBodyColors and preferredBodyColors.HeadColor3)      or (targetDesc and toColor3(targetDesc.HeadColor))      or (sourceBodyColors and sourceBodyColors.HeadColor3)
    local leftArmColor = (preferredBodyColors and preferredBodyColors.LeftArmColor3)   or (targetDesc and toColor3(targetDesc.LeftArmColor))   or (sourceBodyColors and sourceBodyColors.LeftArmColor3)
    local rightArmColor = (preferredBodyColors and preferredBodyColors.RightArmColor3)  or (targetDesc and toColor3(targetDesc.RightArmColor))  or (sourceBodyColors and sourceBodyColors.RightArmColor3)
    local torsoColor = (preferredBodyColors and preferredBodyColors.TorsoColor3)     or (targetDesc and toColor3(targetDesc.TorsoColor))     or (sourceBodyColors and sourceBodyColors.TorsoColor3)
    local leftLegColor = (preferredBodyColors and preferredBodyColors.LeftLegColor3)   or (targetDesc and toColor3(targetDesc.LeftLegColor))   or (sourceBodyColors and sourceBodyColors.LeftLegColor3)
    local rightLegColor = (preferredBodyColors and preferredBodyColors.RightLegColor3)  or (targetDesc and toColor3(targetDesc.RightLegColor))  or (sourceBodyColors and sourceBodyColors.RightLegColor3)
    local preferredPartColors = preferredSnapshot and preferredSnapshot.partColors or nil
    local function pickPartColor(partName, fallbackColor)
        if preferredPartColors then
            local preferred = toColor3(preferredPartColors[partName])
            if preferred then return preferred end
        end
        return fallbackColor
    end
    if headColor     then bodyColors.HeadColor3 = headColor     end
    if leftArmColor  then bodyColors.LeftArmColor3 = leftArmColor  end
    if rightArmColor then bodyColors.RightArmColor3 = rightArmColor end
    if torsoColor    then bodyColors.TorsoColor3 = torsoColor    end
    if leftLegColor  then bodyColors.LeftLegColor3 = leftLegColor  end
    if rightLegColor then bodyColors.RightLegColor3 = rightLegColor end
    local partColorMap = {
        Head = pickPartColor("Head", headColor), LeftArm = pickPartColor("LeftArm", leftArmColor),      RightArm = pickPartColor("RightArm", rightArmColor),
        ["Left Arm"] = pickPartColor("Left Arm", leftArmColor),    ["Right Arm"] = pickPartColor("Right Arm", rightArmColor),
        LeftUpperArm = pickPartColor("LeftUpperArm", leftArmColor), LeftLowerArm = pickPartColor("LeftLowerArm", leftArmColor), LeftHand = pickPartColor("LeftHand", leftArmColor),
        RightUpperArm = pickPartColor("RightUpperArm", rightArmColor), RightLowerArm = pickPartColor("RightLowerArm", rightArmColor), RightHand = pickPartColor("RightHand", rightArmColor),
        Torso = pickPartColor("Torso", torsoColor),          UpperTorso = pickPartColor("UpperTorso", torsoColor),    LowerTorso = pickPartColor("LowerTorso", torsoColor),
        LeftLeg = pickPartColor("LeftLeg", leftLegColor),      LeftUpperLeg = pickPartColor("LeftUpperLeg", leftLegColor), LeftLowerLeg = pickPartColor("LeftLowerLeg", leftLegColor), LeftFoot = pickPartColor("LeftFoot", leftLegColor),
        ["Left Leg"] = pickPartColor("Left Leg", leftLegColor),    ["Right Leg"] = pickPartColor("Right Leg", rightLegColor),
        RightLeg = pickPartColor("RightLeg", rightLegColor),    RightUpperLeg = pickPartColor("RightUpperLeg", rightLegColor), RightLowerLeg = pickPartColor("RightLowerLeg", rightLegColor),RightFoot = pickPartColor("RightFoot", rightLegColor),
    }
    for partName, color3 in pairs(partColorMap) do
        if color3 then
            local part = char:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                pcall(function() part.Color = color3 end) end end
    end
end
local pqzlwt = 0
local apply
local function getTargetBodyScales(userId, targetDesc)
    local scales = {
        width = targetDesc and targetDesc.WidthScale or 1, depth = targetDesc and targetDesc.DepthScale or 1, height = targetDesc and targetDesc.HeightScale or 1,
        head = targetDesc and targetDesc.HeadScale or 1, proportion = targetDesc and targetDesc.ProportionScale or 0, bodyType = targetDesc and targetDesc.BodyTypeScale or 0,
    }
    local okPlayer, targetPlayer = pcall(function() return Players:GetPlayerByUserId(userId) end)
    local targetCharacter = okPlayer and targetPlayer and targetPlayer.Character; local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildOfClass("Humanoid")
    if not targetHumanoid then return scales end
    local okDesc, liveDesc = pcall(function() return targetHumanoid:GetAppliedDescription() end)
    local function readScale(name, field, fallback)
        local valueObject = targetHumanoid:FindFirstChild(name)
        if valueObject and valueObject:IsA("NumberValue") then return valueObject.Value end
        if okDesc and liveDesc then
            local okValue, value = pcall(function() return liveDesc[field] end)
            if okValue and type(value) == "number" then return value end
        end
        return fallback
    end
    scales.width = readScale("BodyWidthScale", "WidthScale", scales.width)
    scales.depth = readScale("BodyDepthScale", "DepthScale", scales.depth)
    scales.height = readScale("BodyHeightScale", "HeightScale", scales.height)
    scales.head = readScale("HeadScale", "HeadScale", scales.head)
    scales.proportion = readScale("BodyProportionScale", "ProportionScale", scales.proportion)
    scales.bodyType = readScale("BodyTypeScale", "BodyTypeScale", scales.bodyType)
    return scales
end
local function kfdkdl(character)
    if not isCharEnabled() then return end
    local cfg = CONFIG and CONFIG.charchanger
    if not cfg then return end
    if not character or not character.Parent then return end
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local scaleValues = cfg.enabled and cfg or cfg.targetScales
    if not scaleValues then return end
    local map = {
        BodyWidthScale = scaleValues.width, BodyDepthScale = scaleValues.depth, BodyHeightScale = scaleValues.height, HeadScale = scaleValues.head,
        BodyProportionScale = scaleValues.proportion, BodyTypeScale = scaleValues.bodyType,
    }
    for name, value in pairs(map) do
        if type(value) == "number" then
            local nv = hum:FindFirstChild(name)
            if nv and nv:IsA("NumberValue") then
                if math.abs(nv.Value - value) > 0.001 then
                    pcall(function() nv.Value = value end) end end
        end
    end
end
local function xmvnrp(character)
    if not isCharEnabled() then return end
    pqzlwt = pqzlwt + 1
    local myToken = pqzlwt; local cfg = CONFIG and CONFIG.charchanger; local interval = (cfg and tonumber(cfg.enforceIntervalSeconds)) or 0.8
    task.spawn(function()
        while myToken == pqzlwt do
            task.wait(interval)
            if myToken ~= pqzlwt then return end
            local curChar = localPlayer.Character
            if not curChar or not curChar.Parent then character = nil else character = curChar end
            if character then kfdkdl(character) end
        end
    end)
end
if okEnv and env then
    env.nxhbtc = {
        Set = function(opts)
            if type(opts) ~= "table" then return end
            for k, v in pairs(opts) do
                if CONFIG.charchanger[k] ~= nil then CONFIG.charchanger[k] = v end
            end
            if opts.enabled ~= nil then GetConfig()['Char']['Body Size']['Enabled'] = opts.enabled == true end
            kfdkdl(localPlayer.Character)
        end,
        Enable = function()
            CONFIG.charchanger.enabled = true
            GetConfig()['Char']['Body Size']['Enabled'] = true
            kfdkdl(localPlayer.Character)
            xmvnrp(localPlayer.Character)
            local uid = runtimeState.currentUserId or targetUserId or getDefaultTargetUserId()
            if uid then apply(uid) end
        end,
        Disable = function()
            CONFIG.charchanger.enabled = false
            GetConfig()['Char']['Body Size']['Enabled'] = false
            pqzlwt = pqzlwt + 1
            local uid = runtimeState.currentUserId or targetUserId or getDefaultTargetUserId()
            if uid then apply(uid) end
        end,
        Reapply = function()
            kfdkdl(localPlayer.Character)
            local uid = runtimeState.currentUserId or targetUserId or getDefaultTargetUserId()
            if uid then apply(uid) end
        end,
    }
end
function applyAppearance(userId, char, applyToken)
    if not isApplyStillCurrent(applyToken, userId) then return end
    local model = getCharacterAppearanceModel(userId)
    if not model then
        local ok, created = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if ok and created then model = created else return end
    end
    if not isApplyStillCurrent(applyToken, userId) then model:Destroy(); return end
    clearCopyChildren(char)
    local sourceModel = model; local humModel = nil; local bodyModel = nil; local hasHead = sourceModel:FindFirstChild("Head") ~= nil
    local hasAnyPart = hasAnySourceBodyPart(sourceModel)
    if not hasHead or not hasAnyPart then
        local ok, created = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if ok and created then
            humModel = created
            sourceModel = humModel
        end
    end
    if not isApplyStillCurrent(applyToken, userId) then
        if humModel then humModel:Destroy() end
        model:Destroy(); return
    end
    local targetDesc = applyCharOptionsToDescription(getTargetDescriptionCached(userId))
    CONFIG.charchanger.targetScales = getTargetBodyScales(userId, targetDesc)
    local bodyApplied = applyBodyFromDescription(targetDesc, char)
    task.wait()
    local postDescriptionColorSnapshot = nil
    if bodyApplied then postDescriptionColorSnapshot = snapshotCharacterColors(char) end
    local delayedSkinSnapshot = nil
    if postDescriptionColorSnapshot and postDescriptionColorSnapshot.bodyColors then
        delayedSkinSnapshot = { bodyColors = postDescriptionColorSnapshot.bodyColors:Clone(), partColors = {}, }
        for partName, brickColor in pairs(postDescriptionColorSnapshot.partColors or {}) do
            delayedSkinSnapshot.partColors[partName] = brickColor
        end
    end
    if not isApplyStillCurrent(applyToken, userId) then
        destroyColorSnapshot(postDescriptionColorSnapshot)
        destroyColorSnapshot(delayedSkinSnapshot)
        if bodyModel then bodyModel:Destroy() end
        if humModel then humModel:Destroy() end
        model:Destroy(); return
    end
    if bodyApplied and not bodyModel then
        local okBody, createdBody = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if okBody and createdBody then bodyModel = createdBody end
    end
    local bodySourceModel = bodyModel or sourceModel
    local desiredFaceTexture = resolveFaceTexture(userId, bodySourceModel, targetDesc)
    local sourcePartSizeMap = buildSourcePartSizeMap(bodySourceModel)
    local charPartMap = buildBasePartMap(char); local attachmentCarrierMap = buildAttachmentCarrierMap(charPartMap)
    for _, partName in ipairs(BODY_PART_NAMES) do
        if bodyApplied then
            if partName == "Head" then applyFaceTexture(char, desiredFaceTexture) end
        else
            local src = bodySourceModel:FindFirstChild(partName) or sourceModel:FindFirstChild(partName); local dest = char:FindFirstChild(partName)
            if src and dest then
                dest.Transparency = src.Transparency
                local sm = src:FindFirstChildOfClass("SpecialMesh"); local dm = dest:FindFirstChildOfClass("SpecialMesh")
                if sm then
                    if not dm then
                        dm = sm:Clone(); dm.Parent = dest
                    else
                        dm.MeshId = sm.MeshId; dm.TextureId = sm.TextureId
                        dm.Scale = sm.Scale;  dm.Offset = sm.Offset
                    end
                elseif dm then
                    dm:Destroy()
                end
                pcall(function()
                    if src:IsA("MeshPart") and dest:IsA("MeshPart") then dest.TextureID = src.TextureID end
                end)
                for _, att in ipairs(src:GetChildren()) do
                    if att:IsA("Attachment") then
                        local existing = dest:FindFirstChild(att.Name)
                        if existing then
                            existing.Position = att.Position
                            existing.Orientation = att.Orientation
                        else
                            att:Clone().Parent = dest
                        end
                    end
                end
                if partName == "Head" then applyFaceTexture(char, desiredFaceTexture) end
            end
        end
    end
    if not isApplyStillCurrent(applyToken, userId) then
        destroyColorSnapshot(postDescriptionColorSnapshot)
        if bodyModel then bodyModel:Destroy() end
        if humModel then humModel:Destroy() end
        model:Destroy(); return
    end
    for _, inst in ipairs(sourceModel:GetChildren()) do
        if shouldCloneClass(inst.ClassName) then
            pcall(function()
                local clone = inst:Clone()
                clone.Parent = char
                if isAccessoryClass(clone.ClassName) then scaleAccessoryOnce(clone, char, sourcePartSizeMap, charPartMap, attachmentCarrierMap) end
            end)
        end
    end
    local rigRefreshToken = 0
    local function requestRigAndFaceRefresh(delaySeconds)
        rigRefreshToken = rigRefreshToken + 1
        local token = rigRefreshToken
        task.delay(delaySeconds or 0, function()
            if token ~= rigRefreshToken then return end
            if not isApplyStillCurrent(applyToken) then return end
            if not char.Parent then return end
            local h = char:FindFirstChildOfClass("Humanoid")
            if h then pcall(function() h:BuildRigFromAttachments() end) end
            applyFaceTexture(char, desiredFaceTexture)
            applyConfiguredCharBodyOptions(char)
            applyConfiguredCharAnimations(char, userId)
        end)
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum:BuildRigFromAttachments() end) end
    if not isApplyStillCurrent(applyToken, userId) then
        destroyColorSnapshot(postDescriptionColorSnapshot)
        destroyColorSnapshot(delayedSkinSnapshot)
        if bodyModel then bodyModel:Destroy() end
        if humModel then humModel:Destroy() end
        model:Destroy(); return
    end
    enforceSkinColorFromDescription(targetDesc, char, bodySourceModel, postDescriptionColorSnapshot)
    destroyColorSnapshot(postDescriptionColorSnapshot)
    applyFaceTexture(char, desiredFaceTexture)
    applyConfiguredCharBodyOptions(char)
    publishColorSnapshot(char)
    kfdkdl(char)
    task.defer(function()
        local retryDelays = { 0.1, 0.28, 0.55 }
        for _, dt in ipairs(retryDelays) do
            task.wait(dt)
            if not isApplyStillCurrent(applyToken) then
                destroyColorSnapshot(delayedSkinSnapshot)
                return
            end
            if not char.Parent then
                destroyColorSnapshot(delayedSkinSnapshot)
                return
            end
            if delayedSkinSnapshot then
                if delayedSkinSnapshot.bodyColors then
                    local okClone, bcClone = pcall(function() return delayedSkinSnapshot.bodyColors:Clone() end)
                    if okClone and bcClone then
                        pcall(function()
                            local currentBC = char:FindFirstChildOfClass("BodyColors")
                            if currentBC then currentBC:Destroy() end
                            bcClone.Parent = char
                        end)
                    end
                end
                for partName, brickColor in pairs(delayedSkinSnapshot.partColors or {}) do
                    local part = char:FindFirstChild(partName)
                    if part and part:IsA("BasePart") and brickColor then
                        pcall(function() part.BrickColor = brickColor end) end end
                enforceSkinColorFromDescription(nil, char, nil, delayedSkinSnapshot)
            else
                enforceSkinColorFromDescription(targetDesc, char, nil, nil)
            end
            kfdkdl(char)
            applyConfiguredCharBodyOptions(char)
        end
        destroyColorSnapshot(delayedSkinSnapshot)
    end)
    disconnectAppearanceHooks()
    appearanceChildConn = char.ChildAdded:Connect(function(child)
        if isAccessoryClass(child.ClassName) then
            task.defer(function()
                if not isApplyStillCurrent(applyToken) then return end
                if not char.Parent then return end
                local livePartMap = buildBasePartMap(char); local liveCarrierMap = buildAttachmentCarrierMap(livePartMap)
                scaleAccessoryOnce(child, char, sourcePartSizeMap, livePartMap, liveCarrierMap)
                requestRigAndFaceRefresh(0.03)
            end)
        elseif child.Name == "Head" or child:IsA("Decal") then
            if child.Name == "Head" then bindConfiguredHeadlessFaceWatcher(child) end
            requestRigAndFaceRefresh(0.02)
        end
    end)
    bindConfiguredHeadlessFaceWatcher(char:FindFirstChild("Head"))
    task.spawn(function()
        local pulseDelays = { 0.05, 0.12, 0.24, 0.4, 0.65, 0.95 }
        for _, dt in ipairs(pulseDelays) do
            task.wait(dt)
            if not isApplyStillCurrent(applyToken) then return end
            if not char.Parent then return end
            requestRigAndFaceRefresh(0.02)
        end
    end)
    local scaleRefreshScheduled = false; local scaleRefreshQueued = false
    local function scheduleScaleRefresh()
        if scaleRefreshScheduled then
            scaleRefreshQueued = true
            return
        end
        scaleRefreshScheduled = true
        task.delay(0.03, function()
            scaleRefreshScheduled = false
            if not isApplyStillCurrent(applyToken) then disconnectAppearanceHooks(); return end
            if not char.Parent then disconnectAppearanceHooks(); return end
            local livePartMap = buildBasePartMap(char); local liveCarrierMap = buildAttachmentCarrierMap(livePartMap)
            scaleAllAccessories(char, sourcePartSizeMap, livePartMap, liveCarrierMap)
            requestRigAndFaceRefresh(0.02)
            if scaleRefreshQueued then
                scaleRefreshQueued = false
                scheduleScaleRefresh()
            end
        end)
    end
    local function onScaleValueChanged() scheduleScaleRefresh() end
    local hScale = char:FindFirstChildOfClass("Humanoid")
    if hScale then
        local function tryBindScaleValue(nv)
            if not nv or not nv:IsA("NumberValue") then return end
            if not SCALE_VALUE_SET[nv.Name] then return end
            local conn = nv:GetPropertyChangedSignal("Value"):Connect(onScaleValueChanged)
            appearanceScaleValueConns[#appearanceScaleValueConns + 1] = conn
        end
        for _, child in ipairs(hScale:GetChildren()) do
            tryBindScaleValue(child)
        end
        local childAddedConn = hScale.ChildAdded:Connect(function(child) tryBindScaleValue(child) end)
        appearanceScaleValueConns[#appearanceScaleValueConns + 1] = childAddedConn
    end
    task.delay(0.2, onScaleValueChanged)
    if bodyModel then bodyModel:Destroy() end
    if humModel then humModel:Destroy() end
    model:Destroy()
end
local function cleanupForSwitch(char)
    disconnectAppearanceHooks()
    if not char then return end
    clearCopyChildren(char)
end
function syncTargetEmotes(userId, thisApply)
    local retryDelays = { 0, 0.45, 1.25, 3 }
    local synced = false
    for _, retryDelay in ipairs(retryDelays) do
        task.delay(retryDelay, function()
            if synced or not runtimeState.active or thisApply ~= applySerial then return end
            local emoteApi = env and env.EmoteMimic
            if emoteApi and type(emoteApi.SetTargetUserId) == "function" then
                local ok, applied = pcall(function() return emoteApi.SetTargetUserId(userId) end)
                if ok and applied then synced = true end
            end
        end)
    end
end
function apply(userId)
    if not runtimeState.active then return end
    if not isCharEnabled() then return end
    local char = localPlayer.Character
    if not char then return end
    applySerial = applySerial + 1
    local thisApply = applySerial
    targetUserId = userId
    runtimeState.currentUserId = userId
    cleanupForSwitch(char)
    startGuiIdentity(userId, thisApply)
    task.spawn(function()
        if not runtimeState.active then return end
        if thisApply ~= applySerial then return end
        applyAppearance(userId, char, thisApply)
        syncTargetEmotes(userId, thisApply)
        applyConfiguredCharAnimations(char, userId)
        task.delay(1, function()
            if thisApply == applySerial and runtimeState.active and char.Parent then applyConfiguredCharAnimations(char, userId) end
        end)
        task.delay(3, function()
            if thisApply == applySerial and runtimeState.active and char.Parent then applyConfiguredCharAnimations(char, userId) end
        end)
    end)
end
if okEnv and env then
    local function setTarget(newTarget)
        local uid = resolveUserToId(newTarget)
        if not uid then return end
        targetUserId = uid
        runtimeState.currentUserId = uid
        apply(uid)
    end
    local function reapplyTarget()
        local uid = runtimeState.currentUserId or targetUserId or getDefaultTargetUserId()
        if uid then apply(uid) end
    end
    local function useDefaultTarget()
        runtimeState.currentUserId = nil
        targetUserId = nil
        local uid = getDefaultTargetUserId()
        if uid then apply(uid) end
    end
    env.OutfitCopy = {
        SetTarget = setTarget, SetTargetUserId = setTarget, SetTargetUsername = setTarget, Reapply = reapplyTarget, UseDefaultTarget = useDefaultTarget, Cleanup = teardown,
    }
    env.CopySetUserId = setTarget
    env.CopyReapplyOutfit = reapplyTarget
    env.CopyUseDefaultTarget = useDefaultTarget
    env.CopyOutfitCleanup = teardown
end
characterAddedConn = localPlayer.CharacterAdded:Connect(function(char)
    runtimeState.active = isCharEnabled()
    disconnectAppearanceHooks()
    applyStandaloneCharBodyOptions(char)
    task.delay(1.5, function()
        if char and char.Parent then refreshStandaloneInspectDescription(char) end
    end)
    if not runtimeState.active then return end
    local hum = char:WaitForChild("Humanoid", 10)
    if not hum then return end
    task.wait(0.15)
    if not char.Parent then return end
    local currentTargetName = getTargetUsername()
    local uid = resolveUserToId(currentTargetName) or tonumber(currentTargetName) or runtimeState.currentUserId or targetUserId or getDefaultTargetUserId()
    if uid then
        -- print("[Prey Char Reset] Reset detected! Morphing fresh character into target: " .. tostring(currentTargetName) .. " (UserId: " .. tostring(uid) .. ")")
        targetUserId = uid
        runtimeState.currentUserId = uid
        apply(uid)
        pcall(function()
            if mimicAnimationsFromUserId then mimicAnimationsFromUserId(uid, true) end
        end)
        pcall(function()
            if mimicEmotesFromUserId then mimicEmotesFromUserId(uid) end
        end)
        kfdkdl(char)
        xmvnrp(char)
    end
end)
if localPlayer.Character then
    applyStandaloneCharBodyOptions(localPlayer.Character)
    local hum = localPlayer.Character:WaitForChild("Humanoid", 10)
    if hum then
        applyConfiguredCharBodyOptions(localPlayer.Character)
        refreshStandaloneInspectDescription(localPlayer.Character)
        if isCharEnabled() then
            local startupUserId = runtimeState.currentUserId or getDefaultTargetUserId()
            if startupUserId then apply(startupUserId) end
            kfdkdl(localPlayer.Character)
            xmvnrp(localPlayer.Character)
        end
    end
end
local LOCAL_PLAYER = localPlayer
local R15_FALLBACK_ANIMATIONS = {
    climb = "rbxassetid://507765644", fall = "rbxassetid://507765000", jump = "rbxassetid://507765000", run = "rbxassetid://913376220", walk = "rbxassetid://913402848",
    swim = "rbxassetid://913384386", idle1 = "rbxassetid://507766388", idle2 = "rbxassetid://507766666",
}
local SLOT_SPECS = {
    { folder = "climb", fallback = R15_FALLBACK_ANIMATIONS.climb },
    { folder = "fall",  fallback = R15_FALLBACK_ANIMATIONS.fall  },
    { folder = "jump",  fallback = R15_FALLBACK_ANIMATIONS.jump  },
    { folder = "run",   fallback = R15_FALLBACK_ANIMATIONS.run   },
    { folder = "walk",  fallback = R15_FALLBACK_ANIMATIONS.walk  },
    { folder = "swim",  fallback = R15_FALLBACK_ANIMATIONS.swim  },
}
if env and env.__AnimationMimicState and env.__AnimationMimicState.cleanup then pcall(env.__AnimationMimicState.cleanup) end
animState = {
    connections = {},
    originalByCharacter = {},
    directControllerByChar = {},
    lastTargetInput = CONFIG.target, pinnedTargetUserId = nil, lastSourceUserId = nil, applyToken = 0,
    animationSetCache = {},
    active = isCharEnabled() and not isAnimateOverrideEnabled(),
    settings = {
        autoApplyOnRespawn = true, useFallbackWhenMissing = true, useDirectTrackFallback = true, cacheTtlSeconds = 22, minLiveCoverage = 1, replicateDescriptionToOthers = false,
        invalidateAnimationCacheOnTargetSwitch = false, },
}
if env then env.__AnimationMimicState = animState end
function normalizeAnimationId(rawId)
    if rawId == nil then return nil end
    local numeric = tostring(rawId):match("%d+")
    if not numeric then return nil end
    if (tonumber(numeric) or 0) <= 0 then return nil end
    return "rbxassetid://" .. numeric
end
function numericIdFromContentId(rawId)
    if not rawId then return nil end
    local numeric = tostring(rawId):match("%d+")
    return numeric and tonumber(numeric) or nil
end
FALLBACK_ANIMATION_NUMERIC_IDS = {
    climb = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.climb), fall = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.fall),
    jump = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.jump), run = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.run),
    walk = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.walk), swim = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.swim),
    idle1 = numericIdFromContentId(R15_FALLBACK_ANIMATIONS.idle1),
}
function getLocalRigType()
    local character = LOCAL_PLAYER.Character; local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.RigType or Enum.HumanoidRigType.R15
end
function isCharacterR15(character)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return humanoid ~= nil and humanoid.RigType == Enum.HumanoidRigType.R15
end
function normalizeAvatarType(rawType)
    if rawType == nil then return nil end
    local s = tostring(rawType):upper()
    if s:find("R15") or s == "2" then return "R15" end
    if s:find("R6")  or s == "1" then return "R6"  end
    return nil
end
function getUserAvatarType(userId)
    local info = getCharacterAppearanceInfoCached(userId)
    return normalizeAvatarType(info and (info.playerAvatarType or info.PlayerAvatarType))
end
function resolveTargetToUserId(target) return resolveUserToId(target) end
function rememberOriginal(character, animationObject)
    if not character or not animationObject then return end
    if not animState.originalByCharacter[character] then animState.originalByCharacter[character] = {} end
    if animState.originalByCharacter[character][animationObject] == nil then animState.originalByCharacter[character][animationObject] = animationObject.AnimationId end
end
function resetCharacterAnimations(character)
    local saved = animState.originalByCharacter[character]
    if not saved then return false end
    for animationObject, originalId in pairs(saved) do
        if animationObject and animationObject.Parent then animationObject.AnimationId = originalId end
    end
    animState.originalByCharacter[character] = nil
    return true
end
function extractFolderAnimationData(animate, folderName)
    local folder = animate and animate:FindFirstChild(folderName)
    if not folder then return nil end
    local data = { byName = {}, ordered = {}, first = nil }
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Animation") then
            local id = normalizeAnimationId(child.AnimationId)
            if id then
                if not data.first then data.first = id end
                data.byName[child.Name] = id
                data.ordered[#data.ordered + 1] = id
            end
        end
    end
    return data
end
function buildAnimationSetFromAnimate(animate)
    if not animate then return nil end
    return {
        climb = extractFolderAnimationData(animate, "climb"), fall = extractFolderAnimationData(animate, "fall"), jump = extractFolderAnimationData(animate, "jump"),
        run = extractFolderAnimationData(animate, "run"), walk = extractFolderAnimationData(animate, "walk"), swim = extractFolderAnimationData(animate, "swim"),
        idle = extractFolderAnimationData(animate, "idle"),
    }
end
function resolveIdFromFolderData(folderData, childName, index)
    local chosen
    if folderData then chosen = folderData.byName[childName] or folderData.ordered[index] or folderData.first end
    return normalizeAnimationId(chosen)
end
function resolveIdFromFolderDataWithFallback(folderData, childName, index, fallbackId)
    if animState.settings.useFallbackWhenMissing then return resolveIdFromFolderData(folderData, childName, index) or normalizeAnimationId(fallbackId) end
    return resolveIdFromFolderData(folderData, childName, index)
end
function makeSingleAnimationData(name, rawId)
    local cleaned = normalizeAnimationId(rawId)
    if not cleaned then return nil end
    return { byName = { [name] = cleaned }, ordered = { cleaned }, first = cleaned }
end
function makeIdleAnimationData(rawIdleId)
    local cleaned = normalizeAnimationId(rawIdleId)
    if not cleaned then return nil end
    return { byName = { Animation1 = cleaned, Animation2 = cleaned }, ordered = { cleaned, cleaned }, first = cleaned, }
end
ANIM_KEYS = { "climb","fall","jump","run","walk","swim","idle" }
function hasAnimationFolderData(fd) return fd ~= nil and fd.first ~= nil end
function countAnimationSetCoverage(animationSet)
    if not animationSet then return 0 end
    local covered = 0
    for _, k in ipairs(ANIM_KEYS) do
        if hasAnimationFolderData(animationSet[k]) then covered = covered + 1 end
    end
    return covered
end
function getCachedAnimationSet(userId)
    local entry = cacheGetEntry(animState.animationSetCache, userId, animState.settings.cacheTtlSeconds)
    if not entry then return nil end
    return entry.set
end
function setCachedAnimationSet(userId, set)
    if not userId or not set then return end
    cacheSetEntry(animState.animationSetCache, userId, { set = set, timestamp = os.clock() }, CACHE_MAX_ENTRIES.animationSet)
end
function getAnimationSetFromLivePlayer(userId)
    local ok, player = pcall(function() return Players:GetPlayerByUserId(userId) end)
    if not ok or not player then return nil end
    local character = player.Character
    if not character then return nil end
    local animate = character:FindFirstChild("Animate")
    if not animate then return nil end
    local set = buildAnimationSetFromAnimate(animate)
    return (countAnimationSetCoverage(set) > 0) and set or nil
end
function getAnimationSetFromDescription(userId)
    local desc = getTargetDescriptionCached(userId)
    if not desc then return nil end
    return {
        climb = makeSingleAnimationData("ClimbAnim", desc.ClimbAnimation), fall = makeSingleAnimationData("FallAnim",  desc.FallAnimation),
        jump = makeSingleAnimationData("JumpAnim",  desc.JumpAnimation), run = makeSingleAnimationData("RunAnim",   desc.RunAnimation),
        walk = makeSingleAnimationData("WalkAnim",  desc.WalkAnimation), swim = makeSingleAnimationData("Swim",      desc.SwimAnimation),
        idle = makeIdleAnimationData(desc.IdleAnimation),
    }
end
function getAnimationSetFromTempRig(userId)
    local rigType = getLocalRigType()
    local ok, rig = pcall(function() return Players:CreateHumanoidModelFromUserId(userId, rigType) end)
    if not ok or not rig then return nil end
    rig.Name = "AnimationMimicTempRig"
    local animate = rig:FindFirstChild("Animate") or rig:WaitForChild("Animate", 5)
    if not animate then rig:Destroy(); return nil end
    local set = buildAnimationSetFromAnimate(animate)
    rig:Destroy()
    return set
end
function getAnimationSetFromUserId(userId)
    local cached = getCachedAnimationSet(userId)
    if cached then return cached end
    local fromLive = getAnimationSetFromLivePlayer(userId); local liveCoverage = countAnimationSetCoverage(fromLive)
    if liveCoverage >= (animState.settings.minLiveCoverage or 1) and liveCoverage > 0 then
        setCachedAnimationSet(userId, fromLive)
        return fromLive
    end
    local fromDesc = getAnimationSetFromDescription(userId); local fromRig = getAnimationSetFromTempRig(userId)
    local function pickBetter(currentBest, candidate)
        if not candidate then return currentBest end
        local coverage = countAnimationSetCoverage(candidate.set)
        if coverage <= 0 then return currentBest end
        if not currentBest then return { set = candidate.set, coverage = coverage, priority = candidate.priority } end
        if coverage > currentBest.coverage then return { set = candidate.set, coverage = coverage, priority = candidate.priority } end
        if coverage == currentBest.coverage and candidate.priority > currentBest.priority then
            return { set = candidate.set, coverage = coverage, priority = candidate.priority }
        end
        return currentBest
    end
    local best = nil
    best = pickBetter(best, { set = fromLive, priority = 3 })
    best = pickBetter(best, { set = fromRig,  priority = 2 })
    best = pickBetter(best, { set = fromDesc, priority = 1 })
    if not best or not best.set then return nil end
    setCachedAnimationSet(userId, best.set)
    return best.set
end
function getAnimationSetFromUserIdWithRetry(userId, attempts)
    attempts = attempts or 2
    for i = 1, attempts do
        local set = getAnimationSetFromUserId(userId)
        if set then return set end
        if i < attempts then task.wait(0.12) end
    end
    return nil
end
function applyAnimationSetToDescriptionFields(desc, animationSet)
    if not desc or not animationSet then return false end
    local function resolveNumeric(folder, childName, idx, fb) return numericIdFromContentId(resolveIdFromFolderDataWithFallback(animationSet[folder], childName, idx, fb)) end
    desc.ClimbAnimation = resolveNumeric("climb","ClimbAnim",1,R15_FALLBACK_ANIMATIONS.climb) or FALLBACK_ANIMATION_NUMERIC_IDS.climb
    desc.FallAnimation = resolveNumeric("fall", "FallAnim", 1,R15_FALLBACK_ANIMATIONS.fall)  or FALLBACK_ANIMATION_NUMERIC_IDS.fall
    desc.JumpAnimation = resolveNumeric("jump", "JumpAnim", 1,R15_FALLBACK_ANIMATIONS.jump)  or FALLBACK_ANIMATION_NUMERIC_IDS.jump
    desc.RunAnimation = resolveNumeric("run",  "RunAnim",  1,R15_FALLBACK_ANIMATIONS.run)   or FALLBACK_ANIMATION_NUMERIC_IDS.run
    desc.WalkAnimation = resolveNumeric("walk", "WalkAnim", 1,R15_FALLBACK_ANIMATIONS.walk)  or FALLBACK_ANIMATION_NUMERIC_IDS.walk
    desc.SwimAnimation = resolveNumeric("swim", "Swim",     1,R15_FALLBACK_ANIMATIONS.swim)  or FALLBACK_ANIMATION_NUMERIC_IDS.swim
    desc.IdleAnimation = resolveNumeric("idle", "Animation1",1,R15_FALLBACK_ANIMATIONS.idle1) or FALLBACK_ANIMATION_NUMERIC_IDS.idle1
    return true
end
function getCurrentScaleValues(humanoid)
    if not humanoid then return nil end
    local function readSV(name, fallback)
        local nv = humanoid:FindFirstChild(name)
        return (nv and nv:IsA("NumberValue") and nv.Value) or fallback
    end
    local okDesc, desc = pcall(function() return humanoid:GetAppliedDescription() end)
    return {
        height = readSV("BodyHeightScale",  okDesc and desc and desc.HeightScale     or 1), width = readSV("BodyWidthScale",   okDesc and desc and desc.WidthScale      or 1),
        depth = readSV("BodyDepthScale",   okDesc and desc and desc.DepthScale      or 1), head = readSV("HeadScale",        okDesc and desc and desc.HeadScale       or 1),
        bodyType = readSV("BodyTypeScale",    okDesc and desc and desc.BodyTypeScale   or 0),
        proportion = readSV("BodyProportionScale", okDesc and desc and desc.ProportionScale or 0),
    }
end
local destroyBodyColorSnapshot = destroyColorSnapshot
function restoreCharacterColors(character, snapshot)
    if not character or not snapshot then return end
    if snapshot.bodyColors then
        local src = snapshot.bodyColors
        local ok, clone = pcall(function() return src:Clone() end)
        if ok and clone then
            local current = character:FindFirstChildOfClass("BodyColors")
            if current then pcall(function() current:Destroy() end) end
            local applied = pcall(function() clone.Parent = character end)
            if not applied then
                pcall(function() clone:Destroy() end)
                task.defer(function()
                    task.wait(0.12)
                    if not character.Parent then return end
                    local ok2, clone2 = pcall(function() return src:Clone() end)
                    if not ok2 or not clone2 then return end
                    pcall(function()
                        local bc = character:FindFirstChildOfClass("BodyColors")
                        if bc then bc:Destroy() end
                        clone2.Parent = character
                    end)
                end)
            end
        end
    end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("BasePart") then
            local saved = snapshot.partColors[child.Name]
            if saved then child.BrickColor = saved end
        end
    end
end
function replicateAnimationStateForOthers(character, animationSet)
    if not animState.settings.replicateDescriptionToOthers then return true end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local liveColorSnapshot = snapshotCharacterColors(character); local scales = getCurrentScaleValues(humanoid)
    local ok, currentDesc = pcall(function() return humanoid:GetAppliedDescription() end)
    if not ok or not currentDesc then
        destroyBodyColorSnapshot(liveColorSnapshot)
        return false
    end
    if scales then
        currentDesc.HeightScale = scales.height
        currentDesc.WidthScale = scales.width
        currentDesc.DepthScale = scales.depth
        currentDesc.HeadScale = scales.head
        currentDesc.BodyTypeScale = scales.bodyType
        currentDesc.ProportionScale = scales.proportion
    end
    if not applyAnimationSetToDescriptionFields(currentDesc, animationSet) then
        destroyBodyColorSnapshot(liveColorSnapshot)
        return false
    end
    if humanoid.ApplyDescriptionClientServer then
        local okCS = pcall(function() humanoid:ApplyDescriptionClientServer(currentDesc) end)
        if okCS then
            restoreCharacterColors(character, liveColorSnapshot)
            task.defer(function()
                task.wait(0.08)
                restoreCharacterColors(character, liveColorSnapshot)
                destroyBodyColorSnapshot(liveColorSnapshot)
            end)
            return true
        end
    end
    destroyBodyColorSnapshot(liveColorSnapshot)
    return false
end
function applyAnimationSetViaDescription(humanoid, animationSet)
    if not humanoid or not animationSet then return false end
    local ok, currentDesc = pcall(function() return humanoid:GetAppliedDescription() end)
    if not ok or not currentDesc then return false end
    if not applyAnimationSetToDescriptionFields(currentDesc, animationSet) then return false end
    if humanoid.ApplyDescriptionClientServer then
        local okCS = pcall(function() humanoid:ApplyDescriptionClientServer(currentDesc) end)
        if okCS then return true end
    end
    local okApply = pcall(function() humanoid:ApplyDescription(currentDesc) end) return okApply end
function stopDirectController(character)
    if not character then return end
    local controller = animState.directControllerByChar[character]
    if not controller then return end
    if controller.connection and controller.connection.Connected then controller.connection:Disconnect() end
    if controller.tracks then
        for _, track in pairs(controller.tracks) do
            pcall(function() track:Stop(0.08) end) end end
    if controller.animations then
        for _, animation in pairs(controller.animations) do
            pcall(function() animation:Destroy() end) end end
    animState.directControllerByChar[character] = nil
end
function stopAllDirectControllers()
    local chars = {}
    for c in pairs(animState.directControllerByChar) do chars[#chars+1] = c end
    for _, c in ipairs(chars) do stopDirectController(c) end
    animState.directControllerByChar = {}
end
function pruneStaleCharacterAnimationState(currentCharacter)
    for character in pairs(animState.originalByCharacter) do
        if character ~= currentCharacter and (not character.Parent or character ~= LOCAL_PLAYER.Character) then
            resetCharacterAnimations(character)
            animState.originalByCharacter[character] = nil
        end
    end
    for character in pairs(animState.directControllerByChar) do
        if character ~= currentCharacter and (not character.Parent or character ~= LOCAL_PLAYER.Character) then stopDirectController(character) end
    end
end
function startDirectController(character, animationSet)
    if not animState.settings.useDirectTrackFallback then return false end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or not animationSet then return false end
    stopDirectController(character)
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        local ok, a = pcall(function() return Instance.new("Animator") end)
        if ok and a then a.Parent = humanoid; animator = a end
    end
    if not animator then return false end
    local function getAnimId(folder, childName, idx, fb) return resolveIdFromFolderDataWithFallback(animationSet[folder], childName, idx, fb) end
    local idMap = {
        idle = getAnimId("idle",  "Animation1", 1, R15_FALLBACK_ANIMATIONS.idle1), run = getAnimId("run",   "RunAnim",    1, R15_FALLBACK_ANIMATIONS.run),
        walk = getAnimId("walk",  "WalkAnim",   1, R15_FALLBACK_ANIMATIONS.walk), jump = getAnimId("jump",  "JumpAnim",   1, R15_FALLBACK_ANIMATIONS.jump),
        fall = getAnimId("fall",  "FallAnim",   1, R15_FALLBACK_ANIMATIONS.fall), climb = getAnimId("climb", "ClimbAnim",  1, R15_FALLBACK_ANIMATIONS.climb),
        swim = getAnimId("swim",  "Swim",       1, R15_FALLBACK_ANIMATIONS.swim),
    }
    local tracks, animations = {}, {}
    local createdAny = false
    for stateName, animId in pairs(idMap) do
        if animId then
            local animation = Instance.new("Animation")
            animation.Name = "Mimic_" .. stateName
            animation.AnimationId = animId
            animations[stateName] = animation
            local okT, track = pcall(function() return animator:LoadAnimation(animation) end)
            if okT and track then
                track.Priority = (stateName == "idle") and Enum.AnimationPriority.Idle or Enum.AnimationPriority.Movement
                track.Looped = (stateName ~= "jump" and stateName ~= "fall")
                tracks[stateName] = track
                createdAny = true
            end
        end
    end
    if not createdAny then
        for _, a in pairs(animations) do pcall(function() a:Destroy() end) end
        return false
    end
    local controller = { tracks = tracks, animations = animations, connection = nil, active = nil, nextUpdateAt = 0 }
    animState.directControllerByChar[character] = controller
    local function playState(nextState)
        if controller.active == nextState then
            local t = controller.tracks[nextState]
            if t and not t.IsPlaying then pcall(function() t:Play(0.08,1,1) end) end
            return
        end
        controller.active = nextState
        for name, track in pairs(controller.tracks) do
            if name == nextState then
                pcall(function() if not track.IsPlaying then track:Play(0.08,1,1) end end)
            else
                pcall(function() if track.IsPlaying then track:Stop(0.08) end end) end end
    end
    controller.connection = RunService.Heartbeat:Connect(function()
        if not animState.active or not character.Parent then stopDirectController(character); return end
        local now = os.clock()
        if now < controller.nextUpdateAt then return end
        controller.nextUpdateAt = now + 0.03
        local moveMag = humanoid.MoveDirection.Magnitude; local humState = humanoid:GetState()
        if humState == Enum.HumanoidStateType.Freefall then
            if tracks.fall then playState("fall") elseif tracks.jump then playState("jump") end; return
        end
        if humState == Enum.HumanoidStateType.Jumping   and tracks.jump  then playState("jump");  return end
        if humState == Enum.HumanoidStateType.Climbing  and tracks.climb then playState("climb"); return end
        if humState == Enum.HumanoidStateType.Swimming  and tracks.swim  then playState("swim");  return end
        if moveMag > 0.08 then
            if tracks.run then playState("run") elseif tracks.walk then playState("walk") end; return
        end
        if tracks.idle then playState("idle") end
    end)
    return true
end
function applyFolderDataToFolder(character, folder, folderData, shouldRemember)
    if not folder then return 0 end
    local changed = 0; local idx = 0
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Animation") then
            idx = idx + 1
            local resolvedId = resolveIdFromFolderData(folderData, child.Name, idx)
            if resolvedId then
                if shouldRemember then rememberOriginal(character, child) end
                child.AnimationId = resolvedId
                changed = changed + 1
            end
        end
    end
    return changed
end
function getFirstAnimationInFolder(folder)
    if not folder then return nil end
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Animation") then return child end
    end
    return nil
end
function applySlotFromSet(character, animate, animationSet, folderName, fallbackId, shouldRemember)
    local folder = animate:FindFirstChild(folderName); local setData = animationSet and animationSet[folderName]
    if applyFolderDataToFolder(character, folder, setData, shouldRemember) > 0 then return true end
    local firstAnim = getFirstAnimationInFolder(folder)
    if not firstAnim or not animState.settings.useFallbackWhenMissing then return false end
    local fallback = normalizeAnimationId(fallbackId)
    if not fallback then return false end
    if shouldRemember then rememberOriginal(character, firstAnim) end
    firstAnim.AnimationId = fallback
    return true
end
function applyIdleFromSet(character, animate, idleData, shouldRemember)
    local idleFolder = animate:FindFirstChild("idle")
    if not idleFolder then return false end
    local applied = 0; local idx = 0
    for _, child in ipairs(idleFolder:GetChildren()) do
        if child:IsA("Animation") then
            idx = idx + 1
            local fb = nil
            if animState.settings.useFallbackWhenMissing then fb = (child.Name == "Animation2") and R15_FALLBACK_ANIMATIONS.idle2 or R15_FALLBACK_ANIMATIONS.idle1 end
            local resolvedIdle = resolveIdFromFolderDataWithFallback(idleData, child.Name, idx, fb)
            if resolvedIdle then
                if shouldRemember then rememberOriginal(character, child) end
                child.AnimationId = resolvedIdle
                applied = applied + 1
            end
        end
    end
    return applied > 0
end
function hardResetAnimator(humanoid)
    if not humanoid then return end
    local tracks = humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(tracks) do track:Stop(0) end
end
function flushAnimationState(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local tracks = humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(tracks) do track:Stop(0) end
end
function refreshAnimate(character)
    local animate = character and character:FindFirstChild("Animate")
    if animate and animate:IsA("LocalScript") then
        animate.Disabled = true
        task.wait()
        animate.Disabled = false
    end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local tracks = humanoid:GetPlayingAnimationTracks()
        for _, track in ipairs(tracks) do track:Stop(0) end
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end
end
function forceAnimationKick(character)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    humanoid:Move(Vector3.new(0, 0, 0), true)
    humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    task.wait()
    humanoid:ChangeState(Enum.HumanoidStateType.Running)
    task.defer(function()
        if not character.Parent then return end
        local playingTracks = humanoid:GetPlayingAnimationTracks()
        if #playingTracks > 0 then return end
        humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        task.wait()
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end)
end
function scrubTracksForDuration(character, seconds)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local tracksStart = humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(tracksStart) do track:Stop(0) end
    task.wait(seconds or 0.2)
    local tracksEnd = humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(tracksEnd) do track:Stop(0) end
end
function applyAnimationSetToCharacter(character, animationSet)
    if not character or not animationSet then return false end
    local animate = character:FindFirstChild("Animate"); local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    hardResetAnimator(humanoid)
    local applied = 0
    if animate then
        for _, spec in ipairs(SLOT_SPECS) do
            if applySlotFromSet(character, animate, animationSet, spec.folder, spec.fallback, true) then applied = applied + 1 end
        end
        if applyIdleFromSet(character, animate, animationSet.idle, true) then applied = applied + 1 end
    end
    if applied > 0 then
        stopDirectController(character)
        refreshAnimate(character)
    else
        local descApplied = applyAnimationSetViaDescription(humanoid, animationSet)
        if descApplied then
            stopDirectController(character)
        else
            if not startDirectController(character, animationSet) then return false end
        end
    end
    forceAnimationKick(character)
    replicateAnimationStateForOthers(character, animationSet)
    task.defer(function()
        if not animState.active then return end
        if not (env and env.EmoteMimic and type(env.EmoteMimic.Reapply) == "function") then return end
        pcall(function() env.EmoteMimic.Reapply() end)
    end)
    return true
end
function restoreOwnAnimationsHard(character)
    if not character then return false end
    local ownSet = getAnimationSetFromUserId(LOCAL_PLAYER.UserId)
    if not ownSet then return false end
    local animate = character:FindFirstChild("Animate"); local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    hardResetAnimator(humanoid)
    local applied = 0
    if animate then
        for _, spec in ipairs(SLOT_SPECS) do
            if applySlotFromSet(character, animate, ownSet, spec.folder, spec.fallback, false) then applied = applied + 1 end
        end
        if applyIdleFromSet(character, animate, ownSet.idle, false) then applied = applied + 1 end
    end
    if applied > 0 then
        stopDirectController(character)
        refreshAnimate(character)
    else
        if applyAnimationSetViaDescription(humanoid, ownSet) then
            stopDirectController(character)
        else
            if not animState.active then return false end
            if not startDirectController(character, ownSet) then return false end
        end
    end
    forceAnimationKick(character)
    replicateAnimationStateForOthers(character, ownSet)
    task.defer(function()
        if not animState.active then return end
        if not (env and env.EmoteMimic and type(env.EmoteMimic.Reapply) == "function") then return end
        pcall(function() env.EmoteMimic.Reapply() end)
    end)
    return true
end
function mimicAnimationsFromUserId(userId, forceApply)
    if not animState.active then return false end
    forceApply = forceApply ~= false and forceApply or false
    local numericUserId = tonumber(userId)
    if not numericUserId then return false end
    local character = LOCAL_PLAYER.Character
    if not character then return false end
    pruneStaleCharacterAnimationState(character)
    if not forceApply and animState.lastSourceUserId == numericUserId then return true end
    animState.applyToken = animState.applyToken + 1
    local applyToken = animState.applyToken
    local targetAvatarType = getUserAvatarType(numericUserId)
    if targetAvatarType == "R6" then
        animState.lastSourceUserId = nil
        restoreOwnAnimationsHard(character)
        flushAnimationState(character)
        return false
    end
    local animationSet = getAnimationSetFromUserIdWithRetry(numericUserId, 3)
    if not animationSet then
        animState.lastSourceUserId = nil
        return false
    end
    if applyToken ~= animState.applyToken then return false end
    local switchedTarget = animState.lastSourceUserId and animState.lastSourceUserId ~= numericUserId
    if switchedTarget then
        restoreOwnAnimationsHard(character)
        flushAnimationState(character)
        scrubTracksForDuration(character, 0.18)
        if applyToken ~= animState.applyToken then return false end
    end
    animState.lastSourceUserId = numericUserId
    animState.pinnedTargetUserId = numericUserId
    local ok = applyAnimationSetToCharacter(character, animationSet)
    if not ok then return false end
    task.defer(function()
        task.wait(0.2)
        if applyToken ~= animState.applyToken then return end
        if not character.Parent then return end
        local hum = character:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if #hum:GetPlayingAnimationTracks() == 0 then
            restoreOwnAnimationsHard(character)
            applyAnimationSetToCharacter(character, animationSet)
        end
    end)
    return ok
end
function mimicAnimationsFromTarget(target)
    if not animState.active then return false end
    local userId = resolveTargetToUserId(target)
    if not userId then return false end
    animState.lastTargetInput = target
    animState.pinnedTargetUserId = userId
    if animState.settings.invalidateAnimationCacheOnTargetSwitch then animState.animationSetCache[userId] = nil end
    return mimicAnimationsFromUserId(userId, true)
end
function disconnectAllConnections()
    for _, conn in ipairs(animState.connections) do
        if conn and conn.Connected then conn:Disconnect() end
    end
    animState.connections = {}
end
function clearRuntimeCaches() animState.animationSetCache = {} end
function restoreCharacterToSelf(character)
    if not character then return false end
    resetCharacterAnimations(character)
    local restored = restoreOwnAnimationsHard(character)
    flushAnimationState(character)
    return restored
end
function animCleanup()
    if not animState.active then return end
    animState.active = false
    animState.lastSourceUserId = nil
    animState.pinnedTargetUserId = nil
    animState.lastTargetInput = nil
    animState.applyToken = animState.applyToken + 1
    disconnectAllConnections()
    local character = LOCAL_PLAYER.Character
    stopAllDirectControllers()
    restoreCharacterToSelf(character)
    flushAnimationState(character)
    animState.originalByCharacter = {}
    clearRuntimeCaches()
end
animState.cleanup = animCleanup
if env then
    env.CloneAnimationsFromTarget = mimicAnimationsFromTarget
    env.AnimationMimicCleanup = animCleanup
end
if env and env.__EmoteMimicState and type(env.__EmoteMimicState.cleanup) == "function" then pcall(env.__EmoteMimicState.cleanup) end
local function deepCopyTable(value, seen)
    if type(value) ~= "table" then return value end
    seen = seen or {}
    if seen[value] then return seen[value] end
    local out = {}
    seen[value] = out
    for k, v in pairs(value) do
        out[deepCopyTable(k, seen)] = deepCopyTable(v, seen)
    end
    return out
end
local emoteState = {
    active = isCharEnabled(), targetInput = CONFIG.target, currentUserId = nil, applyToken = 0,
    connections = {},
    emoteCache = {},
    cacheTtlSeconds = 20, cleanup = nil,
    settings = { autoApplyOnRespawn = true, },
}
if env then env.__EmoteMimicState = emoteState end
local function disconnectEmoteConnections()
    for _, conn in ipairs(emoteState.connections) do
        if conn and conn.Connected then conn:Disconnect() end
    end
    emoteState.connections = {}
end
local function clearEmoteCaches() emoteState.emoteCache = {} end
local function getEmoteDataFromDescription(desc)
    if not desc then return nil end
    local emotes = nil; local equipped = nil
    if type(desc.GetEmotes) == "function" then
        local ok, value = pcall(function() return desc:GetEmotes() end)
        if ok and type(value) == "table" then emotes = deepCopyTable(value) end
    end
    if type(desc.GetEquippedEmotes) == "function" then
        local ok, value = pcall(function() return desc:GetEquippedEmotes() end)
        if ok and type(value) == "table" then equipped = deepCopyTable(value) end
    end
    if emotes == nil then
        local ok, value = pcall(function() return desc.Emotes end)
        if ok and type(value) == "table" then emotes = deepCopyTable(value) end
    end
    if equipped == nil then
        local ok, value = pcall(function() return desc.EquippedEmotes end)
        if ok and type(value) == "table" then equipped = deepCopyTable(value) end
    end
    if type(emotes) ~= "table" then emotes = {} end
    if type(equipped) ~= "table" then equipped = {} end
    return { emotes = emotes, equipped = equipped }
end
local function hasAnyTableEntries(value) return type(value) == "table" and next(value) ~= nil end
local function hasUsableEmotePayload(emoteData)
    if type(emoteData) ~= "table" then return false end
    return hasAnyTableEntries(emoteData.emotes) or hasAnyTableEntries(emoteData.equipped)
end
local function getEmoteDataFromLivePlayer(userId)
    local okPlayer, player = pcall(function() return Players:GetPlayerByUserId(userId) end)
    if not okPlayer or not player then return nil end
    local character = player.Character; local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    local okDesc, desc = pcall(function() return humanoid:GetAppliedDescription() end)
    if not okDesc or not desc then return nil end
    local data = getEmoteDataFromDescription(desc)
    pcall(function() desc:Destroy() end) return data end
local function getEmoteDataFromUserId(userId)
    local entry = cacheGetEntry(emoteState.emoteCache, userId, emoteState.cacheTtlSeconds)
    if entry and entry.data then
        return { emotes = deepCopyTable(entry.data.emotes), equipped = deepCopyTable(entry.data.equipped), }
    end
    local data = nil; local desc = getTargetDescriptionCached(userId)
    if desc then
        data = getEmoteDataFromDescription(desc)
        pcall(function() desc:Destroy() end)
    end
    if not hasUsableEmotePayload(data) then data = getEmoteDataFromLivePlayer(userId) end
    if not data or not hasUsableEmotePayload(data) then return nil end
    cacheSetEntry(emoteState.emoteCache, userId, { data = data, timestamp = os.clock() }, CACHE_MAX_ENTRIES.emoteData)
    return data
end
local function setEmoteDataOnDescription(description, emoteData)
    if not description or not emoteData then return false end
    local applied = false
    if hasAnyTableEntries(emoteData.emotes) then
        local okSetEmotes = pcall(function() description:SetEmotes(deepCopyTable(emoteData.emotes)) end)
        applied = applied or okSetEmotes
    end
    if hasAnyTableEntries(emoteData.equipped) then
        local okSetEquipped = pcall(function() description:SetEquippedEmotes(deepCopyTable(emoteData.equipped)) end)
        applied = applied or okSetEquipped
    end
    return applied
end
local function applyScaleValuesToDescription(desc, scales)
    if not desc or not scales then return end
    desc.HeightScale = scales.height
    desc.WidthScale = scales.width
    desc.DepthScale = scales.depth
    desc.HeadScale = scales.head
    desc.BodyTypeScale = scales.bodyType
    desc.ProportionScale = scales.proportion
end
local function restoreCharacterColorsSafely(character, colorSnapshot)
    if not colorSnapshot then return end
    restoreCharacterColors(character, colorSnapshot)
    task.defer(function()
        task.wait(0.06)
        if character and character.Parent then restoreCharacterColors(character, colorSnapshot) end
    end)
    task.defer(function()
        task.wait(0.2)
        if character and character.Parent then restoreCharacterColors(character, colorSnapshot) end
        destroyBodyColorSnapshot(colorSnapshot)
    end)
end
local function applyEmotesToHumanoid(humanoid, emoteData)
    if not humanoid or not emoteData then return false end
    if not hasUsableEmotePayload(emoteData) then return false end
    local character = humanoid.Parent
    local colorSnapshot = snapshotCharacterColors(character)
    local scaleSnapshot = getCurrentScaleValues(humanoid); local liveDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
        or humanoid:FindFirstChild("HumanoidDescription")
    if liveDescription and setEmoteDataOnDescription(liveDescription, emoteData) then
        destroyBodyColorSnapshot(colorSnapshot)
        task.defer(function()
            if not emoteState.active or not liveDescription.Parent then return end
            setEmoteDataOnDescription(liveDescription, emoteData)
        end)
        return true
    end
    local okDesc, currentDesc = pcall(function() return humanoid:GetAppliedDescription() end)
    if not okDesc or not currentDesc then
        destroyBodyColorSnapshot(colorSnapshot)
        return false
    end
    if not setEmoteDataOnDescription(currentDesc, emoteData) then
        destroyBodyColorSnapshot(colorSnapshot)
        pcall(function() currentDesc:Destroy() end) return false end
    applyScaleValuesToDescription(currentDesc, scaleSnapshot)
    if humanoid.ApplyDescriptionClientServer then
        local okCS = pcall(function() humanoid:ApplyDescriptionClientServer(currentDesc) end)
        if okCS then
            restoreCharacterColorsSafely(character, colorSnapshot)
            pcall(function() currentDesc:Destroy() end) return true end
    end
    local okApply = pcall(function() humanoid:ApplyDescription(currentDesc) end)
    restoreCharacterColorsSafely(character, colorSnapshot)
    pcall(function() currentDesc:Destroy() end) return okApply end
function mimicEmotesFromUserId(userId)
    if not emoteState.active then return false end
    local numericUserId = tonumber(userId)
    if not numericUserId then return false end
    local character = LOCAL_PLAYER.Character; local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    emoteState.applyToken = emoteState.applyToken + 1
    local applyToken = emoteState.applyToken
    local emoteData = getEmoteDataFromUserId(numericUserId)
    if not emoteData then return false end
    if applyToken ~= emoteState.applyToken or not emoteState.active then return false end
    local ok = false
    for attempt = 1, 3 do
        ok = applyEmotesToHumanoid(humanoid, emoteData)
        if ok then break end
        if attempt < 3 then task.wait(0.12) end
    end
    if ok then emoteState.currentUserId = numericUserId end
    return ok
end
function mimicEmotesFromTarget(target)
    if not emoteState.active then return false end
    local userId = resolveTargetToUserId(target)
    if not userId then return false end
    emoteState.targetInput = target
    return mimicEmotesFromUserId(userId)
end
local function reapplyEmotes()
    if emoteState.currentUserId then return mimicEmotesFromUserId(emoteState.currentUserId) end
    return mimicEmotesFromTarget(emoteState.targetInput or CONFIG.target)
end
local function useDefaultEmoteTarget()
    emoteState.currentUserId = nil
    return mimicEmotesFromTarget(CONFIG.target)
end
function emoteCleanup()
    if not emoteState.active then return end
    emoteState.active = false
    emoteState.applyToken = emoteState.applyToken + 1
    disconnectEmoteConnections()
    clearEmoteCaches()
    if env and env.__EmoteMimicState == emoteState then env.__EmoteMimicState = nil end
end
emoteState.cleanup = emoteCleanup
if emoteState.settings.autoApplyOnRespawn then
    local conn = LOCAL_PLAYER.CharacterAdded:Connect(function(char)
        if not emoteState.active then return end
        emoteState.applyToken = emoteState.applyToken + 1
        local respawnToken = emoteState.applyToken; local hum = char:WaitForChild("Humanoid", 10)
        if not hum or respawnToken ~= emoteState.applyToken or not emoteState.active then return end
        task.spawn(function()
            local delays = { 0.2, 0.45, 0.8 }
            for _, delayTime in ipairs(delays) do
                if not emoteState.active or respawnToken ~= emoteState.applyToken or not char.Parent then return end
                task.wait(delayTime)
                if not emoteState.active or respawnToken ~= emoteState.applyToken or not char.Parent then return end
                if reapplyEmotes() then break end
            end
            task.wait(0.9)
            if not emoteState.active or respawnToken ~= emoteState.applyToken or not char.Parent then return end
            reapplyEmotes()
        end)
    end)
    table.insert(emoteState.connections, conn)
end
if env then
    env.EmoteMimic = {
        SetTarget = mimicEmotesFromTarget, SetTargetUserId = mimicEmotesFromUserId, Reapply = reapplyEmotes, UseDefaultTarget = useDefaultEmoteTarget, Cleanup = emoteCleanup,
    }
    env.CloneEmotesFromTarget = mimicEmotesFromTarget
    env.CloneEmotesFromUserId = mimicEmotesFromUserId
    env.EmoteMimicCleanup = emoteCleanup
end
task.defer(function()
    if not emoteState.active then return end
    mimicEmotesFromTarget(CONFIG.target)
end)
local function switchTargetSafe(target)
    if target == nil then return false end
    local outfitTriggered = false; local outfitApi = env and env.OutfitCopy
    if outfitApi and type(outfitApi.SetTarget) == "function" then
        local ok = pcall(function() outfitApi.SetTarget(target) end)
        outfitTriggered = ok
    elseif env and type(env.CopySetUserId) == "function" then
        local ok = pcall(function() env.CopySetUserId(target) end) outfitTriggered = ok end
    task.defer(function()
        if animState.active then mimicAnimationsFromTarget(target) end
        if emoteState.active then mimicEmotesFromTarget(target) end
    end)
    return outfitTriggered
end
local function fullComboCleanup()
    pcall(teardown)
    pcall(animCleanup)
    pcall(emoteCleanup)
end
if env then
    env.SwitchTargetSafe = switchTargetSafe
    env.SetTargetSafe = switchTargetSafe
    env.FullComboCleanup = fullComboCleanup
    env.CloneFullCleanup = fullComboCleanup
end
task.defer(function()
    if not animState.active then return end
    if animState.pinnedTargetUserId then
        mimicAnimationsFromUserId(animState.pinnedTargetUserId)
    elseif animState.lastSourceUserId then
        mimicAnimationsFromUserId(animState.lastSourceUserId)
    elseif animState.lastTargetInput ~= nil then
        mimicAnimationsFromTarget(animState.lastTargetInput)
    else
        mimicAnimationsFromTarget(CONFIG.target)
    end
end)
if animState.settings.autoApplyOnRespawn then
    local conn = LOCAL_PLAYER.CharacterAdded:Connect(function(newCharacter)
        if not animState.active then return end
        animState.applyToken = animState.applyToken + 1
        local respawnToken = animState.applyToken
        pruneStaleCharacterAnimationState(newCharacter)
        local hum = newCharacter:WaitForChild("Humanoid", 10)
        if not hum or respawnToken ~= animState.applyToken or not animState.active then return end
        task.wait(0.15)
        if respawnToken ~= animState.applyToken or not animState.active or not newCharacter.Parent then return end
        task.spawn(function()
            local backoff = 0.25
            for _ = 1, 4 do
                if not animState.active or respawnToken ~= animState.applyToken or not newCharacter.Parent then return end
                if animState.pinnedTargetUserId and mimicAnimationsFromUserId(animState.pinnedTargetUserId, true) then return end
                if animState.lastSourceUserId and mimicAnimationsFromUserId(animState.lastSourceUserId, true) then return end
                if animState.lastTargetInput ~= nil and mimicAnimationsFromTarget(animState.lastTargetInput) then return end
                task.wait(backoff)
                if not animState.active or respawnToken ~= animState.applyToken then return end
                backoff = math.min(backoff * 2, 2)
            end
        end)
    end)
    table.insert(animState.connections, conn)
end
-- Global Target Switcher API (Fully pipeline-connected for unlimited target swapping)
getgenv().SwitchTargetSafe = function(newTarget)
    if not newTarget or newTarget == "" then return false end
    pcall(function()
        if runtimeState then
            runtimeState.active = isCharEnabled()
            runtimeState.currentUserId = nil
        end
    end)
    if not isCharEnabled() then return false end
    local charCfg = GetConfig()['Char']
    if charCfg then
        pcall(function() rawset(charCfg, 'TargetUser', tostring(newTarget)) end)
        pcall(function() rawset(charCfg, 'Target', tostring(newTarget)) end)
        pcall(function() rawset(charCfg, 'target', tostring(newTarget)) end)
    end
    pcall(function()
        if clearAvatarCaches then clearAvatarCaches() end
    end)
    local uid = nil
    if resolveUserToId then uid = resolveUserToId(newTarget) end
    if not uid then uid = tonumber(newTarget) end
    if uid then
        pcall(function()
            if apply then apply(uid) end
        end)
        pcall(function()
            if mimicAnimationsFromUserId then mimicAnimationsFromUserId(uid, true) end
        end)
        pcall(function()
            if mimicEmotesFromUserId then mimicEmotesFromUserId(uid) end
        end)
        return true
    else
        pcall(function()
            if mimicAnimationsFromTarget then mimicAnimationsFromTarget(newTarget) end
        end)
        pcall(function()
            if mimicEmotesFromTarget then mimicEmotesFromTarget(newTarget) end
        end)
    end
    return false
end
getgenv().SetCharTarget = getgenv().SwitchTargetSafe
-- Auto-start Char system on script load
task.spawn(function()
    task.wait(0.3)
    if isCharEnabled() then
        local target = getTargetUsername()
        getgenv().SwitchTargetSafe(target)
    end
end)
end)()
end)()
