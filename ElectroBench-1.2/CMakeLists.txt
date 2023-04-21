cmake_minimum_required(VERSION 3.10)


project(ElectroBench)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 11)

find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

include_directories(${OPENGL_INCLUDE_DIRS} ${GLUT_INCLUDE_DIRS})

add_executable(ElectroBench src/main.cxx)

target_link_libraries(ElectroBench
    ${OPENGL_LIBRARIES}
    ${GLUT_LIBRARY}
    GLEW
    X11
    glut
    OpenGL::GL

)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mlong-double-128 -v")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mlong-double-128 -v")

