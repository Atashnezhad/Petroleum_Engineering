
clc
clear

NumOfVar=6;
Dim=NumOfVar+1;
SwarmNum=200;
CR=0.85;
F=0.95;
iteration=200;
%%
%Some parameters details
% % Wc=0.000000001;hx=1;bx=1;SR=45;BR=45;Db=12.25;
load matlab



%%
RandMat=rand(NumOfVar,SwarmNum);
inipoints=zeros(NumOfVar,SwarmNum);

%%
%Variables ranges
%aa1
VarL(1)=-1000;VarU(1)=1000;
%aa2
VarL(2)=-5;VarU(2)=10;
%aa3
VarL(3)=-5;VarU(3)=10;
%aa4
VarL(4)=-4;VarU(4)=10;
%aa5
VarL(5)=-1000;VarU(5)=1000;
%aa6
VarL(6)=-10;VarU(6)=10;

%%
%making initial points


aa1=size(1,SwarmNum);
aa2=size(1,SwarmNum);
aa3=size(1,SwarmNum);
aa4=size(1,SwarmNum);
aa5=size(1,SwarmNum);
aa6=size(1,SwarmNum);



for i=1:SwarmNum
    
   aa1(1,i)=rand*(VarU(1)-VarL(1))+VarL(1);
   aa2(1,i)=rand*(VarU(2)-VarL(2))+VarL(2);
   aa3(1,i)=rand*(VarU(3)-VarL(3))+VarL(3);
   aa4(1,i)=rand*(VarU(4)-VarL(4))+VarL(4);
   aa5(1,i)=rand*(VarU(5)-VarL(5))+VarL(5);
   aa6(1,i)=rand*(VarU(6)-VarL(6))+VarL(6);
   
   
    
end



%%


%%Calc ROP 1th Evaluate the constrains, conditions/Calculating the objF
fitness=size(1,SwarmNum);


 n(1,1)=aa1(1,1);
 n(2,1)=aa2(1,1);
 n(3,1)=aa3(1,1);
 n(4,1)=aa4(1,1);
 n(5,1)=aa5(1,1);
 n(6,1)=aa6(1,1);




for i=1:SwarmNum
    
    
    fitness(i)=sam2(aa1(1,i),aa2(1,i),aa3(1,i),aa4(1,i),aa5(1,i),aa6(1,i));%
    
end

% y=randperm(SwarmNum);


inipoints(1,1:SwarmNum)=aa1(1,1:SwarmNum);
inipoints(2,1:SwarmNum)=aa2(1,1:SwarmNum);
inipoints(3,1:SwarmNum)=aa3(1,1:SwarmNum);
inipoints(4,1:SwarmNum)=aa4(1,1:SwarmNum);
inipoints(5,1:SwarmNum)=aa5(1,1:SwarmNum);
inipoints(6,1:SwarmNum)=aa6(1,1:SwarmNum);



inipoints(7,1:SwarmNum)=fitness(1,1:SwarmNum);




for ami=1:iteration
Y=zeros(3,SwarmNum);

for i=1:SwarmNum
    
    y1=round(rand*(SwarmNum-1)+1);
    y2=round(rand*(SwarmNum-1)+1);
    y3=round(rand*(SwarmNum-1)+1);
    
    while y1==i 
        y1=round(rand*(SwarmNum-1)+1);
    end
    
    while y2==i | y2==y1
        y2=round(rand*(SwarmNum-1)+1);
    end
    
     while y3==i | y3==y1 | y3==y2 
        y3=round(rand*(SwarmNum-1)+1);
     end
   
    Y(1,i)=y1;
    Y(2,i)=y2;
    Y(3,i)=y3;
    
        
end

    
WDV=size(3,SwarmNum);
for i=1:SwarmNum
    
    WDV(1,i)=(inipoints(1,Y(1,i))-inipoints(1,Y(2,i)))*F;
    WDV(2,i)=(inipoints(2,Y(1,i))-inipoints(2,Y(2,i)))*F;
    WDV(3,i)=(inipoints(3,Y(1,i))-inipoints(3,Y(2,i)))*F;
    WDV(4,i)=(inipoints(4,Y(1,i))-inipoints(4,Y(2,i)))*F;
    WDV(5,i)=(inipoints(5,Y(1,i))-inipoints(5,Y(2,i)))*F;
    WDV(6,i)=(inipoints(6,Y(1,i))-inipoints(6,Y(2,i)))*F;
    
    
    
    

end


