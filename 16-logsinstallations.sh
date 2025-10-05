#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)"
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

dnf list installed mysql $>>$LOG_FILE
# Install if not found
if [ $? -ne 0 ]; then
    dnf install mysql -y $>>$LOG_FILE
    VALIDATE $? "Mysql"
else
    echo -e " Mysql already exist ... $Y SKIPPING $N"
fi

dnf list installed nginx $>>$LOG_FILE
# Install if not found
if [ $? -ne 0 ]; then
    dnf install nginx -y $>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e " nginx already exist ... $Y SKIPPING $N"
fi

dnf list installed python3 $>>$LOG_FILE
# Install if not found
if [ $? -ne 0 ]; then
    dnf install python3 -y $>>$LOG_FILE
    VALIDATE $? "python3"
else 
    echo -e "Python3  already exist ... $Y SKIPPING $N"
fi