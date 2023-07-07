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


rule tag_genome:
    input: 
        "results/genome/genome.fasta",
    output:
        "results/genome/genome_chr.fasta"
    log:
        "logs/tag_genome/genome_tag.log",
    shell:
        """
        awk '$1 ~ /^>/ { split($1, h, ">") 
                    print ">chr"h[2]}
                $1 !~ /^>/ { print $0}' {input} > {output}
        """

rule tag_annotation:
    input: 
        "results/annotation/genome.gtf",
    output:
        real_o="results/annotation/genome_chr.gtf"
    log:
        "logs/tag_annotation/annotation_tag.log",
    shell:
        """
        awk -v OFS="\t" -v FS="\t" ' $1 !~ /^#/ {$1 = "chr"$1}
            {print $0}' {input} > {output.real_o}

        """