function Chrom4 = Rein( Chrom3, Chrom, fitness )


row_parents = size(Chrom,1);
row_son = size(Chrom3,1);  %There are POP_num*(1-GAP) differences between the mother and the offspring

[~,index] = sort(fitness);

c=[];
for i =1:(row_parents-row_son)

    c=[c; Chrom(index(1),:)];

end

Chrom = [c;Chrom3];
Chrom4 =Chrom;
%The genes with the highest fitness values were recorded and inserted into the offspring



end

