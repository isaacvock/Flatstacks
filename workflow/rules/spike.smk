if(config["spike_in"]):

    rule spikein_genome:
        output:
            "results/genome/spikein_genome.fasta",
        log:
            "logs/spikein_genome.log",
        params:
            species=config["spike"]["species"],
            datatype="dna",
            build=config["spike"]["build"],
            release=config["spike"]["release"],
        wrapper:
            "v1.21.4/bio/reference/ensembl-sequence"


    rule spikein_annotation:
        output:
            "results/annotation/spikein_genome.gtf",
        params:
            species=config["spike"]["species"],
            fmt="gtf",
            build=config["spike"]["build"],
            release=config["spike"]["release"],
            flavor="",
        log:
            "logs/spikein_annotation.log",
        wrapper:
            "v1.21.4/bio/reference/ensembl-annotation"