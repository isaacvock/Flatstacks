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


    rule tag_genome:
        input: 
            "results/annotation/spikein_genome.fasta",
        output:
            "results/annotation/spikein_genome_tagged.fasta"
        params:
            species=config["spike"]["species"],
        log:
            "logs/tag_genome/spikein_tag.log",
        shell:
            """
            awk '$1 ~ /^>/ { split($1, h, ">") 
                     print ">"h[2]"_{{params.species}}"}
                 $1 !~ /^>/ { print $0}' {input} > {output}
            """

    rule tag_annotation:
        input: 
            "results/annotation/spikein_genome.gtf",
        output:
            "results/annotation/spikein_genome_tagged.gtf"
        params:
            species=config["spike"]["species"],
        log:
            "logs/tag_genome/spikein_tag.log",
        shell:
            """
            awk -v OFS="\t" -v FS="\t" ' $1 !~ /^#/ {$1 = $1"_{{params.species}}"}
                {print $0}' {input} > {output}

            """