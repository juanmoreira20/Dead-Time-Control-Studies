clc; close all; clear;
s = tf('s');

%%Simulation:
Gm = 1/((1+5*s)*(1+2*s));
Pn = Gm;
L = 12;
Pn.OutputDelay = L;
Pnq1 = 0.5*Pn;
Pnq2 = 0.5/(1+2*s);
Pnq2.OutputDelay = 5;
C_ffsp = 12*(s+0.4)*(s+0.45)/(s*(s+5));
Cff = 0.5;
Cff2 = (0.5*(1+5*s)/(1+0.5*s));
P = Pn;
% b = 0.4;
% c = 0.5;
% F = (b*s+0.4)*(c*s+0.45)/((s+0.4)*(s+0.45));
F = 1;

sim = sim('SfastModelFFA.slx');

figure
subplot(2,1,1)
plot(sim.y, 'r', 'linewidth', 2)       
hold on
plot(sim.ref, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) sp','Reference', 'location', 'best')
subplot(2,1,2)
plot(sim.u, 'b', 'linewidth', 1)
hold on
plot(sim.ref, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) sp','Reference', 'location', 'best') 