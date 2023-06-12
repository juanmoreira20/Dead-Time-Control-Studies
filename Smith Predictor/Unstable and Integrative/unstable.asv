clc; close all; clear;
s = tf('s');
%% Unstable Process:
Gn = 1/(s-1);
P = Gn;
L = 1;
Ln = 1;
P.OutputDelay = L;
%allocating on poles s+2, s+3;
Kc = 6;
Ti = 1;
C_sp = Kc*(1+Ti*s)/(Ti*s);
Tsim  = 10;
Tinit = 1;
Tdist = 5;
Ampdist = -0.1;

sim = sim('SsmithPredictor.slx');


figure
subplot(2,1,1)
plot(sim.y, '--k', 'linewidth', 2)       
grid on
axis tight
legend('Output, y(t) unstable', 'location', 'best')
subplot(2,1,2)
plot(sim.u, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) unstable', 'location', 'best') 