
if [ "$#" != 3 ]; then
	echo "Warning: Must have 1 QUERY file, 1 SUBJECT file, and 1 OUTPUT file"
	exit 1
fi

blastn -query "$1" -subject "$2" -task blastn-short -outfmt '6 qseqid sseqid pident length qlen slen' -out basefile.txt

awk '$3 == 100 && $4==$5' basefile.txt > "$3"

Matches=$(cat "$3" | wc -l)
echo "Number of Matches: $Matches"

rm basefile.txt

