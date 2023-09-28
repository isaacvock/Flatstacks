if(config["spike_in"]):

    rule spikein_genome:
        output:
            "results/genome/spikein_genome.fasta",
        log:
            "logs/spikein_genome/spikein_genome.log",
        params:
            species=config["spike"]["species"],
            datatype="dna",
            build=config["spike"]["build"],
            release=config["spike"]["release"],
        wrapper:
            "v1.21.4/bio/reference/ensembl-sequence"


    rule spikein_annotation:
        output:
            "results/annotation/spikein_genome.gtf",
        params:
            species=config["spike"]["species"],
            fmt="gtf",
            build=config["spike"]["build"],
            release=config["spike"]["release"],
            flavor="",
        log:
            "logs/spikein_annotation/spikein_annotation.log",
        wrapper:
            "v1.21.4/bio/reference/ensembl-annotation"


    rule tag_spike_genome:
        input: 
            "results/genome/spikein_genome.fasta",
        output:
            "results/genome/spikein_genome_chr.fasta"
        params:
            species=config["species_tag"],
            shellscript=workflow.source_path("../scripts/tag_genome_spike.sh")
        log:
            "logs/tag_spike_genome/spikein_genome_tag.log",
        threads: 1
        shell:
            """
            chmod +x {params.shellscript}
            {params.shellscript} {input} {output} {params.species}
            """

    rule tag_spike_annotation:
        input: 
            "results/annotation/spikein_genome.gtf",
        output:
            temp_o=temp("results/annotation/spikein_genome_tagged.gtf"),
            real_o="results/annotation/spikein_genome_chr.gtf"
        params:
            species=config["species_tag"],
            shellscript=workflow.source_path("../scripts/tag_gtf_spike.sh")
        log:
            "logs/tag_spike_annotation/spikein_annotation_tag.log",
        threads: 1
        shell:
            """
            chmod +x {params.shellscript}
            {params.shellscript} {input} {output.temp_o} {output.real_o} {params.species}
            """