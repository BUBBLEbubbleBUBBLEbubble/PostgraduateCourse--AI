function  InitialPopulation()
%INITIALPOPULATION - Generate initial POPULATION
global city_n        %城市数量
global population    %初始种群矩阵，POPULATION_N行*CITIES列
global population_n  %初始种群数量

population = zeros(population_n, city_n);
for i = 1 : population_n
    population(i,:) = randperm(city_n, city_n);  %随机选择population_n个初始路径/种群
end

end

