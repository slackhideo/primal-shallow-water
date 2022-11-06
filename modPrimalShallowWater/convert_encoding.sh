#!/bin/bash
convert() {
    local dir="$1" encoding_new="$2"
    while IFS= read -r -d '' I; do
        encoding_orig=$(file -bi "$I" | cut -d= -f2)
        if [ "$encoding_orig" != "binary" -a "$encoding_orig" != "$2" ]; then
            mv -i "$I" "$I".tmp
            iconv -f "$encoding_orig" -t "$encoding_new" -o "$I" "$I".tmp
            rm "$I".tmp
        fi
    done < <(find "$dir" -print0)
}
convert "${1:-./content/scripts/}" "${2:-utf16}"
