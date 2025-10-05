#!/bin/bash
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi
VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 is .. $R FAILED $N"
        exit 1 # failure is other than 0
    else
         echo -e " Installing $2 is $G success $N"  
    fi
}

dnf list installed mysql
# Install if not found
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "Mysql"
else
    echo -e " Mysql already exist ... $Y SKIPPING $N"
fi

dnf list installed nginx
# Install if not found
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e " nginx already exist ... $Y SKIPPING $N"
fi

dnf list installed python3
# Install if not found
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? "python3"
else 
    echo -e "Python3  already exist ... $Y SKIPPING $N"
fi