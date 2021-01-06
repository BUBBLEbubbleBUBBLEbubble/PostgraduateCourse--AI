function f = Fitness( path )
    %FITNESS - caculate the fitness of xi path

    f = 1 / DistanceOfPath(path);
    
end