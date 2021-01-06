function Stats()
    %Stats -  Build stats table

    global STATS
    global population_n
    global population
    
    %========
    for i = 1 : population_n 
        path = population(i,:);
        STATS{i, 1} = num2str(path); % Cromosome //1路线详情
        STATS{i, 2} = DistanceOfPath(path); % Distance //2路线总距离
        STATS{i, 3} = Fitness(path); % f(x) //3路线的适应度
        STATS{i, 4} = 0.0; % P. Select //4被选择的概率
        STATS{i, 5} = 0.00; % Expected Count //
    end

    %计算适应度的和+均值+最大------------------
    % Compute SUM, AVG & MAX of Fitness
    STATS{population_n + 1, 1} = 'SUM'; %倒数第三行-求适应度和
    STATS{population_n + 1, 3} = sum(cell2mat(STATS(1:population_n, 3)));
    STATS{population_n + 2, 1} = 'AVG'; %倒数第二行-求适应度均值
    STATS{population_n + 2, 3} = mean(cell2mat(STATS(1:population_n, 3)));
    STATS{population_n + 3, 1} = 'MAX'; %倒数第一行-求最大适应度的值
    STATS{population_n + 3, 3} = max(cell2mat(STATS(1:population_n, 3)));

    %计算被选择概率+下一轮繁衍某路径预期出现的条数Nr+实际出现的条数-------
    % Compute P.Select, E. Count & A. Count
    for i = 1 : population_n  %遍历现种群中的每条路线（染色体）
        fxi = STATS{i, 3}; % f(x) //适应度
              
        STATS{i, 4} = ProbOfSelect(fxi); % P. Select //被选择的概率
        STATS{i, 5} = NumOfSelectNr(fxi); % Expected Count //某路径预期出现的条数

    end
    % Compute SUM, AVG & MAX 
    for i = 4 : 5
        STATS{population_n + 1, i} = sum(cell2mat(STATS(1:population_n, i)));
        STATS{population_n + 2, i} = mean(cell2mat(STATS(1:population_n, i)));
        STATS{population_n + 3, i} = max(cell2mat(STATS(1:population_n, i)));
    end
    
    
end







