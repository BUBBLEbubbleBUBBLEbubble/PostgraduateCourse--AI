function Stats()
    %Stats -  Build stats table

    global STATS
    global population_n
    global population
    
    %========
    for i = 1 : population_n 
        path = population(i,:);
        STATS{i, 1} = num2str(path); % Cromosome //1·������
        STATS{i, 2} = DistanceOfPath(path); % Distance //2·���ܾ���
        STATS{i, 3} = Fitness(path); % f(x) //3·�ߵ���Ӧ��
        STATS{i, 4} = 0.0; % P. Select //4��ѡ��ĸ���
        STATS{i, 5} = 0.00; % Expected Count //
    end

    %������Ӧ�ȵĺ�+��ֵ+���------------------
    % Compute SUM, AVG & MAX of Fitness
    STATS{population_n + 1, 1} = 'SUM'; %����������-����Ӧ�Ⱥ�
    STATS{population_n + 1, 3} = sum(cell2mat(STATS(1:population_n, 3)));
    STATS{population_n + 2, 1} = 'AVG'; %�����ڶ���-����Ӧ�Ⱦ�ֵ
    STATS{population_n + 2, 3} = mean(cell2mat(STATS(1:population_n, 3)));
    STATS{population_n + 3, 1} = 'MAX'; %������һ��-�������Ӧ�ȵ�ֵ
    STATS{population_n + 3, 3} = max(cell2mat(STATS(1:population_n, 3)));

    %���㱻ѡ�����+��һ�ַ���ĳ·��Ԥ�ڳ��ֵ�����Nr+ʵ�ʳ��ֵ�����-------
    % Compute P.Select, E. Count & A. Count
    for i = 1 : population_n  %��������Ⱥ�е�ÿ��·�ߣ�Ⱦɫ�壩
        fxi = STATS{i, 3}; % f(x) //��Ӧ��
              
        STATS{i, 4} = ProbOfSelect(fxi); % P. Select //��ѡ��ĸ���
        STATS{i, 5} = NumOfSelectNr(fxi); % Expected Count //ĳ·��Ԥ�ڳ��ֵ�����

    end
    % Compute SUM, AVG & MAX 
    for i = 4 : 5
        STATS{population_n + 1, i} = sum(cell2mat(STATS(1:population_n, i)));
        STATS{population_n + 2, i} = mean(cell2mat(STATS(1:population_n, i)));
        STATS{population_n + 3, i} = max(cell2mat(STATS(1:population_n, i)));
    end
    
    
end







