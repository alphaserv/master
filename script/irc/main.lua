
require "net"

local joke_id = 1

local jokes = {
	 "2 parents are having a fight\nThey call each other BITCH and BASTARD\nTheir kids come in and ask\nWhat does BITCH and Bastard mean?\nThe parrents answer: woman and man\nThe next day the parents are having sex\nThe mom says: feel my tities and the dad: touch my dick\nTHe kids come in and ask\nWhat does tities and dick mean?\nThe parents answer\nhats and coats\nThe day after it is thanksgiving\nDad is shaving himself, but he cuts himself and calls\nSHIT\nThe kids ask what shit means\nThe dad answers: shit is the shaving cream I use\nSome later the mom cuts here self and calls: FUCK\nThe kids ask: what does fuck mean? The mom answers, thats stuffing a turkey.\nFew minutes later arrives the family for the thanksgiving meal\nThe kids open the door and says: Alright you bitches and bastards, put your dicks and titties in the closet, my dad is upstairs wiping the shit off his face, and my mom is in the kitchen fucking the turkey!",
	 
}

function get_joke()
	joke_id = joke_id + 1
	
	if joke_id == #jokes then
		joke_id = 1
	end
	
	return jokes[joke_id]
end

module("irc", package.seeall)

function send_antiflood(i, network, chan, message)
	core.sleep(i * 1000, function()
		network:send("PRIVMSG %(1)s :%(2)s", function() end, chan, message)
	end)
end

local chan_graphox

player_obj = class.new(nil, {
	nick,
	privilege
})

channel_obj = class.new(nil, {
	name = "",
	joined_channel = false,
	join_msg = "hey all!",
	
	players = {},
	
	network = nil,
	
	__init = function(self, name)
		if name[1] ~= "#" then
			error("invalid channel, channels start with a #")
			return
		end
		
		self.name = name
	end,
	
	set_network = function(self, network)
		self.network = network
	end,
	
	join = function(self)
		if self.joined_channel then
			return
		end
		
		self.network:send("JOIN %(1)s", function() end, self.name)
		self.joined_channel = true
	end,
	
	joined = function(self)
		self.joined_channel = true
	end,
	
	after_join = function(self)
		if self.join_msg ~= "" and not self.sent_joinmessage then
			self.network:send("PRIVMSG %(1)s :%(2)s", function() end, self.name, self.join_msg)
			self.sent_joinmessage = true
		end
		
		self.network:send("NAMES %(1)s", function() end, self.name)
	end,
	
	disconnect = function(self)
		self.joined_channel = false
	end,
	
	update_players = function(self, playerstring)
		for i, name in pairs(playerstring:split(" ")) do
			
			if name[1] == "+" then
				name = name:sub(2)
				self.players[name] = player_obj(name, "voice")			
			elseif name[1] == "@" then
				name = name:sub(2)
				self.players[name] = player_obj(name, "op")
			else
				self.players[name] = player_obj(name, "none")
			end
			
			print("detected player %(1)q" % { name })
		end
	end,
	
	check = function(self)
	
	end,
	
	sendto = function(self)
	
	end,
})

