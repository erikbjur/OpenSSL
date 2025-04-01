@echo off
setlocal

REM Set the path to the ARM64 developer environment setup script
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsarm64.bat"

REM Ensure we're in the script directory
cd /d "%~dp0"

REM Create install directory if it doesn't exist
if not exist "..\External\OpenSSL_Static_Library\build-windows" (
    mkdir "..\External\OpenSSL_Static_Library\build-windows"
)

REM Get absolute install path
pushd "..\External\OpenSSL_Static_Library\build-windows"
set BUILD_INSTALL_PATH=%CD%
popd


REM Change to OpenSSL source dir
cd ..\External\OpenSSL_Static_Library\openssl

REM Clean previous builds (optional)
perl Configure clean

set OPENSSL_NO_INSTALL_PATHS=1

REM Configure and build OpenSSL for ARM64
perl Configure VC-WIN64-ARM no-shared --prefix="%BUILD_INSTALL_PATH%"
nmake
nmake install

echo [INFO] OpenSSL ARM64 build complete!
