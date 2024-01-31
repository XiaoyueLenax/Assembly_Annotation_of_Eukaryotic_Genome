#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=maker
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=Generate_gff_fasta
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_maker_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_maker_%j.e
#SBATCH --partition=pall

# Load the module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

base="Sha_group"
cd /data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output

protein=${base}.all.maker.proteins.fasta
transcript=${base}.all.maker.transcripts.fasta
gff=${base}.all.maker.noseq.gff
prefix=${base}_

# Making a copy of the file for later
cp $gff ${gff}.renamed.gff
cp $protein ${protein}.renamed.fasta
cp $transcript ${transcript}.renamed.fasta

# Generates a mapping file to standardize feature IDs in GFF files produced by MAKER.
maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > ${base}.id.map
map_gff_ids ${base}.id.map ${gff}.renamed.gff
map_fasta_ids ${base}.id.map ${protein}.renamed.fasta
map_fasta_ids ${base}.id.map ${transcript}.renamed.fasta
