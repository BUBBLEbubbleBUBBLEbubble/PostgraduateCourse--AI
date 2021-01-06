function n = NumOfSelectNr(f)
%NUMOFSELECTNR - caculate the number of xi to be selected for a population size of N 
% = Nr(xi) = N * Pi = f(xi) / average(f)

    global STATS
    n = f / STATS{length(STATS) - 1, 3};

end



