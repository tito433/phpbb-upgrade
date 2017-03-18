@ECHO OFF

SET wamp_dir= C:\wamp
SET forum_path=%wamp_dir%\www\dreamteam

SET upgrade_path=G:\Personal\dreamteam


echo bddreamteam phpbb upgrade tool.

rem save .git folder
:uniqLoop
set "temp_folder=%tmp%\git~%RANDOM%"
if exist "%temp_folder%" goto :uniqLoop


echo I will save in %temp_folder%
mkdir %temp_folder%
xcopy %forum_path%\.git %temp_folder% /E /Q


