#!/bin/bash
set -e
userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "ERROR you dont have root permissions plese switch to root user"
    exit 1
else
    echo "you have a root access proceed now"
fi

dnf module disable nginx -y
echo "disable default nginx"
dnf module enable nginx:1.24 -y
echo "enable nginx:1.24"
dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed.....going to be installed"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then
       echo "nginx is installed.....successuflly"
    else
        echo "nginx is installation.....failure"
    fi
else
    echo "nginx is already installed.....nothing to change"
fi
systemctl enable nginx
echo "enable nginx"
systemctl start nginx
echo "start nginx"

rm -rf /usr/share/nginx/html/* 
echo "remove default nginx content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
echo "download the frontend code"
cd /usr/share/nginx/html 
echo "open html file"
unzip /tmp/frontend.zip
echo "unzip the frontend code here"

cp /home/ec2-user/shell-roboshop/nginx.conf /etc/nginx/nginx.conf
systemctl restart nginx 
