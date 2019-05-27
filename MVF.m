% MVF
clear all; close all; clc;
mesh=[20 40 80 160 320 640];
t = 0; tmax = 1; a = 1; CFL = 0.9; m = 1;

while m<=length(mesh)
xl = -1; xr = 1; ne = mesh(m);
h = (xr - xl)/ne; 
x = xl:h:xr; xe = x(1)+h/2:h:x(end)-h/2;
dt = CFL*h; nsteps = round(tmax/dt);
s=SolIni(xe); 
hm(m) = h; sn = s;
sl(2:length(s)+1)=s; sr(1:length(s))=s;
sl(1)=s(2); sr(length(s)+1)=s(length(s));
for n=0:dt:tmax
    flux = @(s) (s.^2)/2; dflux =@(s) s;
    [fl,fr]=FluxNum(flux,dflux,sl,sr);
    
    sn(1:ne) = s(1:ne) -(dt/h)*(fr(1:ne)-fl(1:ne));
    t = t + dt; s =sn; 
    sl(2:length(s)+1)=s; sr(1:length(s))=s;
    sl(1)=s(2); sr(length(s)+1)=sr(length(s));
    se = SolIni(xe-a*t);
    
    figure (1)
    plot(xe,s,'.r');hold on
    plot(xe,se,'-k');hold off
    grid on; xlabel('x'); ylabel('S')
    pause(dt);
end
% cálculo dos erros 
Linf(m)=max(abs(se-s)); L1(m)=sum(abs(se-s)*hm(m))/(xr-xl); L2(m)=sqrt((sum((se-s).^2)*hm(m))/(xr-xl));
    if m >1
    %taxa de convergência
    Rinf(m)=(log10(Linf(m-1))-log10(Linf(m)))/(log10(hm(m-1))-log10(hm(m)));
    R1(m)=(log10(L1(m-1))-log10(L1(m)))/(log10(hm(m-1))-log10(hm(m)));
    R2(m)=(log10(L2(m-1))-log10(L2(m)))/(log10(hm(m-1))-log10(hm(m)));
    end
    t=0;
    m=m+1; flux=0;
end
  
    figure(2)
    plot(log10(hm),log10(L1),'-or'); hold on
    plot(log10(hm),log10(L2),'-ok'); hold on
    plot(log10(hm),log10(Linf),'-ob'); hold off
    legend('L1','L2','Linf'); grid on;
    xlabel('log10(h)'); ylabel('Log10(erro)');