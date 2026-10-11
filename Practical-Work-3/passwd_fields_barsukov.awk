#!/usr/bin/awk -f

BEGIN {
    FS = ":"
}

NR == 3 {
    print $1, $3
}
