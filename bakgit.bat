

del lib\DL\service_acount.dart
rem check exist 
rem     git ls-remote git remote add master  https://github.com/JanRegent/QuoteBrowser
rem add remote
rem     git remote add master  https://github.com/JanRegent/QuoteBrowser

rem call backendPull.bat

call git add .
call git status
call git commit -m " %1---%2"
call git push origin main
