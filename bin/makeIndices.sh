#!/bin/bash

GENOME_PATH=$1
BASE=`basename ${GENOME_PATH} .fa`

bsub -o %J.stdout -e %J.stderr -r -M 8000000 -R 'rusage[mem=8000]' bowtie-build ${GENOME_PATH} ${BASE}
bsub -o %J.stdout -e %J.stderr -r -M 8000000 -R 'rusage[mem=8000]' maq fasta2bfa ${GENOME_PATH} ${BASE}.bfa
bsub -o %J.stdout -e %J.stderr -r -M 8000000 -R 'rusage[mem=8000]' bwa index -a bwtsw ${GENOME_PATH}
