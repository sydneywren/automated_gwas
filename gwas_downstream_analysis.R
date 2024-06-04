library(data.table)
library(qqman)
cg_dt<-fread("cg_gwas.assoc.txt")

#qq plot to examine distribution of p values
qq(ct_dt$p_lrt)
#plotting p value by chromosome
plot(-log(ct_dt$p_lrt)~ct_dt$chr)
#histogram of p values
hist(-log(ct_dt$p_lrt))
#snps per chromosome
as.data.table(table(ct_dt$chr))

ct_dt
ct<-data.table(CHR=ct_dt$chr,SNP=ct_dt$rs,BP=ct_dt$ps,P=ct_dt$p_lrt)
cg<-data.table(CHR=cg_dt$chr,SNP=cg_dt$rs,BP=cg_dt$ps,P=cg_dt$p_lrt)
#minor allele frequency is 0.01 or 1% (default for gemma)

# Calculate the Bonferroni threshold
n_tests = nrow(ct)  # Replace with the actual number of tests
bonferroni_p = 0.05 / n_tests

# Add the Bonferroni line to the plot
manhattan(ct)
abline(h = -log10(bonferroni_p), col = "green")

sig_snps<-ct[P<bonferroni_p,]
fwrite(sig_snps,"CT_significant_snps.txt")
ct_snps<-fread("CT_significant_snps.txt")
