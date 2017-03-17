@ECHO OFF

SET wamp_dir= C:\wamp
SET forum_path=%wamp_dir%\www\dreamteam

SET upgrade_path=G:\Personal\dreamteam\


echo Upgradation assist tool

CHOICE /C 123C /M "Please select file source. 1:=live, 2:=phpbb3.0.14, 3:=phpbb3.2, C:=Cancel"
IF ERRORLEVEL 4 GOTO End
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
echo Copying:%src_file% 
xcopy /s/y %src_file% %forum_path% /E /Q


:End
echo Im done master.