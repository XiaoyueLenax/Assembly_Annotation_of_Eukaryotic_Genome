#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=TE_breci_db
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_TE_breci_db_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_TE_breci_db_%j.e
#SBATCH --partition=pall
module load UHTS/Analysis/SeqKit/0.13.2

COURSEDIR="/data/courses/assembly-annotation-course"
input=$1
WORKDIR="/data/users/xdeng/assembly_annotation_course/EDTA_V1.9.6_new"
OUTDIR="/data/users/xdeng/assembly_annotation_course/TE"

cd $WORKDIR
singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
--bind $OUTDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $input -db rexdb-plant -pre breci_db

#Go to gff and check the position of occurance
#-f 1|sed 's/_INT.\+//'
#grep -f "IDs" / files, plot their abundance in genome.
#count numbers of Gypsy - can do creative plot shown by him in slides.