#!/bin/bash

BLACKLIST=$1
BAM_ORIG=$2

BAM_BASE=`basename ${BAM_ORIG} .bam`
BAM_TMP1=${BAM_BASE}_TMP1.bam
BAM_TMP2=${BAM_BASE}_TMP2.bam
BAM_FILT_BASE=${BAM_BASE}_filt
BAM_FILT=${BAM_BASE}_filt.bam

echo blacklist: ${BLACKLIST}
echo bam_orig: ${BAM_ORIG}
echo bam_tmp1: ${BAM_TMP1}
echo bam_tmp2: ${BAM_TMP2}
echo bam_filt: ${BAM_FILT}

filterByRegion --invert ${BLACKLIST} ${BAM_ORIG} ${BAM_TMP1}
samtools view -b -F 0x4 -q 5 -o ${BAM_TMP2} ${BAM_TMP1}
samtools sort -m 2000000000 ${BAM_TMP2} ${BAM_FILT_BASE}
samtools index ${BAM_FILT}
rm ${BAM_ORIG}.bai
rm ${BAM_TMP1}
rm ${BAM_TMP2}
