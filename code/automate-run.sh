#!/bin/bash

rm -f sum.times

for s in armFiles/*.arm64; do
    echo "$s run:" >> sum.times
    for i in {0..9}; do
        echo -ne '\t' >> sum.times
        { time ./$s;}   2> /tmp/time.out
        cat /tmp/time.out   | grep real | awk '{print $2}' >> sum.times
    done
done


# for s in armFiles/*.arm64; do
#     echo -- run $s
#     time ./$s
#     echo "      result: $?"
# done