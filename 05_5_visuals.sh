#!/usr/bin/env bash
#SBATCH --cpus-per-task=10
#SBATCH --mem=20GB
#SBATCH --time=2:00:00
#SBATCH --job-name=nucmer_canu
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_ncmer_canu_unpo_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_ncmer_canu_unpo_%j.e
#SBATCH --partition=pall


module add UHTS/Analysis/mummer/4.0.0beta1
#reference_file="/data/users/xdeng/assembly_annotation_course/raw_data/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
reference_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/flye/flye.fasta"
#reference_file="/data/users/xdeng/assembly_annotation_course/flye/assembly.fasta"
#query_file="/data/users/xdeng/assembly_annotation_course/flye/assembly.fasta"
#query_file="/data/users/xdeng/assembly_annotation_course/canu_3/pacbio_canu_3.contigs.fasta"
# ---------------polished-----------------
query_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/canu/canu.fasta"
#query_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/flye/flye.fasta"



#task_name=flye
#task_name=canu
#task_name=flye_pol
#task_name=canu_pol
task_name=compar2

general_dir="/data/users/xdeng/assembly_annotation_course/comparison"
nucmer_dir=$outfile_general/nucmer
mummer_dir=$outfile_general/mummer

#nucmer_output_dir=$nucmer_dir/$task_name
#mummer_output_dir=$mummer_dir/$task_name

#cd $mummer_output_dir

#nucmer -b 1000 -c 1000 $reference_file $query_file -p $task_name
nucmer --mincluster 100 --breaklen 1000 $reference_file $query_file -p $task_name
nucmer --mincluster 1000 --delta ${OUTPUT_DIR}/${filename}.delta --breaklen 1000 ${reference} ${assemblies[$SLURM_ARRAY_TASK_ID]}
  #--mincluster 1000: sets the minimum cluster length to 1000 base pairs, focusing the alignment on significant matches.
  #--delta ${OUTPUT_DIR}/${filename}.delta: Specifies the output file for the delta alignment results. 
  #--breaklen 1000: Sets the maximum allowed gap between matches in a cluster to 1000 base pairs, 
  #${reference}: The path to the reference genome file.
  #${assemblies[$SLURM_ARRAY_TASK_ID]}: Specifies the path to the query genome file (from an array of assemblies if running multiple alignments in a batch system like SLURM). 

#mummer -mum -b -c ref.fasta qry.fasta > ref_qry.mums
#mummerplot --postscript --prefix=ref_qry ref_qry.mums
#gnuplot ref_qry.gp
