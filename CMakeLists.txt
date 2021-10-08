CMAKE_MINIMUM_REQUIRED(VERSION 3.19)

project(format_demo
    VERSION 1.0.0
    LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(main apps/main.cpp)
target_link_libraries(main ${CONAN_LIBS})