#!/usr/bin/env bash
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=illumina
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_illumina_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_illumina_%j.e


#file="/data/users/xdeng/assembly_annotation_course/02_raw_data/pacbio/ERR3415830.fastq.gz"
#file="/data/users/xdeng/assembly_annotation_course/02_raw_data/pacbio/ERR3415831.fastq.gz"
file1="/data/users/xdeng/assembly_annotation_course/02_raw_data/Illumina/ERR3624575_2.fastq.gz"
file2="/data/users/xdeng/assembly_annotation_course/02_raw_data/Illumina/ERR3624575_2.fastq.gz"

zcat $file1 | awk 'BEGIN{n=0; s=0} /length/ {++n; s=s+substr($3, 8)} END{print n; print s}'
zcat $file2 | awk 'BEGIN{n=0; s=0} /length/ {++n; s=s+substr($3, 8)} END{print n; print s}'
