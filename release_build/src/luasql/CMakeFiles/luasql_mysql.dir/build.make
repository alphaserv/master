# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canoncical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/bram/alphaserv-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/bram/alphaserv-master/release_build

# Include any dependencies generated for this target.
include src/luasql/CMakeFiles/luasql_mysql.dir/depend.make

# Include the progress variables for this target.
include src/luasql/CMakeFiles/luasql_mysql.dir/progress.make

# Include the compile flags for this target's objects.
include src/luasql/CMakeFiles/luasql_mysql.dir/flags.make

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o: src/luasql/CMakeFiles/luasql_mysql.dir/flags.make
src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o: ../src/luasql/src/luasql.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/bram/alphaserv-master/release_build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/luasql_mysql.dir/src/luasql.c.o   -c /home/bram/alphaserv-master/src/luasql/src/luasql.c

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/luasql_mysql.dir/src/luasql.c.i"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /home/bram/alphaserv-master/src/luasql/src/luasql.c > CMakeFiles/luasql_mysql.dir/src/luasql.c.i

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/luasql_mysql.dir/src/luasql.c.s"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /home/bram/alphaserv-master/src/luasql/src/luasql.c -o CMakeFiles/luasql_mysql.dir/src/luasql.c.s

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.requires:
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.requires

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.provides: src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.requires
	$(MAKE) -f src/luasql/CMakeFiles/luasql_mysql.dir/build.make src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.provides.build
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.provides

src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.provides.build: src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o: src/luasql/CMakeFiles/luasql_mysql.dir/flags.make
src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o: ../src/luasql/src/ls_mysql.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/bram/alphaserv-master/release_build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o   -c /home/bram/alphaserv-master/src/luasql/src/ls_mysql.c

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.i"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /home/bram/alphaserv-master/src/luasql/src/ls_mysql.c > CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.i

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.s"
	cd /home/bram/alphaserv-master/release_build/src/luasql && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /home/bram/alphaserv-master/src/luasql/src/ls_mysql.c -o CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.s

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.requires:
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.requires

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.provides: src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.requires
	$(MAKE) -f src/luasql/CMakeFiles/luasql_mysql.dir/build.make src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.provides.build
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.provides

src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.provides.build: src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o

# Object files for target luasql_mysql
luasql_mysql_OBJECTS = \
"CMakeFiles/luasql_mysql.dir/src/luasql.c.o" \
"CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o"

# External object files for target luasql_mysql
luasql_mysql_EXTERNAL_OBJECTS =

src/luasql/libluasql_mysql.so: src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o
src/luasql/libluasql_mysql.so: src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o
src/luasql/libluasql_mysql.so: src/lua/src/liblua.so
src/luasql/libluasql_mysql.so: src/luasql/CMakeFiles/luasql_mysql.dir/build.make
src/luasql/libluasql_mysql.so: src/luasql/CMakeFiles/luasql_mysql.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C shared library libluasql_mysql.so"
	cd /home/bram/alphaserv-master/release_build/src/luasql && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/luasql_mysql.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/luasql/CMakeFiles/luasql_mysql.dir/build: src/luasql/libluasql_mysql.so
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/build

src/luasql/CMakeFiles/luasql_mysql.dir/requires: src/luasql/CMakeFiles/luasql_mysql.dir/src/luasql.c.o.requires
src/luasql/CMakeFiles/luasql_mysql.dir/requires: src/luasql/CMakeFiles/luasql_mysql.dir/src/ls_mysql.c.o.requires
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/requires

src/luasql/CMakeFiles/luasql_mysql.dir/clean:
	cd /home/bram/alphaserv-master/release_build/src/luasql && $(CMAKE_COMMAND) -P CMakeFiles/luasql_mysql.dir/cmake_clean.cmake
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/clean

src/luasql/CMakeFiles/luasql_mysql.dir/depend:
	cd /home/bram/alphaserv-master/release_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bram/alphaserv-master /home/bram/alphaserv-master/src/luasql /home/bram/alphaserv-master/release_build /home/bram/alphaserv-master/release_build/src/luasql /home/bram/alphaserv-master/release_build/src/luasql/CMakeFiles/luasql_mysql.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/luasql/CMakeFiles/luasql_mysql.dir/depend

