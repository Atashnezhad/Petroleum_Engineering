%for ty=1:10
tic
clc
clear
k=0;
h=0;
t=0;
v = size(60,60);
mat = size(60, 60);
F=size(60,60);
%new definitions
vi=size(60,60);
pv=size(60);
%disp('C1=-0.2699 for this problem is common');
c1=0.2;%-0.2699;
%c1 = input('input Cognitive coffecient=');
%disp('C2=4.2373 for this problem is common');
c2=0.72;%4.2373;0.9-0.7-
%c2 = input('input Socitial coffecient=');
%disp('initial velocity required for our search -0.67 is common');
w=0.9;%-0.67;
%w=input('input initial velocity=');
%disp('number of variables is 16D');
x = 16;
%disp('Number of swarms');
%ns = input('input number of swarms=');
ns=30;
%disp('Number of iterations');
%iterations=input('input nimber of iterations=');
iterations=150;
%ProgressBar1.Min = 1;
%ProgressBar1.Max = iterations;
n = 0;
xnb2=0;
format long
disp('Random TMD');
%%
%Constrains
cl(1) = 2500;cl(2) = 10;cl(3) = 40;cl(4) = 90;cl(5) = 270;
cl(6) = 270;cl(7) = 270;cl(8) = 330;cl(9) = 330;cl(10) = 355;
cl(11) = -5;cl(12) = -5;cl(13) = -5;cl(14) = 6000;cl(15) = 10000;
cl(16) = 600;cu(1) = 2500;cu(2) = 20;cu(3) = 70;cu(4) = 95;
cu(5) = 280;cu(6) = 280;cu(7) = 280;cu(8) = 340;cu(9) = 340;
cu(10) = 360;cu(11) = 5;cu(12) = 5;cu(13) = 5;cu(14) = 7000;
cu(15) = 10200;cu(16) = 1000;
while n<ns;
for i = 1 : x
v(i,n+1) = cl(i) + (cu(i)-cl(i)).*rand;
end
rad = (3.14159 / 180);
R1 = 100 / (v(11, n + 1)* rad);
R3 = 100 / (v(12, n + 1)* rad);
R5 = 100 / (v(13, n + 1)* rad);
D1 = R1 * (((v(6, n + 1) - v(5, n + 1)) * rad) ^ 2 * (sin(v(2, n + 1) * rad / 2)) ^ 4 ...
    + ((v(2, n + 1) * rad) ^ 2)) ^ (0.5);
D2 = (v(14, n + 1) - v(16, n + 1) - D1 * (sin(v(2, n + 1) * rad) - sin(0)) / (v(2, n + 1) * rad - 0)) / cos(v(2, n + 1) * rad);
D3 = R3 * (((v(8, n + 1) - v(7, n + 1)) * rad) ^ 2 * (sin((v(3, n + 1)...
    + v(2, n + 1)) * rad / 2)) ^ 4 + ((v(3, n + 1) - v(2, n + 1)) * rad) ^ 2) ^ (0.5);
D4 = (v(15, n + 1) - v(14, n + 1) - D3 * (sin(v(3, n + 1) * rad) - sin(v(2, n + 1) * rad)) / (v(3, n + 1) * rad - v(2, n + 1) * rad)) / cos(v(3, n + 1) * rad);
D5 = R5 * (((v(10, n + 1) - v(9, n + 1)) * rad) ^ 2 * (sin((v(4, n + 1) + v(3, n + 1)) * rad / 2)) ^ 4 ...
    + ((v(4, n + 1) - v(3, n + 1)) * rad) ^ 2) ^ (0.5);
z = v(1, n + 1) + D1 + D2 + D3 + D4 + D5 + v(16, n + 1);
cas1 = v(16, n + 1) + D1 * (sin(v(2, n + 1) * rad) / (v(2, n + 1) * rad));
cas2 = cas1 + D2 * cos(v(2, n + 1) * rad) + D3 * ((sin(v(3, n + 1) * rad) - sin(v(2, n + 1) * rad)) / ((v(3, n + 1) - v(2, n + 1)) * rad));
cas3 = cas2 + D4 * cos(v(3, n + 1) * rad) + D5 * ((sin(v(4, n + 1) * rad) - sin(v(3, n + 1) * rad)) / ((v(4, n + 1) - v(3, n + 1)) * rad));

