function [Days]=DayCalc2(d,i,N);



NumOfWells=N;



Days=0;
%load amin

for j=1:NumOfWells-1
    
Days=mat(d(i,j),d(i,j+1))+Days;




end

%disp(Days)

end