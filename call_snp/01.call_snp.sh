zcat yeast.fasta.gz > yeast.fasta
./bin/bwa.kit/samtools faidx yeast.fasta
./bin/bwa.kit/bwa index yeast.fasta
./bin/bwa.kit/samtools dict yeast.fasta > yeast.dict

./bin/bwa.kit/bwa mem -t 32 -R '@RG\tID:pch2-9D\tSM:pch2-9D\tLB:pch2-9D' yeast.fasta pch2-9D_1.fastq.gz pch2-9D_2.fastq.gz | ./bin/bwa.kit/samtools sort --threads 32 -O bam -T ./.pch2-9D.tmp -l 3 -o pch2-9D.bam -
./bin/bwa.kit/bwa mem -t 32 -R '@RG\tID:pch2-9A\tSM:pch2-9A\tLB:pch2-9A' yeast.fasta pch2-9A_1.fastq.gz pch2-9A_2.fastq.gz | ./bin/bwa.kit/samtools sort --threads 32 -O bam -T ./.pch2-9A.tmp -l 3 -o pch2-9A.bam -
./bin/bwa.kit/bwa mem -t 32 -R '@RG\tID:pch2-8D\tSM:pch2-8D\tLB:pch2-8D' yeast.fasta pch2-8D_1.fastq.gz pch2-8D_2.fastq.gz | ./bin/bwa.kit/samtools sort --threads 32 -O bam -T ./.pch2-8D.tmp -l 3 -o pch2-8D.bam -

./bin/bwa.kit/samtools rmdup pch2-9D.bam pch2-9D.rmdup.bam
./bin/bwa.kit/samtools rmdup pch2-9A.bam pch2-9A.rmdup.bam
./bin/bwa.kit/samtools rmdup pch2-8D.bam pch2-8D.rmdup.bam

./bin/bwa.kit/samtools index pch2-9D.rmdup.bam
./bin/bwa.kit/samtools index pch2-9A.rmdup.bam
./bin/bwa.kit/samtools index pch2-8D.rmdup.bam

./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T RealignerTargetCreator -o pch2-9D.intervals -I pch2-9D.rmdup.bam
./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T RealignerTargetCreator -o pch2-9A.intervals -I pch2-9A.rmdup.bam
./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T RealignerTargetCreator -o pch2-8D.intervals -I pch2-8D.rmdup.bam

./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T IndelRealigner -targetIntervals pch2-9D.intervals -o pch2-9D.realn.bam -I pch2-9D.rmdup.bam
./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T IndelRealigner -targetIntervals pch2-9A.intervals -o pch2-9A.realn.bam -I pch2-9A.rmdup.bam
./jdk1.8.0_05/bin/java -Xmx10g -jar ./gatk/GenomeAnalysisTK.jar -R yeast.fasta -T IndelRealigner -targetIntervals pch2-8D.intervals -o pch2-8D.realn.bam -I pch2-8D.rmdup.bam

ls *.realn.bam > reseq.list
./jdk1.8.0_05/bin/java -jar ./gatk/GenomeAnalysisTK.jar -nct 32 -R yeast.fasta -T HaplotypeCaller -I reseq.list -mbq 20 -o yeast.vcf
