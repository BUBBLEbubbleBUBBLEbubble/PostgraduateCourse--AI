%{
Name   :  TSP - base(symmetric\ return to the starting city)
Author :  Wang Yue
Date   :  2020.11.2
%}

clear; clc; 
close all

global PLOT_TITLE
global PATH_PLOT
global distance_city %Distance matrix/�������n*n
global city_n        %Number of city/��������
global population_n  %Initial population number/��ʼ��Ⱥ����
global population    %Initial population matrix/��ʼ��Ⱥ����POPULATION_N��*CITIES��
global positions     %City coordinates/����������
global best_path     %Best Route/���·��
global STATS         %Statistics/ͳ��
global TABLE
global p_cross            %probability of crossover/�������
global p_mutation_1       %mutation rate1/�������1(Swap two random cities)
global p_mutation_2       %mutation rate2/�������2(Exchange two parts of a path)

city_n = 10;             
generation_n = 2000;     %Generations/iterations/������/��������
population_n = 20;      
p_cross=0.8;           
p_mutation_1 = 0.05;      
p_mutation_2 = 0.02;   


global best_value   %Record the shortest path for each iteration/��¼ÿ�ε��������·��
% global length_ave   %��¼ÿ�ε�����·����ƽ��ֵ
best_value = zeros (1,generation_n);
% length_ave = zeros (1,generation_n);


% Generate map position of cities and distances------------
positions = [ 
    0.3642, 0.7185, 0.0986, 0.2954, 0.5951, 0.6697, 0.4353, 0.2131, 0.3479, 0.4516;
    0.7770, 0.8312, 0.5891, 0.9606, 0.4647, 0.7657, 0.1709, 0.8349, 0.6984, 0.0488;
    ];  
distance_city = DistanceMatrix(positions,city_n);

% Generate initial population------------
InitialPopulation();

% Random initial bestPath----------------
best_path = population(randi(population_n), :);

% initial plot and stats figure --------------
Plot();
Stats();

%subplot2(stats table)----------
colTitles = {'Cromosoma(Path)', 'Distance_path', 'fitness(xi)', 'Prob_Select', 'Nr_NumberOfSelect'};
colFormat = { 'char', 'numeric', 'numeric', 'numeric', 'numeric'};
TABLE = uitable(...
    'Units', 'normalized',...
    'Position', [0, 0, 1, 0.5],...
    'ColumnName', colTitles,...
    'ColumnFormat', colFormat,...
    'ColumnWidth', { 200 'auto' 'auto' 'auto' 'auto' },...
    'Data', STATS);


%========================================================

for i = 1 : generation_n
    
    Stats(); %statistical table//ͳ��
    
    %reproduction/select -> crossover -> mutation
    %population = Mutation(Crossover(Reproduction()));
    population = Reproduction();
    population = Crossover(population);
    population = Mutation(population);
   
    % Find best and remove the worst
    best_path = FindBest();
    best_value (i) = DistanceOfPath(best_path);
    
    % Avoid update plots several times
    if mod(i, 50) == 0
        pause(0.05);
        set(PLOT_TITLE, 'string',... 
        {    ['BEST PATH: ' num2str(best_path)];...
             ['DISTANCE = ' num2str(DistanceOfPath(best_path))];...
             ['GENERATION ' num2str(i)]});
        set(TABLE, 'Data', STATS);
        set(PATH_PLOT,...
            'XData', [positions(1, best_path) positions(1, best_path(1))],...
            'YData', [positions(2, best_path) positions(2, best_path(1))])
    end
end



% Convergence trajectory /����������������
figure()  %��̾��������켣
% subplot(1,2,1)
plot(best_value)
xlabel('Generation')
ylabel('Convergence trajectory of The shortest distance')

% subplot(1,2,2) %ƽ�����������켣
% plot(length_ave)
% xlabel('Generation')
% ylabel('Mean distance convergence trajectory')










