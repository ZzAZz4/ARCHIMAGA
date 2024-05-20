if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/archimaga-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package archimaga)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT archimaga_Development
)

install(
    TARGETS archimaga_archimaga
    EXPORT archimagaTargets
    RUNTIME #
    COMPONENT archimaga_Runtime
    LIBRARY #
    COMPONENT archimaga_Runtime
    NAMELINK_COMPONENT archimaga_Development
    ARCHIVE #
    COMPONENT archimaga_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    archimaga_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE archimaga_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(archimaga_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${archimaga_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT archimaga_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${archimaga_INSTALL_CMAKEDIR}"
    COMPONENT archimaga_Development
)

install(
    EXPORT archimagaTargets
    NAMESPACE archimaga::
    DESTINATION "${archimaga_INSTALL_CMAKEDIR}"
    COMPONENT archimaga_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
