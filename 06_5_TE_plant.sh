#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=TE_sorter
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_TE_sorter_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_TE_sorter_%j.e
#SBATCH --partition=pall

# Define output and input directories
wks=/data/users/xdeng/assembly_annotation_course/06_group_result
tag="brassicaceae"
    output_dir=${wks}/${tag}
    mkdir -p ${output_dir}
    cd ${output_dir}
COURSEDIR=/data/courses/assembly-annotation-course
    input_dir=${COURSEDIR}/CDS_annotation/
        input_file=${input_dir}/Brassicaceae_repbase_all_march2019.fasta

singularity exec \
--bind ${output_dir} \
--bind ${COURSEDIR} \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter ${input_file} -db rexdb-plant -pre ${tag}