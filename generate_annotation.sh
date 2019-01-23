#!/usr/local/bin/zsh

source $HOME/.zshrc

## Process FASTA headers and md5 hash ids to create complete annotation file

FASTA=$1
#ENTRYNAME="${FASTA%.*}.entry_name.tsv"
TAB="${FASTA%.*}.tab"
ANNOTATION="${FASTA%.*}.annotation.tsv"
MD5HEADER="${FASTA%.*}.derep.md5_header.tsv"
DEREP="${FASTA%.*}.derep.fa"

echo Dereplicating FASTA and assigning md5 hash-ids

## Dereplicate sequences by 97 percent similarity
cd-hit -i $FASTA -o $DEREP -c 0.97
## Convert FASTA to one-line format and remove header description (after whitespace)
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < $DEREP | awk '{ print $1 }' > $DEREP.tmp
mv $DEREP.tmp $DEREP
## Convert headers to md5
python3 convert_fasta_headers_md5.py $DEREP $MD5HEADER

echo Merge files to create a complete annotation file

python3 merge_annotation_files.py $MD5HEADER $ENTRYNAME $TAB $ANNOTATION

echo Annotation file saved as $ANNOTATION

echo Removing temporary files
rm -f $MD5HEADER
rm -f $ENTRYNAME

echo Done!
## EOF
