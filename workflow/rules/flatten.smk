rule flatten:
    input:
        gtf="results/annotation/genome.gtf"
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
        "results/flattened/flat_genome_exonID.gtf,
    log:
        "logs/add_exon.log",
    conda:
        "../envs/add_exon.yaml",
    shell:
        """
        awk -v FS="\t" '$3 != "exonic_part" {print $0}
                $3 == "exonic_part" {split($9, atr, "\"") 
                                        $0 = $0"; exon_id \"E" atr[2] atr[6] "\";"
                                        print $0}'  {input} >  {output}
        """
        
