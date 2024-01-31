#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --job-name=nucmer_comparison
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_nucmer_comparison_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_nucmer_comparison_%j.e
#SBATCH --partition=pall

### Run this script 3 times.
#1. assembly_name=canu;    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta; reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#2. assembly_name=flye;    assembly=${course_dir}/02_assembly/flye/assembly.fasta;     reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#3. assembly_name=compare; assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta; reference=${course_dir}/02_assembly/flye/assembly.fasta

course_dir=/data/users/xdeng/assembly_course
raw_data_dir=${course_dir}/RawData
comparison_dir=${course_dir}/04_comparison
nucmer_dir=${comparison_dir}/nucmer
assembly_nucmer_dir=${nucmer_dir}/${assembly_name}

module add UHTS/Analysis/mummer/4.0.0beta1

#Task ID
assembly_name=canu
# assembly_name=flye
# assembly_name=compare

#Input Files
    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
    # assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Specify the reference genome
    reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
    # reference=${course_dir}/02_assembly/flye/assembly.fasta

#Go to folder where results should be stored.
    cd ${assembly_nucmer_dir}

#Run nucmer to compare assemblies
    nucmer -b 1000 -c 1000 -p ${assembly_name} ${reference} ${assembly}
# Options explained:
    #- `nucmer`: Invokes the NUCmer tool from MUMmer for aligning genomes.
    #- `-b 1000`: Sets the maximum gap between adjacent matches in a cluster to 1000 base pairs.
    #- `-c 1000`: Specifies the minimum cluster length as 1000 base pairs.
    #- `-p ${assembly_name}`: Uses the `${assembly_name}` variable as the prefix for output files.
    #- `${reference}`: Path to the reference genome file.
    #- `${assembly}`: Path to the query genome (assembly) file to be aligned.
