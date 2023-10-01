cmake_minimum_required(VERSION 3.2)
project(
    Nebula
    VERSION 0.1.0
    LANGUAGES CXX
)

# Generate a compile_commands.json for tooling
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()


add_executable(Nebula "src/star.cpp")