 
for poiu=1:1;



clc
clear


%%
%********************************
%matric rozaye haffariye har well
NumOfCandidates=3;
NumOfWells=50; %This is fixed,if u wanna change  it you must change input mat data
%********************************        
%*****************************
load amin
load WellLandScapes
load WellProductionPowers
OverLandScape=2000;
%*****************************
%********************************
%bblPrice 20$
bblPrice=100;
%TravelCostPerDay $
TravelCostPerDay=10000;
%********************************
%********************************
Pbest=zeros(NumOfCandidates,NumOfWells+1);
%********************************
%********************************
c1=3;
c2=1;
w=1;
NOW=NumOfWells;
NOC=NumOfCandidates;
%********************************
%----------------------------
d2=zeros(NOC,NOW);
%----------------------------
%-------------------------------
d3=zeros(NOC,NOW);
%-------------------------------

%------------------------------
d5=zeros(NOC,NOW);
%------------------------------

ITERATION=20000;

%------------------------
%determine Vi   

%load V;
%or

for j=1:NOC;
    
    %e=randperm(NOW);
    %V(j,1:NOW)=e;
    %V(j,1:6)=[1 6 2 3 7 5];
    V(j,1:NOW)=randperm(NOW);
end





%------------------------




%%
%In  Matris Tartibe Harkate Rig Hast


d=zeros(NOC,NOW);

for i=1:NOC
    d(i,1:NOW)=randperm(NOW);
end

%%

%DayDistanceCalc for each candidates which
%must travel in Days

DayDistance=zeros(NOC,1);

for i=1:NOC
    
    DayDistance(i,1)=DayCalc(d,i,NOW);
    
end


%input DayDistance in to d
for i=1:NOC
    d(i,NOW+1)=DayDistance(i,1);
end



%Production Power Of each well calculate (Productions Days) by Our OveralScape
for i=1:NOC
    
    
    d(i,NOW+2)=WLSC(d,i,NOW,OverLandScape);
    
    
end



%(Productions Days)---> to $ & tranportation Cost---> $
for i=1:NOC
    
    
    d(i,NOW+1)=d(i,NOW+1)*TravelCostPerDay;
    d(i,NOW+2)=d(i,NOW+2)* bblPrice;
    NPV(i,1)=d(i,NOW+2)-d(i,NOW+1);
    %plot(d(i,NumOfWells+1),1/d(i,NumOfWells+2),'*');
    %hold on
    %pause (0.00001)



end
%********************************
%max(NPV(1:NOC,1))  %*
%********************************

%%




%Deterimine Global Best Candidate Gbest
for i=1:NOC
    if NPV(i,1)==max(NPV(1:NOC,1));
        
        
        Gbest=d(i,1:NOW);
        Gbest(1,NOW+1)=max(NPV(1:NOC,1));
    end
end
%********************************
Gbest                          %*
%********************************







for i=1:NOC
    
    
    if Pbest(i,NOW+1)>=Pbest(i,NOW+1);
        
        
        Pbest(i,1:NOW)=d(i,1:NOW);
        Pbest(i,NOW+1)=NPV(i,1);
        
    end
    
    
end

%%
ite=0;
h = waitbar(0,'Initializing waitbar...'); %,'CreateCancelBtn'
while ite < ITERATION;
    
     waitbar(ite/ITERATION,h,'Pross...') 
    
   %%%%%waitbar(ite/ITERATION,h,sprintf(Gbest))
    
    
    
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:NOC;
    
    %e=randperm(NOW);
    %V(j,1:NOW)=e;
    %V(j,1:6)=[1 6 2 3 7 5];
    V(j,1:NOW)=randperm(NOW);
end 
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    
    
    
    
    
ite=ite+1;
%cross over operation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     OPERATOR #1
%cross over with Gbest

d2=zeros(NOC,NOW);

