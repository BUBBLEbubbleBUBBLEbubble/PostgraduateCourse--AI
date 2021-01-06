function NEWChrom2 = Reverse(NEWChrom2, D)

[row, col] = size(NEWChrom2);

NEWChrom3 = NEWChrom2;  %NEWChorm作为一个比较的中间变量

for i = 1:row

   distance_old = DistanceOfPath(D,NEWChrom2(i,:));  %不是一维的话后面distance(i),后面同理
    
    coll=col-2;
    r = unidrnd(coll,1,2);  %产生两个随机数
    r=r+1;
    
    minrev = min(r);
    maxrev = max(r);

    NEWChrom3(i,minrev:maxrev) = fliplr(NEWChrom3(i,minrev:maxrev)); 
    
    distance_new = DistanceOfPath(D,NEWChrom3(i,:));

    if distance_new < distance_old
        
        NEWChrom2(i,:) = NEWChrom3(i,:);  %结果更优则更新
    
    end
    
      
end