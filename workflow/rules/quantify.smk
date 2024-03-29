rule sort:
    input:
        get_input_bams
    output:
        "results/sort/sorted_{sample}.bam"
    log:
        "logs/sorted/{sample}.log"
    threads: 8
    params:
        extra=config["samtools_params"],
    wrapper:
        "v2.1.1/bio/samtools/sort"


rule quantify_total:
    input:
        bam="results/sort/sorted_{sample}.bam",
        gtf="results/flattened/flat_genome_exonID.gtf"
    output:
        counts="results/quantify/{sample}_total.csv",
    params:
        strand=config["strandedness"]
    conda:
        "../envs/quantify.yaml"
    log:
        "logs/quantify_total/{sample}.log"
    threads: 1
    shell:
        """
        htseq-count -t aggregate_gene -m intersection-strict -s {params.strand} \
        -r pos -p bam --add-chromosome-info -i gene_id --nonunique=all \
        -c {output.counts} {input.bam} {input.gtf} 1> {log} 2>&1
        """


rule quantify_exonbin:
    input:
        bam="results/sort/sorted_{sample}.bam",
        gtf="results/flattened/flat_genome_exonID.gtf"
    output:
        counts="results/quantify/{sample}_exonbin.csv",
    params:
        strand=config["strandedness"]
    conda:
        "../envs/quantify.yaml"
    log:
        "logs/quantify_exonbin/{sample}.log"
    threads: 1
    shell:
        """
        htseq-count -t exonic_part -m union -s {params.strand} \
        -r pos -p bam --add-chromosome-info -i exon_id --nonunique=all \
        -c {output.counts} {input.bam} {input.gtf} 1> {log} 2>&1
        """

rule quantify_exonic:
    input:
        bam="results/sort/sorted_{sample}.bam",
        gtf="results/flattened/flat_genome_exonID.gtf"
    output:
        counts="results/quantify/{sample}_exonic.csv",
    params:
        strand=config["strandedness"]
    conda:
        "../envs/quantify.yaml"
    log:
        "logs/quantify_exonic/{sample}.log"
    threads: 1
    shell:
        """
        htseq-count -t exonic_part -m intersection-strict -s {params.strand} \
        -r pos -p bam --add-chromosome-info -i gene_id --nonunique=all \
        -c {output.counts} {input.bam} {input.gtf} 1> {log} 2>&1
        """