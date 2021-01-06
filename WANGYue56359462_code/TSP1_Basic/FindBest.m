function best = FindBest()
    %FINDBEST - find the best path which has shortest distance

    global population
    global population_n
    
    best  = population(1, :);  %initial
    dbest = DistanceOfPath(best); 
    
    for i = 2 : population_n     %find best
        path = population(i, :);
        dist = DistanceOfPath(path);
        if (dist < dbest)
            best = path;
            dbest = dist;
        end
    end
    
end

