#!/bin/bash

bsub -o %J.stdout -e %J.stderr -r -n 4 -R "span[hosts=1]" ./align.sh $1 $2 $3
