function distance = DistanceOfPath ( path )
    %DISTANCEFORPATH - Calculate the total distance of a path

    global distance_city
    
    dist = 0;
    n = length(path) - 1;
    for i = 1 : n
        from = path(i);
        to   = path(i + 1);
        dist = dist + distance_city(from, to);
    end
    
    distance = dist + distance_city(path(n), path(1));
    
end