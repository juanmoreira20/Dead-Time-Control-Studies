clc; close all; clear;
s = tf('s');
%% Process:
Gn = 1/(1+1.5*s);
Pn = Gn;
Ln = 5;
Pn.OutputDelay = Ln;
P = Pn;

Kc = 6;
Ti = 0.5;
C_sp = Kc*(1+Ti*s)/(Ti*s);
F = 1;
Tsim  = 35;
Tinit = 5;
Tdist = 15;
Ampdist = -0.1;

sim1 = sim('S2DOFSP.slx');

beta = 0.4;
F = (1+s*beta*Ti)/(1+s*Ti);
sim2 = sim('S2DOFSP.slx');

figure
subplot(2,1,1)
plot(sim1.y, '--k', 'linewidth', 1)
hold on
plot(sim2.y, 'r', 'LineWidth',2)
grid on
axis tight
legend('Output, y(t) no filter','Output y(t) filter', 'location', 'best')
subplot(2,1,2)
plot(sim1.u, '--k', 'linewidth', 1);
hold on
plot(sim2.u, 'r', 'LineWidth',2)
grid on
axis tight
legend('Output, u(t) no filter','Output u(t) filter', 'location', 'best') 