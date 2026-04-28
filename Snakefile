DATA = ["test1", "test2"]

rule all:
    input:
        "030.output/output.tsv"

rule calc_gc:
    input:
        "{sample}.fa"
    output:
        "030.output/{sample}.gc"
    run:
        gc_count = 0
        total_count = 0
        with open(input[0], "r") as f:
            for line in f:
                if not line.startswith(">"):
                    seq = line.strip().upper()
                    gc_count += seq.count("G") + seq.count("C")
                    total_count += len(seq)
        
        perc = (gc_count / total_count) * 100 if total_count > 0 else 0.0
        
        with open(output[0], "w") as out:
            out.write(f"{wildcards.sample}\t{perc}\n")

rule create_tsv:
    input:
        expand("030.output/{sample}.gc", sample=DATA)
    output:
        "030.output/output.tsv"
    shell:
        "cat {input} > {output}"
