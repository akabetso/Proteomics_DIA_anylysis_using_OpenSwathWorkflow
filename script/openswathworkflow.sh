#!/bin/bash

# Directories
raw_dir="../docker/results"
output_dir="../open_swath"
param_file_traML="../data/HEK_Ecoli_lib.pqp"
param_file_iRT="../data/iRTassays.tsv"
log_dir="../open_swath/logs"
ini_dir="../data/param.ini"

# Create output directory if it doesn't exist
mkdir -p $output_dir
mkdir -p $log_dir

# Loop over each mzML file in the results directory
#OpenSwathWorkflow -write_ini param.ini

echo "Entering loop for swapfile"
for sample in $raw_dir/Sample*.mzML; do
    filename=$(basename $sample)
	echo "Processing $sample ..."
    OpenSwathWorkflow -in $sample \
    -tr $param_file_traML \
    -tr_irt $param_file_iRT \
    -sort_swath_maps \
    -ini param.ini \
    -out_osw $output_dir/osw_output_${filename}.osw > $log_dir/swath_${filename}.log 2>&1
done
    
echo "All conversions completed!"

./pyprophet.sh 
