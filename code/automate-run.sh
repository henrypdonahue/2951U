#!/bin/bash

for s in armFiles/*.arm64; do
    echo -- run $s
    ./$s
    echo "      result: $?"
done