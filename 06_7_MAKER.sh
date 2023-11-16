#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=maker
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=Generate_gff_fasta
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_maker_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_maker_%j.e
#SBATCH --partition=pall

# Load the module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

# Define output and input directories
#course_dir=/data/users/xdeng/assembly_annotation_course
#output_dir=${course_dir}/09_Annotation_Control
#    mkdir -p ${output_dir}
#    cd ${output_dir}
#ctl=/data/users/xdeng/assembly_annotation_course/09_Annotation_Control/maker_opts.ctl

#COURSEDIR=/data/courses/assembly-annotation-course
#SOFTWAREDIR=/software

#ln -s ${COURSEDIR}/CDS_annotation


# 1) CREATE CONTROL FILES (templates)
#singularity exec \
#--bind ${SCRATCH} \
#--bind ${COURSEDIR} \
#--bind ${SOFTWAREDIR} \
#--bind ${course_dir} \
#${COURSEDIR}/containers2/MAKER_3.01.03.sif \
#maker -CTL


# 2) COPY THE PREPARED MAKER OPTIONS from script folder to output folder (overwriting the freshly created template)
#cp ${ctl} ${output_dir}/maker_opts.ctl


# 3) RUN MAKER
#mpiexec -n 16 singularity exec \
#--bind ${SCRATCH} \
#--bind ${COURSEDIR} \
#--bind ${SOFTWAREDIR} \
#--bind ${course_dir} \
#${COURSEDIR}/containers2/MAKER_3.01.03.sif \
#maker -mpi -base run_mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl


#4) Generate gff and fasta files
export TMPDIR=$SCRATCH
base="run_mpi"
cd ${base}.maker.output
gff3_merge -d /data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output/run_mpi_master_datastore_index.log -o Sha_group.all.maker.gff
gff3_merge -d /data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output/run_mpi_master_datastore_index.log -n -o Sha_group.all.maker.noseq.gff
fasta_merge -d /data/users/xdeng/assembly_annotation_course/09_Annotation_Control/run_mpi.maker.output/run_mpi_master_datastore_index.log -o Sha_group