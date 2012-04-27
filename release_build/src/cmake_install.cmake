# Install script for directory: /home/bram/alphaserv-master/src

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "/home/bram/alphaserv-master/script/package/cubescript_library.lua")
FILE(INSTALL DESTINATION "/home/bram/alphaserv-master/script/package" TYPE FILE FILES "/home/bram/alphaserv-master/src/hopmod/cubescript/cubescript_library.lua")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  IF(EXISTS "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp")
    FILE(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp"
         RPATH "")
  ENDIF()
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "/home/bram/alphaserv-master/bin/utils/luapp")
FILE(INSTALL DESTINATION "/home/bram/alphaserv-master/bin/utils" TYPE EXECUTABLE FILES "/home/bram/alphaserv-master/release_build/src/luapp")
  IF(EXISTS "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp")
    FILE(RPATH_REMOVE
         FILE "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp")
    IF(CMAKE_INSTALL_DO_STRIP)
      EXECUTE_PROCESS(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/bram/alphaserv-master/bin/utils/luapp")
    ENDIF(CMAKE_INSTALL_DO_STRIP)
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/home/bram/alphaserv-master/release_build/src/geoip/cmake_install.cmake")
  INCLUDE("/home/bram/alphaserv-master/release_build/src/lua/cmake_install.cmake")
  INCLUDE("/home/bram/alphaserv-master/release_build/src/fungu/cmake_install.cmake")
  INCLUDE("/home/bram/alphaserv-master/release_build/src/lsqlite3-7/cmake_install.cmake")
  INCLUDE("/home/bram/alphaserv-master/release_build/src/luasql/cmake_install.cmake")
  INCLUDE("/home/bram/alphaserv-master/release_build/src/socket/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

