function p = ProbOfSelect(f)
%ProbOfSelect - calculate probability of xi to be selected

    global STATS
    
    p = f / STATS{length(STATS) - 2, 3};  %STATS£¨£©Îªsum of fitness
    
end

