# Extending time until collision in PACStack
This project explores ways to prevent collision in PACStack besides masking

### General Notes
In the code folder, sum.s is basic ARM64 assembly program that sums the numbers from 0 to the input n:

```math
\sum_{i=1}^n i = \frac{n(n+1)}{2}
```

The `_main` function has a weird double loop. This done in all files to more easily compare runtime overhead. It was easier to compare when everything ran in seconds not nanoseconds.

The following files can in the code folder:
- `sum.s` - the basic sum function
- `sum-pac.s` - the sum function + PACStack without masks
- `sum-pac-mask.s` - the sum function + PACStack with masks
- `sum-pac2.s` - the sum function + two hash function PACStack
- `sum-pacga.s` - the sum function + extended hash length PACStack
- `sum-pac2-lite.s` - the sum function + two hash function PACStack with constant modifer
- `sum-pacga-lite.s` - the sum function + extended hash length PACStack with constant modifier

Old iterations and/or random code can be found in the archieve folder. The references folder contains pdf of some, but not all, of my sources.

### How to run
To compile all files, inside of the code folder run `./automate-compile.sh`(may need to run `chmod 750 ./automate-compile.sh`). Then run `./automate-run.sh` to generate the `sum.times` file which lists the runtimes of the various methods (may need to run `chmod 750 ./automate-run.sh`).

To compile a singular file in the code folder, first `clang -arch arm64e -march=armv8.5-a NAME.s -oNAME.arm64`, then `./NAME.arm64`, then `echo $?`.