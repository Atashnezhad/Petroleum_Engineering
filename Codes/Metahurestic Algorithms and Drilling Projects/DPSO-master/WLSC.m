function [a]=WLSC(d,i,N,OverLandScape)

a=0;

%*****************************
load WellLandScapes
load WellProductionPowers
%*****************************

NumOfWells=N;
%OverLandScape=2000;
b=0;
load amin

for j=1:NumOfWells

    if j==1;
    b=WellLandScapes(d(i,j),1)+b;
    else
    b=WellLandScapes(d(i,j),1)+mat(d(i,j-1),d(i,j))+b;
    end
    
    
    
    
    
a=((OverLandScape-b)*WellProductionPowers(d(i,j),1))+a;





end
%disp(a)

end