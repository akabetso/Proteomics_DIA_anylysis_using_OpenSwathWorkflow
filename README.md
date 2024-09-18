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

According to [Shubham Gupta et al.](https://www.nature.com/articles/s42003-023-05437-2), Data independent acquisition (DIA) is a popular method to probe the proteome landscape of a biological sample in liquid chromatography coupled to tandem mass-spectrometry (LC-MS/MS). They mentioned it has been proven to have superior reproducibility and better quantitative performance compared to other methods, such as shotgun proteomics due to its fixed MS/MS acquisition scheme and MS2 based quantification. In clinical studies, it is often necessary to analyze a large number of samples to identify trends or to achieve enough statistical power in genetically diverse populations. In such large-scale studies, it is often practically infeasible to acquire all runs under homogeneous conditions at the same time on a single instrument. Thus, being able to compare data across larger time frames of LC-MS/MS acquisition or across multiple instruments is becoming increasingly important for MS-based proteomics.

For such large-scale DIA studies, sources of non-biological variation include sample preparation, retention time shifts, ionization and mass-spectrometer related artifacts.

As defined in Galaxy, Proteome is the entirety of proteins in a biological system(tissue, organism...) most often performed by mass spectromety that enables great sensitivity and throughput. Especially for complex protein mixtures, bottom-up mass spectrometry is the standard approach in which proteins are digested with specific protease into peptides and the measured peptides are in silico reassembled into the corresponding proteins. Inside the mass spectrometer, not only the MS1 peptide are measured but they are further fragmented into smaller peptides which are measured again as MS2 level refered as tandem-mass spectrometry (MS/MS). Quantification of peptides are mostly done by measuring the area under the curve of the MS1 level peptide peaks, but special techniques such as TMT allow to quantify peptides on MS2 level. through this approach, several thouasands of proteins can be identified and measured.

![tandem-mass_spectrometry](data/ms_ms_principle.png)
**Figure 1:** Measurement principles of DIA and m/z window schema of staggered DIA printed from Galaxy.

As seen on the figure above, the system performs a series of cycle scan, the red arrows represent MS1 scan which are ful scans of all ions within a wide mass-to-charge(m/z) range of 400-1000m/z. The black arrows represents DIA MS2 scans where the instrument isolates specific ranges (isolation windows) and gragments the ions within that window to get detailed information (MS/MS data). In this case, each isolation window has a width of 24m/z and within each window, ions are fragmented to measure their intensities. Within each cycle, the instrument alternates between one MS1 scan and several MS2 scans. 

**Demultiplexing** in DIA refers to the seperation or untangling of the complex data that results when multiple ions are analyzed together in a single isolation window. This is necessary because multiple precursor ions are fragmented together resulting to complex MS/MS spectra that contain fragments from different precursor ions simultanously which can overlap in the same window when mixed together. Demultiplexing computationaly seperates these mixed fragment ions so each fragment is correctly assigned to it's corresponding precursor ion.

And finally, the spectra shows the intensity distribution of ions detected after fragmentation. the peaks represent fragment ions and their intensities are used to quantify the amount of specific peptides or proteins.

## Dataset description