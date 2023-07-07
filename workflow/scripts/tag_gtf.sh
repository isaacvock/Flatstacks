input=$1
output=$2

awk -v OFS="\t" -v FS="\t" ' $1 !~ /^#/ {$1 = "chr"$1}
        {print $0}' "$input" > "$output"