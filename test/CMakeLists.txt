cmake_minimum_required(VERSION 3.14)

project(archimagaTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(archimaga REQUIRED)
  enable_testing()
endif()

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(archimaga_test source/archimaga_test.cpp)
target_link_libraries(
    archimaga_test PRIVATE
    archimaga::archimaga
    Catch2::Catch2WithMain
)
target_compile_features(archimaga_test PRIVATE cxx_std_17)

catch_discover_tests(archimaga_test)

# ---- End-of-file commands ----

add_folders(Test)
