#!/bin/bash

GENOME_PATH=$1
GENOME_ABBR=$2
FQ1=$3
FQ2=$4
FQBASE1=`basename ${FQ1} .fq`
FQBASE2=`basename ${FQ2} .fq`
FQBASE=`basename ${FQ1} p1.fq`
SAMBASE=${FQBASE}_${GENOME_ABBR}
SAI1=${SAMBASE}_1.sai
SAI2=${SAMBASE}_2.sai
SAM=${SAMBASE}.sam
BAM=${SAMBASE}.bam
BAMSRT=${SAMBASE}_srt.bam
BAMUNSRT=${SAMBASE}_unsrt.bam

bwa aln -t 2 ${GENOME_PATH} ${FQ1} > ${SAI1}
bwa aln -t 2 ${GENOME_PATH} ${FQ2} > ${SAI2}
bwa sampe ${GENOME_PATH} ${SAI1} ${SAI2} ${FQ1} ${FQ2} > ${SAM}
samtools view -bS ${SAM} > ${BAM}
samtools sort ${BAM} ${SAMBASE}_srt
mv ${BAM} ${BAMUNSRT}
mv ${BAMSRT} ${BAM}
samtools index ${BAM}
