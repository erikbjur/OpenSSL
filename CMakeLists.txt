cmake_minimum_required(VERSION 3.15)
project(MyApp LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set default build type to Release if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Determine OpenSSL build output path based on platform
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    message(STATUS "Configuring OpenSSL for macOS")
    set(OPENSSL_ROOT "${CMAKE_SOURCE_DIR}/External/OpenSSL_Static_Library/build-macos")
elseif(WIN32)
    message(STATUS "Configuring OpenSSL for Windows")
    set(OPENSSL_ROOT "${CMAKE_SOURCE_DIR}/External/OpenSSL_Static_Library/build-windows")
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

# Add your main source file
add_executable(myapp src/main.cpp)

# Include OpenSSL headers
target_include_directories(myapp PRIVATE
    ${OPENSSL_ROOT}/include
)

# Link OpenSSL static libraries
target_link_directories(myapp PRIVATE
    ${OPENSSL_ROOT}/lib
)

target_link_libraries(myapp PRIVATE ssl crypto)
