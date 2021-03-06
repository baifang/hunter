# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_SOBER_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_SOBER_HUNTER_CMAKE_ 1)
endif()

include(hunter_add_package)
include(hunter_add_version)
include(hunter_add_version_start)
include(hunter_download)
include(hunter_pick_scheme)

# Dependencies
hunter_add_package(CppNetlibUri)
hunter_add_package(JsonSpirit)
hunter_add_package(Leathers)
hunter_add_package(Sugar)
# -- end

hunter_add_version_start(Sober)

hunter_add_version(
    PACKAGE_NAME
    Sober
    VERSION
    "0.0.1"
    URL
    "https://github.com/ruslo/sober/archive/v0.0.1.tar.gz"
    SHA1
    326987c0807ff7e8caa851476bbd57d0d01604e0
)

hunter_add_version(
    PACKAGE_NAME
    Sober
    VERSION
    "0.0.2"
    URL
    "https://github.com/ruslo/sober/archive/v0.0.2.tar.gz"
    SHA1
    5c0b9ed42f897376610d5b97860c479024b9207d
)

hunter_add_version(
    PACKAGE_NAME
    Sober
    VERSION
    "0.1.0"
    URL
    "https://github.com/ruslo/sober/archive/v0.1.0.tar.gz"
    SHA1
    17aaf1236bb914bf3d93dc1d132ee18a6130288f
)

hunter_pick_scheme(
     DEFAULT
     url_sha1_release_debug
     COMBINED
     url_sha1_combined_release_debug
)

hunter_download(PACKAGE_NAME Sober)
