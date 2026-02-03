#!/bin/bash

echo "===================="
echo "File Analyzer"
echo "===================="
echo "" 

echo "Files in current directory"
echo ""

for file in *; do
	if [ -f "$file" ]; then
		size=$(du -h "$file" | awk '{print $1}')
		echo "$file -Size: $size"
	elif [ -d "$file" ]; then
		echo "$file - (directory)"
	fi
done

echo ""
echo "===================="
echo "Checking .sh files:"
echo ""

count=0
for script in *.sh; do
	if [ -f "$script" ]; then
		count=$((count + 1))
		echo "$count. $script"

		if [ -x "$script" ]; then
			echo "Executable"
		else
			echo "Not executable"
		fi
	fi
done
echo ""
echo "Total scripts found: $count"
echo "===================="
