function NEWChrom = Select(Fit,select_num)

global Chrom

N = size(Fit,1);

a = min(Fit);
b = sum(Fit) + N*(-a);

for i=1:N                    %给一个圆盘分N块区域
    POP_adapt(i)=(Fit(i)-a)/b; 
end

POPnew_adapt = cumsum(POP_adapt); %累加到1

for i = 1:select_num
    target_index = find(POPnew_adapt>rand); 
    NEWChrom(i,:) = Chrom(target_index(1),:); 
end

end 