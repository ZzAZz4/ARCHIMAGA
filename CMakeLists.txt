cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    archimaga
    VERSION 0.1.0
    DESCRIPTION "Gracias Jesus Edwin Bellido Angulo."
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    archimaga_archimaga
    source/archimaga.cpp
)
add_library(archimaga::archimaga ALIAS archimaga_archimaga)

include(GenerateExportHeader)
generate_export_header(
    archimaga_archimaga
    BASE_NAME archimaga
    EXPORT_FILE_NAME export/archimaga/archimaga_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(archimaga_archimaga PUBLIC ARCHIMAGA_STATIC_DEFINE)
endif()

set_target_properties(
    archimaga_archimaga PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME archimaga
    OUTPUT_NAME archimaga
)

target_include_directories(
    archimaga_archimaga ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    archimaga_archimaga SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(archimaga_archimaga PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(archimaga_archimaga PRIVATE fmt::fmt)

find_package(SDL2 REQUIRED)
target_link_libraries(archimaga_archimaga PRIVATE 
    $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
    $<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>)

find_package(imgui CONFIG REQUIRED)
target_link_libraries(archimaga_archimaga PRIVATE imgui::imgui)
# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${archimaga_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT archimaga_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of archimaga"
  )
endif()

include(cmake/dev-mode.cmake)