network_obj = class.new(nil, {
	channels = {},
	client = nil,
	
	nick = "funnybot2",
	username = "me",
	
	host = "",
	port = nil,
	
	adress = {ip = "", port = ""},
	
	connected = false,
	
	__init = function(self, host, port)
		self.client = net.tcp_client()
		
		self.host = host
		self.port = port
	end,
	
	send = function(self, command, callback, ...)
		command = command % arg
		
		print("[IRC] sending: %(1)q" % { command })
		
		self.client:async_send(command.."\n", function(errmsg)
			if errmsg then
				error(errmsg)
				return
			else
				callback(self, command)
			end
		end)
	end,
	
	add_channel = function(self, channel)
		if type(channel) == "string" then
			channel = channel_obj(channel)
		end
		
		channel:set_network(self)
		
		self.channels[channel.name] = channel
	end,
	
	join_channels = function(self)
	
		for i, channel in pairs(self.channels) do
			if not channel.joined_channel then
				channel:join()
			end
		end
	end,
	
	connect = function(self)
		self.client:async_connect(self.host, self.port, function(errmsg) 
		
			if errmsg then
				error(errmsg)
				return
			else
				self.connected = true
		        self.adress = self.client:local_endpoint()
				print("[IRC] : Local socket address %(1)s:%(2)s" % { self.adress.ip, self.adress.port })
				
				self:updatenick(function() self:updateusername() end)
		    end
		end)
	end,
	
	updatenick = function(self, callback)
		self:send("NICK %(1)s", callback or function() end, self.nick)
	end,
	
	updateusername = function(self)
		self:send("USER %(1)s 8 * %(2)s", function() self:startreading() end, self.username, "8", "*", "alphaserv_irc_bot")
	end,
	
	startreading = function(self)
		print("[IRC] Start reading")
		self:read()
	end,
	
	onready_func = function(network)
		network:join_channels()
	end,
	
	ready = function(self)
		self.ready = function() end
		
		self:onready_func()
		
	end,
	
	onready = function(self, func)
		self.onready_func = func
	end,
	
	command = function(self, nick, channel, command)
		local commands
		commands = {
			say = function(_, ...)
				self:send("PRIVMSG %(1)s :%(2)s", function() end, channel, table.concat(arg, " "))
			end,
			
			--[[
			stats= function(_, name)
				for _, row in pairs(alpha.db:query("SELECT id, name, country, team, frags, deaths, suicides, misses, shots, hits_made, hits_get, tk_made, tk_get, flags_returned, flags_stolen, flags_gone, flags_scored, total_scored, win, rank FROM stats_users WHERE name = ? LIMIT 3;", name or "bot"):fetch()) do
					self:send("PRIVMSG %(1)s :STATS %(2)s", function() end, channel, string.format("id: %i, name %s, country %s, team %s, frags %i, deaths %s, suicides %s, misses %s, shots %i, hits_made %i, hits_get %i, tk_made %i, tk_get %i, flags_returned %i, flags_stolen %i, flags_gone %s, flags_scored %i, total_scored %i, win %i, rank %i", row.id, row.name, row.country, row.team, row.frags, row.deaths, row.suicides, row.misses, row.shots, row.hits_made, row.hits_get, row.tk_made, row.tk_get, row.flags_returned, row.flags_stolen, row.flags_gone, row.flags_scored, row.total_scored, row.win, row.rank))
				end
			end,]]
			joke = function(_, id)
				local joke
				
				if id then
					joke = quotes.get_quote("jokes", id)
				else
					joke = quotes.get_random_quote("jokes")
				end
				
				if not joke then
					error("Could not find any joke :/", 1)
				end
				
				joke = joke:split("\n")

				for i, joke in pairs(joke) do
					send_antiflood(i, self, channel, joke)
				end
			end,
			
			add_joke = function(_, ...)
				quotes.add_quote("jokes", table.concat(arg, " "):gsub("\\n", "\n"))
				
				self:send("PRIVMSG %(1)s :Added joke %(2)q !", function() end, channel, table.concat(arg, " "))
			end,
			
			chucknorris = function(_)
				self:send("PRIVMSG %(1)s :%(2)s", function() end, channel, chuck.get_joke())
			end,
			
			help = function(_, command)
				if command then
					if not commands[command] then
						self:send("PRIVMSG %(1)s :could not find command %(2)s", function() end, channel, command)
					else
						self:send("PRIVMSG %(1)s :info: %(2)s", function() end, channel, "blablablablabla")
					end
				else
					self:send("PRIVMSG %(1)s :list of commands:", function() end, channel)
					for name, _ in pairs(commands) do
						self:send("PRIVMSG %(1)s : %(2)s", function() end, channel, name)
					end
				end
			end
		
		}
		
		if command[1] == "#" then
			command = command:sub(2)
			command = command:split(" ")
			
			if commands[command[1]] then
				local return_, error_ = pcall(commands[command[1]], unpack(command))
				if not return_ and error_ then
					self:send("PRIVMSG %(1)s :<%(2)s> %(3)s -> error on execution ?!", function() end, channel, command[1], error_ )
				end
			else
				self:send("PRIVMSG %(1)s :<%(2)s> %(3)s -> command not found ?!", function() end, channel, nick, table.concat(command, " ") )
			end
		else
		end
	end,
	
	read = function(self)
		self.client:async_read_until("\n", function(data)
			if data then
				data = data:gsub("\r", "")--remove \r
				data = data:gsub("\n", "")--remove \n
				print("[IRC] data: "..data)
				
				if data.find(data,"PING") then
					local pong = string.gsub(data,"PING","PONG",1)
					self:send(pong, function() end)

				--:*!~*@* INVITE alphabot #...
				elseif data:match("^(.-)!.+ INVITE "..self.nick.." #(.*)") then				
					local nick, cn = data:match("^(.-)!.+ INVITE "..self.nick.." #(.*)")
					print(nick.." invites us. joining #"..cn)
					self:add_channel("#"..cn)
					self:join_channels()
					
				--:nick!~...@... JOIN :#...
				elseif data:match("^:"..self.nick.."!~"..self.username.."@.- JOIN :#(.-)") then
					local channel = data:match("^:"..self.nick.."!~"..self.username.."@.- JOIN :#(.+)")
					
					print(channel)
					
					if not self.channels["#"..channel] then
						print("server sent join on a non-existing channel")
						print(table_to_string(self.channels))
					else
						self.channels["#"..channel]:joined()
					end
				
				--:ChanServ!ChanServ@Services.GameSurge.net MODE #... +v alphabot
				elseif data:match("^:.-!.-@.- MODE #(.-) (.-) "..self.nick) then
					local channel, mode = data:match("^:.-!.-@.- MODE #(.-) (.-) "..self.nick)
					
					if not self.channels["#"..channel] then
						print("server sent MODE on a non-existing channel")
						print(table_to_string(self.channels))
					else
						self.channels["#"..channel]:after_join(mode)
					end
				
				
				--:ChanServ!ChanServ@Services.GameSurge.net KICK #... alphabot :...
				elseif data:match("^:(.-)!.-@.- KICK #(.-) "..self.nick.." :(.*)") then
					local user, channel, message = data:match("^:(.-)!.-@.- KICK #(.-) "..self.nick.." :(.*)")
					
					if not self.channels["#"..channel] then
						print("server sent KICK on a non-existing channel")
						print(table_to_string(self.channels))
					else
						print("[IRC] [KICKED] we were kicked from #%(1)s by %(2)s (%(3)s)" % { channel, user, message })
						--rejoin
						self.channels["#"..channel]:disconnect("kick")
						self.channels["#"..channel]:join()
					end
					
				--:GameConnect.NL.EU.GameSurge.net 353 alphabot @ #... :alphabot @killme_nl @... +CIA-4 @ChanServ
				elseif data:match("^:.- 353 "..self.nick.." @ #(.-) :(.*)") then
					local channel, ops = data:match("^:.- 353 "..self.nick.." @ #(.-) :(.*)")
										
					if not self.channels["#"..channel] then
						print("server sent KICK on a non-existing channel")
						print(table_to_string(self.channels))
					else
						print("[IRC] OPS: "..ops)

						self.channels["#"..channel]:update_players(ops)
					end
			
				elseif data:match("NOTICE "..self.nick) then
					self:ready()
				elseif data.find(data,"Closing Link") then
					error("Link Closed")
				elseif string.match(data,"^:(.-)!.+ PRIVMSG (.-) :(.*)") then
					local nick, channel, command = string.match(data,"^:(.-)!.+ PRIVMSG (.-) :(.*)")
					
					if command[1] == ""
					or command == "VERSION"
					then
						--TODO: implement
						print("no CTCP")
					else
						--[[
						if not self.channels[channel] then
							print("command from unjoined player")
							return
						end]]
					
						if channel == self.nick then
							channel = nick
						end
					
						--self:send("PRIVMSG %(1)s :trolololllol <%(2)s> %(3)s", function() end, channel, nick, command )
					    self:command(nick, channel, command)
					end
				end				
				
            	self:read()
			else
				error("EOF from server")
			end
		end)
	end,
		
	check = function(self)
		for i, channel in pairs(channels) do
			channel:check()
		end
	end
})

networks = {}

local i = 1
local CHECK_INTERVAL = 10

function check()
	if i == CHECK_INTERVAL then
		i = 1
		
		for i, network in pairs(networks) do
			network:check()
		end		
	else
		i = i + 1
	end
end

function add_network(host, port)
	local network = network_obj(host, port)

	table.insert(networks, network)
	
	return network
end

local network = add_network("irc.gamesurge.net", 6667)

chan_graphox = channel_obj("#MiXeD")
chan_graphox.join_msg = "I AM FUNNYBOT (2)"
network:add_channel(chan_graphox)
--network:add_channel("#alphaserv")
network:connect()

server.interval(30 * 60000, function()
	network:command("internal", "#MiXeD", "#joke")
end)
