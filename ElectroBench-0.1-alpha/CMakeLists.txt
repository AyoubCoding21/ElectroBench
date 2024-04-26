cmake_minimum_required(VERSION 3.12)
project(ElectroBench)

find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)
find_package(GLEW REQUIRED)
set(SOURCES src/main.cxx)
add_executable(ElectroBench ${SOURCES})
target_include_directories(ElectroBench PRIVATE ${OPENGL_INCLUDE_DIRS} ${GLUT_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS})
target_link_libraries(ElectroBench PRIVATE ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES} ${GLEW_LIBRARIES})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -v")
set(CMAKE_CXX_COMPILER "clang++")
