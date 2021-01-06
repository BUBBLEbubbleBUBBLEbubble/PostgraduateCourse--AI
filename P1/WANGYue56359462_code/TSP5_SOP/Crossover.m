function NEWChrom2 = Crossover(NEWChrom1, pc)

row = size(NEWChrom1,1);%��/Ⱦɫ������

NEWChrom2 = NEWChrom1;  %�����㽻�������ľͱ���

for i = 1:2:row-mod(row,2)  %���ó������ĵݽ���ʽ��������ϻ�˵���Ŵ��㷨��һ��
                            %����ΪȾɫ�����Ŀ�ڱ仯 
     if rand <= pc
     
       a = NEWChrom1(i,:);
       b = NEWChrom1(i+1,:);

       L = length(a);
       l=L-2;
       rr =unidrnd(l,[1,2]);
       r = rr+2;

         if r(1) ~= r(2)
             a0=a;b0=b;
             
            for j = min(r):max(r)
                a1=a;b1=b;
                a(j) = b0(j);    %�����м�Ĳ���
                b(j) = a0(j);
                   
                x = find(a==a(j));
                y = find(b==b(j));
                     i1 = x(x~=j);   %�ҵ��������Լ����Ǹ��ظ���λ��
                     i2 = y(y~=j);
                
                if ~isempty(i1)     %ӳ���ȥ,���ư�ԭ��λ�õ��Ǹ���������һ��
                                        %�����ظ����Ǹ�λ������
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