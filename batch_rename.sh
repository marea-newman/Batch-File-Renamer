#!/bin/bash                                                                                                                

# Usage: ./batch_rename.sh -option [directory/] [pattern] [replacement]                                                    

if [ $# -eq 4 ]; then
    #optional dry                                                                                                          
    if [ "$1" = "-d" ]||[ "$1" = "--dry-run" ]; then
        dir=$2
        pat=$3
        rep=$4
        op=1
    else
        echo "unknown option" >&2
        exit 1
        fi
elif [ $# -eq 3 ]; then
    dir=$1
    pat=$2
    rep=$3
    op=0
else
    echo "ERROR: Usage: ./batch_rename.sh -option [directory] [pattern] [replacement]" >&2
    exit 1
fi

if [ -d $dir ]; then
    for file in "$dir"*; do
        if [ -f $file ]; then
            new=$(echo "$file" | sed "s/$pat/$rep/")
            if [ $op = 0 ]; then
                mv $file $new
                echo "$file -> $new"
            elif [ $op = 1 ]; then
                echo "[DRY RUN] $file -> $new"
            fi
        else
	    echo "file does not exist"
	fi
    done
elif [ ! -d $dir ]; then
    echo "directory not found" >&2
    exit 1
else
    echo"ERROR: Usage: ./batch_rename.sh -option [directory] [pattern] [replacement]" >&2
    exit 1
fi
