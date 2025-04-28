#!/bin/bash

if [[ "$1" == "--help" ]]; then
    echo "Usage: $0 [-n] [-v] search_string filename"
    exit 0
fi

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [-n] [-v] search_string filename"
    exit 1
fi

show_line_numbers=false
invert_match=false

while [[ "$1" == -* ]]; do
    case "$1" in
        -n) show_line_numbers=true ;;
        -v) invert_match=true ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

search="$1"
file="$2"

if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

cmd="grep -i"

if $invert_match; then
    cmd="$cmd -v"
fi

if $show_line_numbers; then
    cmd="$cmd -n"
fi

$cmd "$search" "$file"
