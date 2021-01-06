function distance = DistanceOfPath(D,S)
%DISTANCEFORPATH - Calculate the total distance of a path
  
n = length(S);  
distance1 = 0;

 for j = 1:(n-1)

     distance1 = distance1 + D(S(j),S(j +1 ));   %计算这条路线的距离  
     
 end

   distance = distance1 + D(S(n),S(1)); %加上终点回到起点的距离 
   
end