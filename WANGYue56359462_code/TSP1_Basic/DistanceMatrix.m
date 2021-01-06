function D = DistanceMatrix(A,N)
    %DISTANCEOFCITIES - Calculate the distance between cities

D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(A(1,i)-A(1,j)).^2+(A(2,i)-A(2,j)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

end

