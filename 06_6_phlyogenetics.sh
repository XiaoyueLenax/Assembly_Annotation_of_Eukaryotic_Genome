#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=10GB
#SBATCH --time=8:00:00
#SBATCH --job-name=phylogenetic_doer
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_phylogenetic_doer_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_phylogenetic_doer_%j.e
#SBATCH --partition=pall


module load UHTS/Analysis/SeqKit/0.13.2
module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
module load Phylogeny/FastTree/2.1.10

# Define output and input directories
course_dir=/data/users/xdeng/assembly_annotation_course
output_dir=${course_dir}/06_group_result/phylogenetics
    mkdir -p ${output_dir}
    cd ${output_dir}

for tag in "Gypsy" "Copia"
do
    in_file=${course_dir}/06_group_result/${tag}/${tag}.dom.faa
    list_file=${output_dir}/${tag}_RT_prots.list
    out_file=${output_dir}/${tag}_RT.fasta
    if [[ "$tag" == "Gypsy" ]]; then
        rt_tag='Ty3-RT'
    elif [[ "$tag" == "Copia" ]]; then
        rt_tag='Ty1-RT'
    fi

    grep ${rt_tag} ${in_file} > ${list_file} #make a list of RT proteins to extract
    sed -i 's/>//' ${list_file} #remove ">" from the header
    sed -i 's/ .\+//' ${list_file} #remove all characters following "empty space" from the header
    seqkit grep -f ${list_file} ${in_file} -o ${out_file}

    sed_file=${out_file}.sed
    sed 's/|.\+//' ${out_file} > ${sed_file} #remove all characters following "|"

    clustalo_file=${sed_file}.clustalo_protein_alignment.fasta
    clustalo -i ${sed_file} -o ${clustalo_file}

    tree_file=${clustalo_file}.tree
    FastTree -out ${tree_file} ${clustalo_file}
done