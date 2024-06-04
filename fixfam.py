import argparse

def merge_phenotype(fam_file, phenotype_file, output_file):
    # Read phenotype data into a dictionary
    phenotype_dict = {}
    with open(phenotype_file, 'r') as pheno:
        for line in pheno:
            parts = line.strip().split('\t')
            phenotype_dict[parts[0]] = parts[1]

    # Read .fam file and write to a new file with updated phenotypes
    with open(fam_file, 'r') as fam, open(output_file, 'w') as out:
        for line in fam:
            parts = line.strip().split()
            individual_id = parts[1]
            # Update phenotype if individual ID matches
            if individual_id in phenotype_dict:
                parts[5] = phenotype_dict[individual_id]
            out.write('\t'.join(parts) + '\n')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Merge phenotype data into .fam file.')
    parser.add_argument('fam_file', type=str)
    parser.add_argument('phenotype_file', type=str)
    parser.add_argument('output_file', type=str)

    args = parser.parse_args()

    merge_phenotype(args.fam_file, args.phenotype_file, args.output_file)

