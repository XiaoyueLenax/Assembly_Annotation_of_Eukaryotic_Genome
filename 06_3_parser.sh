#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=Phylogenetics_doer
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_Phylogenetics_doer_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_Phylogenetics_doer_%j.e
#SBATCH --partition=pall

Genome_out="/data/users/xdeng/assembly_annotation_course/06_group_result/Sha_flye_polished.fasta.mod.out"
PERL_SCRIPT="/data/users/xdeng/assembly_annotation_course/01_scripts/parseRM.pl"
#Phylogenetics_doer 

# execute the script
cd /data/users/xdeng/assembly_annotation_course/TE_annotation
perl $PERL_SCRIPT -i /data/users/xdeng/assembly_annotation_course/06_group_result/Sha_flye_polished.fasta.mod.out -l 50,1 -v
