#!/bin/bash

infile=$1
outfile=$2
awk -F "," 'BEGIN {
    srand();
} {
    if($1 && $2 && $3 && $4 && ($5 != -1)) {
        if (rand() < 0.5) {
            print $1","$2","$3","$4","$5
        }
    }
}' $infile > $outfile
