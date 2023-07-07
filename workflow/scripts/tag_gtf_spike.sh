input=$1
output_temp=$2
output=$3
tag=$4

awk -v OFS="\t" -v FS="\t" -v addedtag="$tag" ' $1 !~ /^#/ {$1 = "chr"$1"_"addedtag}
        {print $0}' "$input" > "$output_temp"

sed -r 's/(gene_name ")([^"]*)/\1\2_$tag/g' "$output_temp" > "$output"