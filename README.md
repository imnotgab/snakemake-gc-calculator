# **GC Content Calculation Pipeline**
This project contains a lightweight Snakemake workflow designed to calculate the GC content (the percentage of Guanine and Cytosine nucleotides) of DNA sequences provided in FASTA format. 
It processes multiple sequences and compiles the results into a single tabular file.

# **Dependencies**
You need:

- Snakemake (to manage the workflow),

- Python 3 (used within the Snakemake *run* block, so no worries no external libraries like Pandas or Biopython are required),

- Standard Unix tools (*cat* (*ang. concatenate*) for file concatenation).

# **Project Structure & Input Data**
The pipeline expects that input FASTA files are located in the same directory as the Snakefile.

## Main configuration variables:

- **DATA**: A list of sample names to be processed (currently set to ["test1", "test2"]),

- Corresponding input files must be named **{sample}.fa** (e.g., test1.fa, test2.fa).

# Pipeline Steps
The workflow consists of two simple steps:

1. **calc_gc**:

    - Reads each input **.fa** file line by line.

    - Ignores header lines (starting with >).

    - Counts the total number of bases and the specific occurrences of 'G' and 'C' (case-insensitive).

    - Calculates the GC percentage and saves it to a **{sample}.gc** file inside the **030.output/** directory.

2. **create_tsv**:

    - Takes all the individual **.gc** files generated in the previous step.

    - Concatenates them into a **single final file** using the *cat* command.

# **Outputs**
The script will generate an output directory containing the following:

- **030.output/**

  - **test1.gc, test2.gc** - Intermediate files containing the GC percentage for individual samples.

  - **output.tsv** - The final concatenated results table. Each row contains the sample name and its GC content percentage, separated by a tab.

# **Usage**
To run the pipeline and generate the final TSV file:

```
Bash
#Check the execution plan without processing files:
snakemake -n

#Execute the workflow (e.g., using 4 CPU cores or more if needed):
snakemake --cores 4
```
