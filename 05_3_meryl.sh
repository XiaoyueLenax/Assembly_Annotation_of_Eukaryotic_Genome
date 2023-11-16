#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=06:00:00
#SBATCH --job-name=meryl_w
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_meryl_w_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_meryl_w_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Assembler/canu/2.1.1

#Specify directory structure and create them
    course_dir=/data/users/xdeng/assembly_annotation_course
        polish_evaluation_dir=${course_dir}/polish_eval
            evaulation_dir=${polish_evaluation_dir}/eval
                meryl_dir=${evaulation_dir}/meryl
    
    #  mkdir ${meryl_dir}



    data_dir=/data/users/xdeng/assembly_annotation_course/raw_data/Illumina

meryl k=19 count output $SCRATCH/read_1.meryl ${data_dir}/*1.fastq.gz

meryl k=19 count output $SCRATCH/read_2.meryl ${data_dir}/*2.fastq.gz

meryl union-sum output ${meryl_dir}/genome.meryl $SCRATCH/read*.meryl