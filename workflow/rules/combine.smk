if(config["spike_in"]):
    rule combine_gtf:
        input:
            ref="results/annotation/genome_chr.gtf",
            spike="results/annotation/spikein_genome_chr.gtf"
        output:
            cref=config["annotation"]
        log:
            "logs/combine_gtf/combine_gtf.log"
        shell:
            "cat {input.ref} {input.spike} > {output.cref} 2> {log}"

    rule combine_fasta:
        input:
            ref="results/genome/genome_chr.fasta",
            spike="results/genome/spikein_genome_chr.fasta"
        output:
            cref="results/combined/combined_genome_chr.fasta"
        log:
            "logs/combine_fasta/combine_fasta.log"
        shell:
            "cat {input.ref} {input.spike} > {output.cref} 2> {log}"