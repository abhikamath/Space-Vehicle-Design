%% True anomaly to time conversion

function [tof] = anomaly2time(e,nu,mu,a)

tof = real(pi*(atan(2*sqrt((1-e)/(1+e)).*tand(nu/2)) - (e.* sin(atan(2*sqrt((1-e)/(1+e)).*tand(nu/2)))))/ sqrt(mu/(a^3)));
