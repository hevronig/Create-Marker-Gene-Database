# Create-Marker-Gene-Database
Scripts for creating "marker gene" reference files for use as database for sequence similarity searches

#### Overview
The `generate_annotation.sh` is taking a FASTA file with common header format as can be usually found in UniProt, NCBI, etc. and performs the following:  

- Dereplicate sequences by 97 percent similarity with `cd-hit`
- Convert FASTA to one-line format and remove header description (after whitespace) with `awk`
- Convert headers to md5 with python script `convert_fasta_headers_md5.py`
- Merge files to create a complete annotation file with python script `merge_annotation_files.py`

#### Software requirements
```
cd-hit
Pandas (Python)
```

#### Requred files

- FASTA file (`.fa` extention)
- Tab-seperate annotation file (same name as FASTA with `.tab` exention)

Downloaded from UniProt, for example:  
https://www.uniprot.org/uniprot/?query=terminase+family%3Aprotein+taxonomy%3A%22Viruses+%5B10239%5D%22&sort=score

#### Output files

1. derep.fa
2. derep.md5.fa
3. derep.fa.clstr
4. annotation.tsv
