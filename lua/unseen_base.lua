Hooks:PostHook(HUDManager, "_setup_player_info_hud_pd2", "Unseen_Hint", function(self, ...)
    self.checkunseenHint = UnseenHint:new(managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2))
    self:add_updator("UnseenHint_Updater", callback(self.checkunseenHint, self.checkunseenHint, "update"))
end)

function HUDManager:UnseenActivator(target_time)
    self.checkunseenHint:UnseenTimeEnabled(target_time)
end

UnseenHint = UnseenHint or class()

function UnseenHint:init(hud)
    self._t = 0
    self._UnseenLast = -1
    self._unseen = false
end

function UnseenHint:update(t, dt)
    self._t = t
    if self._unseen == true and self._UnseenLast <= t then
        self._unseen = false
        
		if managers.player:upgrade_level("player", "unseen_increased_crit_chance", 0) == 1 and UnseenSave._data.unseen_status == 2 then
			managers.chat:_receive_message(1, "Unseen Strike", "Disabled", Color("FF4400"))
		elseif managers.player:upgrade_level("player", "unseen_increased_crit_chance", 0) == 2 and UnseenSave._data.unseen_status == 3 then
			managers.chat:_receive_message(1, "Unseen Strike", "Disabled", Color("FF4400"))
		elseif UnseenSave._data.status == 4 then
			managers.chat:_receive_message(1, "Unseen Strike", "Disabled", Color("FF4400"))
		else return end
    end
end

function UnseenHint:UnseenTimeEnabled(target_time)
    self._UnseenLast = target_time + self._t
    self._unseen = true

	if managers.player:upgrade_level("player", "unseen_increased_crit_chance", 0) == 1 and UnseenSave._data.unseen_status == 2 then
    	managers.chat:_receive_message(1, "Unseen Strike", "Activated", Color("00CED1"))
	elseif managers.player:upgrade_level("player", "unseen_increased_crit_chance", 0) == 2 and UnseenSave._data.unseen_status == 3 then
		managers.chat:_receive_message(1, "Unseen Strike", "Activated", Color("00CED1"))
	elseif UnseenSave._data.status == 4 then
		managers.chat:_receive_message(1, "Unseen Strike", "Activated", Color("00CED1"))
	else return end
end

