#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=TE_sorter
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_TE_sorter_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_TE_sorter_%j.e
#SBATCH --partition=pall


working_dir=/data/users/xdeng/assembly_annotation_course/06_group_result
COURSEDIR=/data/courses/assembly-annotation-course

for tag in "Gypsy" "Copia"
do
    tag_dir=${working_dir}/${tag}
        input_file=${tag_dir}/${tag}.fa
        cd ${tag_dir}

    singularity exec \
    --bind ${COURSEDIR} \
    --bind ${tag_dir} \
    ${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
    TEsorter ${input_file} -db rexdb-plant -pre ${tag}
done