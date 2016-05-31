#!/bin/bash

BAM_ORIG=$1

BAM_BASE=`basename ${BAM_ORIG} .bam`
BAM_TMP1=${BAM_BASE}_TMP1.bam
BAM_FILT_BASE=${BAM_BASE}_filt_srt
BAM_FILT=${BAM_BASE}_filt_srt.bam

echo bam_orig: ${BAM_ORIG}
echo bam_tmp1: ${BAM_TMP1}
echo bam_filt: ${BAM_FILT}

samtools view -b -q 5 -o ${BAM_TMP1} ${BAM_ORIG}
samtools sort -m 2000000000 ${BAM_TMP1} ${BAM_FILT_BASE}
samtools index ${BAM_FILT}
rm ${BAM_TMP1}
