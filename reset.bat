@ECHO OFF

SET wamp_dir= C:\wamp
SET forum_dir=%wamp_dir%\www\dreamteam
SET fresh_copy=G:\Personal\dreamteam\live_fixed

CHOICE /M "Do you want a full cleanup?"
IF ERRORLEVEL 2 GOTO LabelWampCleanup
IF ERRORLEVEL 1 GOTO LabelFullCleanup

GOTO End

:LabelWampCleanup
ECHO Cleaning Wamp.
echo wamp dir : %wamp_dir%
echo forum dir : %forum_dir%
echo Fresh copy : %fresh_copy%
echo Removing %forum_dir%
rmdir /s %forum_dir%
mkdir %forum_dir%
xcopy %fresh_copy% %forum_dir% /q

GOTO End

:LabelFullCleanup
ECHO Cleaning Full system.
ECHO Cleaning Wamp.
echo wamp dir : %wamp_dir%
echo forum dir : %forum_dir%
echo Fresh copy : %fresh_copy%
echo Removing %forum_dir%
rmdir /s %forum_dir%
mkdir %forum_dir%
xcopy %fresh_copy% %forum_dir% /q

SET forum_db_name=db1164312_dremteam
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_clean.sql
SET PATH=%PATH%;C:\wamp\bin\mysql\mysql5.6.17\bin;

echo Cleaning MySQL for schema %forum_db_name%
mysql -uroot -p %forum_db_name% < %forum_db_path%
GOTO End

:End
echo This is the end.
