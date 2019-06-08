function [s0]=SolIni(si,xe)
% Solução Inicial
    switch si
        case 'fsin'
            s0 = -sin(pi*xe);
        case 'fstep'
            range1=find(xe<=0); range2=find(xe>0);
            s0=ones(size(xe));
            s0(range1)=s0(range1)*(-0.5);
            s0(range2)=s0(range2)*(1);
        case 'fquad' 
           range1=find(xe<=-1/4); range2=find(xe>1/4);
           s0=ones(size(xe))*2;
           s0(range1)=0; s0(range2)=0;
           
    end
end