c1=10*rand;
for j=1:NOC;
    k(j,1)=unidrnd(NOW,1);
    m(j,1)=round(c1*rand);
    if m(j,1)>NOW-k(j,1);
        m(j,1)=NOW-k(j,1);
    end
  
    for i=k(j,1)+1:k(j,1)+m(j,1);
        
         d2(j,i-k(j,1))=Gbest(1,i);
        
    end
    %cross over with Gbest
    sh1=0;
   % d2=zeros(NOC,NOW);
    for i=1:NOW;
        
        if d(j,i)~= d2(j,1) && d(j,i)~= d2(j,2) &&...
           d(j,i)~= d2(j,3) && d(j,i)~= d2(j,4) &&...
           d(j,i)~= d2(j,5) && d(j,i)~= d2(j,6) &&...
           d(j,i)~= d2(j,7) && d(j,i)~= d2(j,8) &&...
           d(j,i)~= d2(j,9) && d(j,i)~= d2(j,10) && ...
           d(j,i)~= d2(j,11) && d(j,i)~= d2(j,12) &&...
           d(j,i)~= d2(j,13) && d(j,i)~= d2(j,14) &&...
           d(j,i)~= d2(j,15) && d(j,i)~= d2(j,16) &&...
           d(j,i)~= d2(j,17) && d(j,i)~= d2(j,18) &&...
           d(j,i)~= d2(j,19) && d(j,i)~= d2(j,20) &&...
           d(j,i)~= d2(j,21) && d(j,i)~= d2(j,22) &&...
           d(j,i)~= d2(j,23) && d(j,i)~= d2(j,24) &&...
           d(j,i)~= d2(j,25) && d(j,i)~= d2(j,26) &&...
           d(j,i)~= d2(j,27) && d(j,i)~= d2(j,28) &&...
           d(j,i)~= d2(j,29) && d(j,i)~= d2(j,30) && ...
           d(j,i)~= d2(j,31) && d(j,i)~= d2(j,32) &&...
           d(j,i)~= d2(j,33) && d(j,i)~= d2(j,34) &&...
           d(j,i)~= d2(j,35) && d(j,i)~= d2(j,36) &&...
           d(j,i)~= d2(j,37) && d(j,i)~= d2(j,38) &&...
           d(j,i)~= d2(j,39) && d(j,i)~= d2(j,40) &&...
           d(j,i)~= d2(j,41) && d(j,i)~= d2(j,42) && ...
           d(j,i)~= d2(j,43) && d(j,i)~= d2(j,44) &&...
           d(j,i)~= d2(j,45) && d(j,i)~= d2(j,46) &&...
           d(j,i)~= d2(j,47) && d(j,i)~= d2(j,48) &&...
           d(j,i)~= d2(j,49) && d(j,i)~= d2(j,50);
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
           sh1=sh1+1;
           d2(j,m(j,1)+sh1)=d(j,i);

        end
             
    end
    
end
    
