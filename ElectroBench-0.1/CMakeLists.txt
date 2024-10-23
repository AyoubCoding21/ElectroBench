cmake_minimum_required(VERSION 3.12)
project(ElectroBench)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/conan/deb")
find_package(glew)
find_package(SDL2)
find_package(opengl_system)

set(SOURCES src/main.cxx)
add_executable(ElectroBench ${SOURCES})
target_include_directories(ElectroBench PRIVATE ${OPENGL_INCLUDE_DIRS} ${GLUT_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS})


# Need to use the Conan targets instead
target_link_libraries(ElectroBench
 PRIVATE
  SDL2::SDL2main
  GLEW::GLEW
  opengl::opengl
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -v")
set(CMAKE_C_COMPILER "clang")
