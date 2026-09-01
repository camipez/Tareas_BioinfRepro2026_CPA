## 4.1. Clean the data

In a typical analysis, data will be received from an Illumina sequencer, or some other type of sequencer as FASTQ files.

The first requirement is to demultiplex, or sort, the raw data to recover the individual samples in the Illumina library.

While doing this, we will use the Phred scores provided in the FASTQ files to discard sequencing reads of low quality.

These tasks are accomplished using the `process_radtags` program.

### Some things to consider when running this program:

- `process_radtags` can handle both single-end or paired-end Illumina sequencing.

- The raw data can be compressed or gzipped (files end with a `.gz` suffix).

- You can supply a list of barcodes, or indexes, to `process_radtags` in order for it to demultiplex your samples.
  - If you also supply a sample name, `process_radtags` can use it to name the output files.
  - Multiple barcodes with the same sample name can be consolidated.

