#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=28g
#SBATCH --time=7-20:00:00
#SBATCH --job-name=GWAS_aut
#SBATCH --output=GWAS_aut.out.%j
#SBATCH --partition=bmh
#SBATCH -o /home/swren/GWAS/slurm_log/gwas_aut_stdout-%j.txt
#SBATCH -e /home/swren/GWAS/slurm_log/gwas_aut_stderr-%j.txt
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sewren@ucdavis.edu

# Specify the file to process
file=$1
fam_file="/home/swren/GWAS/mutation_gwas_2.fam"
bed_file="/home/swren/GWAS/mutation_gwas_2.bed"
bim_file="/home/swren/GWAS/mutation_gwas_2.bim"

# Process CSV file
phenotype=$(basename "$file" .csv)
echo "Phenotype: $phenotype"
tr ',' '\t' < "$file" > "/home/swren/GWAS/$phenotype.txt"

#Fix FAM file
fixed_fam="${phenotype%.*}_updated.fam"
echo "Fixed FAM file: $fixed_fam"
python3 fixfam.py "$fam_file" "$phenotype.txt" "$fixed_fam"

# Process FAM file
updated_bed=$(basename "$fixed_fam" .fam)
echo "Updated BED file: $updated_bed"
plink --bed "$bed_file" --bim "$bim_file" --fam "$fixed_fam" --make-bed --out "$updated_bed"

# Make relatedness matrix
prefix=$(basename "$updated_bed" .bed)
echo "Prefix : $prefix"
gemma -bfile "$prefix" -gk 1 -o "$prefix"

# Process relate matrix file
relate="/home/swren/GWAS/output/${prefix%.*}.cXX.txt"
echo "Relatedness matrix file: $relate"
gemma -bfile "$prefix" -maf 0.05 -k "$relate" -lmm 4 -o "$prefix"
