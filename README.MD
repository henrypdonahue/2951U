# Extending time until collision in PACStack
In the code folder, sum.s is basic ARM64 assembly program that sums the numbers from 0 to the input n:

```math
\sum_{i=1}^n i = \frac{n(n+1)}{2}
```

The `_main` function has a weird double loop. This done in all files to more easier to compare runtime overhead.

The following files can in the code folder:
- `sum.s` - the basic sum function
- `sum-pac.s` - the sum function + PACStack without masks
- `sum-pac-mask.s` - the sum function + PACStack with masks
- `sum-pac2.s` - the sum function + two hash function PACStack
- `sum-pacga.s` - the sum function + extended hash length PACStack
- `sum-pac2-lite.s` - the sum function + two hash function PACStack with constant modifer
- `sum-pacga-lite.s` - the sum function + extended hash length PACStack with constant modifier

To compile all `.s` files, inside of the code folder run `./automate-compile.sh`(may need to run `chmod 750 ./automate-compile.sh`). Then run `./automate-run.sh` to generate the sum.times file which lists the runtimes of the various methods.