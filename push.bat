@echo off

set /p commit_msg="请输入提交消息: "

git reset HEAD~1
git add .
git commit -m "%commit_msg%"
git push origin main

echo 提交并推送成功!
pause