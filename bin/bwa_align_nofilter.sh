#!/bin/bash

GENOME_PATH=$1
GENOME_ABBR=$2
FQ=$3
FQBASE=`basename ${FQ} .fq`
SAMBASE=${FQBASE}_${GENOME_ABBR}
SAI=${SAMBASE}.sai
SAM=${SAMBASE}.sam
BAM=${SAMBASE}.bam
BAMSRT=${SAMBASE}_srt.bam

bwa aln ${GENOME_PATH} ${FQ} > ${SAI}
bwa samse ${GENOME_PATH} ${SAI} ${FQ} > ${SAM}
samtools view -F 0x4 -bS ${SAM} > ${BAM}
samtools sort -m 3000000000 ${BAM} ${SAMBASE}_srt
rm ${BAM}
rm ${SAI}
rm ${SAM}
samtools index ${BAMSRT}
