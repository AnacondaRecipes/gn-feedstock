@echo on

python build/gen.py --no-static-libstdc++ --allow-warnings
if errorlevel 1 exit 1

ninja -C out
if errorlevel 1 exit 1

mkdir %PREFIX%\bin

echo "Copying Binaries"
copy out\gn.exe %PREFIX%\bin\gn.exe
if errorlevel 1 exit 1
