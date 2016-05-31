#!/bin/bash

GENOME_PATH=$1
GENOME_ABBR=$2
BLACKLIST=$3
FQ=$4
FQBASE=`basename ${FQ} .fq`
SAMBASE=${FQBASE}_${GENOME_ABBR}
SAI=${SAMBASE}.sai
SAM=${SAMBASE}.sam
BAM=${SAMBASE}.bam
BAM_TMP1=${SAMBASE}_TMP1.bam
BAM_TMP2=${SAMBASE}_TMP2.bam
BAM_FILT_BASE=${SAMBASE}_filt
BAM_FILT=${SAMBASE}_filt.bam

echo genome:    ${GENOME_PATH}
echo abbr:      ${GENOME_ABBR}
echo blacklist: ${BLACKLIST}
echo sam:       ${SAM}
echo bam_orig:  ${BAM}
echo bam_tmp1:  ${BAM_TMP1}
echo bam_tmp2:  ${BAM_TMP2}
echo bam_filt:  ${BAM_FILT}

#bwa aln ${GENOME_PATH} ${FQ} > ${SAI}
#bwa samse ${GENOME_PATH} ${SAI} ${FQ} > ${SAM}
#samtools view -bS ${SAM} > ${BAM}
/home/brown22/bin/cs_multiBWA --stdoutdir . ${GENOME_PATH} ${FQ}
mv ${FQBASE}.bam ${BAM}
filterByRegion --invert ${BLACKLIST} ${BAM} ${BAM_TMP1}
samtools view -b -q 5 -o ${BAM_TMP2} ${BAM_TMP1}
samtools sort -m 2000000000 ${BAM_TMP2} ${BAM_FILT_BASE}
samtools index ${BAM_FILT}

rm ${SAI}
rm ${SAM}
rm ${BAM_TMP1}
rm ${BAM_TMP2}
