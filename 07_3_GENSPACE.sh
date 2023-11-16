#!/usr/bin/env bash
#SBATCH --cpus-per-task=30
#SBATCH --mem=20GB
#SBATCH --time=8:00:00
#SBATCH --job-name=GENESPACE_SORT
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_GENESPACE_SORT_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_GENESPACE_SORT_%j.e
#SBATCH --partition=pall

### Run this script X times.

module add UHTS/Analysis/SeqKit/0.13.2

INPUT_DIR=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output
OUTPUT_DIR=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/GENESPACE
BED_DIR=${OUTPUT_DIR}/BED
PEPTIDE_DIR=${OUT_DIR}/PEPTIDE


#Get all contings and sort them by size
    awk '$3=="contig"' ${INPUT_DIR}/Sha_group.all.maker.noseq.gff.renamed.gff|sort -t $'\t' -r -k5,5n > ${OUT_DIR}/size_sorted_contigs.txt

#Get the 10 longest
    tail ${OUT_DIR}/size_sorted_contigs.txt|cut -f1 > ${OUT_DIR}/contigs.txt

#Create bed file
    awk '$3=="mRNA"' ${INPUT_DIR}/Sha_group.all.maker.noseq.gff.renamed.gff|cut -f 1,4,5,9|sed 's/ID=//'|sed 's/;.\+//'|grep -w -f ${OUT_DIR}/contigs.txt > ${BED_DIR}/C24.bed

#Get the gene IDs
    cut -f4 ${BED_DIR}/C24.bed > ${OUT_DIR}/gene_IDs.txt

#Create fasta file
    cat ${INPUT_DIR}/Sha_group.all.maker.proteins.fasta.renamed.fasta|seqkit grep -r -f ${OUT_DIR}/gene_IDs.txt |seqkit seq -i > ${PEPTIDE_DIR}/C24.fa