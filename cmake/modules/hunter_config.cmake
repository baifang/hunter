# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

include(CMakeParseArguments) # cmake_parse_arguments

include(hunter_internal_error)
include(hunter_unsetvar)

# internal variables: _hunter_c_*
macro(hunter_config)
  set(_hunter_c_one_value VERSION CUSTOM)
  set(_hunter_c_multiple_values CMAKE_ARGS)
  cmake_parse_arguments(
      _hunter_c
      ""
      "${_hunter_c_one_value}"
      "${_hunter_c_multiple_values}"
      ${ARGV}
  )
  list(LENGTH _hunter_c_UNPARSED_ARGUMENTS _hunter_c_len)
  if(NOT ${_hunter_c_len} EQUAL 1)
    hunter_internal_error("unparsed: ${_hunter_c_UNPARSED_ARGUMENTS}")
  endif()

  # calc <NAME>_ROOT
  list(GET _hunter_c_UNPARSED_ARGUMENTS 0 _hunter_c_current_project)
  string(TOUPPER "${_hunter_c_current_project}" _hunter_c_root)
  set(_hunter_c_root "${_hunter_c_root}_ROOT")

  # clear all
  hunter_unsetvar(${_hunter_c_root})
  unset(ENV{_hunter_c_root})

  if(_hunter_c_CUSTOM)
    set(${_hunter_c_root} "${_hunter_c_CUSTOM}")
    set(ENV{${_hunter_c_root}} "${${_hunter_c_root}}")
    hunter_status_print(
        "Custom location ${_hunter_c_root}: ${${_hunter_c_root}}"
    )
  elseif(_hunter_c_VERSION)
    set(HUNTER_${_hunter_c_current_project}_VERSION ${_hunter_c_VERSION})
    set(HUNTER_${_hunter_c_current_project}_CMAKE_ARGS ${_hunter_c_CMAKE_ARGS})
  else()
    hunter_internal_error("Expected VERSION or CUSTOM")
  endif()
endmacro()
