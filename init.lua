ALPHASERV_PATH = "../alphaserv-v4/"

package.path = package.path .. ";"..ALPHASERV_PATH.."script/package/?.lua;"
package.path = package.path .. ";"..ALPHASERV_PATH.."script/?.lua;"
package.cpath = package.cpath .. ";"..ALPHASERV_PATH.."lib/lib?.so"

package.cpath = package.cpath .. ";lib/lib?.so"

print "init"

