#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_3_fr
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_trinity_3_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_trinity_3_%j.e
#SBATCH --partition=pall

module load UHTS/Assembler/trinityrnaseq/2.5.1

# Define input and output directories and file names
input_dir="/data/users/xdeng/assembly_annotation_course/participant_4/RNAseq/"
output_dir="/data/users/xdeng/assembly_annotation_course/rnaseq_assembly/trinity3"
left_reads="ERR754081_1.fastq.gz"
right_reads="ERR754081_2.fastq.gz"

#Trinity --seqType fq --left "$input_dir/$left_reads" --right "$input_dir/$right_reads" --output "$output_dir" --CPU 16 --max_memory 64G --SS_lib_type RF
Trinity --seqType fq --left "$input_dir/$left_reads" --right "$input_dir/$right_reads" --output "$output_dir" --CPU 16 --max_memory 64G --SS_lib_type FR