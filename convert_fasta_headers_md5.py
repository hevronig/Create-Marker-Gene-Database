#!/bin/python3

import os
import sys
import pandas as pd
import hashlib

FASTA = sys.argv[1]
MD5 = os.path.splitext(FASTA)[0]+'.md5.fa'
INDEX = sys.argv[2]

original_headers = []
md5_headers = []

with open(FASTA, 'r') as inputf, open(MD5, 'w') as outputf:
    lines = filter(None, (line.rstrip() for line in inputf))
    for line in lines:
        if line.startswith('>'):
            original_header = line.replace('>','')
            original_headers.append(original_header)
        if not line.startswith('>'):
            md5_header = hashlib.md5(line.encode('utf-8')).hexdigest()
            md5_headers.append(md5_header)
            outputf.write('>'+md5_header+'\n')
            outputf.write(line+'\n')

df_index = pd.DataFrame(data=list(zip(original_headers,md5_headers)), columns=['name','md5'])

df_index.to_csv(INDEX, sep='\t', index=False)


