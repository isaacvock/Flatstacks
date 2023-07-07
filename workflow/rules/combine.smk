if(config["spike_in"]):
    rule combine_gtf:
        input:
            ref="results/annotation/genome.gtf",
            spike="results/annotation/spikein_genome_tagged.gtf"
        output:
            cref="results/combined/combined_genome.gtf"
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"

    rule combine_fasta:
        input:
            ref="results/genome/genome.fasta",
            spike="results/genome/spikein_genome_tagged.fasta"
        output:
            cref="results/combined/combined_genome.fasta"
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"