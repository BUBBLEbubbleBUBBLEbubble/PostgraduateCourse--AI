function  InitialPopulation()
%INITIALPOPULATION - Generate initial POPULATION
global city_n        %��������
global population    %��ʼ��Ⱥ����POPULATION_N��*CITIES��
global population_n  %��ʼ��Ⱥ����

population = zeros(population_n, city_n);
for i = 1 : population_n
    population(i,:) = randperm(city_n, city_n);  %���ѡ��population_n����ʼ·��/��Ⱥ
end

end

