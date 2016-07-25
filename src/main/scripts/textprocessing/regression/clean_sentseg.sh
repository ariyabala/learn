path=$1
clean_path=$2

rm -r $clean_path
mkdir $clean_path

for file in $path/*.txt
do
filename=$(basename $file)
cut -d$'\t' -f3 $file > $clean_path/$filename
done
