cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(pegoat)

if(NOT MSVC)
    message(FATAL_ERROR "pegoat can only be built on Windows")
endif()

add_executable(pegoat goat.cpp)

# An executable with no stack guards.
add_executable(pegoat-no-gs goat.cpp)
target_compile_options(pegoat-no-gs PRIVATE "/GS-")

# An executable with no ASLR.
add_executable(pegoat-no-dynamicbase goat.cpp)
target_link_options(pegoat-no-dynamicbase PRIVATE "/DYNAMICBASE:NO")

# # An executable with INEFFECTIVE ASLR, as a fixed base address is specified.
# add_executable(pegoard-ineffective-dynamicbase goat.cpp)
# target_link_options(pegoard-ineffective-dynamicbase PRIVATE "/DYNAMICBASE" "/FIXED")

if("{CMAKE_VS_PLATFORM_NAME}" STREQUAL "x64")
    # An executable with ASLR, but not 64-bit aware ASLR.
    add_executable(pegoat-no-highentropyva goat.cpp)
    target_link_options(
        pegoat-no-highentropyva PRIVATE "/DYNAMICBASE" "/HIGHENTROPYVA:NO"
    )
endif()

# An executable without NX (a/k/a DEP, a/k/a W^X).
add_executable(pegoat-no-nxcompat goat.cpp)
target_link_options(pegoat-no-nxcompat PRIVATE "/NXCOMPAT:NO")

# An executable without Intel CET (hardware CFI) compatiblity.
add_executable(pegoat-no-cetcompat goat.cpp)
target_link_options(pegoat-no-cetcompat PRIVATE "/CETCOMPAT:NO")

# An executable without control flow guards.
add_executable(pegoat-no-cfg goat.cpp)
target_compile_options(pegoat-no-cfg PRIVATE "/GUARD:NO")

# An executable with INEFFECTIVE control flow guards, as ASLR is disabled.
add_executable(pegoat-ineffective-cfg-no-dynamicbase goat.cpp)
target_compile_options(pegoat-ineffective-cfg-no-dynamicbase PRIVATE "/GUARD:CF")
target_link_options(pegoat-ineffective-cfg-no-dynamicbase PRIVATE "/DYNAMICBASE:NO")

# An executable with no load-time integrity checks.
add_executable(pegoat-no-integritycheck goat.cpp)
target_compile_options(pegoat-no-integritycheck PRIVATE "/INTEGRITYCHECK:NO")

# An executable with safe structured exception handling disabled.
add_executable(pegoat-no-safeseh goat.cpp)
target_link_options(pegoat-no-safeseh PRIVATE "/SAFESEH:NO")
