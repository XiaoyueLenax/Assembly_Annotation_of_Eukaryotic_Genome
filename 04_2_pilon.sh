#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=pilon_polishing
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_pilon_polishing_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_pilon_polishing_%j.e
#SBATCH --partition=pall


# You have integrated this into bowtie script. How clean.
#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        polish_evaluation_dir=${course_dir}/polish_eval
            polish_dir=${polish_evaluation_dir}/polish
                pilon_dir=${polish_dir}/pilon
                    assembly_pilon_dir=${pilon_dir}/${assembly_name}
    
    # ${pilon_dir}        
    # ${assembly_pilon_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${course_dir}/canu_3/pacbio_canu_3.contigs.fasta
    # assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Run pilon to polish the assemblies
    java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome ${assembly} --frags ${polish_dir}/align/${assembly_name}/${assembly_name}.bam --output ${assembly_name} --outdir ${assembly_pilon_dir}
        #Options entered here are:
            #"--gemone":
            #"--frags":
            #"--output":
            #"--outdir":