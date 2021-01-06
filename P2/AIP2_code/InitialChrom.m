function Chrom = InitialChrom(chromosomeNum,geneNum)
%INITIALCHROM InitialChrom

%  Chrom = randn(chromosomeNum,geneNum); 

for i=1:chromosomeNum
    Chrom(i,:) = 2*rand(1,geneNum)-1;   %Random initial population

end

end

