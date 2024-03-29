### Functions to be used across rules
import glob


# Sample names, used in multiple places to help Snakemake infer wildcards
# and to expand list of bam files
SAMP_NAMES = list(config['samples'].keys())

# Features to quantify
FEATURE_NAMES = ['total', 'exonbin', 'exonic']

# Retrieve input bam files for first steps
def get_input_bams(wildcards):
    return config["samples"][wildcards.sample]


# Target rule (so final output to be looked for)
def get_target_input():

    target = []

    if config["download"]:

        target = target + str(config["annotation"])

    target = target + expand("results/quantify/{SID}_{feature}.csv", SID = SAMP_NAMES, feature = FEATURE_NAMES)

    return target

# Determining output file names for downloaded references
if config["download"]:

    if config["spike_in"]:

        MAIN_GTF_NAME = "results/annotation/genome_chr.gtf"

    else:

        MAIN_GTF_NAME = str(config["annotation"])