%cross over with Pbest
d3=zeros(NOC,NOW);
for j=1:NOC;
    k(j,1)=unidrnd(NOW,1);
    m(j,1)=round(c1*rand);
    if m(j,1)>NOW-k(j,1);
        m(j,1)=NOW-k(j,1);
    end
    

  
    for i=k(j,1)+1:k(j,1)+m(j,1);
        
         d3(j,i-k(j,1))=Pbest(j,i);
        
    end
    %cross over with Pbest
    sh1=0;
    
    for i=1:NOW;
        
        if d2(j,i)~= d3(j,1) && d2(j,i)~= d3(j,2) &&...
           d2(j,i)~= d3(j,3) && d2(j,i)~= d3(j,4) &&...
           d2(j,i)~= d3(j,5) && d2(j,i)~= d3(j,6) &&...
           d2(j,i)~= d3(j,7) && d2(j,i)~= d3(j,8) &&...
           d2(j,i)~= d3(j,9) && d2(j,i)~= d3(j,10) &&...
           d2(j,i)~= d3(j,11) && d2(j,i)~= d3(j,12) &&...
           d2(j,i)~= d3(j,13) && d2(j,i)~= d3(j,14) &&...
           d2(j,i)~= d3(j,15) && d2(j,i)~= d3(j,16) &&...
           d2(j,i)~= d3(j,17) && d2(j,i)~= d3(j,18) &&...
           d2(j,i)~= d3(j,19) && d2(j,i)~= d3(j,20) &&...
           d2(j,i)~= d3(j,21) && d2(j,i)~= d3(j,22) &&...
           d2(j,i)~= d3(j,23) && d2(j,i)~= d3(j,24) &&...
           d2(j,i)~= d3(j,25) && d2(j,i)~= d3(j,26) &&...
           d2(j,i)~= d3(j,27) && d2(j,i)~= d3(j,28) &&...
           d2(j,i)~= d3(j,29) && d2(j,i)~= d3(j,30) &&...
           d2(j,i)~= d3(j,31) && d2(j,i)~= d3(j,32) &&...
           d2(j,i)~= d3(j,33) && d2(j,i)~= d3(j,34) &&...
           d2(j,i)~= d3(j,35) && d2(j,i)~= d3(j,36) &&...
           d2(j,i)~= d3(j,37) && d2(j,i)~= d3(j,38) &&...
           d2(j,i)~= d3(j,39) && d2(j,i)~= d3(j,40) &&...
           d2(j,i)~= d3(j,41) && d2(j,i)~= d3(j,42) &&...
           d2(j,i)~= d3(j,43) && d2(j,i)~= d3(j,44) &&...
           d2(j,i)~= d3(j,45) && d2(j,i)~= d3(j,46) &&...
           d2(j,i)~= d3(j,47) && d2(j,i)~= d3(j,48) &&...
           d2(j,i)~= d3(j,49) && d2(j,i)~= d3(j,50);
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
           sh1=sh1+1;
           d3(j,m(j,1)+sh1)=d2(j,i);

        end
             
    end
    
end
%-----------------------------arzyabi G, p best

%]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

%k_ite=1;

%k_ite=k_ite+1;



% baresiye behtar bodan va jaygozari kardan d , d3 haye khob miyan to d

for i=1:NOC;
    
    

    NPV(i,2)=GC(d3,i,NOW,OverLandScape,TravelCostPerDay,bblPrice);
    if NPV(i,2)>NPV(i,1)
        NPV(i,1)=NPV(i,2);
        d(i,1:NOW)=d3(i,1:NOW);
        
       
        
        if Gbest(1,NOW+1)<NPV(i,2)
            Gbest(1,1:NOW)=d3(i,1:NOW);
            Gbest(1,NOW+1)=NPV(i,2);
            clc
            Gbest
           % beep
            ite
           % pause (0.00001);
            %stairs(Gbest(1,1:50),'DisplayName','Gbest(1,1:50)');
        end
         
    end
    if Pbest(i,NOW+1)<NPV(i,2)
         Pbest(i,1:NOW)=d3(i,1:NOW);
         Pbest(i,NOW+1)=NPV(i,2);
    end
        
    



end





%]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     OPERATOR #2

%------inject

R1=rand;
if R1<0.5;

for j=1:NOC;    
    
    
    
    a=unidrnd(NOW,1);

    d4(j,1:NOW+NOW)=[d3(j,1:NOW) V(j,1:NOW) d3(j,NOW+1:NOW)];
    %d4(j,1:NOW+3)=[d3(j,1:a) V(j,1:NOW) d3(j,a+1:NOW)];
end


d5=zeros(NOC,NOW);
for j=1:NOC;
    %%%%%%%%%%%%%%%%%%%  dorost 
