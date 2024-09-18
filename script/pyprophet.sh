swath_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/open_swath"
pyprophet_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/pyprophet"
template_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/data"
log_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/logs"

mkdir -p $pyprophet_dir/merged
mkdir -p $pyprophet_dir/score




#echo "scoring merged file..."
#pyprophet score --in=$pyprophet_dir/merged_output.osw --classifier=XGBoost > $log_dir/score.log 2>&1
#echo "Scoring completed"

echo "running pyprophet score on merged osw files..."
docker run -it --rm \
    -v $pyprophet_dir/merged:/pypro \
    -v $pyprophet_dir/score:/pypro_score \
    -v $log_dir:/logs \
    pyprophet/pyprophet pyprophet score \
    --in /pypro/merged_samples.osw \
    --out /pypro_score/scored_merged_samples.osw \
    --classifier XGBoost \
    > $log_dir/score.log 2>&1
echo "pyprophet score completed"



