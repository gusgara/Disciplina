function [fl,fr] = FluxNum(rm_solver,flux,dflux,s0,sl,sr)
switch rm_solver
    case 'ROE-E'
        A = find(abs(sr-sl)<10^-10); B = find((dflux(sl).*dflux(sr))<0);
        alpha = (flux(sr)-flux(sl))./(sr-sl);
        alpha(A) = dflux(sr(A));
        beta = max(abs(dflux(sr)),abs(dflux(sl)));
        alpha(B)=beta(B);
        f = 0.5*(flux(sr) + flux(sl) - abs(alpha).*(sr - sl));
    case 'LF'
        alpha = max(max(abs(dflux(s0))));
        f = 0.5*(flux(sr) + flux(sl) - alpha*(sr -sl));
    case 'LLF'
        beta = max(abs(dflux(sr)),abs(dflux(sl)));
        f = 0.5*(flux(sr) + flux(sl) - beta.*(sr -sl));
end
    fr=f(2:end);fl=f(1:end-1);
            
end