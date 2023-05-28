@echo off

set /p username=Enter your Git username:
set /p password=Enter your Git password:

git config --global user.name %username%
git config --global user.password %password%

echo Git login successful!

pause