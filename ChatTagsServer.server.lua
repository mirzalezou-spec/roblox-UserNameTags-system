-- ChatTagsServer : attribue un tag à chaque joueur
-- À placer dans ServerScriptService, en tant que Script nommé "ChatTagsServer"

local Players = game:GetService("Players")

-- Configuration : ajoutez vos IDs et l'ID de votre groupe ici
local OWNER_IDS = {
	-- [123456789] = true,
}
local GROUP_ID = nil     -- exemple : 12345678, ou nil pour désactiver
local MIN_GROUP_RANK = 1 -- rang minimum dans le groupe pour recevoir le tag Member

local DEVELOPER_COLOR = Color3.fromRGB(255, 0, 0)
local MEMBER_COLOR = Color3.fromRGB(0, 255, 0)

-- Renvoie le tag et sa couleur selon le joueur, ou nil s'il n'en a pas
local function getTagFor(player)
	if OWNER_IDS[player.UserId] then
		return "Developer", DEVELOPER_COLOR
	end

	if GROUP_ID then
		local ok, rank = pcall(function()
			return player:GetRankInGroup(GROUP_ID)
		end)
		if ok and rank >= MIN_GROUP_RANK then
			return "Member", MEMBER_COLOR
		end
	end

	return nil, nil
end

-- Les attributs sont répliqués au client, c'est là que le tag est lu
local function applyTag(player)
	local tag, color = getTagFor(player)
	player:SetAttribute("ChatTag", tag)
	player:SetAttribute("ChatTagColor", color)
end

Players.PlayerAdded:Connect(applyTag)
for _, player in ipairs(Players:GetPlayers()) do
	applyTag(player)
end
