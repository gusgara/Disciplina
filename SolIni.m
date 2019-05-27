function [s0]=SolIni(xe)
range1=find(xe<=0); range2=find(xe>0);
s0=ones(size(xe));
s0(range1)=s0(range1)*(-0.5);
s0(range2)=s0(range2)*(1);
end