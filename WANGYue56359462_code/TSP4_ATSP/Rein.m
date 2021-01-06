function Chrom = Rein(Chrom, NEWChrom2,Route_long)

row_parents = size(Chrom,1);
row_son = size(NEWChrom2,1);  %母代和子代就相差一个POP_num*(1-GAP)的数量

[~,index] = sort(Route_long);

Chrom = [Chrom(index(1:row_parents-row_son),:);NEWChrom2];

%记录下距离最短(就是适应度值最高的)几条基因插入到子代

end
