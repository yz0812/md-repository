#!/bin/bash

read -p "请输入提交消息: " commit_msg

# 撤销最近一次的commit
git reset HEAD~1
git add .
git commit -m "$commit_msg"
git push origin main

echo "提交并推送成功!"
read -p "Press [Enter] key to continue..."
