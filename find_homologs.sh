#!/bin/bash

if [ "$#" != 3 ]; then
    echo "Warning: Must have 1 QUERY file, 1 SUBJECT file, and 1 OUTPUT 
file"
    exit 1
fi



tblastn -query "$1" -subject "$2" -task blastn-short -outfmt '6 qseqid 
sseqid pident length qlen slen' -out basefile.txt

match_length_factor=0.90

awk -v match_length_factor="$match_length_factor" '$3 > 30 && $4 > 
match_length_factor * $5' basefile.txt > "$3"

Matches=$(cat "$3" | wc -l)
echo "Number of Matches: $Matches"

rm basefile.txt