sh1=0;
for i=1:NOW+3;
    if d4(j,i)~=d5(j,1) && d4(j,i)~=d5(j,2) && d4(j,i)~=d5(j,3) && ...
            d4(j,i)~=d5(j,4) && d4(j,i)~=d5(j,5) && d4(j,i)~=d5(j,6) &&...
            d4(j,i)~=d5(j,7) && d4(j,i)~=d5(j,8) && d4(j,i)~=d5(j,9) &&...
            d4(j,i)~=d5(j,10) && d4(j,i)~=d5(j,11) && d4(j,i)~=d5(j,12) && d4(j,i)~=d5(j,13) && ...
            d4(j,i)~=d5(j,14) && d4(j,i)~=d5(j,15) && d4(j,i)~=d5(j,16) &&...
            d4(j,i)~=d5(j,17) && d4(j,i)~=d5(j,18) && d4(j,i)~=d5(j,19) &&...
            d4(j,i)~=d5(j,20) && d4(j,i)~=d5(j,21) && d4(j,i)~=d5(j,22) && d4(j,i)~=d5(j,23) && ...
            d4(j,i)~=d5(j,24) && d4(j,i)~=d5(j,25) && d4(j,i)~=d5(j,26) &&...
            d4(j,i)~=d5(j,27) && d4(j,i)~=d5(j,28) && d4(j,i)~=d5(j,29) &&...
            d4(j,i)~=d5(j,30) && d4(j,i)~=d5(j,31) && d4(j,i)~=d5(j,32) && d4(j,i)~=d5(j,33) && ...
            d4(j,i)~=d5(j,34) && d4(j,i)~=d5(j,35) && d4(j,i)~=d5(j,36) &&...
            d4(j,i)~=d5(j,37) && d4(j,i)~=d5(j,38) && d4(j,i)~=d5(j,39) &&...
            d4(j,i)~=d5(j,40) && d4(j,i)~=d5(j,41) && d4(j,i)~=d5(j,42) && d4(j,i)~=d5(j,43) && d4(j,i)~=d5(j,44) && ...
            d4(j,i)~=d5(j,45) && d4(j,i)~=d5(j,46) && d4(j,i)~=d5(j,47) &&...
            d4(j,i)~=d5(j,48) && d4(j,i)~=d5(j,49) && d4(j,i)~=d5(j,50);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        sh1=sh1+1;
        d5(j,sh1)=d4(j,i);
        
    end
    
end
end
else
%------------reverse


for j=1:NOC;
    
sh1=unidrnd(NOW/2,1);
t1=(NOW/2)+1;
t2=NOW;
sh2=round(rand*(t2-t1)+t1);


for i=1:sh1;
    d6(j,i)=d(j,i);
    
end

k=sh1-1;
for i=sh2:-1:sh1;
    k=k+1;
    d6(j,k)=d(j,i);
end

for i=sh2+1:NOW;
    
    d6(j,i)=d(j,i);
    
end

end
end


% baresiye behtar bodan va jaygozari kardan d , d6 haye khob miyan to d

for i=1:NOC;
    
    if R1<0.5 
        x=d5;
    else
        x=d6;
    end
    
%x
    NPV(i,2)=GC(x,i,NOW,OverLandScape,TravelCostPerDay,bblPrice);
    if NPV(i,2)>NPV(i,1)
        
        d(i,1:NOW)=x(i,1:NOW);
        
        if Gbest(1,NOW+1)<NPV(i,2)
            Gbest(1,1:NOW)=x(i,1:NOW);
            Gbest(1,NOW+1)=NPV(i,2);
            clc
            %beep
            Gbest
            ite
            %pause (0.00001);
            %stairs(Gbest(1,1:50),'DisplayName','Gbest(1,1:50)');
        end
          
    end
    if Pbest(i,NOW+1)<NPV(i,2)
         Pbest(i,1:NOW)=d3(i,1:NOW);
         Pbest(i,NOW+1)=NPV(i,2);
    end
    
    
    
    
    
    
end


%if R1<0.5
    %d=d5;
%else 
    %d=d6;
%end

Global_Value(1,ite)=Gbest(1,NOW+1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%pause(0.0001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%plot(1:ite,Global_Value(1,1:ite));
%%%%%%%%%%%%%hold on
%%%%%%%%%%%%grid on
%disp(ite);

end

%plot(Global_Value(1:300,1),'DisplayName','Global_Value(1:1000,1)','YDataSource','Global_Value(1:300,1)');




end

close(h)
    
   
    
    
    
    
    
    
    
    
    




    













    
            
        
    
    
        
       
            
    
    
    
         
         
         
    
    
    
   
 


    
















