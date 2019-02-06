#!/bin/bash


gawk -F ' *, *' -v OFS=',' '
{
    $1 = (NR==1 ? "\"datetime\"," : substr($1, 1, length($1) -1) "T" substr($2, 2)  ",") $1
    print
}' "$@"
