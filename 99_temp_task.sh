#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=10GB
#SBATCH --time=3:00:00
#SBATCH --job-name=copying_data
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_temp_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_temp_%j.e
#SBATCH --partition=pall


# This script is used for small tasks that are repeated or extra to the courses.
#scp /data/users/xdeng/assembly_annotation_course/participant_4/Illumina /data/users/xdeng/assembly_annotation_course/raw_data
