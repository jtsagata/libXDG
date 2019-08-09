cmake_minimum_required(VERSION 3.9)
project("libXDG"
        VERSION 0.0.1
        DESCRIPTION "XDG_BASE utilities"
        HOMEPAGE_URL "https://github.com/jtsagata/libXDG"
        LANGUAGES CXX
        )

set(PROJECT_BUGS ${PROJECT_HOMEPAGE_URL}/issues)
set(TRANSLATION_DOMAIN xdg)


set(PROJECT_BUGS ${PROJECT_HOMEPAGE_URL}/issues)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/support/cmake)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/support/cmake/sanitizers")

find_program(CCACHE_PROGRAM ccache)
if (CCACHE_PROGRAM)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif ()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(GNUInstallDirs)
include(Depedencies)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost 1.65 REQUIRED COMPONENTS filesystem)
message(STATUS "Boost version: ${Boost_VERSION}")

# Enable LTO
if (CMAKE_BUILD_TYPE STREQUAL "Release")
  set_property(GLOBAL PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
endif ()


if (MSVC)
  add_compile_options(/W4 /WX)
else()
  add_compile_options(-Wall -Wextra -pedantic -Werror)
endif()


add_subdirectory(src)
add_subdirectory(test)
add_subdirectory(translations)
