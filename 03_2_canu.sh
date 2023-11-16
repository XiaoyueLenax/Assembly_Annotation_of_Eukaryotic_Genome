#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=canu_3
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_canu3_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_canu3_%j.e
#SBATCH --partition=pall

module load UHTS/Assembler/canu/2.1.1

file_path="/data/users/xdeng/assembly_annotation_course/participant_4/pacbio"
out_dir="/data/users/xdeng/assembly_annotation_course/canu_3"
# files="ERR3415830.fastq.gz ERR3415831.fastq.gz"
# gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY"


# what is the genome size?
canu -p pacbio_canu_3 -d $out_dir genomeSize=126m -pacbio $file_path/*.fastq.gz maxThreads=16 maxMemory=64 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY"

#older version
#for file in $files; do
#  canu -p pacbio_canu -d $out_dir genomeSize=126m -pacbio $file_path/$file maxThreads=16 maxMemory=64
#done