
rmdir /S /Q dist\game
del dist\game.love

mkdir dist\game

xcopy game\* dist\game\ /E

cd dist\game
"%programfiles%\7-Zip\7z" a -tzip ..\game.love *
cd ..\..

mkdir dist\growth-eon
copy /b love\love.exe+dist\game.love dist\growth-eon\growth-eon.exe


xcopy love\*.dll dist\growth-eon\

cd dist

"%programfiles%\7-Zip\7z" a -tzip growth-eon.zip growth-eon\*
pause