@echo on

REM gn has no separate Windows build script differences; mirror the unix bootstrap.
python build/gen.py
if errorlevel 1 exit 1

ninja -C out
if errorlevel 1 exit 1

mkdir %PREFIX%\bin
copy out\gn.exe %PREFIX%\bin\gn.exe
if errorlevel 1 exit 1
