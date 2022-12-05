#!/usr/bin/awk

#print out a somewhat pretty histogram of the data on input

#assume we can store everything in memory

function ceil(x){return int(x)+(x>int(x))}

BEGIN {
    n=0;
}

{
    s += $1;
    n += 1;
    d[n] = $1;
}

END {
    if(n > 0) {
        asort(d,sorted_d);

        num_bins = ceil(sqrt(n));
        if(num_bins > 20) {
            num_bins = 20
        }
        max_bin_count = 0;
        i=1;
        for(bin=0;bin<num_bins;bin+=1) {
            bin_sep[bin] = sorted_d[0]+(sorted_d[n]-sorted_d[0])*(bin+1)/num_bins
            for(;i<=n && sorted_d[i]<bin_sep[bin];i+=1) {
                bin_counts[bin]+=1;
            }
            if(bin_counts[bin] > max_bin_count) {
                max_bin_count = bin_counts[bin];
            }
        }

        max_width = 50
        for(bin=0;bin<num_bins;bin+=1) {
            printf("%.5f ", bin_sep[bin]);
            #printf("%d %d ", bin_counts[bin], bin_counts[bin]/max_bin_count*max_width)
            for(i=0;i<ceil(bin_counts[bin]/max_bin_count*max_width);i++){
                printf("*")
            }
            printf("\n")
        }

        printf("\n")

        printf("N\t%d\n", n);
        printf("min\t%f\n", sorted_d[1]);
        printf("0.05\t%f\n", sorted_d[int(NR*0.05)+1]);
        printf("0.25\t%f\n", sorted_d[int(NR*0.25)+1]);
        printf("0.5\t%f\n", sorted_d[int(NR*0.5)+1]);
        printf("0.75\t%f\n", sorted_d[int(NR*0.75)+1]);
        printf("0.95\t%f\n", sorted_d[int(NR*0.95)+1]);
        printf("max\t%f\n", sorted_d[n]);
        printf("mean\t%f\n", s/n);
    } else {
        printf("N\t%d\n", n);
    }
}

