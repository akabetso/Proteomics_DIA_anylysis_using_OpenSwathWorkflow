# *Proteomics Data Independent Analysis (DIA) with OpenSwathWorkflow*

### Compiled by *Desmond Akabetso Nde* 
### Last updated on the *10 of September 2024* 
### *Enjoy reading through and do not hesitate to comment your thougths on my approach and analysis.*

## Aim: 
	- Navigate the pathway to analyze data independent acquisition (DIA) mass spectrometry (MS) data using OpenSwathWorkflow
	-  Detect different Spike-in sample dataset with case study: Ecoli in a HEK-Ecoli Benchmark DIA dataset.
	- Reproduce Workflow from [Galaxy](https://usegalaxy.org/training-material/topics/proteomics/tutorials/DIA_Analysis_OSW/tutorial.html#hands-on-dia-analysis-using-openswathworkflow) in linux environment for detailed and deep understanding of everystep.
	
## Workflow from Galaxy:
	1. Introduction
	2. dataset description
	3. OpenSwathWorkflow DIA analysis
	4. Pyprophet: merge OpenSwathWorkflow output files
	5. FDR estimation with pyprophet score
		- Apply scores to peptide
		- Apply scores to protein
		- export results in tsv file
	6. Perform statistical analysis with swath2stats.
	7. Conclusion

## Introduction