if D1 > 0 && D2 > 0 && D3 > 0 && D4 > 0 && D5 > 0 && cas1 > 1800 &&...
        cas1 < 2200 && cas2 > 7200 && cas2 < 8700 && cas3 > 10835 &&...
        cas3 < 10885 %&& z<15300
 
for i = 1 : x
mat(i, n+1) = v(i, n + 1);
end
mat(i+1, 1 + n) = z;
%mat(27, 4 + n) = 10000 / (10000 + z);
%mat(30, 4 + n) = 10000 / (10000 + z);
%mat(33, 4 + n) = z;
n = n + 1;
%n;
disp(z);    
    
end

end
disp('Search for better answers');
%%
G=size(200);
for i=1:x%16
    G(i,1)=mat(i,1);
end

GV=mat(17,1);
%g(10+x+1,3+1)=inf;
%For each particle i = 1, ..., S do:

%Initialize the particle's position with a uniformly distributed random vector: xi ~ U(blo, bup), 
%%where blo and bup are the lower and upper boundaries of the search-space.

%Initialize the particle's best known position to its initial position: pi ? xi
pi=size(60,60);
for n=1:ns
    
for i = 1 : x+1
pi( i,  n) = mat(i, n );
end

end

%If (f(pi) < f(g)) update the swarm's best known position: g ? pi
%G=inf;
s=ns;
for i=1:s
    if pi(17,i)<GV%(10+x+1,3+i)
        for j=1:x%16
           G(j,1)=pi(j,i);
        end
        GV=pi(17,i);
        
    end
end



%Initialize the particle's velocity: vi ~ U(-|bup-blo|, |bup-blo|)
for n=1:s
    
    for i=1:x
        pv(i)=cu(i)-cl(i);
        vi( i,  n)=-pv(i) + (2*pv(i)).*rand;
    end
    
end

%Until a termination criterion is met (e.g. number of iterations performed, or adequate fitness reached), repeat:
ite=0;
while ite<iterations
%For each particle i = 1, ..., S do:
for i=1:s;
    
    
%For each dimension d = 1, ..., n do:
     for d=1:x;
