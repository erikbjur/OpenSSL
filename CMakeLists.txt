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
    set(OPENSSL_SSL_LIB "${OPENSSL_ROOT}/lib/libssl.a")
    set(OPENSSL_CRYPTO_LIB "${OPENSSL_ROOT}/lib/libcrypto.a")
elseif(WIN32)
    message(STATUS "Configuring OpenSSL for Windows")
    set(OPENSSL_ROOT "${CMAKE_SOURCE_DIR}/External/OpenSSL_Static_Library/build-windows")
    set(OPENSSL_SSL_LIB "${OPENSSL_ROOT}/lib/libssl.lib")
    set(OPENSSL_CRYPTO_LIB "${OPENSSL_ROOT}/lib/libcrypto.lib")
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

# Declare OpenSSL static libraries as imported targets
add_library(OpenSSL::SSL STATIC IMPORTED)
add_library(OpenSSL::Crypto STATIC IMPORTED)

set_target_properties(OpenSSL::SSL PROPERTIES
    IMPORTED_LOCATION "${OPENSSL_SSL_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_ROOT}/include"
)

set_target_properties(OpenSSL::Crypto PROPERTIES
    IMPORTED_LOCATION "${OPENSSL_CRYPTO_LIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_ROOT}/include"
)

# Add your main source file
add_executable(myapp src/main.cpp)

# Link to OpenSSL imported targets
target_link_libraries(myapp
    PRIVATE
        OpenSSL::SSL
        OpenSSL::Crypto
)

if(WIN32)
    target_link_libraries(myapp
    PRIVATE
        ws2_32
        crypt32
    )
endif()

# Define OPENSSL_STATIC (optional but useful)
target_compile_definitions(myapp PRIVATE OPENSSL_STATIC)
