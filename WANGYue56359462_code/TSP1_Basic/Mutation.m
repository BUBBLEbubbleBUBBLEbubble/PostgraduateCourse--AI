function population = Mutation( children )
    %MUTATION - mutation

    global best_path
    global p_mutation_1       %mutation rate1
    global p_mutation_2       %mutation rate2
    
    % MUTATION 1
    % Swap two random cities
    for i = 1 : length(children) %遍历每条染色体
        child = children(i, :);
        len = length(child);
        for j = 1 : len  %遍历某条染色体中的每个城市
            if rand < p_mutation_1 
                prev = child(j);
                index = randi(len);
                child(j) = child(index);
                child(index) = prev;
                children(i, :) = child; %交换第j个基因和随机一个基因
            end
        end
    end
    
    % MUTATION 2
    % Exchange two parts of path
    for i = 1 : length(children)
        child = children(i, :);
        len = length(child);
        point = randi([2, len - 1]);
        if rand < p_mutation_2
            children(i, :) = [ child(point + 1:len) child(1:point) ];
        end
    end
    
    % USE ELITISM TO PRESERVE LAST BEST
    children(randi(length(children)), :) = best_path;
    population = children;
end

