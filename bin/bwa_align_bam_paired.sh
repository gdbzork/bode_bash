#!/bin/bash

GENOME_PATH=$1
GENOME_ABBR=$2
FQ1=$3
FQBASE1=`basename ${FQ1} .fq`
FQBASE=`basename ${FQ1} p1.fq`
SAMBASE=${FQBASE}_${GENOME_ABBR}
SAI1=${SAMBASE}_1.sai
SAI2=${SAMBASE}_2.sai
SAM=${SAMBASE}.sam
BAM=${SAMBASE}.bam
BAMSRT=${SAMBASE}_srt.bam
BAMUNSRT=${SAMBASE}_unsrt.bam

bwa aln -t 2 ${GENOME_PATH} -b1 ${FQ1} > ${SAI1}
bwa aln -t 2 ${GENOME_PATH} -b2 ${FQ1} > ${SAI2}
bwa sampe ${GENOME_PATH} ${SAI1} ${SAI2} ${FQ1} ${FQ1} > ${SAM}
samtools view -F 0x4 -bS ${SAM} > ${BAM}
samtools sort -m 4G ${BAM} ${SAMBASE}_srt
mv ${BAM} ${BAMUNSRT}
mv ${BAMSRT} ${BAM}
samtools index ${BAM}
