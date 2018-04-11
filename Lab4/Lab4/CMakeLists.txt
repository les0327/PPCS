# CMakeList.txt : CMake project for Lab4, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES Lab4.cpp functions.cpp functions.h)
add_executable(Lab4 Lab4.cpp functions.cpp functions.h)

# added -fopenmp
find_package(OpenMP)
if (OPENMP_FOUND) 
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()

# TODO: Add tests and install targets if needed.
