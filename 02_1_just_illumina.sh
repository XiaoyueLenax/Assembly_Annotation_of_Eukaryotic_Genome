#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem=40GB
#SBATCH --time=02:00:00
#SBATCH --job-name=jellyfish_illumina
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_jellyfishillu_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_jellyfishillu_%j.e
#SBATCH --partition=pall


module load UHTS/Analysis/jellyfish/2.3.0
# Define the base pathway

input_file1="/data/users/xdeng/assembly_annotation_course/participant_4/Illumina/ERR3624575_1.fastq.gz"
input_file2="/data/users/xdeng/assembly_annotation_course/participant_4/Illumina/ERR3624575_2.fastq.gz"
output_file="second_illumina.jf"
jellyfish count -C -m 19 -s 1000000000 -t 4 -o "$output_file" <(zcat "$input_file1") <(zcat "$input_file2")
