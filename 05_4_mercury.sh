#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --job-name=merqu_canu_unpol
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_merqu_canu_unpol_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_merqu_canu_unpol_%j.e
#SBATCH --partition=pall



#assembly_name=canu
#assembly_name=flye
#assembly_name=flye_unpol
assembly_name=canu_unpol

#Specify directory structure and create them
    course_dir=/data/users/xdeng/assembly_annotation_course
        raw_data_dir=${course_dir}/raw_data
        polish_evaluation_dir=${course_dir}/polish_eval
            evaulation_dir=${polish_evaluation_dir}/eval
            #evaulation_dir=${polish_evaluation_dir}/no_polish
                meryl_dir=${evaulation_dir}/meryl
                #meryl_dir=${polish_evaluation_dir}/no_polish
                merqury_dir=${evaulation_dir}/merqury
                    assembly_merqury_dir=${merqury_dir}/${assembly_name}
                    assembly_meryl_dir=${meryl_dir}/${assembly_name}
    
#Specify the assembly to use
    #assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta #Polished canu assembly
    assembly=${course_dir}/canu_3/pacbio_canu_3.contigs.fasta #Unpolished canu assembly
    #assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta #Polished flye assembly
    #assembly=${course_dir}/flye/assembly.fasta #Unpolished flye assembly

#Change permisson of assembly otherwise there is an error (I did not fully understand why) and go to folder where results should be stored.
    chmod ugo+rwx ${assembly}
    cd ${assembly_merqury_dir}

#Run merqury to assess quality of the assemblies; do not indent
apptainer exec \
--bind $course_dir \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${meryl_dir}/genome.meryl ${assembly} ${assembly_name}