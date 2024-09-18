# Directories
raw_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/rawdata"
results_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/results"
log_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/logs"


mkdir -p $results_dir
mkdir -p $log_dir
#docker pull chambm/pwiz-skyline-i-agree-to-the-vendor-licenses

for sample in $raw_dir/Sample*.raw; do
    filename=$(basename $sample)
	echo "Converting $sample ..."
    docker run -it --rm \
        -v $raw_dir:/data \
        -v $results_dir:/results \
        chambm/pwiz-skyline-i-agree-to-the-vendor-licenses \
        wine msconvert /data/$filename \
		--filter "peakPicking true 1" \
		--filter "demultiplex optimization=overlap_only" \
		--simAsSpectra \
		--ignoreUnknownInstrumentError \
		--64 \
        --outdir /results \
        > $log_dir/convert_${filename}.log 2>&1
done


#for file in /home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/rawdata/*.raw; do
#  filename=$(basename "$file")  
 # echo "converting $file"
#  docker run -it --rm -e WINEDEBUG=-all \
 #   -v /home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/rawdata:/data \
 #   chambm/pwiz-skyline-i-agree-to-the-vendor-licenses \
 #   wine msconvert "/data/$filename"
#done


echo "conversion completed"
