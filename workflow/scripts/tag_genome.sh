input=$1
output=$2

awk '$1 ~ /^>/ { split($1, h, ">") 
                print ">chr"h[2]}
        $1 !~ /^>/ { print $0}' "$input" > "$output"