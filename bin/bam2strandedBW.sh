#!/bin/bash

BAMFILE=$1
CHROM_SIZES=$2
BASE=`basename ${BAMFILE} .bam`
TOPBGRF=${BASE}_fwd.bgr
BOTBGRF=${BASE}_rev.bgr
TOPBW=${BASE}_fwd.bw
BOTBW=${BASE}_rev.bw

# 1 bam -> bed
# 2 bed -> stranded bedgraph
# 3 stranded bedgraph -> stranded bigwig

makeBedgraph -5 -k ${CHROM_SIZES} ${BAMFILE} ${TOPBGRF}
makeBedgraph -3 -k ${CHROM_SIZES} ${BAMFILE} ${BOTBGRF}
bedGraphToBigWig ${TOPBGRF} ${CHROM_SIZES} ${TOPBW}
bedGraphToBigWig ${BOTBGRF} ${CHROM_SIZES} ${BOTBW}
