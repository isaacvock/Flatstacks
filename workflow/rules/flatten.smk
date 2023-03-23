rule flatten:
    input:
        gtf="results/annotation/genome.gtf"
    output:
        flatgtf="results/flattened/flat_genome.gtf",
    log:
        "logs/get-genome.log",
    conda: 
        "../envs/dexseq.yaml"
    threads: 1
    script:
        "../scripts/dexseq_prepare_annotation.py"
        
