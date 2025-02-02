@echo off
set "mingwInstallerUrl=https://osdn.net/frs/redir.php?m=constant&f=mingw%%2FInstaller%%2Fmingw-get-setup.exe"
set "mingwPath=C:\MinGW"
set "installerPath=%USERPROFILE%\Downloads\mingw-get-setup.exe"

echo Downloading MinGW installer...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%mingwInstallerUrl%', '%installerPath%')"

echo Running MinGW installer...
start /wait "" "%installerPath%" /S

set "mingwGet=%mingwPath%\bin\mingw-get.exe"
if exist "%mingwGet%" (
    echo Updating MinGW package list...
    start /wait "" "%mingwGet%" update

    echo Installing gcc and g++...
    start /wait "" "%mingwGet%" install gcc g++
) else (
    echo mingw-get.exe not found! Installation might have failed.
)

echo Adding MinGW to system PATH...
setx Path "%Path%;%mingwPath%\bin" /M

echo Installation completed! Please restart your terminal or system for changes to take effect.
pause
