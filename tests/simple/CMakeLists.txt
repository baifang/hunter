# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

include("../common.cmake")

set(HUNTER_Foo_VERSION "")
hunter_config(Foo VERSION 1.2.3)

string(COMPARE EQUAL "${HUNTER_Foo_VERSION}" "1.2.3" is_correct)
if(NOT is_correct)
  message(FATAL_ERROR "Expected HUNTER_Foo_VERSION == 1.2.3")
endif()
