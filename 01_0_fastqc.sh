#!/usr/bin/env bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=04:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_pb31_qc_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_pb31_qc%j.e
#SBATCH --partition=pall

module add UHTS/Quality_control/fastqc/0.11.9
# Create links to the read-files

# Illumina fastqc
#fastqc -o /data/users/xdeng/assembly_annotation_course /data/users/xdeng/assembly_annotation_course/participant_4/Illumina/*.fastq.gz

# PacBio fastqc - specified pacbio 31
fastqc -t 2 -o /data/users/xdeng/assembly_annotation_course /data/users/xdeng/assembly_annotation_course/participant_4/pacbio/ERR3415831.fastq.gz
#fastqc -t 2 -o /data/users/xdeng/assembly_annotation_course /data/users/xdeng/assembly_annotation_course/participant_4/pacbio/*.fastq.gz
# RNAseq fastqc
#fastqc -o /data/users/xdeng/assembly_annotation_course /data/users/xdeng/assembly_annotation_course/participant_4/RNAseq/*.fastq.gz