#!/bin/sh

# Sort the contents

test.txt | sort

# get de-duped Contents

test.txt | uniq

# get contents that occurred only once

test.txt | uniq -u

# get contents that are duplicated

test.txt | uniq -d

# Compare two file contents

sort file1 > file1.sorted
sort file2 > file2.sorted
diff file1.sorted file2.sorted

# Filter contents to report lines in file2 that are absent in file1

diff -u file1.sorted file2.sorted | grep "^+"

#Grep the last/file part of the path
$(echo $filename | awk -F"/" '{print $NF}')

#Create directory/ies from the filePath
mkdir -p dirname $reportPath

#Create filename from the filePath
basename $reportPath