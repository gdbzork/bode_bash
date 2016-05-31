#!/bin/bash

BLACKLIST=$1
BAM=$2
BASE=`basename ${BAM} .bam`
BAM_TMP1=${BASE}_TMP1.bam
BAM_TMP2=${BASE}_TMP2.bam
BAM_FILT_BASE=${BASE}_filt
BAM_FILT=${BASE}_filt.bam

echo blacklist: ${BLACKLIST}
echo bam_orig:  ${BAM}
echo bam_tmp1:  ${BAM_TMP1}
echo bam_tmp2:  ${BAM_TMP2}
echo bam_filt:  ${BAM_FILT}

filterByRegion --invert ${BLACKLIST} ${BAM} ${BAM_TMP1}
samtools view -b -q 5 -o ${BAM_TMP2} ${BAM_TMP1}
samtools sort -m 2000000000 ${BAM_TMP2} ${BAM_FILT_BASE}
samtools index ${BAM_FILT}

rm ${BAM_TMP1}
rm ${BAM_TMP2}
