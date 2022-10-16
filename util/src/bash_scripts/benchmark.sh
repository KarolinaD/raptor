#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# Copyright (c) 2006-2022, Knut Reinert & Freie Universität Berlin
# Copyright (c) 2016-2022, Knut Reinert & MPI für molekulare Genetik
# This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
# shipped with this file and also available at: https://github.com/seqan/raptor/blob/master/LICENSE.md
# -----------------------------------------------------------------------------------------------------

set -e

READ_LENGTH=100
W=35
K=19
S=11110100110100001101100001100110111
ERRORS=4
HASH=2
SIZES="4g"
THREADS=32
BIN_NUMBER=64
IS_THRESHOLD=false
THRESHOLD=0.16
BINARY_DIR="<path to built binaries>" # containing the raptor binary
UTIL_BINARY_DIR="<path to built util binaries>" # containing the util binary
INPUT_DIR="<bin path>" # output directory of simulation. the directory that contains the BIN_NUMBER directory
BENCHMARK_DIR="<path>" # directory where results should be stored. E.g., /dev/shm/username; BIN_NUMBER directory will be created.
COPY_INPUT=false # If true, input data will be copied from INPUT_DIR to BENCHMARK_DIR.
EVAL_ENERGY=false # If true, use perf to measure power/energy-pkg/ and power/energy-ram/.

if [ "$IS_THRESHOLD" = true ] ; then
    working_directory=$BENCHMARK_DIR/$BIN_NUMBER/threshold_$THRESHOLD
else
    working_directory=$BENCHMARK_DIR/$BIN_NUMBER
fi
mkdir -p $working_directory

build_directory="/srv/hdd/karolid94/benchmark_results/"$ERRORS"_errors/shape_option/mandala/span"${#S}/$BIN_NUMBER

if [ "$COPY_INPUT" = true ] ; then
    echo -n "Copying input..."
    mkdir -p $working_directory/bins/
    mkdir -p $working_directory/reads/

    for i in $(seq -f "$INPUT_DIR/$BIN_NUMBER/bins/bin_%0${#BIN_NUMBER}.0f.fasta" 0 1 $((BIN_NUMBER-1)))
    do
        cp $i $working_directory/bins/
    done
    seq -f "$working_directory/bins/bin_%0${#BIN_NUMBER}.0f.fasta" 0 1 $((BIN_NUMBER-1)) > $working_directory/bins.list

    cp $INPUT_DIR/$BIN_NUMBER/reads_e$ERRORS\_$READ_LENGTH/all.fastq $working_directory/reads/
    read_file=$working_directory/reads/all.fastq
    echo "Done."
else
    seq -f "$INPUT_DIR/$BIN_NUMBER/bins/bin_%0${#BIN_NUMBER}.0f.fasta" 0 1 $((BIN_NUMBER-1)) > $working_directory/bins.list
    read_file=$INPUT_DIR/$BIN_NUMBER/reads_e$ERRORS\_$READ_LENGTH/all.fastq
fi

launch_build() {
    if [ "$EVAL_ENERGY" = true ] ; then
        perf stat -o $build_perf -e power/energy-pkg/,power/energy-ram/ "$@"
    else
        "$@"
    fi
}

launch_query() {
    if [ "$EVAL_ENERGY" = true ] ; then
        perf stat -o $query_perf -e power/energy-pkg/,power/energy-ram/ "$@"
    else
        "$@"
    fi
}

for size in $SIZES; do
    if [ "$IS_THRESHOLD" = true ] ; then
        ibf_filename=$build_directory/$W\_${#S}\_$S\_$size.ibf # Does not contain HASH
        query_log=$working_directory/$W\_${#S}\_$S\_$size\_query.log # Does not contain HASH
        query_perf=$working_directory/$W\_${#S}\_$S\_$size\_query.perf
        query_out=$working_directory/$W\_${#S}\_$S\_$size.out
        echo "Searching IBF for reads of length $READ_LENGTH containing $ERRORS errors using percentage threshold $THRESHOLD"
        launch_query    /usr/bin/time -o $query_log -v \
                                $BINARY_DIR/raptor search \
                                    --query $read_file \
                                    --index $ibf_filename \
                                    --output $query_out \
                                    --threads $THREADS \
                                    --error $ERRORS \
                                    --pattern $READ_LENGTH \
                                    --tau 0.9999 \
                                    --time \
                                    --threshold $THRESHOLD

    elif [ "$IS_THRESHOLD" = false ] ; then
        ibf_filename=$build_directory/$W\_${#S}\_$S\_$size.ibf # Does not contain HASH
        build_log=$working_directory/$W\_${#S}\_$S\_$size\_build.log
        build_perf=$working_directory/$W\_${#S}\_$S\_$size\_build.perf
        echo "Building IBF with ($W, ${#S}, $S)-minimisers with $HASH hashes and of size $size"
        launch_build    /usr/bin/time -o $build_log -v \
                            $BINARY_DIR/raptor build \
                                --output $ibf_filename \
                                --shape $S \
                                --window $W \
                                --size $size \
                                --threads $THREADS \
                                --hash $HASH \
                                $working_directory/bins.list 

        query_log=$working_directory/$W\_${#S}\_$S\_$size\_query.log # Does not contain HASH
        query_perf=$working_directory/$W\_${#S}\_$S\_$size\_query.perf
        query_out=$working_directory/$W\_${#S}\_$S\_$size.out
        echo "Searching IBF for reads of length $READ_LENGTH containing $ERRORS errors"
        launch_query    /usr/bin/time -o $query_log -v \
                                $BINARY_DIR/raptor search \
                                    --query $read_file \
                                    --index $ibf_filename \
                                    --output $query_out \
                                    --threads $THREADS \
                                    --error $ERRORS \
                                    --pattern $READ_LENGTH \
                                    --tau 0.9999 \
                                    --time
    fi

    threshold_log=$working_directory/$W\_${#S}\_$S\_$size\_threshold.log
    threshold_out=$working_directory/$W\_${#S}\_$S\_$size\_threshold.out
    echo "Collecting information about threshold calculation"
    /usr/bin/time -o $threshold_log -v \
        $UTIL_BINARY_DIR/threshold_info \
            --query $read_file \
            --output $threshold_out \
            --threads $THREADS \
            --error $ERRORS \
            --pattern $READ_LENGTH \
            --shape $S \
            --window $W

    #rm $ibf_filename
done

# Uncomment for basic cleanup, does not delete results
# chmod -R 744 $working_directory/bins
# chmod -R 744 $working_directory/reads
# rm -f $working_directory/bins/*.fasta
# rm -d $working_directory/bins
# rm -f $working_directory/reads/all.fastq
# rm -d $working_directory/reads
