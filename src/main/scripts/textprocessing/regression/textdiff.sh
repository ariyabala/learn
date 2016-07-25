#!/usr/bin/env bash
# Usage:
# sh textdiff.sh $input.accno


sdiff -I RE -s -B -w 210 $old_output/cleanTextOutput $new_output/cleanTextOutput > idrDiff.txt

echo "Find the text differences under idrDiff.txt"
