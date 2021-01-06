function Chrom2 = Select(Chrom,Fit,select_num)


%Individual selection probability
sumfitness=sum(Fit);
sumf=Fit./sumfitness;

[chromosomeNum,~]=size(Chrom);
%Use roulette to select new individuals
index=[];
for i=1:select_num   %Turn the wheel select_num times
    pick=rand;
    while pick==0     %not 0
        pick=rand;
    end
    for j=1:chromosomeNum
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  
            %This time chromosome I is selected. 
            %Note that it is possible that certain chromosomes may be selected repeatedly 
            %as the select_NUM wheel rotates.
    end
end

%new
Chrom2=Chrom(index,:);

%-----------------------------------------------------------------
% [~,N] = size(Fit);
% Fit = mapminmax(Fit);
% 
% a = min(Fit);
% b = sum(Fit) + N*(-a);
% 
% for i=1:N                    %divide a disk into N regions
%     POP_adapt(i)=(Fit(i)-a)/b; 
% end
% 
% POPnew_adapt = cumsum(POP_adapt); %Sum to 1
% 
% for i = 1:select_num
%     target_index = find(POPnew_adapt>rand); 
%     Chrom2(i,:) = Chrom(target_index(1),:); 
% end



end

