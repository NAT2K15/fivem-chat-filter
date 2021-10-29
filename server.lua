AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local src = source
    local function_check, msg = chatblacklist(message)
    if not function_check then
      TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, message)
	  else 
      TriggerClientEvent('chatMessage', -1, string.format(config.retrun_message, msg))
      sendtodiscord(src, msg)
    end
end)

-- function --
function chatblacklist(str)
    local blacklist = false;
    local word = nil
    for badword in ipairs(config.words) do
        if string.match(string.lower(str), config.words[badword]) then
          blacklist = true
          word = config.words[badword]
        else 
            if(blacklist == true) then
              blacklist = true
            else 
              blacklist = false;
            end
        end
    end
    return blacklist, word
end

function sendtodiscord(user, message)
  local embed = {
    {
      ["color"] = config.color,
      ["title"] = "**[#".. user .. "] " .. GetPlayerName(user) .."**",
      ["description"] = message,
      ["footer"] = {
        ["text"] = "MADE BY NAT2K15#2951",
      },
    }
  }

  PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({username = GetPlayerName(user), embeds = embed, avatar_url = config.avatar_url}), { ['Content-Type'] = 'application/json' })
end
