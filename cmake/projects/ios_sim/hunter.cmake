# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_IOS_SIM_HUNTER_CMAKE)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_IOS_SIM_HUNTER_CMAKE 1)
endif()

include(hunter_add_version)
include(hunter_add_version_start)
include(hunter_download)
include(hunter_pick_scheme)

hunter_add_version_start(ios_sim)

hunter_add_version(
    PACKAGE_NAME
    ios_sim
    VERSION
    "1.8.2"
    URL
    "https://github.com/phonegap/ios-sim/archive/1.8.2.tar.gz"
    SHA1
    4328b3c8e6b455631d52b7ce5968170c9769eb1e
)

hunter_pick_scheme(DEFAULT url_sha1_ios_sim)
hunter_download(PACKAGE_NAME ios_sim)
