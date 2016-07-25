#!/usr/bin/env bash
#Usage
# sh calculateFragmentation.sh file1.txt file2.txt report.txt
# Example: sh calculateFragmentation.sh easyConverted.txt ptConverted.txt fragmentedReport.txt
# Usecase: Compare the pdf to Text conversion Fragmentation between EasyConverter and the PdfToText

start=`date +%s`
echo "Fragmentation Start: $start"

export argsCount=3
export isDirCompare=false

if [ "$#" -ne $argsCount ]
then
echo "Invalid number of Arguments: Expected:$argsCount Actual: $#"
echo "Usage: sh calculateFragmentation.sh file1.txt file2.txt report.txt
      file1.txt - First file to be compared.
      file2.txt - Second file to be compared with first file
      report.txt - %Fragmentation of the Second file compared to the first
      % Fragmented = (file2_linecount)*100/file1_lineCount
      Above logic calculates how fragmented the file2 compared to file1"

exit
fi

export file1=$1
export file2=$2
export dir1=$1
export dir2=$2
export reportPath=$3
export lineCounts="linecounts.txt"
export fragListFile=$reportPath"_list"
export fragStatsLog=$reportPath"_stats.log"

function does_file_exist(){
    if [ -f $file1 -a -f $file2 ]
    then
        echo "Found Files $file1 and $file2"
        return 0
    elif [ -d $dir1 -a -d $dir2 ]
    then
        echo "Found directory $dir1 and $dir2"
        isDirCompare=true
        return 0
    else
        echo "Either $file1 or $file2 or both does not exist"
        return 1
    fi
}

function calculateFragmentPerCentage (){
    echo "Writing to $reportPath"
    echo "** EasyConverterOutput PdfToTextOutput \"Filename\" \"%Fragmentation\" **" >> $reportPath
    if [ $isDirCompare = true ]
    then
        for filename in $dir1/*; do
            basename=$(echo $filename | awk -F"/" '{print $NF}')
            file1="$dir1/$basename"
            file2="$dir2/$basename"
            if [ ! -f $file2 ]
            then
                echo "$file2 does not exist. Skipping"
            else
                calculateFragmentPercentageOnFile $file1 $file2
            fi
        done
    else
        calculateFragmentPercentageOnFile $file1 $file2
    fi
}

function calculateFragmentPercentageOnFile (){
    count_file1=$(wc -l $file1 | awk '{print $1}')
    count_file2=$(wc -l $file2 | awk '{print $1}')
    diff=$(($count_file2 - $count_file1))
    frag=$((($count_file2*100)/$count_file1))
    basename=$(echo $file1 | awk -F"/" '{print $NF}')
    echo "|| $file1 $file2 \"$basename\" $frag ||" >> $reportPath
}

function calculateFragmentStats (){
    calculateFragmentPerCentage
    # Calculate the Stats of the Fragmentation
    cut -f4 $reportPath > $fragListFile
    calcStats
}

function calcStats(){
echo $reportPath'Plot.jpg'
    chartName=$(echo $reportPath'Plot.jpg' | awk -F"/" '{print $NF}')
    Rscript calculateFragmentationStats.R $fragListFile $reportPath'Plot.jpg' $chartName > $fragStatsLog
    mean=$(head -1 $fragStatsLog | tail -1 | awk '{print $2}')
    med=$(head -2 $fragStatsLog | tail -1 | awk '{print $2}')
    sd=$(head -3 $fragStatsLog | tail -1 | awk '{print $2}')
    echo "*************************" >> $reportPath
    echo "# Mean   Frag% : $mean" >> $reportPath
    echo "# Median Frag% : $med" >> $reportPath
    echo "# SD     Frag% : $sd" >> $reportPath
    echo "*************************" >> $reportPath
}


# Main call
# Invalid Argument Check
echo "Calculating Fragmentation% "
does_file_exist
if [[ $((does_file_exist)) -eq 1 ]]
then
    echo "Exiting" >> $reportPath
    exit
fi
rm $reportPath
calculateFragmentStats

echo "Report completed" >> $reportPath
echo "Done - Calculating Fragmentation% "
end=`date +%s`
runtime=$(($end-$start))
echo "Fragmentation End: $end"
echo "Time taken: $runtime"
exit

