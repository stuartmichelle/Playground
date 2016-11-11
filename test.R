ls mapped.*.bed | sed 's/mapped.//g' | sed 's/.bed//g' | shuf | parallel --memfree 50G --no-notice \
--delay 1 freebayes -b cat-RRG.bam -t mapped.{}.bed -v raw.{}.vcf -f reference.fasta \
-m 5 -q 5 -E 3 --min-repeat-entropy 1 -V --populations popmap -n 4 -j 15 &