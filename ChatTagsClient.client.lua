-- ChatTagsClient : affiche le tag devant les messages du chat
-- À placer dans StarterPlayer > StarterPlayerScripts, en tant que LocalScript nommé "ChatTagsClient"

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

TextChatService.OnIncomingMessage = function(message)
	local properties = Instance.new("TextChatMessageProperties")
	local source = message.TextSource

	if not source then
		return properties
	end

	local player = Players:GetPlayerByUserId(source.UserId)
	if not player then
		return properties
	end

	-- Le serveur a défini ces attributs dans ChatTagsServer
	local tag = player:GetAttribute("ChatTag")
	local color = player:GetAttribute("ChatTagColor")

	if tag and color then
		properties.PrefixText = string.format(
			'<font color="#%s">[%s]</font> %s',
			color:ToHex(),
			tag,
			message.PrefixText
		)
	end

	return properties
end
