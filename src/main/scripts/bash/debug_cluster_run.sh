#!/usr/bin/env bash

#Usage
# sh debug_cluster_run.sh $starcluster.log $testSet_count $workDir
# Ex: sh debug_cluster_run.sh /fse/devel_hki/Processing/newidrrun.log 20 /fse/temp/ariya/scdebug

if [ $# -le 2 ]
  then
    echo "Please supply 3 arguments"
    echo "Usage: sh debug_cluster_run.sh $starcluster.log $testSet_count $workDir"
    echo "Ex: sh debug_cluster_run.sh /fse/devel_hki/Processing/newidrrun.log 20 /fse/temp/ariya/scdebug"
    exit 1
fi

logFilePath=$1
fileCount=$2
workDir=$3

#Starcluster error check

mkdir -p $workDir;cd $workDir
logZip=$(grep tar.gz $logFilePath | grep Creating | awk '{print $2}')

echo "Untarring $logZip"
tar -xvf $logZip > temp.txt

s3LogFolder=$(tail -1 temp.txt | cut -d'/' -f1)
s3FileName=$(tail -1 temp.txt | cut -d'/' -f2|sed 's/_batch/@/g'|awk -F@ '{print $1"*.log"}')
echo "Writing logFile List to $workDir/logList.txt "
s3cmd ls s3://as.logs/starcluster/$s3LogFolder/* > $workDir/logList.txt

echo "Selecting random log File fro Analysis from $workDir/logList.txt"
shuf -n $fileCount $workDir/logList.txt | awk '{print $4}'> $workDir/randomFiles.txt
rm -r s3logs;mkdir s3logs;cd s3logs;
exec<$workDir/randomFiles.txt
while read file
do
echo $file
echo "Getting $file from S3"
s3cmd get $file
done

cd $workDir; mkdir reports;cd reports;
cat $workDir/s3logs/* |grep Error > error.txt
cat $workDir/s3logs/* |grep Exception > exception.txt

echo "Writing output to $workDir/reports"