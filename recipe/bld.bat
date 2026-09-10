@echo on

if "%target_platform%"=="win-arm64" (
    set "GN_MSVC_MACHINE=ARM64"
) else (
    set "GN_MSVC_MACHINE=x64"
)
REM gn has no separate Windows build script differences; mirror the unix bootstrap.
python build/gen.py
if errorlevel 1 exit 1

ninja -C out
if errorlevel 1 exit 1

mkdir %PREFIX%\bin
copy out\gn.exe %PREFIX%\bin\gn.exe
if errorlevel 1 exit 1
