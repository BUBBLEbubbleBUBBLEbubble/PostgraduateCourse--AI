%{
Name   :  TSP 4 - Asymmetric traveling salesman problem (ATSP)
Author :  Wang Yue
Date   :  2020.11.7
%}
% If there are somthing wrong, just run it again, please.
% And the best path are printed in Command line window.
%========================
clc;
clear;    
close all;

t0=clock; %调用windows系统的时钟进行时间差计算

% 算法的初始设置------------------------------
chrom_n = 100;        %Initial population number/初始种群数量
generation = 1000;     %Generations/iterations/世代数/迭代次数

pc = 0.8;      %交叉概率
pm = 0.1;     %变异概率
GAP = 0.9;     %代沟(也就是选择概率)

% 随机产生城市的坐标------------------------
global n        %Number of city/城市数量
n = 10; 
global cities   %City coordinates/各城市坐标
cities = [
    0.1,0.13;
    0.2,0.5;
    0.3,0.6;
    0.4,0.82;
    0.5,0.7;
    0.83,0.3;
    0.6,0.1;
    0.4,0.85;
    0.73,0.45;
    0.25,0.5;
];

% %作出初始图---------------------------------
% x = cities(:,1);
% y = cities(:,2);
% xlabel('经度');    
% ylabel('纬度');     
% title('TSP问题遗传算法(GA)优化');    
% grid on

% 计算各个城市之间的距离----------------------
global D    %Distance matrix/距离矩阵n*n
D = [
0  , 0.8, 0.5, 0.1, 0.5, 0.5, 0.6, 0.5, 0.5, 0.9;
0.6, 0  , 0.5, 0.5, 0.5, 0.1, 0.5, 0.5, 0.8, 0.5;
0.7, 0.7, 0  , 0.5, 0.1, 0.5, 0.5, 0.5, 0.5, 0.5;
0.6, 0.5, 0.1, 0  , 0.5, 0.5, 0.5, 0.5, 0.5, 0.5;
0.5, 0.7, 0.5, 0.9, 0  , 0.8, 0.1, 0.5, 0.7, 0.5;
0.5, 0.5, 0.6, 0.5, 0.5, 0  , 0.6, 0.6, 0.5, 0.1;
0.6, 0.5, 0.7, 0.5, 0.5, 0.5, 0  , 0.5, 0.1, 0.6;
0.5, 0.1, 0.7, 0.6, 0.5, 0.5, 0.6, 0  , 0.5, 0.5;
0.5, 0.5, 0.8, 0.5, 0.5, 0.5, 0.5, 0.1, 0  , 0.9;
0.1, 0.8, 0.5, 0.9, 0.5, 0.5, 0.5, 0.5, 0.5, 0  ;
];

%path---------------------------------------------
path_evolution = zeros(generation,n+1);  %记录每次迭代之后的最优路线path进化过程
best_value = zeros(generation,1);        %记录每次迭代之后的最优路线距离值进化过程
length_ave = zeros(generation,1);        %每次迭代路线距离的平均值

path_length = zeros(chrom_n,1);          %种群中每个path的长度

% 种群的初始化---------------------------------
global Chrom

Chrom = InitialChrom (chrom_n,n);


% 记录一个初始的随机解后开始优化==========================================

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
    NEWChrom2 = Crossover(NEWChrom1, pc);
    
    %变异操作
    NEWChrom2 = Mutation(NEWChrom2, pm);
    
    %进化逆转操作
    NEWChrom2 = Reverse(NEWChrom2, D);
    
    %(Elitism)重插入几条优秀的父代基因到子代里形成新种群
    Chrom = Rein(Chrom, NEWChrom2,path_length);
    
    %动态效果   
%     if times >= 1
%         cla;     
%         Route_all = path_evolution(iter+1,:);
%         plot(cities(Route_all,1), cities(Route_all,2), 'bo-'); 
%         text(cities(Route_all(1),1),cities(Route_all(1),2),'   start');
%         text(cities(Route_all(end-1),1),cities(Route_all(end-1),2),'  end');
%         
%         title({['BEST PATH: ' num2str( path_evolution(iter+1,:) )];...
%                ['DISTANCE = ' num2str( route_best )];...
%                ['GENERATION ' num2str( iter+1 )] }) ;
%         pause(0.05);
%         times = 0;
%     end 

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

% % 画出最终结果图====================================================
% figure()
% 
% for i = 1 : n                            
%    scatter(x(i),y(i),'b');            %画出散点图
%    hold on
%    text(x(i)+0.01,y(i)+0.01,num2str(i));     %用text做好标记，
%    hold on
% end
% plot(cities(Route_print,1), cities(Route_print,2), 'bo-'); 
% text(cities(Route_print(1),1),cities(Route_print(1),2),'   start');
% text(cities(Route_print(end-1),1),cities(Route_print(end-1),2),'  end');
% 
% xlabel('Longitude');       %横坐标
% ylabel('Latitude');       %纵坐标
% title('Final result diagram');    %图片标题
% grid on

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
