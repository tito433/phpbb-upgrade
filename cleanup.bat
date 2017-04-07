@ECHO OFF

SET wamp_dir=C:\wamp
SET forum_path=%wamp_dir%\www\dreamteam
SET upgrade_path=G:\Personal\dreamteam
SET forum_db_name=db1164312_dremteam
SET PATH=%PATH%;C:\wamp\bin\mysql\mysql5.6.17\bin;

set forver=0.5
set /p forver=File version phpbb3.0.5?:
SET src_file=%upgrade_path%\phpbb\phpbb3.%forver%

if not exist %src_file% goto StepTwo

echo Cleaning "%forum_path%"

if exist %forum_path%\.git ATTRIB +H %forum_path%\.git

FOR /D %%i IN (%forum_path%\*) DO rmdir /S /Q %%i
 DEL /Q %forum_path%\*.*

echo Copying from %src_file%
xcopy /S %src_file% %forum_path% /E /Q



:StepTwo

set dbver=%forver%
set /p dbver=Database version %forum_db_name%_3.%dbver%?:
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_3.%dbver%.sql

if not exist %forum_db_path% goto  End

:ImportDB
echo Importing schema using %forum_db_path%
rem mysql -u root -p --execute="drop database %forum_db_name%"
mysql -uroot -p %forum_db_name% < %forum_db_path%

:End
echo Im done master.