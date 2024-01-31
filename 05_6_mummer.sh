#!/usr/bin/env bash
#SBATCH --cpus-per-task=10
#SBATCH --mem=20GB
#SBATCH --time=2:00:00
#SBATCH --job-name=mum_flye
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_mum_flye_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_mum_flye_%j.e
#SBATCH --partition=pall

module add UHTS/Analysis/mummer/4.0.0beta1
export PATH=/software/bin:$PATH

#Inputs
reference_file="/data/users/xdeng/assembly_annotation_course/raw_data/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
#reference_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/flye/flye.fasta"
#reference_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/canu/canu.fasta"
#----------------unpolished---------------
#query_file="/data/users/xdeng/assembly_annotation_course/flye/assembly.fasta"
#query_file="/data/users/xdeng/assembly_annotation_course/canu_3/pacbio_canu_3.contigs.fasta"
# ---------------polished-----------------
#query_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/canu/canu.fasta"
query_file="/data/users/xdeng/assembly_annotation_course/polish_eval/polish/pilon/flye/flye.fasta"

#Task ID for tracking purposes
#task_name=flye
#task_name=canu
#task_name=flye_pol
#task_name=canu_pol
task_name=compar3_canu_vs_flye

general_dir="/data/users/xdeng/assembly_annotation_course/comparison"
nucmer_dir=$outfile_general/nucmer
mummer_dir=$outfile_general/mummer

#nucmer_output_dir=$nucmer_dir/$task_name
#mummer_output_dir=$mummer_dir/$task_name

# match file
#match_file=/data/users/xdeng/assembly_annotation_course/comparison/mummer/try2/canu.delta
match_file=/data/users/xdeng/assembly_annotation_course/comparison/mummer/try2/flye_pol.delta
#match_file=/data/users/xdeng/assembly_annotation_course/comparison/mummer/try2/compar2.delta

mummerplot -filter -l -R ${reference_file} -Q ${query_file} --large --png -p $task_name --layout --fat ${match_file}
# Options explained:
  #-filter: Filters out alignments, improving clarity by removing clutter.
  #-l: Forces the use of the 'large' layout for plotting, suitable for large genomes.
  #-R ${reference_file}: Specifies the reference genome for labelling the plot.
  #-Q ${query_file}: Specifies the query genome for labelling the plot.
  #--large: Optimizes plot settings for large datasets.
  #--png: Outputs the plot in PNG format.
  #-p $task_name: Sets the prefix for the output files, defined by $task_name.
  #--layout: Uses an improved layout algorithm for the plot.
  #--fat: Increases the line width in the plot, making it easier to see.
  #${match_file}: Specifies the input file containing the alignment data to be plotted.
