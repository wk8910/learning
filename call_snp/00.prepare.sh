curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/005/SRR4038955/SRR4038955_1.fastq.gz | gzip -d | head -100000 | gzip - > pch2-9D_1.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/005/SRR4038955/SRR4038955_2.fastq.gz | gzip -d | head -100000 | gzip - > pch2-9D_2.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/002/SRR4038952/SRR4038952_1.fastq.gz | gzip -d | head -100000 | gzip - > pch2-9A_1.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/002/SRR4038952/SRR4038952_2.fastq.gz | gzip -d | head -100000 | gzip - > pch2-9A_2.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/001/SRR4038951/SRR4038951_1.fastq.gz | gzip -d | head -100000 | gzip - > pch2-8D_1.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR403/001/SRR4038951/SRR4038951_2.fastq.gz | gzip -d | head -100000 | gzip - > pch2-8D_2.fastq.gz
curl ftp://ftp.ensembl.org/pub/current_fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz > yeast.fasta.gz
