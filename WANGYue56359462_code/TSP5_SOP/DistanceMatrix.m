function D = DistanceMatrix(A,n)
%DISTANCEOFCITIES - Calculate the distance between cities

D = zeros(n,n);
x = A(:,1);
y = A(:,2);
for i = 1:n
    for j = 1:n    
            D(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);  %¾àÀë¹«Ê½
    end    
end

end

