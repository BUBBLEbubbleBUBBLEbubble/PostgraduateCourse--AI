function distance = DistanceOfPath(D,S)
%DISTANCEFORPATH - Calculate the total distance of a path
  
n = length(S);  
distance1 = 0;

 for j = 1:(n-1)

     distance1 = distance1 + D(S(j),S(j +1 ));   %��������·�ߵľ���  
     
 end

   distance = distance1 + D(S(n),S(1)); %�����յ�ص����ľ��� 
   
end