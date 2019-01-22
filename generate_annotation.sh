#!/usr/local/bin/zsh

source $HOME/.zshrc

## Process FASTA headers and md5 hash ids to create complete annotation file

FASTA=$1
ENTRYNAME="${FASTA%.*}.entry_name.tsv"
TAB="${FASTA%.*}.tab"
ANNOTATION="${FASTA%.*}.annotation.tsv"
MD5HEADER="${FASTA%.*}.derep.md5_header.tsv"
DEREP="${FASTA%.*}.derep.fa"

echo Create a header:entry_name index from $FASTA

grep '>' $FASTA | cut -d'>' -f2 | awk '{ split($0, a, " "); printf "%s\t", a[1]; split(a[1], b, "|"); printf "%s\n", b[3] }' > $ENTRYNAME

echo Dereplicating FASTA and assigning md5 hash-ids

vsearch --derep_fulllength $FASTA --fasta_width 0 --relabel_keep --relabel_md5 --minseqlength 0 --maxseqlength 50000000 --output $DEREP

echo Create a header:md5 index from $DEREP

grep '>' $DEREP | cut -d'>' -f2 | awk '{ split($0, a, " "); printf "%s\t%s\n", a[1], a[2]; }' > $MD5HEADER


python3 merge_annotation_files.py $MD5HEADER $ENTRYNAME $TAB $ANNOTATION

echo Annotation file saved as $ANNOTATION

echo Removing temporary files
rm $MD5HEADER
rm $ENTRYNAME

echo Done!

## EOF
