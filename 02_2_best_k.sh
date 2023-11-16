#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5GB
#SBATCH --time=02:00:00
#SBATCH --job-name=best_kmer
#SBATCH --mail-user=xiaoyue.deng@students.unibe.ch
#SBATCH --output=/data/users/xdeng/assembly_annotation_course/outputs_errors/output_best_kmer_%j.o
#SBATCH --error=/data/users/xdeng/assembly_annotation_course/outputs_errors/error_best_kmer_%j.e
#SBATCH --partition=pall

if [ -z $1 ]; then
  echo "Usage: ./best_k.sh [-c] <genome_size> [tolerable_collision_rate]"
  echo -e "  -c         : [OPTIONAL] evaluation will be on homopolymer compressed genome. EXPERIMENTAL"
  echo -e "  genome_size: Haploid genome size or diploid genome size, depending on what we evaluate. In bp."
  echo -e "  tolerable_collision_rate: [OPTIONAL] Error rate in the read set. DEFAULT=0.001 for illumina WGS"
  echo -e "See Fofanov et al. Bioinformatics, 2004 for more details."
  echo
  exit -1
fi

if [ "x$1" = "x-c" ]; then
  compress="1"
  shift
fi

if [ ! -z $2 ]; then
	e=$2
else
	e=0.001
fi

g=$1

echo "genome: $g"
echo "tolerable collision rate: $e"
if [[ -z $compress ]]; then
  n=4;
else
  n=3;
fi
k=`echo $g $e | awk '{print $1"\t"(1-$2)/$2}' | awk -v n=$n '{print log($1*$2)/log(n)}'`
echo $k