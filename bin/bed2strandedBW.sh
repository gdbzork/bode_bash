#!/bin/bash

BEDFILE=$1
CHROM_SIZES=$2
BASE=`basename ${BEDFILE} .bed`
TOPBGRB=${BASE}_fwd
BOTBGRB=${BASE}_rev
TOPBGRF=${BASE}_fwd.bgr
BOTBGRF=${BASE}_rev.bgr
TOPBW=${BASE}_fwd.bw
BOTBW=${BASE}_rev.bw

# 2 bed -> stranded bedgraph
# 3 stranded bedgraph -> stranded bigwig

makeWiggle -B -1 -5 ${BEDFILE} ${TOPBGRB}
makeWiggle -B -1 -3 ${BEDFILE} ${BOTBGRB}
bedGraphToBigWig ${TOPBGRF} ${CHROM_SIZES} ${TOPBW}
bedGraphToBigWig ${BOTBGRF} ${CHROM_SIZES} ${BOTBW}
