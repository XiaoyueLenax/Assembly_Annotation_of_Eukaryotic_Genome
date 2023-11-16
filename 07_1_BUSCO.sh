#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=maker
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=busco_maker
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_busco_maker_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_busco_maker_%j.e
#SBATCH --partition=pall

# Load the module
module load SequenceAnalysis/GenePrediction/maker/2.31.9
module add UHTS/Analysis/busco/4.1.4

# Configure busco
#cp -r /software/UHTS/Analysis/busco/4.1.4/config/config.ini
#export BUSCO_CONFIG_FILE=./config.ini
#unset BUSCO_CONFIG_FILE

# set dirs
WORK_DIR=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control
cd $WORK_DIR
OUT_DIR=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/BUSCO
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=/data/users/xdeng/assembly_annotation_course/augustus_config

INPUT_FILE=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output/Sha_group.all.maker.proteins.fasta.renamed.fasta
busco -i $INPUT_FILE -l brassicales_odb10 -m proteins -c 20 -f --out Sha_group
# parameter -f : force busco, overwrites the original files