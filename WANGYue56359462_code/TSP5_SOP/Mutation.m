function NEWChrom2 = Mutation(NEWChrom2,pm)

[row,col] = size(NEWChrom2);

%-------------------------
for i = 1:row
    if rand <= pm

        R = randperm(col-2);        %��ȡ����λ�ã���������
        R =R +2;
        
        NEWChrom2(i,R(1:2)) = NEWChrom2(i,R(2:-1:1));
            
    end
end

end