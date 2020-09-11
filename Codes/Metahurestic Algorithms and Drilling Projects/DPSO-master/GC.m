function [npv]=GC(d,i,NOW,OverLandScape,TravelCostPerDay,bblPrice);




    
    DayDistance(i,1)=DayCalc(d,i,NOW);
    
    d(i,NOW+1)=DayDistance(i,1);
    
    d(i,NOW+2)=WLSC(d,i,NOW,OverLandScape);
    
    d(i,NOW+1)=d(i,NOW+1)*TravelCostPerDay;
    d(i,NOW+2)=d(i,NOW+2)* bblPrice;
    
    npv=d(i,NOW+2)-d(i,NOW+1);
    
    




end
