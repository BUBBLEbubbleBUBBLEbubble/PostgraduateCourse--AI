function parents = Reproduction
    %REPRODUCTION - reproduction/selection

    global STATS
    global population_n
    global population
    
    parents = zeros(size(population));
    i = 1;
    count = 0;
    %roulette wheel selection-----
    while count < population_n  
        probs = rand(population_n, 1, 'double');
        
        while count < population_n && i <= population_n
            if probs(i) <= STATS{i, 4}  % p > Prob_Select
                count = count + 1;
                parents(count, :) = population(i,:);
            end
            i = i + 1;
        end
        
        i = 1;
    end
end
