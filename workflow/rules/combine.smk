if(config["spike_in"]):
    rule combine_gtf:
        input:
            ref="results/flattened/flat_genome.gtf",
            spike="results/annotation/spikein_genome.gtf"
        output:
            cref="results/combined/combined_genome.gtf"
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"

    rule combine_fasta:
        input:
            ref="results/genome/genome.fa",
            spike="results/genome/spikein_genome.fa"
        output:
            cref="results/combined/combined_genome.fa"
        shell:
            "cat {input.ref} {input.spike} > {output.cref}"