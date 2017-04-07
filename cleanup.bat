@ECHO OFF

SET wamp_dir=C:\wamp
SET forum_path=%wamp_dir%\www\dreamteam
SET upgrade_path=G:\Personal\dreamteam
SET forum_db_name=db1164312_dremteam
SET PATH=%PATH%;C:\wamp\bin\mysql\mysql5.6.17\bin;

echo %forum_db_name% upgrade tool.


CHOICE /C 1234C /M "phpbb Version ?1:=phpbb3.0.5, 2:=phpbb3.0.12, 3:=phpbb3.0.14, 4:=phpbb3.2.0, C:=Cancel"
IF ERRORLEVEL 5 GOTO StepTwo
IF ERRORLEVEL 4 GOTO LabelFour
IF ERRORLEVEL 3 GOTO LabelThree
IF ERRORLEVEL 2 GOTO LabelTwo
IF ERRORLEVEL 1 GOTO LabelOne

GOTO End

:LabelOne
SET src_file=%upgrade_path%\phpbb\phpbb3.0.5
goto DoCopy

:LabelTwo
SET src_file=%upgrade_path%\phpbb\phpbb3.0.12
goto DoCopy


:LabelThree
SET src_file=%upgrade_path%\phpbb\phpbb3.0.14
goto DoCopy

:LabelFour
SET src_file=%upgrade_path%\phpbb\phpbb3.2.0
goto DoCopy




:DoCopy
echo Cleaning "%forum_path%"

if exist %forum_path%\.git ATTRIB +H %forum_path%\.git

FOR /D %%i IN (%forum_path%\*) DO rmdir /S /Q %%i
 DEL /Q %forum_path%\*.*

echo Copying from %src_file%
xcopy /S %src_file% %forum_path% /E /Q

:StepTwo
CHOICE /C 123sC /M "Database?\n 1: 3.0.5, 2: 3.0.14, 3: 3.2.0, s: 3.0.14s, C: Cancel"
IF ERRORLEVEL 5 GOTO End
IF ERRORLEVEL 4 GOTO RestoreDatabaseS
IF ERRORLEVEL 3 GOTO RestoreDatabase3
IF ERRORLEVEL 2 GOTO RestoreDatabase2
IF ERRORLEVEL 1 GOTO RestoreDatabase1

GOTO End



:RestoreDatabase1
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_3.0.5.sql
goto ImportDB

:RestoreDatabase2
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_3.0.14.sql
goto ImportDB

:RestoreDatabase3
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_3.2.0.sql
goto ImportDB

:RestoreDatabaseS
SET forum_db_path=G:\Personal\dreamteam\database\%forum_db_name%_3.0.14s.sql
goto ImportDB

:ImportDB
if not exist %forum_db_path% (
  ECHO Database sql  file %forum_db_path% doesnot exist! 
  goto End
)
echo Cleaning MySQL for schema %forum_db_name% using %forum_db_path%
rem mysql -u root -p --execute="drop database %forum_db_name%"
mysql -uroot -p %forum_db_name% < %forum_db_path%


:End
echo Im done master.