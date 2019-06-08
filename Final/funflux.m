function [flux,dflux]=funflux(fflux,a)
switch fflux
    case 'linear'
        flux = @(s) a*s; dflux = @(s) a;
    case 'burgers'
        flux = @(s) (s.^2)/2; dflux = @(s) s;
end
end