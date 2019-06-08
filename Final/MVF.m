%% MVF
clear; close all; clc;
%% Casos
test = '3';
switch test
    
    case '1'
        si = 'fsin'; cc = 'periodica'; xl = -1; xr = 1; CFL = 0.9;  ne = 200;ae = 1;
        t = 0; tmax = 1; a = 1; fflux = 'linear'; rm_solver = 'ROE-E'; metodo = 'MVF';
            
    case '2'
        si = 'fstep'; cc = 'dirichlet'; xl = -1; xr = 1; CFL = 0.8; ne = 200; ae = 0;  
        t = 0; tmax = 1; a= 1; fflux = 'burgers'; rm_solver = 'ROE-E'; metodo = 'MVF';
    case '3'
        si = 'fsin'; cc = 'periodica'; xl = -1; xr = 1; CFL = 0.5; ne = 50; ae = 0;  
        t = 0; tmax = 1; a= 1; fflux = 'linear'; rm_solver = 'ROE-E'; metodo = 'MUSCL';

end
h = (xr - xl)/ne; 
x = xl:h:xr; xe = x(1)+h/2:h:x(end)-h/2;
dt = CFL*h; nsteps = round(tmax/dt); n = 1;
s0 = SolIni(si,xe);
while n < nsteps
    
     esp=meth(metodo,cc,rm_solver,fflux,a,s0);
     sn = s0 -(dt/h)*esp;
       
    t = t + dt; s0 = sn;
    n = n +1;
    figure (1)
    plot(xe,sn,'-.r')
    hold off
    grid on; xlabel('x'); ylabel('S')
    switch metodo
        case 'MVF'
            title('MVF');
        case 'MUSCL'
            title('MUSCL');  
    end
    pause(dt);
end
% cálculo dos erros 
%Linf(m)=max(abs(se-s0)); L1(m)=sum(abs(se-s0)*hm(m))/(xr-xl); L2(m)=sqrt((sum((se-s0).^2)*hm(m))/(xr-xl));
   
    
