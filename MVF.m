% MVF
clear; close all; clc;

t = 0; tmax = 1; CFL = 0.9;
xl = -1; xr = 1; ne = 200;
h = (xr - xl)/ne; 
x = xl:h:xr; xe = x(1)+h/2:h:x(end)-h/2;
dt = CFL*h; nsteps = round(tmax/dt); n=1;
s=SolIni(xe); %sn = s;
sl = [s(1) s]; sr = [s s(end)];

while n < nsteps
    
    flux = @(s) (s.^2)/2; dflux =@(s) s;
    [fl,fr]=FluxNum(flux,dflux,sl,sr);
    
    sn = s -(dt/h)*(fr - fl);
    t = t + dt; s =sn; 
    sl = [s(1) s]; sr = [s s(end)];
    n = n + 1;
    
    figure (1)
    plot(xe,s,'.r');hold off
    grid on; xlabel('x'); ylabel('S')
    pause(dt);
end