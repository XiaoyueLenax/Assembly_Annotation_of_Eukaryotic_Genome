#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=EDTA2
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_EDTA2_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_EDTA2_%j.e
#SBATCH --partition=pall

COURSEDIR="/data/courses/assembly-annotation-course"
WORKDIR="/data/users/xdeng/assembly_annotation_course"
DATADIR="/data/users/grochat/genome_assembly_course"
cd $WORKDIR
singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
--bind $DATADIR \
$COURSEDIR/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome /data/users/grochat/genome_assembly_course/data/assembly/flye_assembly_polished.fasta #The genome FASTA \
--species others \
--step all \
--cds /data/courses/assembly-annotation-course/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated # The coding sequences FASTA \
--anno 1 #perform whole-genome TE annotation after TE library construction \
-t 50 #Number of threads to run this script (default: 4)
