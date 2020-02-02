@echo off
::chcp of your country
::chcp вашей страны
chcp 850
::Path to the pw3i.exe, for example C:\pw3i 1.02\pw3i.exe (without quotes)
::Путь к pw3i.exe, например C:\pw3i 1.02\pw3i.exe (без кавычек)
set pw3i=C:\pw3i 1.02\pw3i.exe
::Path to the folder with maps, for example C:\maps (without quotes and without a slash at the end)
::Путь к папке с картами, например C:\maps (без кавычек и без слеша в конце)
set DirMap=C:\maps
::Path to the folder with the output of the result, for example C:\maps\data (without quotes and without a slash at the end)
::Путь к папке с выводом результата, например C:\maps\data (без кавычек и без слеша в конце)
set DirRes=C:\maps\data

echo pw3i Batcher 1.0
echo 1 - English, 2 - Russian
Set /p lang=""
if NOT %lang%==1 if NOT %lang%==2 exit
if "%lang%"=="1" echo 1 - Current Dir, 2 - Specified Folder
if "%lang%"=="2" echo 1 - Текущая папка, 2 - Заданная папка
Set /p curdir=""
if "%curdir%"=="1" (set DirMap=%CD%)
if "%curdir%"=="1" (set DirRes=%DirMap%\data)
if NOT %curdir%==1 if NOT %curdir%==2 exit
::File filter (w3x w3m mpq)
::Фильтр файлов (w3x w3m mpq)
set Filter="%DirMap%\*.w3x" "%DirMap%\*.w3m" "%DirMap%\*.mpq"
cls
if "%lang%"=="1" echo pw3i Batcher - Batch metadata parser from w3x w3m (from war3map.w3i war3map.wts)
if "%lang%"=="2" echo pw3i Batcher - Пакетный парсер w3x w3m метаданных (из war3map.w3i war3map.wts)
echo by Firstrun70
if "%lang%"=="1" echo v1.0 [12.25.2019]
if "%lang%"=="2" echo v1.0 [25.12.2019]
if "%lang%"=="1" echo Requires pw3i.exe v1.02
if "%lang%"=="2" echo Требуется pw3i.exe v1.02
if "%lang%"=="1" if "%curdir%"=="1" (echo Before starting this file, specify one folder set pw3i= and chcp of your country at the beginning of this file ^(via Notepad^))
if "%lang%"=="1" if "%curdir%"=="2" (echo Before starting this file, specify three folders and chcp of your country at the beginning of this file ^(via Notepad^))
if "%lang%"=="2" if "%curdir%"=="1" (echo Перед запуском этого файла укажите одну папку set pw3i= и chcp вашей страны в начале этого файла ^(через Блокнот^))
if "%lang%"=="2" if "%curdir%"=="2" (echo Перед запуском этого файла укажите три папки и chcp вашей страны в начале этого файла ^(через Блокнот^))
echo.
if "%lang%"=="1" echo Settings:
if "%lang%"=="2" echo Настройки:
chcp
if "%lang%"=="1" echo pw3i=%pw3i% (path to pw3i.exe)
if "%lang%"=="2" echo pw3i=%pw3i% (путь к pw3i.exe)
if "%lang%"=="1" echo DirMap=%DirMap% (folder with maps)
if "%lang%"=="2" echo DirMap=%DirMap% (папка с картами)
if "%lang%"=="1" echo DirRes=%DirRes% (folder with result)
if "%lang%"=="2" echo DirRes=%DirRes% (папка результата)
if "%lang%"=="1" call echo Filter=%%Filter:%DirMap%\=%% (file filter)
if "%lang%"=="2" call echo Filter=%%Filter:%DirMap%\=%% (фильтр файлов)
echo.
if "%lang%"=="1" echo Choose a work method:
if "%lang%"=="2" echo Выберите метод работы:
if "%lang%"=="1" echo 1 - Export to one folder. Map-like file names: map.txt
if "%lang%"=="2" echo 1 - Экспорт в одну папку. Имена файлов как у карт: map.txt
if "%lang%"=="1" echo 2 - Export to different folders. Folder names like maps. Original file names: output.txt
if "%lang%"=="2" echo 2 - Экспорт в разные папки. Имена папок как у карт. Имена файлов оригинальные: output.txt
if "%lang%"=="1" Set /p choice="Your choice (1 or 2, then Enter): "
if "%lang%"=="2" Set /p choice="Ваш выбор (1 или 2, потом Enter): "
goto ch

:ch
If Not Exist "%DirRes%" md "%DirRes%"
if "%choice%"=="1" (goto v1)
if "%choice%"=="2" (goto v2)
if "%choice%"=="11" (goto ver11)
if "%choice%"=="12" (goto ver12)
if "%choice%"=="13" (goto ver13)
if "%choice%"=="21" (goto ver21)
if "%choice%"=="22" (goto ver22)
if "%choice%"=="23" (goto ver23)
exit

:v1
:ver11
for %%F in (%Filter%) do (
set "ff=%%F" & set "ffn=%%~nF" & set "ffx=%%~xF"
setlocal EnableDelayedExpansion
echo "!ff!" "!DirRes!\!ffn!_!ffx:~1,3!.txt" 
"!pw3i!" "!ff!" 
move "!CD!\output.txt" "!DirRes!\!ffn!!ffx:.=_!.txt"
endlocal
)
@goto end
:ver12
@cmd /v/c "for %%F in (%Filter%) do @( "%pw3i%" "%%F" & set "n=%%~nF" & set "x=%%~xF" & set "nx=!n!!x:.=_!" & echo "%%F" "%DirRes%\!nx!.txt" & move "%CD%\output.txt" "%DirRes%\!nx!.txt")"
@goto end
:ver13
@cmd /v/c "for %%F in (%Filter%) do @( "%pw3i%" "%%F" & set "Ext=%%~xF" & call echo %date% %time% "%%F" "%DirRes%\%%~nF_%%Ext:~1%%.txt" & call move "%CD%\output.txt" "%DirRes%\%%~nF_%%Ext:~1%%.txt")"
@goto end

:v2
:ver21
for %%F in (%Filter%) do (
set "ff=%%F" & set "ffn=%%~nF" & set "ffx=%%~xF"
setlocal EnableDelayedExpansion
set folder=!ffn!!ffx:.=_!
echo "!ff!" "!DirRes!\!folder!\output.txt"
If Not Exist "!DirRes!\!folder!" md "!DirRes!\!folder!"
"!pw3i!" "!ff!" 
move "!CD!\output.txt" "!DirRes!\!folder!\output.txt"
endlocal
)
@goto end
:ver22
@cmd /v/c "for %%F in (%Filter%) do @( "%pw3i%" "%%F" & set "n=%%~nF" & set "x=%%~xF" & set "nx=!n!!x:.=_!" & echo "%%F" "%DirRes%\!nx!\output.txt" & md "%DirRes%\!nx!" & move "%CD%\output.txt" "%DirRes%\!nx!\output.txt")"
@goto end
:ver23
@cmd /v/c "for %%F in (%Filter%) do @( "%pw3i%" "%%F" & set "Ext=%%~xF" & call echo %date% %time% "%%F" "%DirRes%\%%~nF_%%Ext:~1%%\output.txt" & call md "%DirRes%\%%~nF_%%Ext:~1%%" & call move "%CD%\output.txt" "%DirRes%\%%~nF_%%Ext:~1%%\output.txt")"
@goto end

:end
@pause