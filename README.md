This is a tutorial on running a GWAS from a VCF file and phenotype file.
### 1. Converting VCF file:
1. Need to convert your VCF file to PLINK's binary format: `plink --vcf [your_vcf_file].vcf --make-bed --out [output_prefix]`
2. This will generate [output_prefix].bed, [output_prefix].bim, and [output_prefix].fam files

### 2. Phenotype Format:
Your phenotype file should be in a format that PLINK can read. Typically, it should have at least two columns: the first for individual IDs and the second for the phenotype. Make sure the individual IDs in your phenotype file match those in the `.fam` file generated from the VCF.

### 3. Running GWAS:
1. Download `fixfam.py` script
2. Download and activate Conda environment: `gwas_env.yml`
#### Individual
1. Make sure the converted VCF files, phenotype file, `fixfam.py`, and `automate_test.sh` are in the same directory
2. Edit script for your own pathways and prefixes
3. Run `automate_test.sh [phenotype_file].csv`
4. This will generate [output prefix].assoc.txt in an output folder
#### Multiple
1. Create a phenotype folder in the directory with all phenotype files
2. Make sure converted VCF files, phenotype folder, `fixfam.py`, `automate_test.sh`, and `automate_multiple.sh` are in the same directory
3. Run 'automate_multiple.sh'
4. This will generate [output prefix].assoc.txt in an output folder for all phenotypes

### 4. Downstream Analysis
1. Copy [output prefix].assoc.txt to local computer
2. Run file through `gwas_downstream_analysis.R` to create figures (Manhattan Plot)
3. Update to your variables and pathways throughout analysis

