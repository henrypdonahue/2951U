#!/bin/bash

clang -arch arm64e -march=armv8.5-a sum.s -o armFiles/sum.arm64
clang -arch arm64e -march=armv8.5-a sum-pac.s -o armFiles/sum-pac.arm64
clang -arch arm64e -march=armv8.5-a sum-pac-mask.s -o armFiles/sum-pac-mask.arm64
clang -arch arm64e -march=armv8.5-a sum-pac2.s -o armFiles/sum-pac2.arm64
clang -arch arm64e -march=armv8.5-a sum-pacga.s -o armFiles/sum-pacga.arm64

clang -arch arm64e -march=armv8.5-a sum-pac2-lite.s -o armFiles/sum-pac2-lite.arm64
clang -arch arm64e -march=armv8.5-a sum-pacga-lite.s -o armFiles/sum-pacga-lite.arm64