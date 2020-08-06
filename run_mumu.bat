adb kill-server
adb start-server
taskkill /F /T /IM NemuPlayer.exe
taskkill /F /T /IM NemuHeadless.exe
start cmd /c "D:\Program Files (x86)\MuMu\emulator\nemu\EmulatorShell\NemuPlayer.exe"
timeout /T 1200
taskkill /F /T /IM NemuPlayer.exe
taskkill /F /T /IM NemuHeadless.exe
rem pause