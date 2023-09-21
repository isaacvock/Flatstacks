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
    params:
        shellscript=workflow.source_path("../scripts/tag_genome.sh")
    threads: 1
    shell:
        """
        chmod +x {params.shellscript}
        {params.shellscript} {input} {output}
        """

rule tag_annotation:
    input: 
        "results/annotation/genome.gtf",
    output:
        real_o=MAIN_GTF_NAME
    log:
        "logs/tag_annotation/annotation_tag.log",
    params:
        shellscript=workflow.source_path("../scripts/tag_gtf.sh")
    threads: 1
    shell:
        """
        chmod +x {params.shellscript}
        {params.shellscript} {input} {output.real_o}
        """