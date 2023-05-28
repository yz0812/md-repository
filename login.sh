#!/bin/bash

read -p "Enter your Git username: " username
read -s -p "Enter your Git password: " password
echo

git config --global user.name $username
git config --global user.password $password

echo "Git login successful!"
read -p "Press [Enter] key to continue..."