%Pick random numbers: rp, rg ~ U(0,1)
rp=rand;
rg=rand;
%Update the particle's velocity: vi,d ? ? vi,d + ?p rp (pi,d-xi,d) + ?g rg (gd-xi,d)

             vi( d, i)=w* vi(d,i) + c1 *rp* (pi(d,i)-mat(d,i)) + c2* rg* (G(d)-mat(d,i));
                
             
     end
     %Update the particle's position: xi ? xi + vi
     for d=1:x;
        if mat(d,i)+vi(d,i)<cl(d)
            mat(d,i)=cl(d);
        elseif mat(d,i)+vi(d,i)>cu(d)
        %if mat(d,i)+vi(d,i)>cu(d)
            mat(d,i)=cu(d);
        else
        %if mat(d,i)+vi(d,i)<cu(d) && mat(d,i)+vi(d,i)>cl(d)
            
             mat(d,i)=mat(d,i)+vi(d,i); 
        end
     end
     %If (f(xi) < f(pi)) do:
     rad = (3.14159 / 180);
     R1 = 100 / (mat(11, i) * rad);
     R3 = 100 / (mat(12, i) * rad);
     R5 = 100 / (mat(13, i) * rad);
     D1 = R1 * (((mat(6, i) - mat(5, i)) * rad) ^ 2 * (sin(mat(2, i) * rad / 2)) ^ 4 + ((mat(2, i ) * rad) ^ 2)) ^ (0.5);
     D2 = (mat(14, i) - mat(16, i) - D1 * (sin(mat(2, i) * rad) - sin(0)) / (mat(2, i) * rad - 0)) / cos(mat(2, i) * rad);
     D3 = R3 * (((mat(8, i) - mat(7, i)) * rad) ^ 2 * (sin((mat(3, i) + mat(2, i)) * rad / 2)) ^ 4 + ((mat(3, i) - mat(2, i)) * rad) ^ 2) ^ (0.5);
     D4 = (mat(15, i) - mat(14, i) - D3 * (sin(mat(3, i) * rad) - sin(mat(2, i) * rad)) / (mat(3, i) * rad - mat(2, i) * rad)) / cos(mat(3, i) * rad);
     D5 = R5 * (((mat(10, i) - mat(9, i)) * rad) ^ 2 * (sin((mat(4, i) + mat(3, i)) * rad / 2)) ^ 4 + ((mat(4, i) - mat(3, i)) * rad) ^ 2) ^ (0.5);
     z = mat(1, i) + D1 + D2 + D3 + D4 + D5 + mat(16, i);
     cas1 = mat(16, i) + D1 * (sin(mat(2, i) * rad) / (mat(2, i) * rad));
     cas2 = cas1 + D2 * cos(mat(2, i) * rad) + D3 * ((sin(mat(3, i) * rad) - sin(mat(2, i) * rad)) / ((mat(3, i) - mat(2, i)) * rad));
     cas3 = cas2 + D4 * cos(mat(3, i) * rad) + D5 * ((sin(mat(4, i) * rad) - sin(mat(3, i) * rad)) / ((mat(4, i) - mat(3, i)) * rad));
     if D1 > 0 && D2 > 0 && D3 > 0 && D4 > 0 &&...
        D5 > 0 && cas1 > 1800 && cas1 < 2200 && cas2 > 7200 &&...
        cas2 < 8700 && cas3 > 10835 && cas3 < 10885 && pi(d+1,i) > z %&& TVD<10900% &&...
        %TVD>10850 
        %beep
        %disp(ite)
        %disp('Update the particles best known position: pi ? xi')
     %Update the particle's best known position: pi ? xi
        for d=1:x
        pi(d,i)=mat(d,i); 
       
        end
        pi(d+1,i)=z;
        %If (f(pi) < f(g)) update the swarm's best known position: g ? pi
        if z<GV
            %t=t+1;
           for d=1:x
              G(d)=mat(d,i); 
              
              
              %h=1;
              %disp('update the swarms best known position: g ? pi')
           end
           disp(ite)
           GV=z;
           %GV
           
        end
     end
     
     
end


ite=ite+1;
for d=1:x
F(d,ite)=G(d,1);
end
D(ite)=GV;
%disp(ite)
figure (1)
subplot(2,2,1)
plot(1:ite,D(1:ite),'b')%,'--'
xlabel('Iterations')
ylabel('Candidates Fitness, MSE')
grid on
hold on

subplot(2,2,2)
pause (0.000001);
%subplot(2,2,1)

for u=1:s
    %Xlim([9000 13000])
    %YLim([9000 13000])
    plot(mat(11,  u),mat(12,  u),'*');%,mat(13,  u),
    title('Candidates Convergence')
    
    hold on
    grid on
end

    hold off
    
 %   figure(2)
%for i=1:16
%subplot(4,4,i);
%grid on;
%%%%xlabel('Iterations')

%plot(1:ite,((cu(i)-G(i,1))/(cu(i)-cl(i))));
%%%%plot(1:ite,mat(10+1,3+best):mat(10+i,3+best))

%666666666666666666666666666666666666666%$figure(2)
subplot(2,2,3)
%subplot(4,4,1)
for i=1:16
plot(1:ite,((cu(i)-F(i,1:ite))/(cu(i)-cl(i))),'r');
xlabel('Iterations')
ylabel('Candidates Evolution, Normalized')
end
hold on







%hold on;

%end
%%
%mimicplot
%if h==1;












    %%
    N(ite)=GV;
end

%end


%%
%mimicplot2
%if h==1;






    %%



%Now g holds the best found solution.





