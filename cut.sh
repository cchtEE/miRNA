#!/bin/bash

# Copy important files.
while IFS='' read -r line || [[ -n "$line" ]]; do
    location=$line
    sample=${location##*/}
    mkdir $sample.results
    cp $(find $sample -name "results.txt" -o -name "novel.txt" -o -name "novel_mature.fa" -o -name "novel_hairpin.fa" -o -name  "microRNAannotation.txt" -o -name "mature.iso" -o -name "mappingStat.txt" -o -name "isomiR_summary.txt" -o -name "mature_sense.grouped") $sample.results
done < "$locations"