NRV=size(3,SwarmNum);
for i=1:SwarmNum
    
    NRV(1,i)=(WDV(1,i)+inipoints(1,Y(3,i)));
    NRV(2,i)=(WDV(2,i)+inipoints(2,Y(3,i)));
    NRV(3,i)=(WDV(3,i)+inipoints(3,Y(3,i)));
    NRV(4,i)=(WDV(4,i)+inipoints(4,Y(3,i)));
    NRV(5,i)=(WDV(5,i)+inipoints(5,Y(3,i)));
    NRV(6,i)=(WDV(6,i)+inipoints(6,Y(3,i)));
    
    
    

end


TV=size(NumOfVar,SwarmNum);

for j=1:SwarmNum
    for i=1:NumOfVar
        a=rand;
  
    if a<CR
       TV(i,j)=NRV(i,j);
    else
       TV(i,j)=inipoints(i,j);
        
    end
    
    end
end
%%
%Filter TV by taking the upper and lowwer boundries into account

for i=1:SwarmNum
    
    if TV(1,i)<VarL(1)
        
       TV(1,i)=VarL(1);
    end
        
    if TV(1,i)>VarU(1)
       TV(1,i)=VarU(1);
    end
    
end

for i=1:SwarmNum
    
    if TV(2,i)<VarL(2)
        TV(2,i)=VarL(2);
    elseif TV(2,i)>VarU(2)
        TV(2,i)=VarU(2);
    end
    
end  

for i=1:SwarmNum
    
    if TV(3,i)<VarL(3)
        TV(3,i)=VarL(3);
    elseif TV(3,i)>VarU(3)
        TV(3,i)=VarU(3);
    end
    
end  

for i=1:SwarmNum
    
    if TV(4,i)<VarL(4)
        TV(4,i)=VarL(4);
    elseif TV(4,i)>VarU(4)
        TV(4,i)=VarU(4);
    end
    
end  

% % % for i=1:SwarmNum
% % %     
% % %     if TV(5,i)<VarL(5)
% % %         TV(5,i)=VarL(5);
% % %     elseif TV(5,i)>VarU(5)
% % %         TV(5,i)=VarU(5);
% % %     end
% % %     
% % % end  
% % % 
% % % 
% % % for i=1:SwarmNum
% % %     
% % %     if TV(6,i)<VarL(6)
% % %         TV(6,i)=VarL(6);
% % %     elseif TV(6,i)>VarU(6)
% % %         TV(6,i)=VarU(6);
% % %     end
% % %     
% % % end  















%%
%calc ROP 2th
for i=1:SwarmNum
    
    %TV(3,i)=tan(sin(TV(1,i))*cos(TV(2,i)));
    TV(7,i)=sam2(TV(1,i),TV(2,i),TV(3,i),TV(4,i),TV(5,i),TV(6,i));%
end
%%
%replace if TV is better than inipoints

for i=1:SwarmNum
    
   if TV(7,i)<inipoints(7,i)
       inipoints(1:7,i)=TV(1:7,i);
   end
   
end
%%
%best global
subplot(2,4,1);
plot(inipoints(1,:))
xlabel ('Swarm Num')
ylabel ('parameter_1')
subplot(2,4,2);
plot(inipoints(2,:))
xlabel ('Swarm Num')
ylabel ('parameter_2')
subplot(2,4,3);
plot(inipoints(3,:))
xlabel ('Swarm Num')
ylabel ('parameter_3')
subplot(2,4,4);
plot(inipoints(4,:))
xlabel ('Swarm Num')
ylabel ('parameter_4')
subplot(2,4,5);
plot(inipoints(5,:))
xlabel ('Swarm Num')
ylabel ('parameter_5')
subplot(2,4,6);
plot(inipoints(6,:))
xlabel ('Swarm Num')
ylabel ('parameter_6')






BG(ami,1)=min(inipoints(7,1:SwarmNum));
subplot(2,4,7);
plot(BG)
xlabel ('Iteration num')
ylabel ('fittness=MSE')
pause(0.00001)




for j=1:SwarmNum
    
    
    
    if inipoints(7,j)==BG(ami,1)
        
       s=0;

       for i=1:20
    
           data(i,5)=(inipoints(1,j)*(data(i,1)^inipoints(2,j)))*...
          (inipoints(3,j)*(data(i,2)^inipoints(4,j)))*...
          (inipoints(5,j)*(data(i,3)^inipoints(6,j)));
    
       end
       
       j=SwarmNum;
       Bset(1:6,1)=inipoints(1:6,j);

   end
    
    
end






subplot(2,4,8);
plot(1:20,data(:,4))
hold on
plot(1:20,data(:,5))
hold off

xlabel ('data comparing')
ylabel ('Reduction%')

end


Bset
BG(iteration,1)





















