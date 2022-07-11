#! /bin/bash
#prepare the primer file
#dependencies：samtools >= 1.9 BLAST+, primerserver2, tsv-utils
#tsv-utils add into PATH
ls *.fna | while read id; do (samtools faidx $id); done
ls *.fna | while read id; do (makeblastdb -in $id -dbtype nucl); done
ls *.fna | while read id; do (primertool check primer.txt $id -t ${id%%.fna}.tsv); done
cat *.tsv > processing.tsv
tsv-filter -H --is-numeric 1 --ge 1:1 processing.tsv > result.01.tsv
tsv-select -f 1,12-15 result.01.tsv > result.02.tsv
tsv-filter -H --is-numeric Possible_Amplicon_Number --ge Possible_Amplicon_Number:1 result.02.tsv > result.03.tsv

