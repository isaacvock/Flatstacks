input=$1
output=$2
tag=$3

awk -v addedtag="$tag" '$1 ~ /^>/ { split($1, h, ">") 
        print ">chr"h[2]"_"addedtag}
        $1 !~ /^>/ { print $0}' "$input" > "$output"