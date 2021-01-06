function Chrom = InitialChrom(chrom_n,n)
%INITIALCHROM - Generate initial POPULATION

Chrom = zeros(chrom_n,n); 

for i=1:chrom_n
    Chrom(i,:) = randperm(n);   %随机产生初始的种群
end

end

