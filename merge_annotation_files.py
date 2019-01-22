#!/bin/env/python

import sys
import pandas as pd

file1 = sys.argv[1] #.derep.md5_header.tsv
file2 = sys.argv[2] #.entry_name.tsv
file3 = sys.argv[3] #.tab
filename = sys.argv[4] #.annotation.tsv

df1 = pd.read_csv(file1, sep='\t')

df2 = pd.read_csv(file2, sep='\t', names=['name','Entry name'])

df3 = pd.read_csv(file3, sep='\t')

df_out = df1.merge(df2, on='name', how='left').merge(df3, on='Entry name', how='left')

df_out.to_csv(filename, sep='\t', index=False)

print('Finished merging files')
