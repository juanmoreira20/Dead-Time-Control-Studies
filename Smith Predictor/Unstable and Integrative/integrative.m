clc; close all; clear;
s = tf('s');
%% Unstable Process:
Gn = 2/s;
Pn = Gn;
L = 5;
Ln = 5.1;
Pn.OutputDelay = Ln;
P = 2/((1+0.1*s)*s);
P.OutputDelay = L;
%allocating on poles s+0.25;
Kc = 0.25;
Ti = 8;
C_sp = Kc*(1+Ti*s)/(Ti*s);
Tsim  = 150;
Tinit = 10;
Tdist = 75;
Ampdist = -0.05;

sim = sim('SintegrativeSP.slx'); 
figure
subplot(2,1,1)
plot(sim.y, '--k', 'linewidth', 2)       
grid on
axis tight
legend('Output, y(t) integrative', 'location', 'best')
subplot(2,1,2)
plot(sim.u, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) integrative', 'location', 'best') 