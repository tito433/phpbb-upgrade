@ECHO OFF

SET wamp_dir=C:\wamp
SET forum_path=%wamp_dir%\www\dreamteam

SET upgrade_path=G:\Personal\dreamteam


echo bddreamteam phpbb upgrade tool.

rem save .git folder
:uniqLoop
set "temp_folder=%tmp%\git~%RANDOM%"
if exist "%temp_folder%" goto :uniqLoop

echo Git backup is %temp_folder%
mkdir %temp_folder%
xcopy %forum_path%\.git %temp_folder% /E /Q



CHOICE /C 123C /M "Forum source ?1:=live, 2:=phpbb3.0.14, 3:=phpbb3.2, C:=Cancel"
IF ERRORLEVEL 4 GOTO StepTwo
IF ERRORLEVEL 3 GOTO LabelThree
IF ERRORLEVEL 2 GOTO LabelTwo
IF ERRORLEVEL 1 GOTO LabelOne

GOTO End

:LabelThree
SET src_file=%upgrade_path%\phpbb3.2
goto DoCopy

:LabelTwo
SET src_file=%upgrade_path%\phpbb3.0.14
goto DoCopy

:LabelOne
SET src_file=%upgrade_path%\live
goto DoCopy


:DoCopy
echo Cleaning "%forum_path%"
pushd %forum_path%
del /s /q .
popd
echo Copying from %src_file%
xcopy /S %src_file% %forum_path% /E /Q
echo Restore Git %temp_folder%
xcopy /S %temp_folder% %forum_path%\.git\ /E /Q

:StepTwo
CHOICE /M "Database restore?"
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
echo Im done master.