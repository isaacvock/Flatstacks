rule flatten:
    input:
        gtf=config["annotation"]
    output:
        flatgtf="results/raw_flattened/flat_genome.gtf",
    log:
        "logs/get-genome.log",
    conda: 
        "../envs/dexseq.yaml"
    threads: 1
    script:
        "../scripts/dexseq_prepare_annotation.py"

rule add_exon:
    input:
        "results/raw_flattened/flat_genome.gtf",
    output:
        "results/flattened/flat_genome_exonID.gtf",
    log:
        "logs/add_exon.log",
    params:
        shellscript=workflow.source_path("../scripts/exon_ID.sh")
    conda:
        "../envs/add_exon.yaml",
    threads: 1
    shell:
        """
        chmod +x {params.shellscript}
        {params.shellscript} {input} {output}
        """
        
