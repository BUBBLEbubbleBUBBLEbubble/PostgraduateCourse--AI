function childrens = Crossover( parents )
    %CROSSOVER - crossover
 
    global population_n
    global population
    global p_cross          
    
    if rand < p_cross
        
        pool = parents(randperm(size(parents,1)),:); % Shuffle
        childrens = zeros(size(population));
        % Crossover
        for i = 1 : 2 : population_n
            parent1 = pool(i, :);
            parent2 = pool(i + 1, :);
            childrens(i:i + 1, :) = Cross(parent1, parent2);
        end

    else
        
        childrens =  parents;
        
    end
    
end
