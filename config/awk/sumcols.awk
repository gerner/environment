@include "reduce.awk"

BEGIN {
    setkey("1");
}

function startrun(key) {
    delete vals;
}

function reduce(key) {
    for(i=2; i<=NF; i++) {
        vals[i] += $i;
        col_sums[i] += $i;
    }
}

function endrun(key) {
    printf("%s\t", key[1]);
    for(x in vals) {
        printf("%f\t", vals[x])
    }
    printf("%s", "\n");
}

END {
    printf("\t");
    for(x in col_sums) {
        printf("%f\t", col_sums[x]);
    }
    printf("%s", "\n");
}
