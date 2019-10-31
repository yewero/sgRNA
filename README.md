# sgRNA
A pipeline for sgRNA design

## Usage
1. Rscript do_sgRNA_form_sg.r foo.fa xname
2. bash do_bt2.psh xname
3. bash do_step1.psh xname
4. bash do_step2.psh xname
5. bash do_step3.psh xname

`foo.fa` is the path of genomic sequence file or one chromosome in fasta format (e.g. chr9.fa).  
`xname` is the accession name (e.g. batch1).

The output file named "xname_selected.txt" contains the sgRNA information.

## Citation
Zhou, Y. *et al.* [Painting a specific chromosome with CRISPR/Cas9 for live-cell imaging](https://www.ncbi.nlm.nih.gov/pubmed/28084328). *Cell Res*, doi:10.1038/cr.2017.9 (2017).
