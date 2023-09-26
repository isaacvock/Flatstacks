from snakemake.io import expand, glob_wildcards

SAMP_NAMES = ['A', 'B']

# Features to quantify
FEATURE_NAMES = ['total', 'exonbin', 'exonic']

def get_target_input():

    target = []

    if False:

        target = target + str(config["annotation"])

    target = target + expand("results/quantify/{SID}_{feature}.csv", SID = SAMP_NAMES, feature = FEATURE_NAMES)

    return target

get_target_input()