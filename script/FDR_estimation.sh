pyprophet_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/pyprophet"
log_dir="/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/logs"

mkdir -p $pyprophet_dir/FDR_estimation

echo "running pyprophet FDR estimation experiment wide for peptides..."
docker run -it --rm \
    -v $pyprophet_dir/score:/pypro_score \
    -v $pyprophet_dir/FDR_estimation:/fdr_estimation \
    -v $log_dir:/logs \
    pyprophet/pyprophet pyprophet peptide \
    --in /pypro_score/scored_merged_samples.osw \
    --context experiment-wide \
    --out /fdr_estimation/peptide_experiment.osw \
    > $log_dir/FDR_estimation_wide.log 2>&1
echo "pyprophet FDR estimation completed"

echo "running pyprophet FDR estimation global for peptide..."
docker run -it --rm \
    -v $pyprophet_dir/FDR_estimation:/fdr_estimation \
    -v $log_dir:/logs \
    pyprophet/pyprophet pyprophet peptide \
    --in /fdr_estimation/peptide_experiment.osw \
    --context global \
    --out /fdr_estimation/peptide_global.osw \
    > $log_dir/FDR_estimation_global.log 2>&1
echo "pyprophet FDR estimation completed"


echo "running pyprophet FDR estimation protein inference experiment wide for peptides..."
docker run -it --rm \
    -v $pyprophet_dir/FDR_estimation:/fdr_estimation \
    -v $log_dir:/logs \
    pyprophet/pyprophet pyprophet protein \
    --in /fdr_estimation/peptide_global.osw \
    --context experiment-wide \
    --out /fdr_estimation/protein_experiment.osw \
    > $log_dir/protein_FDR_estimation_wide.log 2>&1
echo "pyprophet FDR estimation completed"

echo "running pyprophet FDR estimation protein inference global for peptide..."
docker run -it --rm \
    -v $pyprophet_dir/FDR_estimation:/fdr_estimation \
    -v $log_dir:/logs \
    pyprophet/pyprophet pyprophet protein \
    --in /fdr_estimation/protein_experiment.osw \
    --context global \
    --out /fdr_estimation/protein_global.osw \
    > $log_dir/protein_FDR_estimation_global.log 2>&1
echo "pyprophet FDR estimation completed"

echo "Export pyprophet osw results"
docker run -it --rm \
    -v $pyprophet_dir/FDR_estimation:/fdr_estimation \
    pyprophet/pyprophet pyprophet export \
    --in /fdr_estimation/protein_global.osw \
    --format legacy_merged \
    --max_rs_peakgroup_qvalue 0.05 \
    --max_global_peptide_qvalue 0.05 \
    --max_global_protein_qvalue 0.05




#pyprophet protein --in=peptide_experiment.osw --context=global --out=/path/to/output/peptide_global.osw

