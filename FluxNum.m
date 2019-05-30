function [fl,fr]=FluxNum(flux,dflux,sl,sr)
A = find((sr-sl)<10^-10);
alpha(1:length(sl)) = (flux(sr)-flux(sl))/(sr-sl);
alpha(A) = dflux(sl(A));

f = 0.5*(flux(sr) + flux(sl) - abs(alpha).*(sr -sl));

fr=f(2:end);fl=f(1:end-1);

end