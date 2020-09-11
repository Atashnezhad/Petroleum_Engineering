function o = sam2(t1,t2,t3,t4,t5,t6)%
load matlab
o=0;
for i=1:20
 
    o=((t1*(data(i,1)^t2)+t3*(data(i,2)^t4)+t5*(data(i,3)^t6))-data(i,4))^2+o;%3182
    %o=((t1*(data(i,1)^t2)*(data(i,2)^t3)*(data(i,3)^t4))-data(i,4))^2+o;%  299
    %o=((t1*(data(i,1)^t2)+t3*(data(i,2)^t4)/t5*(data(i,3)^t6))-data(i,4))^2+o;%365
    %o=(((t1*(data(i,1)^t2)+t3*(data(i,2)^t4))/t5*(data(i,3)^t6))-data(i,4))^2+o;%338

end
o = o/20;
end
