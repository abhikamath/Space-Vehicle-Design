%% Torque on spacecraft due to gravity gradient

function [tg_x, tg_y, tg_z] = grav(v,m1,m2,l1,l2,peri,mu,theta_y,theta_z)

tg_x = 0;
tg_y = m1*l1*((v.^2*(peri + l1*cosd(theta_y))-mu)/(peri + l1*cosd(theta_y))^2) - m2*l2*((v.^2*(peri + l2*cosd(theta_y))-mu)/(peri + l2*cosd(theta_y))^2);
tg_z = m1*l1*((v.^2*(peri + l1*cosd(theta_z))-mu)/(peri + l1*cosd(theta_z))^2) - m2*l2*((v.^2*(peri + l2*cosd(theta_z))-mu)/(peri + l2*cosd(theta_z))^2);
