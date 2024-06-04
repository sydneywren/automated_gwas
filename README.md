This is a tutorial on running a GWAS from a VCF file and phenotype file.
### 1. Converting VCF file:
1. Need to convert your VCF file to PLINK's binary format: `plink --vcf [your_vcf_file].vcf --make-bed --out [output_prefx]`
2. This will generate [output_prefix].bed, [output_prefix].bim, and [output_prefix].fam files

### 2. Phenotype Format:
   

