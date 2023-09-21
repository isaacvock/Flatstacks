if(config["spike_in"]):
    rule combine_gtf:
        input:
            ref="results/annotation/genome_chr.gtf",
            spike="results/annotation/spikein_genome_chr.gtf"
        output:
            cref=config["annotation"]
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"

    rule combine_fasta:
        input:
            ref="results/genome/genome_chr.fasta",
            spike="results/genome/spikein_genome_chr.fasta"
        output:
            cref="results/combined/combined_genome_chr.fasta"
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"