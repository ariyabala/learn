#!/usr/bin/env bash
if [ "$#" -ne 3 ]
then
    echo "Invalid number of arguments: Expected = 3: Actual = $#"
    echo "Usage: sh calculatestats.sh dir1 dir2 reportPath
          dir1      - Directory path with the text output of Converter1
          dir2      - Directory path with the text output of Converter2
          reportPath- Path to write the report"
    echo "sh calculatestats.sh /Users/ariyabala/Downloads/test2/SSR/easy/temp /Users/ariyabala/Downloads/test2/SSR/PT/temp /Users/ariyabala/Downloads/edReport.txt"
    exit
fi

export dir1=$1
export dir2=$2
export reportPath=$3

mkdir -p dirname $reportPath
calculateFragmentation.sh $dir1 $dir2 $reportPath'_frag'
calculateEditDistance.sh $dir1 $dir2 $reportPath'_editcost'