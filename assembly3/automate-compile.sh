#!/bin/bash

clang -arch arm64e -march=armv8.5-a sum.s -osum.arm64
clang -arch arm64e -march=armv8.5-a sum-pac.s -osum-pac.arm64
clang -arch arm64e -march=armv8.5-a sum-pac-mask.s -osum-pac-mask.arm64
clang -arch arm64e -march=armv8.5-a sum-pac2.s -osum-pac2.arm64
clang -arch arm64e -march=armv8.5-a sum-pacga.s -osum-pacga.arm64

clang -arch arm64e -march=armv8.5-a sum-pac2-lite.s -osum-pac2-lite.arm64
clang -arch arm64e -march=armv8.5-a sum-pacga-lite.s -osum-pacga-lite.arm64