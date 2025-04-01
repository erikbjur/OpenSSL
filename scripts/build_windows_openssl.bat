@echo off
set OPENSSL_NO_INSTALL_PATHS=1
REM Set up MSVC environment
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

REM Get absolute path to the intended install folder (build-windows)
pushd "%~dp0..\External\OpenSSL_Static_Library\build-windows"
set BUILD_INSTALL_PATH=%CD%
popd

REM Navigate to OpenSSL source directory
cd /d "%~dp0..\External\OpenSSL_Static_Library\openssl"

REM Clean previous configuration
perl Configure clean

REM Configure OpenSSL for 64-bit static build, install to the correct path
perl Configure VC-WIN64A no-shared --prefix="%BUILD_INSTALL_PATH%"

REM Build and install
nmake
nmake install
