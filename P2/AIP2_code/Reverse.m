function Chrom = Reverse( Chrom, inputTrain , outputTrain ,trainNum )

[row, col] = size(Chrom);

NEWChrom = Chrom;  %NEWChorm as an intermediate variable for comparison

for i = 1:row
    
    [ ~ ,fitness_old  ] = NNforward ( Chrom(i,:), inputTrain , outputTrain ,trainNum);
   
    r = unidrnd(col,1,2);  %Generate two random numbers
    
    minrev = min(r);
    maxrev = max(r);

    NEWChrom(i,minrev:maxrev) = fliplr(NEWChrom(i,minrev:maxrev)); 
    
    
    [ ~ ,fitness_new  ] = NNforward ( Chrom(i,:), inputTrain , outputTrain ,trainNum);
    
    if fitness_new > fitness_old
        
        Chrom(i,:) = NEWChrom(i,:);  %Update if the results are better
    
    end
    


end

