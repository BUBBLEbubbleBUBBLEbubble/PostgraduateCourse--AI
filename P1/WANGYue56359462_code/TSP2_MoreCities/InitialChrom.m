function Chrom = InitialChrom(chrom_n,n)
%INITIALCHROM - Generate initial POPULATION

Chrom = zeros(chrom_n,n); 

for i=1:chrom_n
    Chrom(i,:) = randperm(n);   %���������ʼ����Ⱥ
end

end

