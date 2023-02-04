_G.UnseenSave = _G.UnseenSave or {}
UnseenSave._path = ModPath
UnseenSave._data_path = SavePath .. "unseen_hint.txt"
UnseenSave._data = {}

function UnseenSave:Save()
	local file = io.open(self._data_path, "w+")
	if file then
		file:write(json.encode(self._data ))
		file:close()
	end
end

function UnseenSave:Load()
	local file = io.open(self._data_path, "r")
	if file then
		self._data = json.decode(file:read("*all"))
		file:close()
	end
end

UnseenSave:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_UnseenSaveMenu", function(loc)
	loc:load_localization_file(UnseenSave._path .. "loc/en.txt")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_UnseenSave", function(menu_manager)
	MenuCallbackHandler.callback_unseenhint_status = function(self, item)
		UnseenSave._data.unseen_status = item:value()
		UnseenSave:Save()
	end

	MenuHelper:LoadFromJsonFile(UnseenSave._path .. "menu/unseenhintmenu.txt", UnseenSave, UnseenSave._data)
	UnseenSave:Load()
end)

