function Chrom3 = Crossocer(Chrom, pc, fitness)

% row = size(Chrom,1);%行

% Chrom3 = Chrom;
% 
% % [~,index] = sort(fitness);
%
% for i = 1:row
%
%     if rand <= pc
%
%         a = Chrom(i,:);
%         b = Chrom(i+1,:);
%
%         L = length(a);
%
%         r = unidrnd(L);
%
%         %cross
%         at = a(r:end);
%         bt = b(r:end);
%
%         a(r:end) = bt;
%         b(r:end) = at;
%
%         Chrom3(i,:) = a;
%         Chrom3(i+1,:) = b;
%
%     end
% end




%--------------------

[row,lenchrom ]= size(Chrom);

for i=1:row
    pick=rand(1,2);
    while prod(pick)==0
        pick=rand(1,2);
    end
    index=ceil(pick.*row);
    % The crossover probability determines whether or not to cross
    pick=rand;
    while pick==0
        pick=rand;
    end
    if pick>pc
        continue;
    end
    % 随机选择交叉位
    pick=rand;
    while pick==0
        pick=rand;
    end
    
    pos=ceil(pick*lenchrom); %Random selection of crossover location, that is, select the number of variables to cross, 
    %note: the two chromosomes intersect at the same location
    pick=rand; %Cross began
    v1=Chrom(index(1),pos);
    v2=Chrom(index(2),pos);
    Chrom(index(1),pos)=pick*v2+(1-pick)*v1;
    Chrom(index(2),pos)=pick*v1+(1-pick)*v2; %Cross over
    
    
end

Chrom3 = Chrom;


end

