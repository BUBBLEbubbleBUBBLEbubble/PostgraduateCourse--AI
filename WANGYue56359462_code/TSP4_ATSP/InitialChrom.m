function Chrom = InitialChrom(chrom_n,n)
%INITIALCHROM - Generate initial POPULATION

Chrom = zeros(chrom_n,n); 
Chrom(1,:) = randperm(n); 
for i=2:chrom_n
    Chrom(i,:) = randperm(n);   %���������ʼ����Ⱥ
end

end

