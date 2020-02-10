function [out1,out2,outx]=people_logic(in1,in2,inx,n)

if inx<0
    in2=in2-inx;
    inx=0;
else if inx>n
        in1=in1-(inx-n);
        inx=n;
    end
end

out1=in1;
out2=in2;
outx=inx;
    
end