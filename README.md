# Create-Marker-Gene-Database
Scripts for creating "marker gene" reference files for use as database for sequence similarity searches

**Requirements**:
```
vsearch
Pandas (Python)
```

**Sample files**: 
Downloaded from UniProt. For example:

https://www.uniprot.org/uniprot/?query=terminase+family%3Aprotein+taxonomy%3A%22Viruses+%5B10239%5D%22&sort=score

1. FASTA format
2. Tab-seperated format

**Output files**:

1. derep.fa
2. annotation.tsv
