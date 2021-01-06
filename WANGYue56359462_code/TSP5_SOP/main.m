%{
Name   :  TSP 5 - Sequential ordering problem (SOP)
Author :  Wang Yue
Date   :  2020.11.8
%}

clc;
clear    
close all;

t0=clock; %����windowsϵͳ��ʱ�ӽ���ʱ������

% �㷨�ĳ�ʼ����------------------------------
chrom_n = 100;        %Initial population number/��ʼ��Ⱥ����
generation = 300;     %Generations/iterations/������/��������

pc = 0.8;      %�������
pm = 0.06;     %�������
GAP = 0.9;     %����(Ҳ����ѡ�����)

% ����������е�����------------------------
global n        %Number of city/��������
n = 20; 
global cities   %City coordinates/����������
cities = rand(n,2);

%������ʼͼ---------------------------------
x = cities(:,1);
y = cities(:,2);
xlabel('����');     
ylabel('γ��');      
title('TSP�����Ŵ��㷨(GA)�Ż�');    
grid on

% �����������֮��ľ���----------------------
global D    %Distance matrix/�������n*n
D = DistanceMatrix(cities,n);

%path---------------------------------------------
path_evolution = zeros(generation,n);  %��¼ÿ�ε���֮�������·��path��������
best_value = zeros(generation,1);      %��¼ÿ�ε���֮�������·�߾���ֵ��������
length_ave = zeros(generation,1);      %ÿ�ε���·�߾����ƽ��ֵ

path_length = zeros(chrom_n,1);        %��Ⱥ��ÿ��path�ĳ���

%�趨���ơ�����-start_city1, start_city2������������֮ǰȥ��----------------
start_city1 = 2;  %��ʼ����1���
start_city2 = 5;  %��ʼ����2���

% ��Ⱥ�ĳ�ʼ��----------------------------------
global Chrom
Chrom = InitialChrom (chrom_n, n, start_city1, start_city2);


% GA==========================================================================

iter = 0;
times = 0; %����̬Ч����

while iter < generation
    
    %�����iter���и�·���ܳ���----------------------------
    for i = 1:chrom_n
        path_length(i) = DistanceOfPath(D,Chrom(i,:));  
    end
    
    %��¼��С·��+ƽ��ֵ+ÿ�ֵĵ���-------------------------------
    [route_best,best_index] = min(path_length);
    
    length_ave(iter+1) = mean(path_length);     %ÿ�ε���·�߾����ƽ��ֵ
    best_value(iter+1) = route_best;
%   path_evolution(iter+1,:) = [Chrom(best_index,:) Chrom(best_index,1)];  %��¼����ε�����·��
    path_evolution(iter+1,:) = Chrom(best_index,:);  %��¼����ε�����·��    

    %������Ӧ��-------------------------------
    fitness = Fitness(path_length);
    
    %=============================================================
    %%ѡ��������������Ӧ��ֵԽ��Խ�п��ܱ�ѡ�У�
    select_num = max(floor(chrom_n*GAP+0.6),2);   %��ѡ�е�Ⱦɫ����Ŀ
    NEWChrom1 = Select(fitness,select_num); 
    
    %%�������
    NEWChrom2 = Crossover(NEWChrom1, pc);
    
    %%�������
    NEWChrom3 = Mutation(NEWChrom2, pm);
    
    %%������ת����
    NEWChrom4 = Reverse(NEWChrom3, D);
    
    %%(Elitism)�ز��뼸������ĸ��������Ӵ����γ�����Ⱥ
    Chrom = Rein(Chrom, NEWChrom4, path_length);
    
    %%��̬Ч��   
    if times >= 1
        cla;     
        Route_all = path_evolution(iter+1,:);
        plot(cities(Route_all,1), cities(Route_all,2), 'bo-'); 
        text(cities(Route_all(1),1),cities(Route_all(1),2),'   antecedent1');
        text(cities(Route_all(2),1),cities(Route_all(2),2),'   antecedent2');
        text(cities(Route_all(end),1),cities(Route_all(end),2),'  end');
        
        title({['BEST PATH: ' num2str( path_evolution(iter+1,:) )];...
               ['DISTANCE = ' num2str( route_best )];...
               ['GENERATION ' num2str( iter+1 )] }) ;
        pause(0.02);
        times = 0;
    end 
    
    iter = iter + 1;
    times = times + 1;
  
end


% ����ڵĽ����ʾ============================================
Time_Cost=etime(clock,t0);   %����windowsϵͳ��ʱ�ӽ���ʱ������
disp(['The shortest distance around the city:' num2str(best_value(end))]);
arrow = '%d ---> %d\n';
disp('The shortest route is shown below��');
Route_print = path_evolution(end,:);
for i=1:n
  fprintf(arrow,Route_print(i));
end

disp(['program execution time:' num2str(Time_Cost) 'seconds']);

% �������ս��ͼ====================================================
figure()

for i = 1 : n                            
   scatter(x(i),y(i),'b');            %����ɢ��ͼ
   hold on
   text(x(i)+0.01,y(i)+0.01,num2str(i));     %��text���ñ�ǣ�
   hold on
end
plot(cities(Route_print,1), cities(Route_print,2), 'bo-'); 
text(cities(Route_print(1),1),cities(Route_print(1),2),'   antecedent1');
text(cities(Route_print(2),1),cities(Route_print(2),2),'   antecedent2');
text(cities(Route_print(end),1),cities(Route_print(end),2),'  end');

xlabel('Longitude');       %������
ylabel('Latitude');       %������
title('Final result diagram');    %ͼƬ����
grid on

% ����������������=======================================================
figure()
subplot(1,2,1)
plot(best_value)
xlabel('Iterations')
ylabel('The convergence trajectory of shortest distance')

subplot(1,2,2)
plot(length_ave)
xlabel('Iterations')
ylabel('The convergence trajectory of mean distance')