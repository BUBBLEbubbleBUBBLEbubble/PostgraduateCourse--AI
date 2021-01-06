function Chrom = Mutation(Chrom, pm)


[a,b]=size(Chrom);

for i=1:a
    
    for j=1:b
        
        if rand<pm
            
            Chrom(i,j)=2*rand-1;
            
        end
 
    end
    
end


end

