data=load('cluster_dataset.txt');
[n,m] = size(data);
x = data(:,1);
y = data(:,2);
for i = 1 : n                            
   scatter(x(i),y(i),'b');            %plot
   hold on
   text(x(i)+0.01,y(i)+0.01,num2str(i));     %text
   hold on
end