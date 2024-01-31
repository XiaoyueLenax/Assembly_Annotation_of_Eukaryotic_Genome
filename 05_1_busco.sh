#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=16:00:00
#SBATCH --job-name=BUSCO_canu_unpo;
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_BUSCO_canu_unpo_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_BUSCO_canu_unpo_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Analysis/busco/4.1.4

#task name
    #assembly_name=canu
    #assembly_name=flye_unpol
    #assembly_name=trinity2
    assembly_name=canu_unpol

#structure specification
course_dir=/data/users/xdeng/assembly_annotation_course
polish_evaluation_dir=${course_dir}/polish_eval
evaulation_dir=${polish_evaluation_dir}/eval
BUSCO_dir=${evaulation_dir}/BUSCO
assembly_BUSCO_dir=${BUSCO_dir}/${assembly_name}

# --------------------------------------------------------------------------------------------
#Inoput
    #assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
    assembly=${course_dir}/canu_3/pacbio_canu_3.contigs.fasta #Unpolished canu assembly
    #assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta
    #assembly=${course_dir}/flye/assembly.fasta #Unpolished flye assembly
    #assembly=${course_dir}/rnaseq_assembly/trinity2/Trinity.fasta

#Go to the folder where the evaluation results will be stored
    cd ${assembly_BUSCO_dir}

#Make a copy of the augustus config directory to a location where I have write permission
    cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
    export AUGUSTUS_CONFIG_PATH=./augustus_config

#Run busco to assess the quality of the assemblies
    busco -i ${assembly} -l brassicales_odb10 -o ${assembly_name} -m genome --cpu 8
        #Options entered here are:
            #"-i": input file for BUSCO to analyze
            #"-l": define the specific BUSCO lineage dataset that will be used for the assessment. BUSCO lineages are curated sets of highly conserved genes expected to be found in all members of a taxonomic group
            #"-o": This option sets the name for the output directory where BUSCO will save all the results, logs, and intermediate files generated during the analysis. 
            #"-m": Specify which BUSCO analysis mode to run, genome, proteins, transcriptome (!!!FOR THE CANU AND FLYE ASSEMBLY I USE GENOME AND FOR THE TRINITRY ASSEMBLY I USE TRANSCRIPTOME!!!)
            #"--cpu": Specify the number (N=integer) of threads/cores to use.


#Remove the augustus config directory again
    rm -r ./augustus_config
