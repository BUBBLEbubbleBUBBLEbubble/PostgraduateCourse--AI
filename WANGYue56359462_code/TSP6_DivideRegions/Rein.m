function Chrom = Rein(Chrom, NEWChrom2,Route_long)

row_parents = size(Chrom,1);
row_son = size(NEWChrom2,1);  %ĸ�����Ӵ������һ��POP_num*(1-GAP)������

[~,index] = sort(Route_long);

Chrom = [Chrom(index(1:row_parents-row_son),:);NEWChrom2];

%��¼�¾������(������Ӧ��ֵ��ߵ�)����������뵽�Ӵ�

end
