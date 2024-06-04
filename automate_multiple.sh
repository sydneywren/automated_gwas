#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=28g
#SBATCH --time=7-20:00:00
#SBATCH --job-name=GWAS_aut_mult
#SBATCH --output=GWAS_aut_mult.out.%j
#SBATCH --partition=bmh
#SBATCH -o /home/swren/GWAS/slurm_log/gwas_aut_mult_stdout-%j.txt
#SBATCH -e /home/swren/GWAS/slurm_log/gwas_aut_mult_stderr-%j.txt
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sewren@ucdavis.edu

folder="/home/swren/GWAS/phenotypes"

# Iterate over each file in the folder
for file in "$folder"/*; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Execute your existing script with the current file as an argument
       sbatch automate_test.sh "$file"
    fi
done
