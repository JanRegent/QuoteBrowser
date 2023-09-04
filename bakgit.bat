

@echo off
echo %DATE%
echo %TIME%
set datetimef=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_build
echo %datetimef%

rem check exist 
rem     git ls-remote git remote add master  https://github.com/JanRegent/QuoteBrowser
rem add remote
rem     git remote add master  https://github.com/JanRegent/QuoteBrowser

rem call backendPull.bat

copy "String buildDate = '" + datetimef + "';"  > lib/DL/build.dart

call git add .
call git status
call git commit -m " %1---%2"
call git push origin main
