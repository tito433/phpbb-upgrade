@ECHO OFF

SET wamp_dir= C:\wamp
SET forum_old=%wamp_dir%\www\dreamteam
SET forum_new=%wamp_dir%\www\phpbb32
SET copy_old=G:\Personal\dreamteam\live_fixed
SET copy_new=G:\Personal\dreamteam\phpbb32


ECHO Cleaning Wamp.
echo wamp dir : %wamp_dir%
echo Old Forum : %forum_old%
echo Copy Old : %copy_old%
xcopy %copy_old% %forum_old% /E /Q


echo New Forum : %forum_new%
echo Copy New : %copy_new%
xcopy %copy_new% %forum_new% /E /Q


CHOICE /M "Do you want a database restore?"
IF ERRORLEVEL 2 GOTO End
IF ERRORLEVEL 1 GOTO RestoreDatabase

GOTO End

:RestoreDatabase

SET forum_db_name=db1164312_dremteam
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_clean.sql
SET PATH=%PATH%;C:\wamp\bin\mysql\mysql5.6.17\bin;

echo Cleaning MySQL for schema %forum_db_name%
mysql -uroot -p %forum_db_name% < %forum_db_path%

:End
echo This is the end.
