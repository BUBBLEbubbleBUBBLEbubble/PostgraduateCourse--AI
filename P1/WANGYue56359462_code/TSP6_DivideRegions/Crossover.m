function NEWChrom2 = Crossover(NEWChrom1, pc)

row = size(NEWChrom1,1);%行

NEWChrom2 = NEWChrom1;  %不满足交叉条件的就保持

for i = 1:2:row-mod(row,2)  %设置成奇数的递进形式，这里和上回说的遗传算法不一样
                            %是因为染色体的数目在变化
     if rand <= pc
     
       a = NEWChrom1(i,:);
       b = NEWChrom1(i+1,:);
       
       L = length(a);
       
       r = unidrnd(L,[1,2]);

         if r(1) ~= r(2)
             a0=a;b0=b;
             
            for j = min(r):max(r)
                a1=a;b1=b;
                a(j) = b0(j);    %交换中间的部分
                b(j) = a0(j);
                   
                x = find(a==a(j));
                y = find(b==b(j));
                     i1 = x(x~=j);   %找到不是它自己的那个重复的位置
                     i2 = y(y~=j);
                
                if ~isempty(i1)     %映射过去,类似把原先位置的那个数字再用一次
                                        %换到重复的那个位置上面
                    a(i1) = a1(j);
                end
                
                if ~isempty(i2)
                    b(i2) = b1(j);
                end
          
            end
     
          end
         
           NEWChrom2(i,:) = a;
           NEWChrom2(i+1,:) = b;    
     end
end