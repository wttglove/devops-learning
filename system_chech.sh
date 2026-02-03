#!/bin/bash

# variables
USER=$(whoami)
CURRENT_DIR=$(pwd)
DATE=$(date +"%Y-%m-%d %H:%M:%S")
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')
FILE_COUNT=$(ls -1 | wc -l)

#greetings
echo "====================="
echo " DevOps System Check"
echo "===================="
echo ""

#Information 
echo "User: $USER"
echo "Directory: $CURRENT_DIR"
echo "Date: $DATE"
echo "Disk usage: $DISK_USAGE"
echo "Files: $FILE_COUNT"
echo ""

#condition check disk usage
DISK_NUM=${DISK_USAGE%\%}

if [ $DISK_NUM -gt 80 ]; then
	echo "WARNING: Disk usage is HIGH!"
elif [ $DISK_NUM -gt 50 ]; then
	echo "WARNING: Disk usage is moderated"
else
	echo "OK: Disk usage is low"
fi

echo ""
echo "===================="

