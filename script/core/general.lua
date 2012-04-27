
alpha.settings.new_setting("servername", "Alphaserv1", "unique name of the server.")
alpha.settings.new_setting("server_id", 1, "unique id of the server in the database.")

alpha.settings.register_type("server_var", class.new(alpha.settings.setting_obj, {
	__init = function(self)
		self.setting = nil
	end,
	
	get = function(self)
	
	end,
	
	set = function(self, value)
		self.setting = value
		
		return self
	end

}))
