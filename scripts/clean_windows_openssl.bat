@echo off
REM Set up MSVC environment
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

REM Navigate to OpenSSL source
cd /d "%~dp0..\External\OpenSSL_Static_Library\openssl"

REM Clean OpenSSL build files
nmake clean

REM Optionally remove the install directory
cd ..
rmdir /s /q build-windows