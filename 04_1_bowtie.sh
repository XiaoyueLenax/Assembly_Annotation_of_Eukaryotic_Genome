#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=18:00:00
#SBATCH --job-name=bowtie2_flye
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_bowtie2_polishing_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_bowtie2_polishing_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Aligner/bowtie2/2.3.4.1
    module add UHTS/Analysis/samtools/1.10

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly_name=canu
    assembly_name=flye

#Specify directory structure and create them (!!!COMMENT OUT THE ONEs ALREADY CREATED IN OTHER RUNS!!!)
    course_dir=/data/users/xdeng/assembly_annotation_course
        raw_data_dir=${course_dir}/participant_4
        polish_evaluation_dir=${course_dir}/polish_eval
            polish_dir=${polish_evaluation_dir}/polish
                index_dir=${polish_dir}/index
                    assembly_index_dir=${index_dir}/${assembly_name}
                align_dir=${polish_dir}/align
                    assembly_align_dir=${align_dir}/${assembly_name}
                    pilon_dir=${polish_dir}/pilon
                        assembly_pilon_dir=${pilon_dir}/${assembly_name}

    #mkdir ${polish_evaluation_dir}
    #mkdir ${polish_dir}
    #mkdir ${index_dir}
    #mkdir ${assembly_index_dir}
    #mkdir ${align_dir}
    #mkdir ${assembly_align_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly=${course_dir}/canu_3/pacbio_canu_3.contigs.fasta
    assembly=${course_dir}/flye/assembly.fasta

#Run bowtie2 to align the reads to the assembly
    #Create index
    # bowtie2-build ${assembly} index_bowtie2_$assembly_name
            #Options entered here are:
                #"${assembly}":
                #"-index_bowtie2":
        
        #Index is build in folder where the script is run, move the files to the desired output folder
    #            mv data/users/xdeng/assembly_annotation_course/*.bt2 ${assembly_index_dir}
                

    #Execute bowtie2
        bowtie2 --sensitive-local -x ${assembly_index_dir}/index_bowtie2 -1 ${raw_data_dir}/Illumina/*_1.fastq.gz -2 ${raw_data_dir}/Illumina/*_2.fastq.gz -S $SCRATCH/${assembly_name}.sam
            #Options entered here are:
                #"--sensitive-local":
                #"-x":
                #"-1/-2":
                #"-S":

#Convert SAM to BAM
    samtools view -b $SCRATCH/${assembly_name}.sam > $SCRATCH/${assembly_name}_unsorted.bam
        #Options entered here are:
            #"view": Views and converts SAM/BAM/CRAM files.
            #"-b": Output in the BAM format.
            #"-t: A tab-delimited file. Each line must contain the reference name in the first column and the length of the reference in the second column, with one line for each distinct reference.
            #"*.sam": Input file.
            #"*_unsorted.bam": Output file.

    #Sort BAM
        samtools sort -o $SCRATCH/${assembly_name}.bam $SCRATCH/${assembly_name}_unsorted.bam
            #Options entered here are:
                #"sort": Sort alignments by leftmost coordinates, or by read name when -n is used. 
                #"-o": Write the final sorted output to file, rather than to standard output.
                #"*_unsorted.bam": Input file

    #Index BAM
        samtools index $SCRATCH/${assembly_name}.bam
            #Options entered here are:
                #"index": Index coordinate-sorted BGZIP-compressed SAM, BAM or CRAM files for fast random access.
    
    #Move the bams created in the temporary folder $SCRATCH to the output folder
                mv $SCRATCH/${assembly_name}.bam* ${assembly_align_dir}

    #Run pilon to polish the assemblies
    java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome ${assembly} --frags ${polish_dir}/align/${assembly_name}/${assembly_name}.bam --output ${assembly_name} --outdir ${assembly_pilon_dir}
        #Options entered here are:
            #"--gemone": The input genome we are trying to improve, which must be the reference used for the bam alignments.
            #"--frags": A bam file consisting of fragment paired-end alignments, aligned to the --genome argument using bwa or bowtie2.
            #"--output": Prefix for output files
            #"--outdir": Use this directory for all output files.
