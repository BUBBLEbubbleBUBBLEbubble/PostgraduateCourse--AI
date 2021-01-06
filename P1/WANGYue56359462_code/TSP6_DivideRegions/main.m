%{
Name   :  TSP 6 - the cities are divided into 3 regions
Author :  Wang Yue
Date   :  2020.11.12
%}

clc;
clear    
close all;
t0=clock; %调用windows系统的时钟进行时间差计算

% 算法的初始设置------------------------------
chrom_n = 100;        %Initial population number/初始种群数量
generation = 600;     %Generations/iterations/世代数/迭代次数

pc = 0.8;      %交叉概率
pm = 0.08;     %变异概率
GAP = 0.9;     %代沟(选择概率)

% 随机产生城市的坐标------------------------
global n        %Number of city/城市数量
n = 50; 

global cities   %City coordinates/各城市坐标
cities = load('cluster_dataset.txt');

%每个聚类的个数，每个聚类开始的点------------
global cluster1_n
global cluster2_n
global cluster3_n
cluster1_n = 17;
cluster2_n = 20;
cluster3_n = 13;
global cs1
global cs2
global cs3
cs1 = 1;
cs2=18;
cs3=38;

%作出初始图---------------------------------
x = cities(:,1);
y = cities(:,2);
xlabel('经度');      
ylabel('纬度');      
title('TSP问题遗传算法(GA)优化');  
grid on

% 计算各个城市之间的距离----------------------
global D    %Distance matrix/距离矩阵n*n
D = DistanceMatrix(cities,n);

%path---------------------------------------------
path_evolution = zeros(generation,n+1);  %记录每次迭代之后的最优路线path进化过程
best_value = zeros(generation,1);        %记录每次迭代之后的最优路线距离值进化过程
length_ave = zeros(generation,1);        %每次迭代路线距离的平均值

path_length = zeros(chrom_n,1);          %种群中每个path的长度

% 种群的初始化---------------------------------
global Chrom
Chrom = InitialChrom (chrom_n,n);


% GA=========================================================================

iter = 0;
times = 0; %做动态效果的

while iter < generation
    
    %计算第iter轮中各路线总长度----------------------------
    for i = 1:chrom_n
        path_length(i) = DistanceOfPath(D,Chrom(i,:));  
    end
    
    %记录最小路径+平均值+每轮的迭代-------------------------------
    [route_best,best_index] = min(path_length);
    
    length_ave(iter+1) = mean(path_length);     %每次迭代路线距离的平均值
    best_value(iter+1) = route_best;
    path_evolution(iter+1,:) = [Chrom(best_index,:) Chrom(best_index,1)];  %记录下这次的最优路线
    
    %计算适应度-------------------------------
    fitness = Fitness(path_length);
    
    %=============================================================
    %选择操作（个体的适应度值越大越有可能被选中）
    select_num = max(floor(chrom_n*GAP+0.6),2);   %被选中的染色体数目
    NEWChrom1 = Select(fitness,select_num); 
    
    %交叉操作
    NEWChrom2(:,cs1:cluster1_n) = Crossover(NEWChrom1(:,cs1:cluster1_n), pc);
    NEWChrom2(:,cs2:cs2+cluster2_n-1) = Crossover(NEWChrom1(:,cs2:cs2+cluster2_n-1), pc);
    NEWChrom2(:,cs3:cs3+cluster3_n-1) = Crossover(NEWChrom1(:,cs3:cs3+cluster3_n-1), pc);
    
    %变异操作
    NEWChrom3(:,cs1:cluster1_n) = Mutation(NEWChrom2(:,cs1:cluster1_n), pm);
    NEWChrom3(:,cs2:cs2+cluster2_n-1) = Mutation(NEWChrom2(:,cs2:cs2+cluster2_n-1), pm);
    NEWChrom3(:,cs3:cs3+cluster3_n-1) = Mutation(NEWChrom2(:,cs3:cs3+cluster3_n-1), pm);
    
    %进化逆转操作
    NEWChrom4(:,cs1:cluster1_n) = Reverse(NEWChrom3(:,cs1:cluster1_n), D);
    NEWChrom4(:,cs2:cs2+cluster2_n-1) = Reverse(NEWChrom3(:,cs2:cs2+cluster2_n-1), D);
    NEWChrom4(:,cs3:cs3+cluster3_n-1) = Reverse(NEWChrom3(:,cs3:cs3+cluster3_n-1), D);
    
    %(Elitism)重插入几条优秀的父代基因到子代里形成新种群
    Chrom = Rein(Chrom, NEWChrom4, path_length);
    
    %动态效果   
    if times >= 1
        cla;     
        Route_all = path_evolution(iter+1,:);
        plot(cities(Route_all,1), cities(Route_all,2), 'bo-'); 
        text(cities(Route_all(1),1),cities(Route_all(1),2),'   start');
        text(cities(Route_all(end-1),1),cities(Route_all(end-1),2),'  end');
        
        title({['BEST PATH: ' num2str( path_evolution(iter+1,:) )];...
               ['DISTANCE = ' num2str( route_best )];...
               ['GENERATION ' num2str( iter+1 )] }) ;
        pause(0.05);
        times = 0;
    end 
    
    iter = iter + 1;
    times = times + 1;
  
end


% 命令窗口的结果显示============================================
Time_Cost=etime(clock,t0);   %调用windows系统的时钟进行时间差计算
disp(['The shortest distance around the city:' num2str(best_value(end))]);
arrow = '%d ---> %d\n';
disp('The shortest route is shown below：');
Route_print = path_evolution(end,:);
for i=1:n
  fprintf(arrow,Route_print(i),Route_print(i+1));
end

disp(['program execution time:' num2str(Time_Cost) 'seconds']);

% 画出最终结果图====================================================
figure()

for i = 1 : n                            
   scatter(x(i),y(i),'b');                 %plot
   hold on
   text(x(i)+0.01,y(i)+0.01,num2str(i));   %text
   hold on
end
plot(cities(Route_print,1), cities(Route_print,2), 'bo-'); 
text(cities(Route_print(1),1),cities(Route_print(1),2),'   start');
text(cities(Route_print(end-1),1),cities(Route_print(end-1),2),'  end');

xlabel('Longitude');              
ylabel('Latitude');               
title('Final result diagram');    
grid on

% 画出迭代过程曲线=======================================================
figure()
subplot(1,2,1)
plot(best_value)
xlabel('Iterations')
ylabel('The convergence trajectory of shortest distance')

subplot(1,2,2)
plot(length_ave)
xlabel('Iterations')
ylabel('The convergence trajectory of mean distance')