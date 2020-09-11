function [s]=DIV(Gbest,Pbest,i,d6,NOW);




% between Xi and Gbest

    
    sh1=0;
    for k=1:NOW;
        if d6(i,k)==Gbest(1,k);
            sh1=sh1+1;
        end
    end
    s(1,1)=sh1;

% between Xi and Pbest

    sh1=0;
    for k=1:NOW;
        if d6(i,k)==Pbest(i,k);
            sh1=sh1+1;
        end
    end
    s(1,2)=sh1;

% between Gbest and Pbest

    sh1=0;
    for k=1:NOW;
        if Pbest(i,k)==Gbest(1,k);
            sh1=sh1+1;
        end
    end
    s(1,3)=sh1;
    
%    for k=1:NOC;
    s(1,4)=sum(s(1,1:3))/3;
   % end

end
