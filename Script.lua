if _G.Reantheajfdfjdgse then
    return
end

_G.Reantheajfdfjdgse = "susan"

local coregui = game:GetService("CoreGui")
local players = game:GetService("Players")
local plr = players.LocalPlayer

local highlights = {}

function esp(target, color)
    pcall(function()
        if target.Character then
            if not highlights[target] then
                local highlight = Instance.new("Highlight", coregui)
                highlight.Name = target.Name
                highlight.Adornee = target.Character
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillColor = color
                highlights[target] = highlight
            else
                highlights[target].FillColor = color
            end
        end
    end)
end

players.PlayerAdded:Connect(function(v)
    v.CharacterAdded:Connect(function()
        esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
    end)
end)

players.PlayerRemoving:Connect(function(v)
    if highlights[v] then
        highlights[v]:Destroy()
        highlights[v] = nil
    end
end)

for i, v in pairs(players:GetPlayers()) do
    if v ~= plr then
        local color = _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor)
        v.CharacterAdded:Connect(function()
            local color = _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor)
            esp(v, color)
        end)
        
        esp(v, color)
    end
end

while task.wait() do
    for i, v in pairs(highlights) do
        local color = _G.UseTeamColor and i.TeamColor.Color or ((plr.TeamColor == i.TeamColor) and _G.FriendColor or _G.EnemyColor)
        v.FillColor = color
    end
end
'+


--[[
recursion's simple esp
6/23/2021
]]--

local start = tick()

_G.TeamLine = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localplayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

function esp(plr)
	local Lines = Drawing.new("Line")
	Lines.Color = Color3.new(1, 1, 1)
	Lines.Visible = false
	Lines.Thickness = 1
	Lines.Transparency = 1

	local Names = Drawing.new("Text")
	Names.Text = plr.Name
	Names.Color = Color3.new(1, 1, 1)	
	Names.Outline = true
	Names.OutlineColor = Color3.new(0, 0, 0)
	Names.Size = 20
	Names.Visible = false

	RunService.RenderStepped:Connect(function()
		if plr ~= localplayer and plr.Character ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") then
			local headPos = plr.Character:FindFirstChild("Head").Position
			local primaryPos = plr.Character.PrimaryPart.Position

			local nameVector, nameSeen = cam:WorldToViewportPoint(headPos)
			local lineVector, lineSeen = cam:WorldToViewportPoint(primaryPos)

			if lineSeen then
				Lines.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
				Lines.To = Vector2.new(lineVector.X, lineVector.Y)
				Names.Position = Vector2.new(nameVector.X-2, nameVector.Y)

				Lines.Visible = true
				Names.Visible = true

				if plr.TeamColor then
					Lines.Color = plr.TeamColor.Color
					Names.Color = plr.TeamColor.Color
				else
					Lines.Color = Color3.new(1, 1, 1)
					Names.Color = Color3.new(1, 1, 1)
				end

				if not _G.TeamLine then
					if plr.TeamColor == localplayer.TeamColor then
						Lines.Visible = false
						Names.Visible = false
					else
						Lines.Visible = true
						Names.Visible = true
					end
				end
			else
				Lines.Visible = false
				Names.Visible = false
			end
		end
	end)
end

for i,v in pairs(Players:GetChildren()) do
	esp(v)
end

Players.PlayerAdded:Connect(function(v)
	v.CharacterAdded:Connect(function()
		esp(v)
	end)
end)

print(("esp inititalized in %s seconds"):format(tick()-start))
'+

