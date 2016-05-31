#!/bin/bash

GENOME=$1
FQ=$2
GENOME_PATH=/home/brown22/genomes/${GENOME}/${GENOME}.fa
SBASE=`basename ${FQ} .fq`_${GENOME}
SAI=${SBASE}.sai
SAM=${SBASE}.sam
TXT=${SBASE}.txt

bwa aln ${GENOME_PATH} ${FQ} > ${SAI}
bwa samse ${GENOME_PATH} ${SAI} ${FQ} > ${SAM}
samtools view -S -F 4 ${SAM} | cut -f 1 > ${TXT}
rm ${SAI}
rm ${SAM}
