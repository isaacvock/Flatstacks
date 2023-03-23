rule get_genome:
    output:
        "results/genome/genome.fasta",
    log:
        "logs/get_genome.log",
    params:
        species=config["ref"]["species"],
        datatype="dna",
        build=config["ref"]["build"],
        release=config["ref"]["release"],
    wrapper:
        "v1.21.4/bio/reference/ensembl-sequence"


rule get_annotation:
    output:
        "results/annotation/genome.gtf",
    params:
        species=config["ref"]["species"],
        fmt="gtf",
        build=config["ref"]["build"],
        release=config["ref"]["release"],
        flavor="",
    log:
        "logs/get_annotation.log",
    wrapper:
        "v1.21.4/bio/reference/ensembl-annotation"