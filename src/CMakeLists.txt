add_subdirectory(geoip)
add_subdirectory(lua)
if(NOT IS_DIRECTORY /usr/include/boost)
    add_subdirectory(boost)
    set(BOOST_LIBS ${BOOST_SIGNALS_LIBRARY} ${BOOST_THREAD_LIBRARY})
else(NOT IS_DIRECTORY /usr/include/boost)
    set(BOOST_LIBS
    -lboost_signals
    -lboost_thread
    -lboost_system)
    set(BOOST_INCLUDE_DIRS /usr/include/boost)
endif(NOT IS_DIRECTORY /usr/include/boost)
add_subdirectory(fungu)
add_subdirectory(lsqlite3-7)
add_subdirectory(luasql)
add_subdirectory(socket)

include(CheckLibraryExists)

check_library_exists(z gzopen "" ZLIB_EXISTS)
check_library_exists(pthread pthread_self "" PTHREAD_EXISTS)
check_library_exists(rt clock_gettime "" RTLIB_EXISTS)

if(NOT ${ZLIB_EXISTS})
    message(FATAL_ERROR "missing required library: ZLIB")
endif(NOT ${ZLIB_EXISTS})

find_package(OpenSSL)

if(OPENSSL_FOUND)
    set(LUA_NET_SSL_SOURCES
        hopmod/lua/modules/net/ssl_context.cpp
        hopmod/lua/modules/net/ssl_tcp_stream.cpp)
    add_definitions(-DKSSL_DEBUG)
else(OPENSSL_FOUND)
    add_definitions(-DDISABLE_SSL -DWITHOUT_OPENSSL)
endif(OPENSSL_FOUND)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/shared
#    ${CMAKE_CURRENT_SOURCE_DIR}/fpsgame
    ${CMAKE_CURRENT_SOURCE_DIR}/hopmod
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${ENET_INCLUDE_DIRS}
    ${LUA_INCLUDE_DIRS}
    ${BOOST_INCLUDE_DIRS}
    ${FUNGU_INCLUDE_DIRS}
    ${OPENSSL_INCLUDE_DIR}
)

add_definitions(-Wall -fsigned-char -DSTANDALONE -DREVISION=$ENV{REVISION} ${LSQLITE3_DEFINITIONS} -llua_modules)

set(SAUERTOOLS_SOURCES
    shared/tools.cpp
    shared/stream.cpp
    shared/crypto.cpp
    )

add_library(sauertools STATIC ${SAUERTOOLS_SOURCES})

target_link_libraries(sauertools -lrt -lz ${BOOST_LIBS})

set(LUA_MODULES_SOURCES
    hopmod/lib/md5.c
    hopmod/utils.cpp
    hopmod/net/address.cpp
    hopmod/net/address_mask.cpp
    hopmod/net/address_prefix.cpp
    hopmod/lua/event.cpp
    hopmod/lua/push_function.cpp
    hopmod/lua/library_extensions.cpp
    hopmod/lua/pcall.cpp
    hopmod/lua/error_handler.cpp
    hopmod/lua/push.cpp
    hopmod/lua/register_class.cpp
    hopmod/lua/modules/module.cpp
    hopmod/lua/modules/crypto.cpp
    hopmod/lua/modules/timer.cpp
    hopmod/lua/modules/geoip.cpp
    hopmod/lua/modules/filesystem.cpp
    hopmod/lua/modules/packlib.c
    hopmod/lua/modules/cubescript.cpp
    hopmod/lua/modules/net/module.cpp
    hopmod/lua/modules/net/tcp_socket.cpp
    hopmod/lua/modules/net/weak_ref.cpp
    hopmod/lua/modules/net/ipmask.cpp
    hopmod/lua/modules/net/file_stream.cpp
    hopmod/lua/modules/net/tcp_acceptor.cpp
    hopmod/lua/modules/net/resolver.cpp
    ${LUA_NET_SSL_SOURCES}
    hopmod/cubescript/cubescript.cpp
    hopmod/cubescript/lua_command_stack.cpp
    hopmod/cubescript/lua/pcall.cpp
    hopmod/httpserver/filesystem_resource.cpp
    hopmod/httpserver/lua_module.cpp
)

set(LUA_MODULE_LIB lua_modules CACHE INTERNAL "lua module library")

add_library(${LUA_MODULE_LIB} STATIC ${LUA_MODULES_SOURCES})

target_link_libraries(${LUA_MODULE_LIB}
    -pthread sauertools
    ${GEOIP_LIBRARY}
    ${LUA_LIBRARY}
    ${FUNGU_STRING_LIBRARY}
    ${FUNGU_HTTP_LIBRARY}
    ${LSQLITE3_LIBRARY}
    ${OPENSSL_LIBRARIES}
    ${LUA_SOCKET_LIBRARY})

#SET(GAME_SERVER_SOURCES
#    engine/server.cpp
#    fpsgame/server.cpp
#    hopmod/startup.cpp
#    hopmod/scheduler.cpp
#    hopmod/lua.cpp
#    hopmod/core_bindings.cpp
#    hopmod/events.cpp
#    hopmod/signals.cpp)

#add_executable(sauer_server ${GAME_SERVER_SOURCES})

#target_link_libraries(sauer_server 
#    -lz
#    -lrt
#    ${BOOST_LIBS}
 #   sauertools
 #   ${LUA_MODULE_LIB}
 #   ${ENET_LIBRARY})

#add_executable(keygen hopmod/standalone/keygen.cpp)
#target_link_libraries(keygen sauertools)

#add_executable(monitor hopmod/standalone/monitor.cpp hopmod/lib/program_arguments.cpp)

#install(TARGETS 
#        sauer_server
#        monitor
#    RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR} 
#    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} 
#    ARCHIVE DESTINATION ${INSTALL_ARCHIVE_DIR})

#install(TARGETS 
#        keygen
#    RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR}/utils)

install(FILES 
        hopmod/cubescript/cubescript_library.lua 
    DESTINATION ${PROJECT_SOURCE_DIR}/script/package)
    
#DON'T COMPILE BOTH LUAPP AND SERVER -> BUG
#luapp
add_definitions(-DNO_EVENTS -DNO_CORE_TABLE -DLUAPP_TABLE)

add_executable(luapp
	hopmod/standalone/luapp/luapp.cpp
	hopmod/lua.cpp
)

target_link_libraries(luapp ${LUA_LIBRARY} ${BOOST_SYSTEM_LIBRARY} ${FUNGU_STRING_LIBRARY} ${FUNGU_HTTP_LIBRARY} ${LUA_MODULE_LIB} -lrt -lz)

install(TARGETS luapp RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR})
