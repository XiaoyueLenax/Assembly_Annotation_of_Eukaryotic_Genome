#!/usr/bin/env bash
#SBATCH --cpus-per-task=30
#SBATCH --mem=20GB
#SBATCH --time=8:00:00
#SBATCH --job-name=blast_genepred
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_blast_genepred_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_blast_genepred_%j.e
#SBATCH --partition=pall


module load Blast/ncbi-blast/2.10.1+
module add SequenceAnalysis/GenePrediction/maker/2.31.9

INPUT_FILE=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output/Sha_group.all.maker.proteins.fasta.renamed.fasta
COURSE_DIR=/data/courses/assembly-annotation-course
OUT_DIR=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/BLAST
cd ${OUT_DIR}/BLAST_DB

makeblastdb -in ${COURSE_DIR}/CDS_annotation/uniprot-plant_reviewed.fasta -dbtype prot -out ${OUT_DIR}/BLAST_DB/uniprot_plant_reviewed
blastp -query ${INPUT_FILE} -db ${OUT_DIR}/BLAST_DB/uniprot_plant_reviewed -num_threads 30 -outfmt 6 -evalue 1e-10 -out ${OUT_DIR}/blastp.out
