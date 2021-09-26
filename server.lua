AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local function_check, msg = chatblacklist(message)
    if not function_check then
      TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, message)
	  else 
      TriggerClientEvent('chatMessage', -1, string.format(config.retrun_message, msg))
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
              blakclist = false;
            end
        end
    end
    return blacklist, word
end