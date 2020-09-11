

%Gbest - Xi


GB_X=zeros(NumOfCandidates,10);





for k=1:NumOfCandidates
    a=0;
    b=0;
    for j=1:NumOfWells-1
        
        for i=1:NumOfWells 
            
            if Gbest(1,j)==d(k,i) && Gbest(1,j+1)~= d(k,i+1);
                a=a+1;
                GB_X(k,a)=Gbest(1,j);         
            end
           
        end
        
        
    end
    
    
end



