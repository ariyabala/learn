#!/usr/bin/env bash
# Usage: sh pdfchecker.sh $downloaded_dir
inputdir=$1
wd=$(dirname $inputdir)

cd $inputdir
rm $wd/pdf_success.accno
rm $wd/pdf_error.accno


echo "Changing directory to $inputdir"

for f in *.pdf;
  do
    if [ $(pdfinfo $f | wc -c) -ne 0 ]; then
        echo "$f" | sed 's/.pdf//g' >> $wd/pdf_success.accno;
    else
        echo "$f" | sed 's/.pdf//g' >> $wd/pdf_error.accno;
    fi;
done

echo "Valid PDF List written to $wd/pdf_success.accno";
echo "Valid PDF List written to $wd/pdf_error.accno";