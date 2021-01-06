function Chrom = InitialChrom(chrom_n,n,start_city1,start_city2)
%INITIALCHROM - Generate initial POPULATION

nn=n-2;
cort = zeros(1,nn);
j=1;
%cort为去掉开头两个的数组（n-2个）
for i = 1:n
    if i==start_city1 || i==start_city2
        
    else
        cort(j)=i;
        j=j+1;
    end 
end

cor = zeros(2,nn);
for p = 1:nn
    cor(1,p)=p;
    cor(2,p)=cort(p);
end

%-----------------------------
Chrom = zeros(chrom_n,n); 
Chromt = zeros(chrom_n,nn); 

Chrom(:,1)=start_city1;
Chrom(:,2)=start_city2;

for i=1:chrom_n
    Chromt(i,:) = randperm(nn);   %随机产生初始的种群
    Chrom(i,3:n) = cor(2,Chromt(i,:));
end


end

