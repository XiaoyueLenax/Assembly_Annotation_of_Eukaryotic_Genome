#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_fastqc_rna_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_fastqc_rna_%j.e
#SBATCH --partition=pall

module add UHTS/Quality_control/fastqc/0.11.9
fastqc -o /data/users/xdeng/assembly_annotation_course /data/users/xdeng/assembly_annotation_course/participant_4/RNAseq/*.fastq.gz