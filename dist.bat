
rmdir /S /Q dist\game
del dist\game.love

mkdir dist\game

xcopy game\* dist\game\ /E

xcopy love\*.dll dist\game\

cd dist\game
"%programfiles%\7-Zip\7z" a -tzip ..\game.love *
cd ..\..


copy /b love\love.exe+dist\game.love dist\growth-eon.exe
