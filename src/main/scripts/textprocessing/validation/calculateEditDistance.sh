#!/usr/bin/env bash
#Usage
# sh calculateEditDistance.sh dir1 dir2 reportPath
# Example: sh calculateEditDistance.sh /Users/ariyabala/Downloads/test2/SSR/easy/temp /Users/ariyabala/Downloads/test2/SSR/PT/temp "/Users/ariyabala/Downloads/edReport.txt"
# Usecase: Compare the Edit Distance Cost between EasyConverter and the PdfToText

start=`date +%s`
echo "Edit distance Start: $start"

if [ "$#" -ne 3 ]
then
    echo "Invalid number of arguments: Expected = 3: Actual = $#"
    echo "Usage: sh calculateEditDistance.sh dir1 dir2 reportPath
          dir1      - Directory path with the text output of Converter1
          dir2      - Directory path with the text output of Converter2
          reportPath- Path to write the report"
    echo "sh calculateEditDistance.sh /Users/ariyabala/Downloads/test2/SSR/easy/temp /Users/ariyabala/Downloads/test2/SSR/PT/temp /Users/ariyabala/Downloads/edReport.txt"
    exit
fi


export easyconverterPath=/fse/devel_hki/Processing/easyConverter/3.0.22/easyConverterHTML/Samples
export libpath=$easyconverterPath/lib
export editcostcalc_classpath=$libpath/pdftxttest/testbench-1.0-SNAPSHOT.jar:$libpath/pdftxttest/full-filing-backend-1.13-SNAPSHOT.jar
export dir1=$1
export dir2=$2
export reportPath=$3
export editcostListFile=$reportPath"_list"
export editcostStatsLog=$reportPath"_stats.log"
echo "Calculating Edit Distance Cost"

function calcStats(){
    echo "%RelativeEditcost" > $editcostListFile
    cat $reportPath |grep '*'|awk '{print $7}' >> $editcostListFile
    chartName=$(echo $reportPath"Plot.jpg" | awk -F"/" '{print $NF}')
    Rscript calculateEditcostStats.R $editcostListFile $reportPath"Plot.jpg" $chartName > $editcostStatsLog
    mean=$(head -1 $editcostStatsLog | tail -1 | awk '{print $2}')
    med=$(head -2 $editcostStatsLog | tail -1 | awk '{print $2}')
    sd=$(head -3 $editcostStatsLog | tail -1 | awk '{print $2}')
    echo " " >> $reportPath
    echo "*************************" >> $reportPath
    echo "# Mean   %RelativeEditcost : $mean" >> $reportPath
    echo "# Median %RelativeEditcost : $med" >> $reportPath
    echo "# SD     %RelativeEditcost : $sd" >> $reportPath
    echo "*************************" >> $reportPath
}

java -cp $editcostcalc_classpath com.alphasense.pdftotext.TestEditDistances $dir1 $dir2 $reportPath
#java -cp $editcostcalc_classpath com.alphasense.pdftotext.parallelexecution.EditDistanceCalculator  $dir1 $dir2 100 >> $reportPath
calcStats
end=`date +%s`
runtime=$(($end-$start))
echo "Edit distance End: $end"
echo "Time taken: $runtime"
