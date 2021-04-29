#!/usr/bin/cmake -P

execute_process(COMMAND ${CMAKE_COMMAND} -E remove -f CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory cmake)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory test)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory src)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_LIST_DIR}/cmake cmake)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_LIST_DIR}/test test)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_LIST_DIR}/src src)

file(DOWNLOAD https://raw.githubusercontent.com/cpp-pm/gate/master/cmake/HunterGate.cmake cmake/HunterGate.cmake)

file(DOWNLOAD https://github.com/cpp-pm/hunter/releases/latest ./hunterversion.txt)
file(READ hunterversion.txt HTML_CONTENT)
string(REGEX MATCH "https://github.com/cpp-pm/hunter/archive/v.........tar.gz" HUNTER_URL "${HTML_CONTENT}")
string(REGEX MATCH ">\"........................................\"<" HUNTER_SHA1 "${HTML_CONTENT}")
string(REPLACE ">\"" "" HUNTER_SHA1 "${HUNTER_SHA1}")
string(REPLACE "\"<" "" HUNTER_SHA1 "${HUNTER_SHA1}")
message(STATUS ${HUNTER_URL})
message(STATUS ${HUNTER_SHA1})

execute_process(COMMAND ${CMAKE_COMMAND} -E remove -f hunterversion.txt)

configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt.in CMakeLists.txt @ONLY)
