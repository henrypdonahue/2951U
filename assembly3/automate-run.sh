for s in *.arm64; do
    echo -- run $s
    ./$s
    echo "      result: $?"
done