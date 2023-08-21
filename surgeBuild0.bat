
rem once copy assets/ web/assets/

xcopy .gitIgnor\quotebrowser23_credentials.dart    lib\DL\credentials.dart   /y
xcopy .gitIgnor\quotebrowser23_spreadsheets.dart   lib\DL\spreadsheets.dart  /y
call .\surgebuild.bat quotebrowser23 





