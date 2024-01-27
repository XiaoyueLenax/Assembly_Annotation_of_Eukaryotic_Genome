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
name=Illumina
#name=pacbio
#name=RNAseq
  input_file1=$1
  input_file2=$2
  output_file="${name}.jf"
  #K mer is set to 19 after testing & discussing
  jellyfish count -C -m 19 -s 1000000000 -t 4 -o "$output_file" <(zcat "$input_file1") <(zcat "$input_file2")
