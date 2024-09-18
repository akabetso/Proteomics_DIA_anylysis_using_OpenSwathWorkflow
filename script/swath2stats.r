library(SWATH2stats) 
library(data.table) 
data('Spyogenes', package = 'SWATH2stats')

out_dir <- "../docker/pyprophet/FDR_estimation"
# Read the PyProphet osw file
data <- data.frame(fread('/home/akabetso/Desktop/Proteomics/DIA_Analysis_Using_OpenSwathWorkflow/docker/pyprophet/FDR_estimation/protein_global.tsv', sep='\t', header=TRUE))
Study_design <- data.frame(Filename = unique(data$filename))
Study_design$Filename <- gsub(".*strep_align/(.*)_all_peakgroups.*", "\\1", Study_design$Filename) 
Study_design$Condition <- gsub("(Strep.*)_Repl.*", "\\1", Study_design$Filename) 
Study_design$BioReplicate <- gsub(".*Repl([[:digit:]])_.*", "\\1", Study_design$Filename) 
Study_design$Run <- seq_len(nrow(Study_design)) 
head(study_design)

data.annotated <- sample_annotation(data, Study_design, column_file = "filename")
data.annotated.nodecoy <- subset(data.annotated, decoy==FALSE)
count_analytes(data.annotated.nodecoy)

pdf(file.path(out_dir, "correlation_plots.png"), width = 1600, height = 800)
par(mfrow = c(1, 2)) 
correlation_intensity <- plot_correlation_between_samples(data.annotated.nodecoy,column.values= 'Intensity')
correlation_delta_rt <- plot_correlation_between_samples(data.annotated.nodecoy,column.values= 'delta_rt')
dev.off()

data.filtered <- filter_mscore_condition(data.annotated, 0.01, n_replica = 2)
data.filtered2 <- filter_on_max_peptides(data.filtered, n_peptides = 10)
data.filtered3<-filter_on_min_peptides(data.filtered2,n_peptides=2)
data.transition<-disaggregate(data.filtered3)
MSstats.input<-convert4MSstats(data.transition)
head(MSstats.input)
# Write the output file for further use
write.csv(msstats_data, "'../docker/path/to/output/msstats_input.csv")
