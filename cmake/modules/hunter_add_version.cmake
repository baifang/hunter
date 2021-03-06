# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

include(CMakeParseArguments) # cmake_parse_arguments

include(hunter_internal_error)
include(hunter_status_debug)

# If 'HUNTER_<name>_VERSION' is equal to 'h_VERSION', then
# this function will set 'HUNTER_<name>_URL' and 'HUNTER_<name>_SHA1'.
function(hunter_add_version)
  set(h_one_value PACKAGE_NAME VERSION URL SHA1)
  cmake_parse_arguments(h "" "${h_one_value}" "" ${ARGV})
  if(h_UNPARSED_ARGUMENTS)
    hunter_internal_error("unexpected argument: ${h_UNPARSED_ARGUMENTS}")
  endif()
  if(NOT h_PACKAGE_NAME)
    hunter_internal_error("PACKAGE_NAME can't be empty")
  endif()
  if(NOT h_VERSION)
    hunter_internal_error("VERSION can't be empty")
  endif()
  if(NOT h_URL)
    hunter_internal_error("URL can't be empty")
  endif()
  if(NOT h_SHA1)
    hunter_internal_error("SHA1 can't be empty")
  endif()

  # update HUNTER_<name>_VERSIONS (list of available versions)
  set(h_versions "HUNTER_${h_PACKAGE_NAME}_VERSIONS")
  list(APPEND ${h_versions} ${h_VERSION})
  set(${h_versions} ${${h_versions}} PARENT_SCOPE)

  # check <NAME>_ROOT (if already set, then skip)
  string(TOUPPER ${h_PACKAGE_NAME} h_root)
  set(h_root "${h_root}_ROOT")
  string(COMPARE NOTEQUAL "${${h_root}}" "" root_not_empty)
  if(root_not_empty)
    hunter_status_debug("Skip '${h_VERSION}' (root is set)")
    return()
  endif()

  set(expected_version "HUNTER_${h_PACKAGE_NAME}_VERSION")
  string(COMPARE EQUAL "${${expected_version}}" "" version_is_empty)
  if(version_is_empty)
    hunter_internal_error(
        "Both <NAME>_ROOT and HUNTER_<name>_VERSION can't be empty "
        "(${h_PACKAGE_NAME})"
        "(probably `hunter_config(...)` missing in config.cmake)"
    )
  endif()
  string(COMPARE NOTEQUAL "${${expected_version}}" "${h_VERSION}" version_diff)
  if(version_diff)
    hunter_status_debug("Skip '${h_VERSION}' (not equal)")
    return()
  endif()

  # <NAME>_ROOT not set and HUNTER_<name>_VERSION found
  set(h_url_name "HUNTER_${h_PACKAGE_NAME}_URL")
  set(h_sha1_name "HUNTER_${h_PACKAGE_NAME}_SHA1")

  set(${h_url_name} "${h_URL}" PARENT_SCOPE)
  set(${h_sha1_name} "${h_SHA1}" PARENT_SCOPE)
endfunction()
