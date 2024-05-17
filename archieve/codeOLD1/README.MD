clang -arch arm64e -march=armv8.5-a sum-pac.s -osum-pac.arm64
./sum-pac.arm64
echo $?

chmod 750 ./automate-compile.sh