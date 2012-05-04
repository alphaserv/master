
--please change this!
ALPHASERV_PATH = "../alphaserv-v4/"

local initmem = gcinfo()

native_pcall = pcall

dofile(ALPHASERV_PATH.."script/hopmod_base/pcall.lua")
dofile(ALPHASERV_PATH.."script/hopmod_base/core_function_overloads.lua")
dofile(ALPHASERV_PATH.."script/hopmod_base/event.lua")
dofile(ALPHASERV_PATH.."script/hopmod_base/server.lua")

package.path = package.path .. ";"..ALPHASERV_PATH.."script/package/?.lua;"
package.path = package.path .. ";script/package/?.lua;"
package.path = package.path .. ";"..ALPHASERV_PATH.."script/?.lua;"
package.cpath = package.cpath .. ";"..ALPHASERV_PATH.."lib/lib?.so"

package.cpath = package.cpath .. ";lib/lib?.so"

alpha = {}

alpha.module_prefix = ALPHASERV_PATH.."script/alphaserv/" --path to this directory
alpha.module_extention = ".lua" ----extention of the files, deprecated

require "language.init"

dofile(alpha.module_prefix.."loader.lua")

local config_loaded = server.create_event_signal("config_loaded")
local pre_started = server.create_event_signal("pre_started")
local started = server.create_event_signal("started")

alpha.load.file("utils")

alpha.load.file("core/logging")

alpha.load.file("core/settings")

alpha.load.file("core/package")

--generate default config if file not found
if server.file_exists("conf/core.lua") then
	alpha.load.file("conf/core.lua", true)
end

config_loaded()

--force proper configuration scheme
alpha.settings.write("conf/core.lua")

pre_started()

local mem = gcinfo()
	
alpha.log.message("=> memory usage: %iKb (%iKb on init) diff: %iKb", mem, initmem, mem - initmem)
print(string.format("=> memory usage: %iKb (%iKb on init) diff: %iKb", mem, initmem, mem - initmem))
started()
