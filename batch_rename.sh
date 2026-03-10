#!/bin/bash

set -euo pipefail

d=0
g=0

usage() {
    cat << USAGE
Usage: ./batch_rename.sh [options] <directory> <pattern> <replacement>

Options:
    -h, --help           Show this help message
    -d, --dry-run	 Print changes to screen without renaming files
    -g, --global	 Apply change to all inctences of pattern

Example:
    $0 -d -g  results/ old new
Note: -dg not supported, rewrite as -d -g
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -d|--dry-run)
            d=1
            shift
            ;;
        -g|--global)
            g=1
            shift
            ;;
        -*)
            echo "ERROR: Unknown option: $1" >&2
            exit 1
            ;;
        *)
            dir="$1"
            pat="$2"
            rep="$3"
            shift 3
            ;;
    esac
done


if [ ! -d $dir ]; then
    echo "ERROR: Directory not found" >&2
    exit 1
fi

files=$(ls "$dir" | grep "$pat")
for file in $files; do
    if [ $g = 0 ]; then
	new=$(echo "$file" | sed "s/$pat/$rep/")
    elif [ $g = 1 ]; then
	new=$(echo "$file" | sed "s/$pat/$rep/g")
    fi
    if [ $d = 0 ]; then
	mv "$dir""$file" "$dir""$new"
	echo "$file -> $new"
    elif [ $d = 1 ]; then
	echo "[DRY RUN] $file -> $new"
    fi
done

