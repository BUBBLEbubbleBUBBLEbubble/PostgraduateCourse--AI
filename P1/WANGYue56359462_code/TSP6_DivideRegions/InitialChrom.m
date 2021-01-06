function Chrom = InitialChrom(chrom_n,n)
%INITIALCHROM - Generate initial POPULATION

global cs1
global cs2
global cs3
global cluster1_n
global cluster2_n
global cluster3_n
Chrom = zeros(chrom_n,n); 

for i=1:chrom_n
    
    a = randperm(cluster1_n);
    b = randperm(cluster2_n);
    b = b + cluster1_n;
    c = randperm(cluster3_n);
    c = c + cluster1_n + cluster2_n;  

    Chrom(i, cs1:cluster1_n) = a;  
    Chrom(i, cs2:cs2+cluster2_n-1) = b;
    Chrom(i, cs3:cs3+cluster3_n-1) = c;
    
    
end



