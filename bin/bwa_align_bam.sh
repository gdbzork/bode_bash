#!/bin/bash

GENOME_PATH=$1
GENOME_ABBR=$2
FQ=$3
FQBASE=`basename ${FQ} .fq`
SAMBASE=${FQBASE}_${GENOME_ABBR}
SAI=${SAMBASE}.sai
SAM=${SAMBASE}.sam
BAM=${SAMBASE}.bam
BAMSRT=${SAMBASE}_filt_srt.bam

bwa aln ${GENOME_PATH} -b0 ${FQ} > ${SAI}
bwa samse ${GENOME_PATH} ${SAI} ${FQ} > ${SAM}
samtools view -F 0x4 -q 5 -bS ${SAM} > ${BAM}
samtools sort ${BAM} ${SAMBASE}_filt_srt
rm ${BAM}
rm ${SAI}
rm ${SAM}
mv ${BAMSRT} ${BAM}
samtools index ${BAM}
