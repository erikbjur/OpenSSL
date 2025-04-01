@echo off
setlocal

REM Load the x64 developer environment
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

REM Ensure we're in the script directory
cd /d "%~dp0"

REM Change to OpenSSL source dir
cd ..\External\OpenSSL_Static_Library\openssl

REM Run OpenSSL clean
nmake clean

REM Remove the install directory if it exists
cd ..
if exist build-windows (
    echo [INFO] Deleting build-windows directory...
    rmdir /s /q build-windows
)

echo [INFO] OpenSSL x64 clean complete!
