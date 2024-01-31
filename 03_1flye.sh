#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_concat
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_flye2_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_flye2_%j.e
#SBATCH --partition=pall


module load UHTS/Assembler/flye/2.8.3
out_path="/data/users/xdeng/assembly_annotation_course"
in_path="/data/users/xdeng/assembly_annotation_course/participant_4/pacbio"
# flye --pacbio-raw $in_path/ERR3415830.fastq.gz --out-dir $out_path/pacbio_assembly --threads 4
# flye --pacbio-raw $in_path/ERR3415830.fastq.gz --out-dir $out_path/pacbio_assemply --threads 4

# flye concat
# Uses the genome size from before.
flye --pacbio-raw $in_path/*.fastq.gz -o $out_path/flye --threads 16 -g 126m 
