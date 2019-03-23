%% Simulation Script

% Constants

peri = 108000000; % Perigee (meters)
apo = 375000000; % Apogee (meters)
inc = 37; % Inclination (degrees)
T = (328.8*60*60); % Orbital Period
e = 0.55; % Eccentricity
mu = 3.986 * 10^14; % Standard Gravitational Parameter 
a = 240000000; %(peri + apo)/2; % Semi-major axis

theta_y = 0;
theta_z = 0;

l1 = -0.06533; %meters - Center of mass of spacecraft without appendage
l2 = 2.002; %meters - Center of mass of appendage
m1 = 355.5; %kg - Mass of spacecraft without appendage
m2 = 7.5; %kg - Mass of appendage
%v1 = 2513.672244; % m/s

r = [];
v = [];
nu = 0:359;
nu1 = 0:(2*pi)/360:(2*pi)-(2*pi)/360;

% Orbital Parameters
    
r = ((a*(1-e^2))./(1+e.*cosd(nu))); % Orbital Radius
v = (mu.*((2./r)-(1./a))).^(0.5); % Orbital Velocity

% Gravity Gradient

[tg_x, tg_y, tg_z] = grav(v,m1,m2,l1,l2,peri,mu,theta_y,theta_z);

% Solar Radiation Pressure

tsrp_x = [zeros(1,360)];
tsrp_y = (12.68*10^-6).*[ones(1,360)];
tsrp_z = [zeros(1,360)];

% Gimbal

tgim_x = [zeros(1,360)];
tgim_x(359) = 18;
tgim_y = [zeros(1,360)];
tgim_z = [zeros(1,360)];
tgim_z(359) = 18;

% True anomaly to time conversion

t_a = anomaly2time(e,nu,mu,a);

% Piezoelectrics

tx = -(tg_x + tgim_x + tsrp_x);
ty = -(tg_y + tgim_y + tsrp_y);
tz = -(tg_z + tgim_z + tsrp_z);
t = sqrt(tx.^2 + ty.^2 + tz.^2);

t_a_plot = [t_a(181:360) t_a(1:180)];

figure(1)
plot(t_a_plot, nu);
title('True Anomaly v Time of Flight')
xlabel('Time (seconds)')
ylabel('True Anomaly (degrees)')

figure(2)
subplot(1,3,1)
plot(nu,tgim_x);
title('About the x-axis')
ylabel('Torque (Nm)')
subplot(1,3,2)
plot(nu,tgim_y);
xlabel('True Anomaly (degrees)')
title('About the y-axis')
subplot(1,3,3)
plot(nu,tgim_z);
title('About the z-axis')
sgtitle('Gimbal Torque (Controllable) v True Anomaly')

figure(3)
subplot(1,3,1)
plot(nu,tg_x);
title('About the x-axis')
ylabel('Torque (Nm)')
subplot(1,3,2)
plot(nu,tg_y);
title('About the y-axis')
xlabel('True Anomaly (degrees)')
subplot(1,3,3)
plot(nu,tg_z);
title('About the z-axis')
sgtitle('Gravity Gradient (Disturbance) Torque v True Anomaly')

figure(4)
subplot(1,3,1)
plot(nu,tsrp_x);
title('About the x-axis')
ylabel('Torque (Nm)')
subplot(1,3,2)
plot(nu,tsrp_y);
title('About the y-axis ( ~12.68 uNm)')
xlabel('True Anomaly (degrees)')
subplot(1,3,3)
plot(nu,tsrp_z);
title('About the z-axis')
sgtitle('Torque (Disturbance) due to Solar Radiation Pressure v True Anomaly')


figure(5)
subplot(1,3,1)
plot(nu,tx);
title('About the x-axis')
ylabel('Torque (Nm)')
subplot(1,3,2)
plot(nu,ty);
title('About the y-axis')
xlabel('True Anomaly (degrees)')
subplot(1,3,3)
plot(nu,tz);
title('About the z-axis')
sgtitle('Counter-torque to be effected by the piezoelectric actuators to maintain equilibrium')


figure(6)
plot(nu, t);
xlabel('True Anomaly (degrees)')
ylabel('Torque (Nm)')
title('Resultant Torque (Piezoelectric ACS)')

maximum_torque = max(t)
